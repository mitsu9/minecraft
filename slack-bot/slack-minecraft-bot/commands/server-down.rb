module SlackMinecraftBot
  module Commands
    class ServerDown < SlackRubyBot::Commands::Base
      command 'down' do |client, data, _match|
        res = %x( aws ec2 describe-instances --instance-ids #{ENV["AWS_EC2_INSTANCE_ID"]} | jq '.Reservations[].Instances[] | {InstanceId, InstanceState: .State.Name}' )
        status = JSON.parse(res)['InstanceState']
        case status
        when "stopped"
          client.say(channel: data.channel, text: 'すでに止まってるよ')
        when "stopping"
          client.say(channel: data.channel, text: '今止めてるからもう少し待ってて')
        when "pending"
          client.say(channel: data.channel, text: '今起動中だから起動してから止めてね')
          # TODO: 停止したら通知 or 起動処理を実行
        when "running"
          client.say(channel: data.channel, text: 'はーい、今からサーバーを止めるよ')
          %x( aws ec2 stop-instances --instance-ids #{ENV["AWS_EC2_INSTANCE_ID"]})
          # TODO* 止まった後に通知
        end
      end
    end
  end
end
