class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @movie_actors = @movie.actors
    
    if params[:name]
      @movie_actors << Actor.find_actor(params[:name])
    end
  end
end
