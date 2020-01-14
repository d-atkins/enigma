require './lib/crypto_tool'

class Decoder < CryptoTool

  def reverse_shifts(shifts)
    shifts.map{|shift| -shift}
  end

  def decrypt(ciphertext, key, date = today)
    shifts = shifts(keys(key), offset(date)).map{|shift| -shift}
    decryption = shift_all(ciphertext, shifts)
    report(:decryption, decryption, key, date)
  end
end
