require_relative '../config/environment'

puts `clear`
puts
puts "*" * 20
puts


cli = CommandLineInterface.new
game = cli.select_game
if game
  puts "*" * 20
  puts game.reviews
  puts "*" * 20
else
  puts "*" * 20
  puts "Game not found please try again"
  puts "*" * 20
end
action = cli.choose_action
binding.pry
0
