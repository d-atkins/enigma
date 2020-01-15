require './lib/crypto_tool'

class Encoder < CryptoTool

  def random_key
    key = "00000"
    key.split('').map {|char| rand(10).to_s}.join
  end

  def encrypt(message, key = random_key, date = today)
    shifts = shifts(keys(key), offsets(date))
    encryption = shift_all(message, shifts)
    report(:encryption, encryption, key, date)
  end
end
