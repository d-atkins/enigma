require './lib/crypto_tool'

class Decoder < CryptoTool

  def invert_shifts(shifts)
    shifts.map{|shift| -shift}
  end

  def decrypt(ciphertext, key, date = today)
    inverted_shifts = invert_shifts(shifts(codes(key), offsets(date)))
    decryption = shift_all(ciphertext, inverted_shifts)
    report(:decryption, decryption, key, date)
  end
end
