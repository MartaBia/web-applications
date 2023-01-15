require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'
include ERB::Util

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  DatabaseConnection.connect

  # -- OLD VERSION WITHOUT HTML:
  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all

  #   response = albums.map do |album|
  #     album.title
  #   end.join(", ")

  #   return response
  # end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  post '/albums' do
    repo = AlbumRepository.new
    @new_album = Album.new


    if invalid_request_params 
      status 400
    end

    @new_album.title = params[:title]
    @new_album.release_year = params[:release_year]
    @new_album.artist_id = params[:artist_id]

    repo.create(@new_album)

    return erb(:album_added)
  end

  def invalid_request_params
    params[:title] == nil ||  params[:release_year] == nil || params[:artist_id] == nil
  end

  # -- OLD VERSION WITHOUT HTML FORM: 
  # post '/albums' do
  #   repo = AlbumRepository.new
  #   new_album = Album.new

  #   new_album.title = params[:title]
  #   new_album.release_year = params[:release_year]
  #   new_album.artist_id = params[:release_year]

  #   repo.create(new_album)

  #   return ''
  # end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  post '/artists' do
    repo = ArtistRepository.new
    @new_artist = Artist.new

    puts "name: #{params[:name]}, genre: #{params[:genre]}"

    @new_artist.name = params[:name]
    @new_artist.genre = params[:genre]

    repo.create(@new_artist)

    return erb(:artist_added)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:artist)
  end

  # -- OLD VERSION WITHOUT HTML FORM: 
  # post '/artists' do
  #   repo = ArtistRepository.new
  #   new_artist = Artist.new

  #   new_artist.name = params[:name]
  #   new_artist.genre = params[:genre]

  #   repo.create(new_artist)

  #   return ''
  # end
end