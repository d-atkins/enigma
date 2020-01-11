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
    keys.zip(offset).map {|key, off| key.to_i + off.to_i }
  end

  def caesar_shift(character, shift)
    index = @whitelist.index(character.downcase)
    index ? @whitelist.rotate(shift)[index] : character
  end

  def encryption_info(encryption, key, date)
    {encryption: encryption, key: key, date: date}
  end

  #possible to-do: make a "run_message_through_caesar_shifts" super method
  def encrypt(message, key = nil, date = nil)
    enigma_shifts = shifts(keys(key), offset(date)).rotate(-1)
    encryption = message.split('').map do |character|
      enigma_shifts = enigma_shifts.rotate
      caesar_shift(character, enigma_shifts[0])
    end.join
    encryption_info(encryption, key, date)
  end
end
