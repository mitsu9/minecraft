module SlackMinecraftBot
  module Commands
    class ServerStatus < SlackRubyBot::Commands::Base
      command 'status' do |client, data, _match|
        res = %x( aws ec2 describe-instances --instance-ids #{ENV["AWS_EC2_INSTANCE_ID"]} | jq '.Reservations[].Instances[] | {InstanceId, InstanceState: .State.Name}' )
        status = JSON.parse(res)['InstanceState']
        client.say(channel: data.channel, text: "現在のサーバーの状況: #{status}")
      end
    end
  end
end
