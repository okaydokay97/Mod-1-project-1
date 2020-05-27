###  USER INFO ###
dan = User.create(username: 'Dan', age: 35)
rubens = User.create(username: 'Rubens', age: 22)

### VIDEO GAME INFO ###
zelda = VideoGame.create(title: "Breath of the Wild", genre: 'Open world RPG', console: 'Nintendo Switch')
sonic = VideoGame.create(title: "Sonic '06", genre: "chao simulator", console: "GameCube")

### REVIEW INFO ###
dan_review_one = Review.create(user_review: "This was a great game", user_rating: 5, user: dan, video_game: zelda)
dan_review_two = Review.create(user_review: "This was a bad game", user_rating: 2, user: dan, video_game: sonic)
rubens_review_one = Review.create(user_review: "This is a GOAT game", user_rating: 5, user: rubens, video_game: sonic)
