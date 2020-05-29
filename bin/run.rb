require_relative '../config/environment'

ActiveRecord::Base.logger.level = 1 # or Logger::INFO

puts `clear`
puts
puts "*" * 23
puts


cli = CommandLineInterface.new
cli.select_user
cli.select_game
cli.choose_action
# binding.pry
# 0
