require './lib/enigma_encoder'
require './lib/enigma_decoder'
require './lib/enigma_cracker'

class Enigma
  attr_reader :encoder, :decoder, :cracker

  def initialize
    @encoder = EnigmaEncoder.new
    @decoder = EnigmaDecoder.new
    @cracker = EnigmaCracker.new
  end
end
