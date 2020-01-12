require './lib/crypto_tool'

class Encoder < CryptoTool

  def encrypt(message, key = nil, date = nil)
    date = today if date.nil?
    shifts = shifts(keys(key), offset(date))
    encryption = shift_all(message, shifts)
    report(:encryption, encryption, key, date)
  end
end
