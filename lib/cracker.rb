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

  def full_shift(key)
    key + @whitelist.length
  end

  def key_to_string(key)
    key.to_s.length < 2 ? key.to_s.prepend("0") : key.to_s
  end

  def potential_keys(base_keys)
    base_keys.map do |key|
      keys = [key_to_string(key)]
      until full_shift(keys.last.to_i) > 99 do
        keys << key_to_string(full_shift(keys.last.to_i))
      end
      keys
    end
  end

  def all_potential_key_combinations(potential_keys)
    potential_keys[0].product(potential_keys[1], potential_keys[2], potential_keys[3])
  end

  def working_key_combinations(all_potential_key_combinations)
    all_potential_key_combinations.find_all do |combination|
      combination.each_cons(2).all? {|first_char, second_char| first_char[1] == second_char[0]}
    end
  end
end
