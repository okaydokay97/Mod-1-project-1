class CommandLineInterface

  def select_game
      puts "Here is our selection of video games:"
      puts "1. Breath of the Wild \n2. Sonic '06"
      puts
      puts "Enter an title:"
      puts
      game = gets.chomp
      @@game = VideoGame.find_by(title: game)
      @@game_id = @@game.id
      VideoGame.find_by(title: game)

      # puts "Not sure what game to get?  Check out some reviews!"
      # puts list of games goes here
      # user will select a game, using tty?
      # VideoGame.find_by(title: user_input)
  end

  def select_user
    puts "Please enter your name."
    puts
    puts "***********************"
    puts
    name = gets.chomp 
    puts `clear`
    puts "Hi #{name}, welcome to OhYea, the largest online video game store in Ohio."
    puts "--------------------------------------------------------------------------"
    puts
    @@user = User.find_by(username: name)
  end

  def return_to_main_menu
    puts "Please Press Enter To Return To Menu"
    gets.chomp
    puts `clear`
  end

  def choose_action
    puts "What would you like to do?"
    puts
    puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \n\nType `exit` to leave"
    puts
    user_input = gets.chomp

      while user_input != "exit"
        case user_input
        when "1"
          #Creating a review

          # NEED A WAY TO VALIDATE IF USER ALREADY POSTED REVIEW, IF SO, END THIS #
          if Review.all.find{|review| review.user.id == @@user.id}
            puts "You've Already Written A Review For This Game! \n\nWould You Like To Update Your Existing Review? 'Y/N'\n"
            user_input = gets.chomp.downcase
            puts
            if user_input == "y"
              user_input = 3

            else
              puts
              return_to_main_menu
            end
          else
            puts "Please Write A Review"
            puts
            new_review = gets.chomp
            puts
            puts "Please Enter A Rating"
            puts
            new_rating = gets.chomp.to_i
            Review.create(user_review: new_review, user_rating: new_rating, user: @@user, video_game: @@game)
            puts
            puts "Review Added!"
            puts
            puts "-------------"
            puts 
            return_to_main_menu
          end

        when "2"
          #Reading a review
          puts "Here are the reviews!"
          puts "---------------------"
          puts
          review_instances_arr = Review.where(video_game: @@game_id)
          review_instances_arr.map do |game|
            puts "#{game.user.username} says: '#{game.user_review}.' \nRating: #{game.user_rating}\n\n"
          end
          puts 
          puts "---------------------"
          puts 
          return_to_main_menu

          
        when "3"
          #Updating a review
          found_reviews = Review.where(user: @@user.id)
          puts
          puts "Please Select The Review Number To Update:"
          puts "------------------------------------------"
          puts
          puts found_reviews.map {|review| "#{review.id}. #{review.user_review} \n   Rating: #{review.user_rating}\n\n"}
          user_input = gets.chomp
          selected_review_instance = Review.find_by(id: user_input)
          puts
          puts "********************************"
          puts "Please Enter Your Updated Review"
          puts "********************************"
          puts
          new_review = gets.chomp
          puts
          updated_review = selected_review_instance.update(user_review: new_review)
          puts "Updated Your Review To '#{new_review}'!"
          puts
          puts "********************************"
          puts "Please Enter Your Updated Rating"
          puts "********************************"
          puts
          new_rating = gets.chomp
          puts
          updated_rating = selected_review_instance.update(user_rating: new_rating)
          puts "Updated Your Rating To '#{new_rating}'!"
          puts
          puts "------------------------------------------"
          puts 
          return_to_main_menu
        
        when "4"
          #Deleting a review

          found_reviews = Review.where(user: @@user.id)
          puts "What Review Would You Like To Delete?"
          puts "-------------------------------------"
          puts 
          puts found_reviews.map {|review| "#{review.id}. #{review.user_review} \n   Rating: #{review.user_rating}\n\n"}
          user_input = gets.chomp
          selected_review_instance = Review.find_by(id: user_input)
          puts
          puts 'Are You Sure? "Y/N"'
          puts 
          puts
          user_input = gets.chomp 
          puts
          case user_input
          when user_input == "Y" || "y"
            selected_review_instance.delete 
            puts
            puts "Review Has Been Deleted!"
            puts 
            puts "------------------------"
            puts 
            return_to_main_menu
          when user_input == "N" || "n"
            puts "Review Not Deleted!"
            puts 
            puts "-----------------------"
            puts
            return_to_main_menu
          end
        end
        puts "What Would You Like To Do?"
        puts
        puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \n\nType `exit` to leave"
        puts
        user_input = gets.chomp
        puts
      end
  end
end
