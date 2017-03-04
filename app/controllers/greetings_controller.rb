class GreetingsController < ApplicationController

  # seeding the genres list, and the seed user.
  def hello
  	@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
    # collected this by playing around in rails console
    # could eventually create a genres table in order to add more genres and update genres
    @genres = ["Action", "Adventure", "Fantasy", "Sci-Fi", "Thriller", "Documentary", "Romance", "Animation", "Comedy", "Family", "Musical", "Mystery", "Western", "Drama", "History", "Sport", "Crime", "Horror", "War", "Biography", "Music", "Game-Show", "Reality-TV", "News", "Short", "Film-Noir"]
  end

  # takes in the data from Hello view
  def show
    # if the form is filled out then define user with data from params 
    # passed in through form
  	if params[:user]
  		name = params[:user][:name]
      genres = params[:user][:genres].join("|")
        # manipulating params so data matches the way our model methods want them
        if params[:user][:likes_old_movies] == "true"
          likes_old_movies = true
        else
          likes_old_movies = false
        end

      @user = {name: name, likes_old_movies: likes_old_movies, favorite_genres: genres}
  	
    # if user just goes with the seed user then we use the seed user below
    else
  		@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}

  	end
    # once we have user defined, we get top ten movies for user
    # this method is in the movie model
    @top_ten = Movie.get_top_10_movies_for_user(@user)

  end

  # could add some private params here to keep data input clean and safe


end
