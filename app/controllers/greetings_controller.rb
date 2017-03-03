class GreetingsController < ApplicationController

  def hello
  	# henery = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
  	@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
  end

  def show
  	byebug
  	if params[:user]
  		@user = params[:user]
  	else
  		@user = {name: "Henry", id: 12, likes_old_movies: true, favorite_genres: "Action|Sci-Fi"}
  		movies = Movie.get_top_10_movies_for_user(@user)
  		byebug
  	end
  end


end
