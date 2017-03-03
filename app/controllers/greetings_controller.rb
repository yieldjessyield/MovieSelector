class GreetingsController < ApplicationController

  def hello
  	# henery = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
  	@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
    @genres = ["Thriller", "Drama", "Sci-Fi"]
  end

  def show
  	if params[:user]
  		name = params[:user][:name]
      genres = params[:user][:genres].join("|")
      
        if params[:user][:likes_old_movies] == "true"
          likes_old_movies = true
        else
          likes_old_movies = false
        end

      @user = {name: name, likes_old_movies: likes_old_movies, favorite_genres: genres}
  	else
  		@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
  		movies = Movie.get_top_10_movies_for_user(@user)

  	end
    @top_ten = Movie.get_top_10_movies_for_user(@user)

  end


end
