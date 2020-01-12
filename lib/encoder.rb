require './lib/crypto_tool'

class Encoder < CryptoTool

  def initialize
    @whitelist = ('a'..'z').to_a << ' '
  end

  # def encryption_info(encryption, key, date)
  #   {encryption: encryption, key: key, date: date}
  # end

  def encrypt(message, key = nil, date = nil)
    shifts = shifts(keys(key), offset(date))
    encryption = shift_all(message, shifts)
    report(:encryption, encryption, key, date)
  end
end
