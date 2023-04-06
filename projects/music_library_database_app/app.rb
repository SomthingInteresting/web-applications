# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:new_album)
  end

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

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    return erb(:artist)
  end

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all
    return albums.map(&:title).join(", ")
  end
  
  post '/albums' do
    if invalid_request_parameters_album?
      status 400
      return 'Invalid parameters'
    end

    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo.create(new_album)
    return ''
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all
    return artists.map(&:name).join(", ")
  end  

  post '/artists' do
    if invalid_request_parameters_artist?
      status 400
      return 'Invalid parameters'
    end

    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    repo.create(new_artist)
    return ''
  end

  def invalid_request_parameters_album?
    return (params[:title].nil? || params[:release_year].nil? || params[:artist_id].nil?)
  end

  def invalid_request_parameters_artist?
    return (params[:name].nil? || params[:genre].nil?)
  end
end