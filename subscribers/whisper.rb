require './lib/redis-config'
require 'faraday'

conn = Faraday.new(:url => 'https://hooks.slack.com')

begin
  puts 'Hey, I like to take whatever you say on Slacker & share it on Slack.'
  puts "Press Ctrl-C at any time to exit.\n"
  
  $redis.subscribe(:community) do |on|
    on.message do |channel, msg|
      message = JSON.parse(msg)

      data = {
        username: message['user'],
        icon_url: "http://robohash.org/#{message['user']}.png",
        text: message['msg']
      }
      
      conn.post do |req|
        req.url "/services/#{ENV['SLACKER_WEBHOOK']}"
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
    end
  end
rescue Interrupt => e
  puts "\nGoodbye."
end
