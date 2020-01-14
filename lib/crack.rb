require './lib/enigma'

enigma = Enigma.new
date = ARGV[2]

handle = File.open(ARGV[0], "r")

ciphertext = handle.read.chomp

handle.close

crack_info = enigma.crack(ciphertext, date)

writer = File.open(ARGV[1], "w")

writer.write(crack_info[:decryption])

writer.close

puts "Created '#{writer.path}' with the cracked key #{crack_info[:key]} and date #{crack_info[:date]}"
