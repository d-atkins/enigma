require_relative 'test_helper'
require './lib/crypto_tool'
require 'time'
require 'mocha/minitest'

class CryptoToolTest < Minitest::Test

  def setup
    @crypto_tool = CryptoTool.new
  end

  def test_it_exists
    assert_instance_of CryptoTool, @crypto_tool
  end

  def test_it_can_get_todays_date
    dummy_time = Time.parse("2020-1-1")
    Time.stubs(:now).returns(dummy_time)
    assert_equal "010120", @crypto_tool.today
  end

  def test_it_can_set_keys
    assert_equal ["02", "27", "71", "15"], @crypto_tool.keys("02715")
  end

  def test_it_can_set_offsets
    assert_equal ["1", "0", "2", "5"], @crypto_tool.offsets("040895")
  end

  def test_it_can_set_shifts
    keys = @crypto_tool.keys("02715")
    offsets = @crypto_tool.offsets("040895")

    assert_equal [3, 27, 73, 20], @crypto_tool.shifts(keys, offsets)
  end

  def test_it_can_caesar_shift
    assert_equal "m", @crypto_tool.caesar_shift("l", 1)
    assert_equal "b", @crypto_tool.caesar_shift("Z", 3)
    assert_equal " ", @crypto_tool.caesar_shift("a", -1)
    assert_equal "q", @crypto_tool.caesar_shift("Q", 54)
    assert_equal ",", @crypto_tool.caesar_shift(",", 3)
    assert_equal "!", @crypto_tool.caesar_shift("!", -7)
    assert_equal "d", @crypto_tool.caesar_shift("z", 815)
    assert_equal "g", @crypto_tool.caesar_shift("g", 0)
  end

  def test_it_can_caesar_shift_all_characters_of_a_message
    shifts = [3, 27, 73, 20]
    unshifts = [-3, -27, -73, -20]

    assert_equal "keder ohulw", @crypto_tool.shift_all("hello world", shifts)
    assert_equal "hello world", @crypto_tool.shift_all("keder ohulw", unshifts)
  end

  def test_it_can_format_a_report
    expected = {
      encryption: "ai",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @crypto_tool.report(:encryption, "ai", "02715", "040895")
  end
end
