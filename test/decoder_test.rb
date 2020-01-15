require_relative "test_helper"
require "./lib/decoder"
require 'time'
require 'mocha/minitest'

class DecoderTest < Minitest::Test

  def setup
    dummy_time = Time.parse("2020-1-12")
    Time.stubs(:now).returns(dummy_time)
    @decoder = Decoder.new
  end

  def test_it_exists
    assert_instance_of Decoder, @decoder
  end

  def test_it_can_get_todays_date
    assert_equal "120120", @decoder.today
  end

  def test_it_can_set_codes
    assert_equal ["02", "27", "71", "15"], @decoder.codes("02715")
  end

  def test_it_can_set_offsets
    assert_equal ["1", "0", "2", "5"], @decoder.offsets("040895")
  end

  def test_it_can_set_shifts
    codes = @decoder.codes("02715")
    offsets = @decoder.offsets("040895")

    assert_equal [3, 27, 73, 20], @decoder.shifts(codes, offsets)
  end

  def test_it_can_caesar_shift
    assert_equal "m", @decoder.caesar_shift("l", 1)
    assert_equal "b", @decoder.caesar_shift("Z", 3)
    assert_equal " ", @decoder.caesar_shift("a", -1)
    assert_equal "q", @decoder.caesar_shift("Q", 54)
    assert_equal ",", @decoder.caesar_shift(",", 3)
    assert_equal "!", @decoder.caesar_shift("!", -7)
    assert_equal "d", @decoder.caesar_shift("z", 815)
    assert_equal "g", @decoder.caesar_shift("g", 0)
  end

  def test_it_can_report_info
    expected = {
      decryption: "ai",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decoder.report(:decryption, "ai", "02715", "040895")
  end

  def test_it_can_invert_shifts
    assert_equal [-1, -2, -3, -4], @decoder.invert_shifts([1,2,3,4])
  end

  def test_it_can_decrypt
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decoder.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_decrypt_with_no_date_argument
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @decoder.decrypt("nib udmcxpu", "02715")
  end
end
