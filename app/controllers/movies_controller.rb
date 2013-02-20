# in app/controllers/movies_controller.rb

class MoviesController < ApplicationController
  def index
		redir = false
		@all_ratings = Movie.ratings
	
	#session for ratings
		if !params.has_key?("ratings")
			if session.has_key?(:ratings)
				redir = true
				@select_ratings_hash = session[:ratings]
			end
			if !params.has_key?(:sort_param)
				if session.has_key?("sort_param")
				@sort = session[:sort_param]
				end
			else
				session[:sort_param] = params[:sort_param]
			end
			if @select_ratings_hash == nil
				@select_ratings_hash = {}
				@all_ratings.each do |val|
					@select_ratings_hash.store(val, 1)
				end
			end
		else
			session[:ratings] = params[:ratings]
		end

		if(redir)
			flash.keep
			redir = false
			redirect_to movies_path(:ratings => @select_ratings_hash, :sort_param => @sort)
		end
		@sort = params[:sort_param] unless (params[:sort_param] == nil)
		if @sort != "title" && @sort != "release_date"
			@sort = nil
		end
		session[:sort_param] = @sort
		@title_header_class = ('hilite' if @sort == "title")
		@release_date_class = ('hilite' if @sort == "release_date")
		if params[:ratings] != nil
			@select_ratings_hash = params[:ratings]
		end
    @movies = Movie.find_all_by_rating(@select_ratings_hash.keys, :order => @sort)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
    # will render app/views/movies/show.html.haml by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
