class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @studio_actors = @studio.studio_actors
  end
end
