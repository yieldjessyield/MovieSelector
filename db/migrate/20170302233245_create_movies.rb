class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genres
      t.integer :year
      t.string :link
      t.integer :imdb_score

      t.timestamps
    end
  end
end
