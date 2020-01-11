class EnigmaEncoder

  def initialize
    @whitelist = ('a'..'z').to_a << ' '
  end

  def keys(key)
    key.split('').each_cons(2).map {|a,b| a + b}
  end

  def offset(date)
    (date.to_i**2).to_s[-4..-1].split('')
  end

  def shifts(keys, offset)
    keys.map.with_index do |key, index|
      key.to_i + offset[index].to_i
    end
  end

  def caesar_cipher_shift(character, shift)
    index = @whitelist.index(character.downcase)
    index ? @whitelist.rotate(shift)[index] : character
  end
end
