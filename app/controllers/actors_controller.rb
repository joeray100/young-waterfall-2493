class ActorsController < ApplicationController
  def show
    @actor = Actor.find(params[:id])
    @worked_with = Actor.worked_with

    # @worked_with = Actor.worked_with(@actor)
  end
end
