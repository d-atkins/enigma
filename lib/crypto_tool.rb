class CryptoTool

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
    keys.zip(offset).map {|key, off| key.to_i + off.to_i }
  end

  def caesar_shift(character, shift)
    index = @whitelist.index(character.downcase)
    index ? @whitelist.rotate(shift)[index] : character
  end

  def shift_message(message, shift)
    message.split('').map {|char| caesar_shift(char, shift)}.join
  end
end
