class CommandLineInterface

  def select_game
      puts "Welcome to OhYea, the largest online video game store in Ohio."
      puts "Here is our selection of video games:"
      puts "1. Breath of the Wild \n2. Sonic '06"
      puts "Enter an title:"
      game = gets.chomp
      @@game_id = VideoGame.find_by(title: game).id
      VideoGame.find_by(title: game)

      # puts "Not sure what game to get?  Check out some reviews!"
      # puts list of games goes here
      # user will select a game, using tty?
      # VideoGame.find_by(title: user_input)
  end

  def choose_action
    puts "What would you like to do?"
    puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \ntype `exit` to leave"
    user_input = gets.chomp

      while user_input != "exit"
        case user_input
        when "1"
          #Creating a review
          puts "Please Write a review"
        when "2"
          #Reading a review
          puts "Here are the reviews!"
          review_instances_arr = Review.where(video_game: @@game_id)
          review_instances_arr.map do |game|
            puts "#{game.user.username} says: '#{game.user_review}.'"
          end
        when "3"
          #Updating a review
          puts "Please write your updated review"
        when "4"
          #Deleting a review
          puts "Deleting your review..."
        end

        puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \ntype `exit` to leave"
        user_input = gets.chomp
      end
  end
end
