require './lib/crypto_tool'

class Decoder < CryptoTool

  def decrypt(ciphertext, key, date = nil)
    date = today if date.nil?
    shifts = shifts(keys(key), offset(date)).map{|shift| -shift}
    decryption = shift_all(ciphertext, shifts)
    report(:decryption, decryption, key, date)
  end
end
