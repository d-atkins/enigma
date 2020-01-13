require_relative "test_helper"
require "./lib/decoder"

class DecoderTest < Minitest::Test

  def test_it_exists
    decoder = Decoder.new

    assert_instance_of Decoder, decoder
  end
end
