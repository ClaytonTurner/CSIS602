class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    # Sort Behavior
    self.sort_trigger

    # Ratings Behavior
    @all_ratings = Movie.all_ratings
    @checked_ratings = @all_ratings
    self.rating_trigger
  end

  def sort_trigger
    if params[:sort].nil?
      if session[:sort].nil?
      else
        @sort = session[:sort]
        redirect_to movies_path(:sort => session[:sort])
      end
    else
      @sort = params[:sort]
      session[:sort] = params[:sort]
      @movies = Movie.order(@sort.to_sym)
    end
  end

  def rating_trigger
    if params[:ratings].nil?
      if session[:ratings].nil?
      else
        #session has a value - use it
        redirect_to movies_path(:ratings => session[:ratings])
      end
    else
      # params has a value - use it
      ratings_hash = params[:ratings]
      ratings_keys = ratings_hash.keys
      session[:ratings] = params[:ratings]
      @movies = Movie.find_all_by_rating(ratings_keys)
      @checked_ratings = ratings_keys
    end
    
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
