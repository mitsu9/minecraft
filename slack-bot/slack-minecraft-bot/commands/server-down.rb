module SlackMinecraftBot
  module Commands
    class ServerDown < SlackRubyBot::Commands::Base
      command 'down' do |client, data, _match|
        client.say(channel: data.channel, text: 'down server')
      end
    end
  end
end
