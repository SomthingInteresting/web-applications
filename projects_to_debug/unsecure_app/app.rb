require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = Rack::Utils.escape_html(Rack::Utils.escape_path(params[:name]))

    return erb(:hello)
  end
end
