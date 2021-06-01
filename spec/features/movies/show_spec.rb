require 'rails_helper'

RSpec.describe 'movie show page' do
  before :each do
    @studio1 = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @movies1 = @studio1.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @actor1 = Actor.create!(name: 'Harrison Ford', age: 78, currently_working: true)
    @actor2 = Actor.create!(name: 'Karen Allen', age: 69, currently_working: false)

    @movies2 = @studio1.movies.create!(title: 'Cruella', creation_year: 2021, genre: 'Comedy/Crime')
    @actor3 = Actor.create!(name: 'Emma Stone', age: 32, currently_working: true)
    @actor4 = Actor.create!(name: 'Joel Fry', age: 36, currently_working: true)
    # actor to be added
    @actor5 = Actor.create!(name: 'Jackie Chan', age: 67, currently_working: true)

    @movies1.actors.push(@actor1, @actor2)
    @movies2.actors.push(@actor3, @actor4)

    visit movie_path(@movies1)
  end

  it "I see the movie's title, creation year, and genre" do
    expect(page).to have_content(@movies1.title)
    expect(page).to have_content(@movies1.creation_year)
    expect(page).to have_content(@movies1.genre)
  end

  it "I see all of the actors in the movie" do

    within "#movie-actor-#{@actor1.id}" do
      expect(page).to have_content(@actor1.name)
    end

    within "#movie-actor-#{@actor2.id}" do
      expect(page).to have_content(@actor2.name)
    end
  end

  it "I do not see any actors listed that are not part of the movie" do
    expect(page).to_not have_content(@actor3.name)
    expect(page).to_not have_content(@actor4.name)
  end

  it "I see a form to add an actor to this movie" do
    expect(current_path).to eq(movie_path(@movies1))
    expect(page).to have_field('Name')

    fill_in 'Name', with: 'Jackie Chan'
    click_button 'Submit'

    expect(current_path).to eq(movie_path(@movies1))
    expect(page).to have_content('Jackie Chan')
  end
end
