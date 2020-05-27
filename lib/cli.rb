class CommandLineInterface

  def greet
      puts "Welcome to OhYea, the largest online video game store in Ohio."
      puts "Here is our selection of video games:"
      puts "Enter a game:"
      user_input = gets.chomp
      VideoGame.find_by(title: user_input)

      puts "Not sure what game to get?  Check out some reviews!"
      # puts list of games goes here
      # user will select a game, using tty?


      # VideoGame.find_by(title: user_input)
  end



end
