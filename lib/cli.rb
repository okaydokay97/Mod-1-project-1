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


  def write_review
    if Review.all.find{|review| review.user.id == @@user.id}
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
  end

  def delete_review
     found_reviews = Review.where(user: @@user.id)
     puts "Would You like To Delete Your Game Review? 'Y/N'"
     puts "------------------------------------------\n\n"
     puts found_reviews.map {|review| "#{review.user_review} \n   Rating: #{review.user_rating}\n\n"}
     user_input = gets.chomp
     selected_review_instance = Review.find_by(id: user_input)
     puts
     puts "Are You Sure? 'Y/N'\n\n"
     user_input = gets.chomp.downcase
     puts
     if user_input == "y"
       selected_review_instance.delete 
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
        end
      end
      puts `clear`
      puts "Thanks For Visting!"
  end
end
