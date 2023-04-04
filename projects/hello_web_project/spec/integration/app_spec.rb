require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET to /" do
    it "returns 200 OK with the right content" do
      response = get("/")
      expect(response.status).to eq 200
      expect(response.body).to eq "Hello World"
    end
  end

  context "POST to /submit" do
    it "returns 200 OK with the right content" do
      response = post("/submit?name=Dana")
      expect(response.status).to eq 200
      expect(response.body).to eq "Hello Dana"
    end
  end

  context "GET to /names" do
    it "returns 200 OK with the right content" do
      response = get("/names?names=Julia,Mary,Karim")
      expect(response.status).to eq 200
      expect(response.body).to eq "Julia, Mary, Karim"
    end
  end

  context "POST /sort-names" do
    it 'returns 200 OK with sorted names' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end