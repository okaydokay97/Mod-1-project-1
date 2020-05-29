User.destroy_all
Review.destroy_all
VideoGame.destroy_all


###  USER INFO ###
dan = User.create(username: 'Dan', age: 35)
rubens = User.create(username: 'Rubens', age: 22)

### VIDEO GAME INFO ###
zelda = VideoGame.create(title: "Breath of the Wild", genre: 'Open world RPG', console: 'Nintendo Switch')
sonic = VideoGame.create(title: "Sonic '06", genre: "chao simulator", console: "GameCube")
bioshock = VideoGame.create(title: "Bioshock", genre: "FPS", console: "Playstation")
mario = VideoGame.create(title: "Super Mario Odyssey", genre: "Platformer", console: "Switch")
warcraft = VideoGame.create(title: "World of Warcraft", genre: "MMORPG", console: "PC")

### REVIEW INFO ###
dan_review_one = Review.create(user_review: "This was a great game", user_rating: 5, user: dan, video_game: zelda)
dan_review_two = Review.create(user_review: "This was a bad game", user_rating: 2, user: dan, video_game: sonic)
rubens_review_one = Review.create(user_review: "This is a GOAT game", user_rating: 5, user: rubens, video_game: sonic)
