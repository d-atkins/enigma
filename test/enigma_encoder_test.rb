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
    assert_equal "02277115", @encoder.keys("02715")
  end

  def test_it_can_set_offset
    assert_equal "1025", @encoder.offset("040895")
  end

  def test_it_can_make_key_hash
    assert_equal ({a:1, b:2, c:3, d:4}), @encoder.key_hash("1234")
    assert_equal ({a:15, b:26, c:37, d:48}), @encoder.key_hash("15263748")
  end
end
