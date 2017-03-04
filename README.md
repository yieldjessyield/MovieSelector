# README

======================================================
Instructions
======================================================

Suppose the user in question is the following:

{
    “id”: 12,
    “likes_old_movies”:  True,
    “favorite_genres”: “Action|Sci-Fi”
}


The Problem

Based on our data science work, Henry came up with perfect formula for the prototype of the recommendation engine:

Fractal_movie_score is equal to 2.3 * imdb_score minus (the release year divided by 2000) plus a 1.5 bonus if the genre is either Sci-Fi or Fantasy

Now that we have the objective fractal score, we also want to personalize our recommendations to the user, so on top of the fractal score, we want to give a 2.5 bonus for movies released before 1970 if the user prefers old movies and a 3.5 bonus if the movie genre matches one of the movie favorites.

The Questions

Implement a function called `get_score` that takes a movie’s imdb title id, which you can get from the movie_imdb_link (e.g. in http://www.imdb.com/title/tt2070597/?ref_=fn_tt_tt_1', the title id is “tt2070597”) and returns the fractal score for that movie.

Implement a function called `get_user_score` that takes the movie’s imdb title id and a user dictionary (a.k.a. hash) and returns the user-specific score for that movie.

Implement a function called `get_top_10_movies_for_user` that takes the user dictionary and returns the names of the top 10 movies and their corresponding user-specific fractal scores.

Run `get_top_10_movies_for_user` for the example user dictionary specified in the section titled The Data above.

Ensure that your functions are well-documented.

Email us your code and the results from Question 4!

======================================================
Notes
======================================================

Dependencies: 

using ruby version 2.2.2


Database Creation:

seeded movies table in database with data from movie_metadata_rails.csv

run bundle install

rake db:create

rake db:migrate

rake db:seed


