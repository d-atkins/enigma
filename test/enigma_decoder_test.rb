require_relative "test_helper"
require "./lib/enigma_decoder"

class EnigmaDecoderTest < Minitest::Test
  
  def test_it_exists
    decoder = EnigmaDecoder.new

    assert_instance_of EnigmaDecoder, decoder
  end
end
