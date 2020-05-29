class CommandLineInterface
  def display_games
    puts "Here Is Our Selection Of Video Games:"
    puts "1. Breath of the Wild \n2. Sonic '06"
    puts
    puts "Please Enter A Title:\n\n"
    puts
  end

  def display_selected_game
    puts "*" * (19 + @@game.title.length)
    puts "You have selected #{@@game.title}."
    puts "*" * (19 + @@game.title.length)
    puts
  end

  def select_game
    display_games
    game = gets.chomp
    @@game = VideoGame.find_by(title: game)
    while !@@game
      puts `clear`
      puts "*" * 31
      puts "Game not found please try again"
      puts "*" * 31
      puts
      display_games
      game = gets.chomp
      @@game = VideoGame.find_by(title: game)
    end
    @@game_id = @@game.id 
    puts `clear`
    VideoGame.find_by(title: @@game)
    # user will select a game, using tty?
  end

  def select_user
    puts `clear`
    puts "***************************"
    puts 
    puts "Please Enter Your Username."
    puts
    puts "***************************"
    puts
    name = gets.chomp
    if User.find_by(username: name)
      puts `clear`
      puts "Hi #{name}, Welcome To OhYea, The Largest Online Video Game Store In Ohio."
      puts "-" * (67 + name.length)
      puts
      @@user = User.find_by(username: name)
    else
      puts
      puts "It Looks Like You Don't Have An Account With Us."
      puts "Would You Like To Create An Account? 'Y/N'"
      puts
      user_input = gets.chomp.downcase
      if user_input == "y"
        create_user
      else
        puts `clear`
        puts "You Must Have An Account To Access Reviews"
        sleep(3)
        select_user
      end
    end
  end

  def main_menu
    puts `clear`
    display_selected_game
    puts "What Would You Like To Do?"
    puts
    puts "1. Write A Review \n2. Read Reviews \n3. Update Your Review \n4. Delete Your Review \n5. Exit"
    puts
    gets.chomp
  end

  def return_to_main_menu
    puts "\nPlease Press Enter To Return To Menu\n"
    gets.chomp
    puts `clear`
  end


  def get_review
    Review.all.find{|review| review.user.id == @@user.id && review.video_game.id == @@game_id}
  end

  def create_user
    puts `clear`
    puts "\nPlease Enter Your Username:\n\n"
    user_name = gets.chomp
    while user_name == "" || user_name.include?(" ")
      puts `clear`
      puts "Your Username Can Not Be Empty Or Contain Spaces\n\n"
      user_name = gets.chomp 
    end
    puts "\nPlease Enter Your Age:\n\n"
    user_age = gets.chomp
    while (1..99).to_a.include?(user_age.to_i) == false
      puts `clear`
      puts "Please Enter A Valid Age"
      user_age = gets.chomp
      (1..99).to_a.include?(user_age.to_i)
    end
    User.create(username: user_name, age: user_age)
    puts "Your Username And Age Have Been Registered."
    sleep(3)
    select_user
  end


  def write_review
    if get_review
    puts `clear`
    puts "You've Already Written A Review For This Game! \n\nWould You Like To Update Your Existing Review? 'Y/N'\n\n"
    puts 
    user_input = gets.chomp.downcase
    puts
      if user_input == "y"
        update_review
      else
        puts
        return_to_main_menu
      end
    else
      puts `clear`
      puts "Please Write A Review"
      puts
      new_review = gets.chomp
      puts
      puts "Please Enter A Rating From One To Five"
      puts
      new_rating = gets.chomp.to_i
      while [1, 2, 3, 4, 5].include?(new_rating) == false
        puts `clear`
        puts "Please Enter A Valid Rating From One To Five\n\n"
        new_rating = gets.chomp.to_i
        [1, 2, 3, 4, 5].include?(new_rating)
      end
      Review.create(user_review: new_review, user_rating: new_rating, user: @@user, video_game: @@game)
      puts
      puts
      puts "Review Added!"
      puts "-------------"
      puts
      return_to_main_menu
    end
  end

  def read_review
    puts "Here Are The Reviews!"
    puts "---------------------"
    puts
    review_instances_arr = Review.where(video_game: @@game_id)
    review_instances_arr.map do |game|
      puts "#{game.user.username} says: '#{game.user_review}'. \nRating: #{game.user_rating}/5\n\n"
    end
    puts "---------------------"
    puts
    return_to_main_menu
  end

  def update_review
    if get_review
      puts `clear`
      puts "Would You Like To Update This Review? 'Y/N'"
      puts "------------------------------------------"
      puts
      puts "#{get_review.user_review} \nRating: #{get_review.user_rating}/5 \n\n"
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
        puts "*************************************************"
        puts "Please Enter Your Updated Rating From One To Five"
        puts "*************************************************"
        puts
        new_rating = gets.chomp
        while [1, 2, 3, 4, 5].include?(new_rating) == false
          puts `clear`
          puts "Please Enter A Valid Rating From One To Five\n\n"
          new_rating = gets.chomp.to_i
          [1, 2, 3, 4, 5].include?(new_rating)
        end
        puts
        updated_rating = review_to_update.update(user_rating: new_rating)
        puts "Updated Your Rating To '#{new_rating}/5'!"
        puts
        puts "Your Review Has Been Successfully Updated."
        puts
        puts "------------------------------------------"
        puts
        return_to_main_menu
      else
        return_to_main_menu
      end
    else
      puts "It Looks Like You Haven't Written A Review For This Game Yet."
      puts "Would You Like To Write A Review? 'Y/N'"
      puts
      user_input = gets.chomp.downcase
      puts
      if user_input == "y"
        write_review
      else
        return_to_main_menu
      end
    end
  end

  def delete_review
    if get_review
       puts "Would You like To Delete Your Game Review? 'Y/N'"
       puts "------------------------------------------------\n\n"
       puts "#{get_review.user_review} \n Rating: #{get_review.user_rating}/5\n\n\n"
       user_input = gets.chomp.downcase
       if user_input == "n"
         return_to_main_menu
       else
        puts
        puts "Are You Sure? 'Y/N'\n\n\n"
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
      puts "You Have Not Written A Review For This Game."
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
      puts "\n\nThanks For Visting!\n\n\n"
  end
end
