require './lib/redis-config'

$redis.subscribe(:community) do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)
    puts "##{channel} - [#{data['user']}]: #{data['msg']}"
  end
end