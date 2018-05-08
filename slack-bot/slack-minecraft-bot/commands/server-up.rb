module SlackMinecraftBot
  module Commands
    class ServerUp < SlackRubyBot::Commands::Base
      command 'up' do |client, data, _match|
        res = %x( aws ec2 describe-instances --instance-ids #{ENV['AWS_EC2_INSTANCE_ID']} | jq '.Reservations[].Instances[] | {InstanceId, InstanceState: .State.Name}' )
        status = JSON.parse(res)['InstanceState']
        case status
        when "running"
          client.say(channel: data.channel, text: 'すでに起動してるよ')
        when "pending"
          client.say(channel: data.channel, text: 'もう少しで起動するから待ってて')
        when "stopping"
          client.say(channel: data.channel, text: '今停止しようとしてるからもう少し後で起動して')
          # TODO* 停止後に通知 or 起動処理を実行
        when "stopped"
          client.say(channel: data.channel, text: 'はーい、今から起動するよ')
          %x( aws ec2 start-instances --instance-ids #{ENV['AWS_EC2_INSTANCE_ID']})
          # TODO: 起動後に通知
        end
      end
    end
  end
end
