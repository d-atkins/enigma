require_relative "test_helper"
require "./lib/enigma_encoder"

class EnigmaEncoderTest < Minitest::Test
  
  def test_it_exists
    encoder = EnigmaEncoder.new

    assert_instance_of EnigmaEncoder, encoder
  end
end
