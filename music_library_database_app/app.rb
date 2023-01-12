# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  DatabaseConnection.connect

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all

    response = albums.map do |album|
      album.title
    end.join(", ")

    return response
  end

  # get '/albums/:id' do
  #   repo = AlbumRepository.new
  #   albums = repo.all

  #   single_album
  # end

  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new

    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:release_year]

    repo.create(new_album)

    return ''
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do |artist|
      artist.name
    end.join(', ')

    return response
  end

  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new

    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return ''
  end
end