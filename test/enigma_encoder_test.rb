require_relative "test_helper"
require "./lib/enigma_encoder"

class EnigmaEncoderTest < Minitest::Test

  def setup
    @encoder = EnigmaEncoder.new
  end

  def test_it_exists
    assert_instance_of EnigmaEncoder, @encoder
  end

  def test_it_can_set_keys
    assert_equal ["02", "27", "71", "15"], @encoder.keys("02715")
  end

  def test_it_can_set_offset
    assert_equal ["1", "0", "2", "5"], @encoder.offset("040895")
  end

  def test_it_can_set_shifts
    keys = @encoder.keys("02715")
    offset = @encoder.offset("040895")

    assert_equal [3, 27, 73, 20], @encoder.shifts(keys, offset)
  end

  def test_it_can_caesar_cipher_shift
    assert_equal "m", @encoder.caesar_cipher_shift("l", 1)
    assert_equal "b", @encoder.caesar_cipher_shift("Z", 3)
    assert_equal " ", @encoder.caesar_cipher_shift("a", -1)
    assert_equal "q", @encoder.caesar_cipher_shift("Q", 54)
    assert_equal ",", @encoder.caesar_cipher_shift(",", 3)
    assert_equal "!", @encoder.caesar_cipher_shift("!", 7)
    assert_equal "?", @encoder.caesar_cipher_shift("?", 800)
  end
end
