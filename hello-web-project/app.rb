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
  end

  # -- Using instance variables and dinamics id tags ------
  get '/name' do
    @name = params[:name]
    
    return erb(:name)
  end

  # -- Looping through arrays with erb -------
  get '/names-array' do
    @names = ['Anna', 'Josh', 'Marco']
    
    return erb(:names_array)
  end

  # -- Conditionals with erb ------------
  get '/password' do
    @password = params[:password]
    
    return erb(:password)
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]

    return "Thanks #{name}, you sent this message: #{message}"
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

  # -- HTML challenge: -----------
  get '/hello' do
    return erb(:hello)
  end
end