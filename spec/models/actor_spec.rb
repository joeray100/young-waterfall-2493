require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it {should have_many(:movie_actors)}
    it {should have_many(:movies).through(:movie_actors)}
  end

  before :each do
    @studio1 = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @movies1 = @studio1.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @actor1 = Actor.create!(name: 'Harrison Ford', age: 78, currently_working: true)
    @actor2 = Actor.create!(name: 'Karen Allen', age: 69, currently_working: false)

    @movies2 = @studio1.movies.create!(title: 'Cruella', creation_year: 2021, genre: 'Comedy/Crime')
    @actor3 = Actor.create!(name: 'Emma Stone', age: 32, currently_working: true)
    @actor4 = Actor.create!(name: 'Joel Fry', age: 36, currently_working: true)
    @actor5 = Actor.create!(name: 'Jackie Chan', age: 67, currently_working: true)

    @movies1.actors.push(@actor1, @actor2)
    @movies2.actors.push(@actor3, @actor4)
  end

  describe 'class methods' do
    describe '.find_actor' do
      it "should find actor in db by name" do
        expect(Actor.find_actor("em")).to eq([@actor3])
      end
    end
  end
end
