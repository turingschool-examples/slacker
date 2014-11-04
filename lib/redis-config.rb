require 'redis'
require 'json'

$redis = ENV['SLACKER_REDIS'] ? Redis.new(url: ENV['SLACKER_REDIS']) : Redis.new