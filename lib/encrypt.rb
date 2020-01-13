require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")

message = handle.read

handle.close

encrypted_info = enigma.encrypt(message)

writer = File.open(ARGV[1], "w")

writer.write(encrypted_info[:encryption])

writer.close

puts "Created '#{writer.path}' with the key #{encrypted_info[:key]} and date #{encrypted_info[:date]}"
