require 'sinatra'
require './lib/redis-config'

get '/' do
  erb :index
end

post '/' do
  $redis.publish :community, params.to_json
  @message = 'Your post has been published.'
  erb :index
end

__END__

@@ index
<doctype html>
<html>
  <head>
    <title>Slacker</title>
    <style>
      body { font-family: Helvetica, sans-serif; margin: 2em;}
      .message { color: green; }
    </style>
  </head>
  <body>
    <% if @message %><div class="message"><%= @message %></div><% end %>
    <form action="/" autocomplete="on" method="POST">
      <p><label>Name: <label><input type="text" name="user"></p>
      <p>Message: </label><input type="text" name="msg"></p>
      <input type="submit" value="Send Message">
    </form> 
  </body>
</html>
