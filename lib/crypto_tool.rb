require 'date'

class CryptoTool

  def initialize
    @whitelist = ('a'..'z').to_a << ' '
  end

  def today
    Time.now.strftime("%d/%m/%y").delete('/')
  end

  def codes(key)
    key.split('').each_cons(2).map {|a,b| a + b}
  end

  def offsets(date)
    (date.to_i**2).to_s[-4..-1].split('')
  end

  def shifts(codes, offsets)
    codes.zip(offsets).map {|key, offset| key.to_i + offset.to_i}
  end

  def caesar_shift(character, shift)
    index = @whitelist.index(character.downcase)
    index ? @whitelist.rotate(shift % @whitelist.length)[index] : character
  end

  def shift_all(message, shifts)
    message.split('').map do |character|
      shifted_character = caesar_shift(character, shifts[0])
      shifts.rotate!
      shifted_character
    end.join
  end

  def report(type, message, key, date)
    {type => message, key: key, date: date}
  end
end
