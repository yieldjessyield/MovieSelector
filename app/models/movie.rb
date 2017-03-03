class Movie < ApplicationRecord

	def self.all_old_movies()
		return self.all.select {|m| m.year != nil && m.year < 1970}
	end

	def self.all_genre_movies(my_genres)
		# “favorite_genres”: “Action|Sci-Fi”
		genres = my_genres.split("|")

		movies = self.all.select do |movie|
			genres.any? { |g| movie.genres.include?(g) }
		end
		return movies
	end

	def self.all_old_genre_movies(my_genres)
		genres = my_genres.split("|")
		old_movies = self.all_old_movies()
		movies = old_movies.select do |movie|
			genres.any? { |g| movie.genres.include?(g) }
		end
		return movies
	end

	def self.get_top_10_movies_for_user(user)
		# byebug
		scores = []
	 	if user[:likes_old_movies]
	 		# user old movies list of movies
	 		movies = self.all_old_genre_movies(user[:favorite_genres])
	 		byebug
	 	else
	 		movies = self.all_genre_movies(user[:favorite_genres])
	 		byebug
	 		# use just genre list
	 	end

	 	movies.each do |movie|
	 		# byebug
	 		movie_score = {}
	 		movie_score["name"] = movie.title
	 		movie_score["link"] = movie.link
	 		movie_score["score"] = movie.get_user_score(user)
	 		scores << movie_score
	 	end

	 	byebug
	 	sorted = scores.sort! {|a,b| a["score"] <=> b["score"]}.reverse!
	 	byebug
	 	top_ten = sorted[1..10]
	 	return top_ten
	 	# top_ten.each {|m| puts m["name"]}
	end

	def sci_fi_bonus
		# byebug
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
		this_score = 2.3 * self.imdb_score
		# ruby is rounding here
		# had to add this if/else because some data is missing years
		if self.year == nil
			that_score = 0
		else
			that_score = self.year / 2000
		end
		the_score = this_score - that_score
		return the_score + self.sci_fi_bonus
	end

	# give a 2.5 bonus for movies released before 1970 if the user 
	# prefers old movies and a 3.5 bonus if the movie genre matches one of the movie favorites
	def genre_bonus(user_genre_array)
		# “favorite_genres”: “Action|Sci-Fi”
		# byebug
		user_genre_array.each do |genre|
			# byebug
			if self.genres.include? genre
				return 3.5
			else
				return 0
			end
		end
	end

	def old_movie_bonus(user)
		# byebug
		# check user
		if user[:likes_old_movies] && self.year < 1970
			return 2.5
		else
			return 0
		end
	end

	def get_user_score(user)
		total = 0
		my_genres_array = user[:favorite_genres].split("|")
		# byebug

		total += self.get_score
		# byebug
		total += self.genre_bonus(my_genres_array)
		# byebug
		total += self.old_movie_bonus(user)
		# byebug
		return total
	end


end
