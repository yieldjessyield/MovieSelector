# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'byebug'

# /Users/jessharrelson/Development/fractalTechExerciseRefactor/movie_finder/movie_metadata_rails.csv

# seeding my rails database with the info from the .csv file
# should check for duplicates and missing data here before it reaches the db

all_movies = CSV.read('../movie_finder/movie_metadata_rails.csv')
all_movies.shift
all_movies.each do |movie|
	Movie.create(title: movie[11].strip, genres: movie[9], year: movie[23], link: movie[17], imdb_score: movie[25])
end