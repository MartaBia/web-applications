require 'sinatra/base'
require 'sinatra/reloader'
require 'erb'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return "Hello!"

    # Version with erb:
    # erb = "Hello"
  end

  get '/hello' do
    name = params[:name]

    return "Hello #{name}"

    # Version with erb:
    # erb = "Hello #{name}"
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]

    return "Thanks #{name}, you sent this message: #{message}"

    # Version with erb:
    # erb = "Thanks #{name}, you sent this message: #{message}"
    # erb :submit
  end

  get '/names' do
    names = params[:names]

    return "#{names}"
  end

  post '/sort-names' do
    names = params[:names]
    names_array = names.split(',')
    sorted_names = names_array.sort

    return sorted_names.join(',')
  end
end