require './lib/encoder'
require './lib/decoder'
require './lib/cracker'

class Enigma
  attr_reader :encoder, :decoder, :cracker

  def initialize
    @encoder = Encoder.new
    @decoder = Decoder.new
    @cracker = Cracker.new
  end
end
