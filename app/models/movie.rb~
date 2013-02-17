class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
	def Movie.ratings 
		movie_list = Movie.all
		ratings = []
		ratings << movie_list.each {|mov| mov.rating}
		ratings = ratings.uniq
	end
end

