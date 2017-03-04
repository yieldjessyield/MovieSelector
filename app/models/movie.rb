class Movie < ApplicationRecord

	# collects all movies that were released before 1970
	def self.all_old_movies
		return self.all.select {|m| m.year != nil && m.year < 1970}
	end

	# collects all movies that include at least one of the genres passed in
	def self.all_genre_movies(my_genres)
		# data will be coming in as a string like this "Action|Sci-Fi"
		genres = my_genres.split("|")

		movies = self.all.select do |movie|
			genres.any? { |g| movie.genres.include?(g) }
		end
		return movies
	end

	# same as all_genre_movies, but only ones that are "old"
	def self.all_old_genre_movies(my_genres)
		genres = my_genres.split("|")
		old_movies = self.all_old_movies()
		movies = old_movies.select do |movie|
			genres.any? { |g| movie.genres.include?(g) }
		end
		return movies
	end

	# uses rating system to gather top 10 movies for user based on
	# user score and bonuses
	def self.get_top_10_movies_for_user(user)
		scores = []
	 	if user[:likes_old_movies]
	 		# if user liked old movies then grabs only old genre movies
	 		movies = self.all_old_genre_movies(user[:favorite_genres])
	 	else
	 		movies = self.all_genre_movies(user[:favorite_genres])
	 		# if not then grabs only genre movies
	 	end
	 	# iterate through grabbed movies and create objects from only useful
	 	# movie info, including user's score of movie
	 	movies.each do |movie|
	 		movie_score = {}
	 		movie_score["name"] = movie.title
	 		movie_score["link"] = movie.link
	 		movie_score["score"] = movie.get_user_score(user)
	 		scores << movie_score
	 	end
	 	# sort the list by highest rated and choose only the top ten
	 	# for display in show view
	 	sorted = scores.sort! {|a,b| a["score"] <=> b["score"]}.reverse!
	 	top_ten = sorted[1..10]
	 	return top_ten
	end

	# if movie is sci-fi or fantasy it gets a 1.5 bonus
	def sci_fi_bonus
	  	if self.genres.include?("Sci-Fi") || self.genres.include?("Fantasy")
	  		return 1.5
	  	else
	  		return 0
	  	end
    end

    # Fractal_movie_score is equal to 2.3 * imdb_score minus 
	# (the release year divided by 2000) plus a 1.5 bonus if the 
	# genre is either Sci-Fi or Fantasy
    def get_score
		# ruby is rounding here
		this_score = 2.3 * self.imdb_score
		# had to add this if/else because some movies are missing years
		if self.year == nil
			that_score = 0
		else
			that_score = self.year / 2000
		end
		the_score = this_score - that_score
		return the_score + self.sci_fi_bonus
	end

	# give a 2.5 bonus for movies released before 1970 if the user prefers old  
	# movies and a 3.5 bonus if the movie genre matches one of the movie favorites
	def genre_bonus(user_genre_array)
		# iterate through each user's genre and see if they match movie
		user_genre_array.each do |genre|
			if self.genres.include? genre
				return 3.5
			else
				return 0
			end
		end
	end

	# if movie is old it gets a bonus
	def old_movie_bonus(user)
		if user[:likes_old_movies] && self.year < 1970
			return 2.5
		else
			return 0
		end
	end

	# gets score based on user's genre preference and old movie pereference
	def get_user_score(user)
		total = 0
		my_genres_array = user[:favorite_genres].split("|")

		total += self.get_score
		total += self.genre_bonus(my_genres_array)
		total += self.old_movie_bonus(user)
		return total
	end


end
