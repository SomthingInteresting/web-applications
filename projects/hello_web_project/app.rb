require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    "Hello World"
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Hello #{name}"
  end

  get '/names' do
    names = params[:names]
    return names.split(",").join(", ")
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(",").sort.join(",")
  end

  # post '/goodbye' do
  #   name = params[:name] # The value is 'Alice'
  
  #   # Do something with `name`...
  
  #   return "Hello #{name}"
  # end

  # get '/hello' do
  #   name = params[:name] # The value is 'Alice'
  
  #   # Do something with `name`...
  
  #   return "Hello #{name}"
  # end

  # post '/submit' do
  #   name = params[:name] # The value is 'Alice'
  #   message = params[:message] # The value is 'Hello World'
  
  #   # Do something with `name`...
  
  #   return "Thanks #{name}, you sent this message: #{message}"
  # end

end