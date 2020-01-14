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

  def encrypt(message, key = @encoder.random_key, date = @encoder.today)
    @encoder.encrypt(message, key, date)
  end

  def decrypt(message, key, date = @decoder.today)
    @decoder.decrypt(message, key, date)
  end
end
