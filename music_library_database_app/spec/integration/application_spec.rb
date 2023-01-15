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

   # -- OLD VERSION WITHOUT HTML:
  # context 'POST /albums' do
  #   it "creates a new album" do
  #     response = post('/albums', title: 'OK computer', release_year: '1997', artist_id: '1')

  #     expect(response.status).to eq 200
  #     expect(response.body).to eq ""

  #     response = get('/albums')

  #     expect(response.body).to include('OK computer')
  #   end
  # end

  context 'GET /artists' do
    it "returns the list of the artist" do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include('<p> Name: Pixies')
      expect(response.body).to include('Genre: Rock </p>')
      expect(response.body).to include('<p> Name: Nina Simone')
      expect(response.body).to include('Genre: Pop </p>')
    end
  end

  # -- OLD VERSION WITHOUT HTML:
  # context 'POST /artists' do
  #   it "creates a new artists" do
  #     response = post('/artists', name: 'Wild nothing', genre: 'Indie')

  #     expect(response.status).to eq 200
  #     expect(response.body).to eq ""

  #     response = get('/artists')

  #     expect(response.body).to include("Wild nothing")
  #   end
  # end

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

  context "GET /artists/:id" do
    it "returns the album with id 1" do
      response = get('/artists/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end

    it "returns the album with id 2" do
      response = get('/artists/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include('Genre: Pop')
    end
  end

  context "GET /albums/new" do
    it "returns the form page" do
      response = get('/albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an album</h1>')
      expect(response.body).to include('<form action="/album" method="POST">')
      expect(response.body).to include("Enter the album's title:")
      expect(response.body).to include('<input type="text" name="release_year" />')
    end
  end

  context "POST /albums" do
    it 'returns a success page' do
      response = post('/albums', title: 'OK computer', release_year: '1997', artist_id: '1')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('The album OK computer has been added succesfully!')
    end
  
    # xit 'responds with 400 status if parameters are invalid' do
    #   response = post('/albums', title: "ad", release_year: '1997', artist_id: '1')

    #   expect(response.status).to eq(400)
    # end
  end

  context "GET /artists/new" do
    it "adds a new artist" do
      response = get('/artists/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add an Artist</h1>')
      expect(response.body).to include('<form action="/artists" method="POST">')
      expect(response.body).to include("Please enter the artists's genre:")
      expect(response.body).to include('<input type="submit" />')
    end
  end

  context "POST /artists" do
    it "returns a success page" do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')

      expect(response.status).to eq 200
      expect(response.body).to include("<title>Artist added</title>")
      expect(response.body).to include("The artist Wild nothing has been added succesfully!")
    end
  end
end