# in app/controllers/movies_controller.rb

class MoviesController < ApplicationController
  def index
		@all_ratings = Movie.ratings
		if @select_ratings == nil
			@select_ratings = @all_ratings
		end
		if params[:ratings] != session[:ratings]
			session[:ratings] = @select_ratings
		end
		@sort = params[:sort_param] unless (params[:sort_param] == nil)
		@select_ratings = params[:ratings].keys unless params[:ratings] == nil
		@title_header_class = ('hilite' if @sort == "title")
		@release_date_class = ('hilite' if @sort == "release_date")
    @movies = Movie.find_all_by_rating(@select_ratings, :order => @sort)
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
