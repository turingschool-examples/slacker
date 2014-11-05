require './lib/redis-config'

begin
  puts "You're listening on Slacker."
  puts "Press Ctrl-C at any time to exit.\n"
  $redis.subscribe(:community) do |on|
    on.message do |channel, msg|
      data = JSON.parse(msg)
      puts "[#{data['user']}]: #{data['msg']}"
    end
  end
rescue Interrupt => e
  puts 'Goodbye...'
end