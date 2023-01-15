require 'sinatra/base'
require "sinatra/reloader"
# The line below includes some util functions for erb 
# for example html_escape to prevent code injection
include ERB::Util

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]

    if @name.include?("<script>")
      status 400
      return ''
    end

    return erb(:hello)
  end
end
