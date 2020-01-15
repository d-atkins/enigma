require_relative 'test_helper'
require './lib/encoder'
require 'time'
require 'mocha/minitest'

class EncoderTest < Minitest::Test

  def setup
    dummy_time = Time.parse("2020-1-12")
    Time.stubs(:now).returns(dummy_time)
    @encoder = Encoder.new
  end

  def test_it_can_get_todays_date
    assert_equal "120120", @encoder.today
  end

  def test_it_exists
    assert_instance_of Encoder, @encoder
  end

  def test_it_can_generate_a_5_character_random_key
    random_key = @encoder.random_key
    assert_instance_of String, random_key
    assert_equal 5, random_key.length
  end

  def test_it_can_set_codes
    assert_equal ["02", "27", "71", "15"], @encoder.codes("02715")
  end

  def test_it_can_set_offsets
    assert_equal ["1", "0", "2", "5"], @encoder.offsets("040895")
  end

  def test_it_can_set_shifts
    codes = @encoder.codes("02715")
    offsets = @encoder.offsets("040895")

    assert_equal [3, 27, 73, 20], @encoder.shifts(codes, offsets)
  end

  def test_it_can_caesar_shift
    assert_equal "m", @encoder.caesar_shift("l", 1)
    assert_equal "b", @encoder.caesar_shift("Z", 3)
    assert_equal " ", @encoder.caesar_shift("a", -1)
    assert_equal "q", @encoder.caesar_shift("Q", 54)
    assert_equal ",", @encoder.caesar_shift(",", 3)
    assert_equal "!", @encoder.caesar_shift("!", -7)
    assert_equal "d", @encoder.caesar_shift("z", 815)
    assert_equal "g", @encoder.caesar_shift("g", 0)
  end

  def test_it_can_report_info
    expected = {
      encryption: "ai",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @encoder.report(:encryption, "ai", "02715", "040895")
  end

  def test_it_can_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @encoder.encrypt("hello world", "02715", "040895")

    expected = {
      encryption: "ke(eo)gtz*jeg?",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @encoder.encrypt("he(ll)o w*rld?", "02715", "040895")
  end

  def test_it_can_encrypt_with_no_date_argument
    expected = {
      encryption: "nib udmcxpu",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @encoder.encrypt("hello world", "02715")

    expected = {
      encryption: "nib u,qkuvbs\nlz\nnm",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @encoder.encrypt("hello, world\nhi\nhi", "02715")
  end

  def test_it_can_encrypt_with_no_key_or_date_argument
    @encoder.stubs(:random_key).returns("10482")
    expected = {
      encryption: "vmfmbhqpety",
      key: "10482",
      date: "120120"
    }

    assert_equal expected, @encoder.encrypt("hello world")

    expected = {
      encryption: "@(bfl{*$)!@}?)",
      key: "10482",
      date: "120120"
    }

    assert_equal expected, @encoder.encrypt("@(hey{*$)!@}?)")
  end

  def test_two_keys_can_generate_same_ciphertext
    example1 = @encoder.encrypt("hello world", "90366", "040895")
    example2 = @encoder.encrypt("hello world", "63093", "040895")

    assert_equal true, example1[:encryption] == example2[:encryption]
    assert_equal true, example1[:key] != example2[:key]
  end
end
