require './lib/redis-config'

data = {user: ARGV[0] || ENV['USER']}

puts <<END
Welcome to Slacker
==================

(Type 'exit' to leave.)

END

loop do
  print '> '
  msg = STDIN.gets
  break if msg.chomp == 'exit'
  $redis.publish :community, data.merge(msg: msg.strip).to_json
end

puts 'Exiting...'