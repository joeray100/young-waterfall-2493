require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies}
    it {should have_many(:movie_actors).through(:movies)}
    it {should have_many(:actors).through(:movie_actors)}
  end

  before :each do
    @studio1 = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @movies1 = @studio1.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @actor1 = Actor.create!(name: 'Harrison Ford', age: 78, currently_working: true)
    @actor2 = Actor.create!(name: 'Karen Allen', age: 69, currently_working: false)

    @movies2 = @studio1.movies.create!(title: 'Cruella', creation_year: 2021, genre: 'Comedy/Crime')
    @actor3 = Actor.create!(name: 'Emma Stone', age: 32, currently_working: true)
    @actor4 = Actor.create!(name: 'Joel Fry', age: 36, currently_working: true)
    # only adding @actor3 in movie1 to test no dups for method
    @movies1.actors.push(@actor1, @actor2, @actor3)
    @movies2.actors.push(@actor3, @actor4)
  end

  describe 'instance methods' do
    describe '#studio_actors' do
      it "should list actors with not duplicates, ordered from oldest actor to youngest, only includes actors that are currently working" do
        expected = [@actor3, @actor4, @actor1]
        not_expected = [@actor3, @actor3, @actor4, @actor1, @actor2]

        expect(@studio1.studio_actors).to eq(expected)
        expect(@studio1.studio_actors).to_not eq(not_expected)
      end
    end
  end
end
