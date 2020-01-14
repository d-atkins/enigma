require './lib/decoder'

class Cracker < Decoder

  def reverse_shifts(ciphertext, known_end = " end")
    last_four = ciphertext[-known_end.length..-1].split('')
    last_four.zip(known_end.split('')).map do |cipher_char, known_char|
      shift = @whitelist.index(cipher_char) - @whitelist.index(known_char)
      shift.negative? ? (shift + @whitelist.length) : shift
    end.rotate(-(ciphertext.length % known_end.length))
  end

  def root_keys(shifts, offset)
    shifts.zip(offset).map {|shift, subtrahend| shift - subtrahend.to_i}
  end

  def full_shift(key)
    key + @whitelist.length
  end

  def key_to_string(key)
    key.to_s.length < 2 ? key.to_s.prepend("0") : key.to_s
  end

  def potential_keys(root_keys)
    root_keys.map do |key|
      keys = [key]
      keys << full_shift(keys.last) until full_shift(keys.last) > 99
      keys.map {|potential_key| key_to_string(potential_key)}
    end
  end

  def all_combinations(key_arrays)
    key_arrays[0].product(key_arrays[1], key_arrays[2], key_arrays[3])
  end

  def chains_together?(combination)
    combination.each_cons(2).all? {|char1, char2| char1[1] == char2[0]}
  end

  def valid_keys(all_combinations)
    all_combinations.find_all {|combination| chains_together?(combination)}
  end

  def derive_key(keys)
    keys.reduce("") {|acc, key| acc << key[0]} << keys.last[-1]
  end

  def prepare_keys(ciphertext, date)
    root_keys = root_keys(reverse_shifts(ciphertext), offset(date))
    working_keys = valid_keys(all_combinations(potential_keys(root_keys)))
    working_keys.map {|keys| derive_key(keys)}
  end

  def crack(ciphertext, date = today)
    keys = prepare_keys(ciphertext, date)
    info = decrypt(ciphertext, keys.first, date)
    info[:key] = keys if keys.length > 1
    info
  end
end
