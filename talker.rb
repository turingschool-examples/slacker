require './lib/redis-config'

data = {user: ARGV[0] || ENV['USER']}

loop do
  print '> '
  msg = STDIN.gets
  break if msg.chomp == 'exit'
  $redis.publish :community, data.merge('msg' => msg.strip).to_json
end

puts 'Exiting...'