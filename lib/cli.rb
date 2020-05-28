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

      # user will select a game, using tty?
  end

  def select_user
    puts `clear`
    puts "Please enter your name."
    puts
    puts "***********************"
    puts
    name = gets.chomp
    if User.find_by(username: name)
      puts `clear`
      puts "Hi #{name}, welcome to OhYea, the largest online video game store in Ohio."
      puts "--------------------------------------------------------------------------"
      puts
      @@user = User.find_by(username: name)
    else
      puts "It looks like you don't have an account with us."
      puts "Would you like to create an account? 'Y/N'"
      user_input = gets.chomp.downcase
      if user_input == "y"
        create_user
      else
        select_user
      end
    end
  end

  def main_menu
    puts "What would you like to do?"
    puts
    puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \n5. Exit"
    puts
    gets.chomp
  end

  def return_to_main_menu
    puts "Please Press Enter To Return To Menu"
    gets.chomp
    puts `clear`
  end

  # def get_review_relation
  #   Review.where(user: @@user.id, video_game: @@game_id)
  # end

  def get_review
    Review.all.find{|review| review.user.id == @@user.id && review.video_game.id == @@game_id}
  end

  def create_user
    puts "Please enter your username:"
    user_name = gets.chomp
    puts "Please enter your age:"
    user_age = gets.chomp
    User.create(username: user_name, age: user_age)
    puts "Your username and age have been registered."
    sleep(5)
    select_user
  end


  def write_review
    if get_review
    puts "You've Already Written A Review For This Game! \n\nWould You Like To Update Your Existing Review? 'Y/N'\n"
    user_input = gets.chomp.downcase
    puts
      if user_input == "y"
        update_review
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
  end

  def read_review
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
  end

  def update_review
    if get_review
      # found_reviews = get_review_relation
      puts
      puts "Would you like to update this review? 'Y/N'"
      puts "------------------------------------------"
      puts
      # puts found_reviews.map {|review| "#{review.user_review} \n   Rating: #{review.user_rating}\n\n"}
      puts "#{get_review.user_review} \n Rating: #{get_review.user_rating}\n\n"
      user_input = gets.chomp.downcase
      if user_input == "y"
        review_to_update = Review.find_by(user: @@user.id, video_game: @@game_id)
        puts
        puts "********************************"
        puts "Please Enter Your Updated Review"
        puts "********************************"
        puts
        new_review = gets.chomp
        puts
        updated_review = review_to_update.update(user_review: new_review)
        puts "Updated Your Review To '#{new_review}'!"
        puts
        puts "********************************"
        puts "Please Enter Your Updated Rating"
        puts "********************************"
        puts
        new_rating = gets.chomp
        puts
        updated_rating = review_to_update.update(user_rating: new_rating)
        puts "Updated Your Rating To '#{new_rating}'!"
        puts
        puts "Your review has been successfully updated."
        puts
        puts "------------------------------------------"
        puts
        return_to_main_menu
      else
        return_to_main_menu
      end
    else
      puts "It looks like you haven't written a review for this game yet."
      puts "Would you like to write a review? 'Y/N'"
      user_input = gets.chomp.downcase
      if user_input == "y"
        write_review
      else
        return_to_main_menu
      end
    end
  end

  def delete_review
    if get_review
       # found_reviews = get_review_relation
       puts "Would You like To Delete Your Game Review? 'Y/N'"
       puts "------------------------------------------\n\n"
       # puts found_reviews.map {|review| "#{review.user_review} \n   Rating: #{review.user_rating}\n\n"}
       puts "#{get_review.user_review} \n Rating: #{get_review.user_rating}\n\n"
       user_input = gets.chomp.downcase
       if user_input == "n"
         return_to_main_menu
       else
         # review_to_delete = Review.find_by(user: @@user.id, video_game: @@game_id)
         puts
         puts "Are You Sure? 'Y/N'\n\n"
         user_input = gets.chomp.downcase
         puts
         if user_input == "y"
           Review.find_by(user: @@user.id, video_game: @@game_id).delete
           puts
           puts "Review Has Been Deleted!"
           puts
           puts "------------------------"
           puts
           return_to_main_menu
         else
           puts "Review Not Deleted!"
           puts
           puts "-----------------------"
           puts
           return_to_main_menu
          end
      end
    else
      puts "You have not yet written a review for this game."
      puts
      return_to_main_menu
    end
  end

  def choose_action
    user_input = "start"
      while user_input != "5"
        user_input = main_menu
        case user_input
        when "1"
          puts `clear`
          write_review
        when "2"
          puts `clear`
          read_review
        when "3"
          puts `clear`
          update_review
        when "4"
          puts `clear`
          delete_review
        # when "6"
        #   `mpv https://www.youtube.com/watch?v=dQw4w9WgXcQ`
        end
      end
      puts `clear`
      puts "Thanks For Visting!"
      binding.pry
  end
end
