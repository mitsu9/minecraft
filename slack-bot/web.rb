require 'sinatra/base'

module SlackMinecraftBot
  class Web < Sinatra::Base
    get '/' do
      'Hello World'
    end
  end
end
