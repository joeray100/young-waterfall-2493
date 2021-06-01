class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @movie_actors = @movie.actors
  end
end
