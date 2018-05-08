module SlackMinecraftBot
  module Commands
    class ServerStatus < SlackRubyBot::Commands::Base
      command 'status' do |client, data, _match|
        client.say(channel: data.channel, text: 'status')
      end
    end
  end
end
