require 'rails_helper'

RSpec.describe 'studio show page' do
  before :each do
    @studio1 = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @movies1 = @studio1.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @actor1 = Actor.create!(name: 'Harrison Ford', age: 78, currently_working: true)
    @actor2 = Actor.create!(name: 'Karen Allen', age: 69, currently_working: false)

    @movies2 = @studio1.movies.create!(title: 'Cruella', creation_year: 2021, genre: 'Comedy/Crime')
    @actor3 = Actor.create!(name: 'Emma Stone', age: 32, currently_working: true)
    @actor4 = Actor.create!(name: 'Joel Fry', age: 36, currently_working: true)

    @movies1.actors.push(@actor1, @actor2)
    @movies2.actors.push(@actor3, @actor4)

    visit studio_path(@studio1)
  end

  it "I see the studio's name and location and I see the titles of all of its movies" do
    expect(page).to have_content(@studio1.name)
    expect(page).to have_content(@studio1.location)

    within "#studio-movie-#{@movies1.id}" do
      expect(page).to have_content(@movies1.title)
    end

    within "#studio-movie-#{@movies2.id}" do
      expect(page).to have_content(@movies2.title)
    end
  end

  it "I see a list of actors that have acted in any of the studio's movies" do

    within "#studio-actor-#{@actor1.id}" do
      expect(page).to have_content(@actor1.name)
    end
    within "#studio-actor-#{@actor3.id}" do
      expect(page).to have_content(@actor3.name)
    end
    within "#studio-actor-#{@actor4.id}" do
      expect(page).to have_content(@actor4.name)
    end
  end

  it "shows actors with no duplicates, ordered from oldest actor to youngest, only includes actors that are currently working" do
    expect(@actor3.name).to appear_before(@actor1.name)
  end
end
