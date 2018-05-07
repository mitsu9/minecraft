module SlackMinecraftBot
  module Commands
    class ServerUp < SlackRubyBot::Commands::Base
      command 'up' do |client, data, _match|
        client.say(channel: data.channel, text: 'up server')
      end
    end
  end
end
