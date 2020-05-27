require_relative '../config/environment'

puts `clear`
puts
puts "*" * 20
puts


cli = CommandLineInterface.new
game = cli.greet
if game
  puts "*" * 20
  puts game.reviews
  puts "*" * 20
else
  puts "*" * 20
  puts "game not found please try again"
  puts "*" * 20
end
binding.pry
0
