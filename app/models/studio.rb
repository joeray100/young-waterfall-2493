class Studio < ApplicationRecord
  has_many :movies
  has_many :movie_actors, through: :movies
  has_many :actors, through: :movie_actors

  def studio_actors
    actors.where(currently_working: true).order(:age).distinct
  end
end
