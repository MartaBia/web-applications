require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # -- Initial version without html: ------

  # context "GET /albums" do
  #   it "returns a list of albums" do
  #     response = get('/albums')

  #     expected_response = "Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"

  #     expect(response.status).to eq 200
  #     expect(response.body).to eq expected_response
  #   end
  # end

  context "GET /albums" do
    xit "returns a list of albums" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include('<p> Title: Doolittle')
      expect(response.body).to include('Released: 1989 </p>')
      expect(response.body).to include('<p> Folklore')
      expect(response.body).to include('Released year: 2020 </p>')
    end
  end

  context 'POST /albums' do
    it "creates a new album" do
      response = post('/albums', title: 'OK computer', release_year: '1997', artist_id: '1')

      expect(response.status).to eq 200
      expect(response.body).to eq ""

      response = get('/albums')

      expect(response.body).to include('OK computer')
    end
  end

  context 'GET /artists' do
    it "returns the list of artists" do
      response = get('/artists')

      expected_response = ("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context 'POST /artists' do
    it "creates a new artists" do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq 200
      expect(response.body).to eq ""

      response = get('/artists')

      expect(response.body).to include("Wild nothing")
    end
  end

  context "GET /albums/:id" do
    it "returns a the album with id 1" do
      response = post('/albums', title: 'Doolittle', release_year: '1989', artist_id: '1')
      response = get('/albums/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it "returns a the album with id 2" do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end

    it "returns a the album with id 6" do
      response = get('/albums/6')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Lover</h1>')
      expect(response.body).to include('Release year: 2019')
      expect(response.body).to include('Artist: Taylor Swift')
    end
  end
end