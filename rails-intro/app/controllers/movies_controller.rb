class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    self.redirector # Preserves RESTfulness

    # Sort Behavior
# self.sort_trigger

    # Ratings Behavior
    @all_ratings = Movie.all_ratings
    @checked_ratings = @all_ratings
    self.rating_trigger
    self.sort_trigger
  end

  def sort_trigger
    # sort has a value, use it
    if params[:sort].present?
        @sort = params[:sort]
        session[:sort] = params[:sort]
        @movies = Movie.order(@sort.to_sym)
    end
  end

  def rating_trigger
    # params has a value - use it
    if params[:ratings].present?
      ratings_hash = params[:ratings]
      ratings_keys = ratings_hash.keys
      session[:ratings] = params[:ratings]
      @movies = Movie.find_all_by_rating(ratings_keys)
      @checked_ratings = ratings_keys
    end
  end

  def redirector
    psort = true if params[:sort].present?
    pratings = true if params[:ratings].present?
    ssort = true if session[:sort].present?
    sratings = true if session[:ratings].present?
    ratings_switch = nil
    sort_switch = nil
    redirect = false
    if psort && pratings # both true, do nothing
    elsif psort # psort is true, pratings is false
      sort_switch = params[:sort]
      if sratings # psort && sratings
        ratings_switch = session[:ratings]
        redirect = true
      end
    elsif pratings # pratings is true, psort is false
      ratings_switch = params[:ratings]
      if ssort # pratings && ssort
        sort_switch = session[:sort]
        redirect = true
      end
    else # no params, let's check session
      sort_switch = session[:sort] if ssort
      ratings_switch = session[:ratings] if sratings
      redirect = true if sort_switch || ratings_switch
    end
    redirect_to movies_path(:ratings => ratings_switch,:sort => sort_switch) if redirect
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
