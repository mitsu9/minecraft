require 'json'
require 'net/http'

if ENV['MACKEREL_AGENT_PLUGIN_META'] == '1'

  meta = {
    :graphs => {
      'stat' => {
        :label   => 'minecraft-stat',
        :unit    => 'integer',
        :metrics => [
          {
            :name  => 'active-users',
            :label => 'active-users'
          }
        ]
        }
      }
    }

  puts '# mackerel-agent-plugin'
  puts meta.to_json
  exit 0
end

res = Net::HTTP.get(URI.parse('https://mcapi.ca/query/<IP>/players'))
active_users = JSON.parse(res)['players']['online']

# output format {metric name}\t{metric value}\t{epoch seconds}
puts [ 'stat.active-users',  active_users, Time.now.to_i ].join("\t")
