require_relative "test_helper"
require "./lib/enigma"

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_instance_of Encoder, @enigma.encoder
    assert_instance_of Decoder, @enigma.decoder
    assert_instance_of Cracker, @enigma.cracker
  end
end
