class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.find_actor(actor_name)
    where('name ILIKE ?', "%#{actor_name}%")
  end
end
