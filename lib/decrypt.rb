require './lib/enigma'

enigma = Enigma.new
key = ARGV[2]
date = ARGV[3]

handle = File.open(ARGV[0], "r")

ciphertext = handle.read

handle.close

decrypted_info = enigma.decrypt(ciphertext, key, date)

writer = File.open(ARGV[1], "w")

writer.write(decrypted_info[:decryption])

writer.close

puts "Created '#{writer.path}' with the key #{decrypted_info[:key]} and date #{decrypted_info[:date]}"
