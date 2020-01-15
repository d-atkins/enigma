require './lib/decoder'

class Cracker < Decoder

  def reverse_shifts(ciphertext, known_end = " end")
    last_four = ciphertext[-known_end.length..-1].split('')
    last_four.zip(known_end.split('')).map do |cipher_char, known_char|
      shift = @whitelist.index(cipher_char) - @whitelist.index(known_char)
      shift.negative? ? (shift + @whitelist.length) : shift
    end.rotate(-(ciphertext.length % known_end.length))
  end

  def root_codes(shifts, offsets)
    shifts.zip(offsets).map {|shift, offset| shift - offset.to_i}
  end

  def full_shift(code)
    code + @whitelist.length
  end

  def code_to_string(code)
    code.to_s.length < 2 ? code.to_s.prepend("0") : code.to_s
  end

  def potential_codes(root_codes)
    root_codes.map do |code|
      codes = [code]
      codes << full_shift(codes.last) until full_shift(codes.last) > 99
      codes.map {|potential_code| code_to_string(potential_code)}
    end
  end

  def all_combinations(code_arrays)
    code_arrays[0].product(code_arrays[1], code_arrays[2], code_arrays[3])
  end

  def chains_together?(combination)
    combination.each_cons(2).all? {|code1, code2| code1[1] == code2[0]}
  end

  def valid_codes(all_combinations)
    all_combinations.find_all {|combination| chains_together?(combination)}
  end

  def key_from_codes(codes)
    codes.reduce("") {|acc, key| acc << key[0]} << codes.last[-1]
  end

  def prepare_keys(ciphertext, date)
    root_codes = root_codes(reverse_shifts(ciphertext), offsets(date))
    working_codes = valid_codes(all_combinations(potential_codes(root_codes)))
    working_codes.map {|codes| key_from_codes(codes)}
  end

  def crack(ciphertext, date = today)
    keys = prepare_keys(ciphertext, date)
    info = decrypt(ciphertext, keys.first, date)
    info[:key] = keys if keys.length > 1
    info
  end
end
