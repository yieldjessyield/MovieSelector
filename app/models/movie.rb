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

end
