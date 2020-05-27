require_relative '../config/environment'

ActiveRecord::Base.logger.level = 1 # or Logger::INFO

puts `clear`
puts
puts "*" * 20
puts


cli = CommandLineInterface.new
cli.select_user
game = cli.select_game
if game
  puts `clear`
  puts "*" * 20
  puts "You have selected #{game.title}."
  puts "*" * 20
  puts
else
  puts "*" * 20
  puts "Game not found please try again"
  puts "*" * 20
end
action = cli.choose_action
binding.pry
0
