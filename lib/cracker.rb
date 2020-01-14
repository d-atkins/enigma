require './lib/decoder'

class Cracker < Decoder

  def shifts(cipher_length, cipher_end, known_end = " end")
    cipher_end.split('').zip(known_end.split('')).map do |cipher_char, known_char|
      shift = @whitelist.index(cipher_char) - @whitelist.index(known_char)
      shift += 27 if shift < 0
      shift
    end.rotate(-(cipher_length % 4))
  end

  def base_keys(shifts, offset)
    shifts.zip(offset).map {|shift, subtrahend| shift - subtrahend.to_i}
  end
end
