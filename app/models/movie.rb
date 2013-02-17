class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
	def Movie.ratings 
		movie_list = Movie.all
		ratings = []
		movie_list.each {|mov| ratings << mov.rating}
		ratings = ratings.uniq.sort
	end
end

