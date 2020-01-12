require './lib/crypto_tool'

class Encoder < CryptoTool

  def random_key
    rand.to_s[2..6]
  end

  def encrypt(message, key = nil, date = nil)
    date = today if date.nil?
    key = random_key if key.nil?
    shifts = shifts(keys(key), offset(date))
    encryption = shift_all(message, shifts)
    report(:encryption, encryption, key, date)
  end
end
