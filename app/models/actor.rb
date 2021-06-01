class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.find_actor(actor_name)
    where('name ILIKE ?', "%#{actor_name}%")
  end

  # I know this is not correct as it is not dynamic enough to handle different conditions, would love feedback on the correct way of doing it?
  # Makes sense to start with class method so you can start with all of the actors and widdle it down using maybe the movies they are attached to somehow and where.not the actor themselves?
  # you can pull the actor in as argument from controller using -> @actor = Actor.find(params[:id])
  # @worked_with = Actor.worked_with(@actor)
  def self.worked_with
    joins(:movies)
    .where(movies: {title: 'Cruella'})
    .where.not(name: 'Emma Stone')
    .uniq
  end
end
