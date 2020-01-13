require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")

message = handle.read

handle.close

enigma_info = enigma.encrypt(message)

writer = File.open(ARGV[1], "w")

writer.write(enigma_info[:encryption])

writer.close

puts "Created '#{writer.path}' with the key #{enigma_info[:key]} and date #{enigma_info[:date]}"
