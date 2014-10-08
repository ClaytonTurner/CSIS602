class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @sort = params[:sort]
    @movies = Movie.order(@sort.to_sym) unless @sort.nil?
    @all_ratings = Movie.all_ratings
    self.rating_trigger unless params[:ratings].nil?
  end

  def rating_trigger
    if session[:ratings].nil?
      ratings_hash = params[:ratings]
    else
      ratings_hash = session[:ratings]
    end
    ratings_keys = ratings_hash.keys
    @movies = Movie.find_all_by_rating(ratings_keys)
    session[:ratings] = ratings_hash
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
