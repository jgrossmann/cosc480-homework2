class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
	def Movie.ratings 
		ratings = Movie.pluck(:rating).uniq.sort
	end
end

