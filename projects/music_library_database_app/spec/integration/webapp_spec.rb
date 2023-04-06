require "spec_helper"
require "rack/test"
require_relative '../../webapp'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_tables
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_tables
  end

  context "get all albums" do
    it "returns a HTML list of all albums" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include ('<a href="/albums/1">Doolittle</a>')
      expect(response.body).to include ('<a href="/albums/2">Surfer Rosa</a>')
    end
  end

  context 'GET /albums/:id' do
    it 'should return info about album 1' do
      response = get('/albums/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it 'should return info about album 2' do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context "GET /artists/:id" do
    it "returns a page with the artists name and genre" do
      response = get('/artists/1')

      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('<p>Genre: Rock</p>')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK and a list of artists links' do
      response = get('/artists')

      expect(response.body).to include('<a href="/artists/1">Pixies</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
    end
  end

  context "GET /albums/new" do
    it "returns a form to add a new album" do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add a new album</h1>')
      expect(response.body).to include('<form method="POST" action="albums">')
      expect(response.body).to include('<input type="text" name="title" />')
      expect(response.body).to include('<input type="text" name="release_year" />')
      expect(response.body).to include('<input type="text" name="artist_id" />')
    end
  end
end
    