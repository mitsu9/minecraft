module SlackMinecraftBot
  module Commands
    class Server < SlackRubyBot::Commands::Base
      command 'up' do |client, data, _match|
        client.say(channel: data.channel, text: 'up server')
      end

      command 'down' do |client, data, _match|
        client.day(channel: data.channel, text: 'down server')
      end
    end
  end
end
