require_relative "test_helper"
require './lib/crypto_tool'

class CryptoToolTest < Minitest::Test

  def setup
    @crypto_tool = CryptoTool.new
  end

  def test_it_exists
    assert_instance_of CryptoTool, @crypto_tool
  end

  def test_it_can_set_keys
    assert_equal ["02", "27", "71", "15"], @crypto_tool.keys("02715")
  end

  def test_it_can_set_offset
    assert_equal ["1", "0", "2", "5"], @crypto_tool.offset("040895")
  end

  def test_it_can_set_shifts
    keys = @crypto_tool.keys("02715")
    offset = @crypto_tool.offset("040895")

    assert_equal [3, 27, 73, 20], @crypto_tool.shifts(keys, offset)
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

  def test_it_can_shift_a_message
    assert_equal "ifmmp,axpsme!", @crypto_tool.shift_message("Hello, world!", 1)
    assert_equal "gdkkn,zvnqkc!", @crypto_tool.shift_message("Hello, world!", -1)
    assert_equal "hello, world!", @crypto_tool.shift_message("Hello, world!", 0)
  end
end
