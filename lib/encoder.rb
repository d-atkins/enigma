require './lib/crypto_tool'

class Encoder < CryptoTool

  def random_key
    key = "00000"
    key.split('').map {|char| rand(10).to_s}.join
  end

  def encrypt(message, key = nil, date = nil)
    date = today if date.nil?
    key = random_key if key.nil?
    shifts = shifts(keys(key), offset(date))
    encryption = shift_all(message, shifts)
    report(:encryption, encryption, key, date)
  end
end
