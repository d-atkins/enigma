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

  def test_it_can_set_shift
    keys = @encoder.keys("02715")
    offset = @encoder.offset("040895")
    
    assert_equal [2, 27, 73, 20], @encoder.shift(keys, offset)
  end
end
