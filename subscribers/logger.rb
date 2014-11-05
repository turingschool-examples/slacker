require './lib/redis-config'

begin
  puts "You're logging on Slacker."
  puts "Press Ctrl-C at any time to exit.\n"
  $redis.subscribe(:community) do |on|
    on.message do |channel, msg|
      data = JSON.parse(msg)
      File.open(File.expand_path('./logs/log.txt'), 'a') do |file| 
        file.write("[#{data['user']}]: #{data['msg']}\n")
      end
    end
  end
rescue Interrupt => e
  puts 'Goodbye...'
end