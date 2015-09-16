# Slacker

A pub/sub chat using Redis. Written as a tool for this
[lesson](https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/pubsub_on_the_server.markdown) on
server-side pub/sub.

Slacker provides a few simple ruby files for subscribing and publishing
to redis channels.

It will look for an environment variable called `SLACKER_REDIS` when
deciding which server to connect to. By default it will use
the standard redis url (`localhost:6379`).

__Group Exercise__

For the group exercise, provide everyone with a shared,network-accessible redis url.
One easy way to obtain a new redis url is to create a new heroku
app (`heroku create`) and add the `redistogo` addon (`heroku addons:create redistogo`).

Once this is done, you can retrieve the newly created redis url
by checking `heroku config`.

Once you have this URL, use it for your redis connections by
sourcing it into the environment when running each file.

For example

```
SLACKER_REDIS=my-redis-to-go-url ruby publishers/talker.rb
```
## Provided Scripts

### Subscribers

* `subscribers/listener.rb` - Subscribes to "community" channel and prints messages to consol
* `subscribers/logger.rb` - Subs to "community" and logs messages
to `log.txt`
* `subscribers/whisper.rb` - Subs to "community" and forwards messages
to a slack integration

__Note__ The `whisper.rb` slack integration requires a `SLACKER_WEBHOOK` ENV
variable, which needs to contain the ID of the "bean-spiller" slack integration.

This is an incoming webhook in the slack API which accepts messages
and posts them to Turing's `super-secret` slack channel.

Authorized slack users can retrieve the appropriate token from
this [slack page](https://turingschool.slack.com/services/2937942030)

### Publishers

* `publishers/talker.rb` - Simple message input REPL - gives
a command prompt and sends any input to "community" redis channel
* `publishers/webber.rb` - Sinatra-based web UI for taking messages
via a form and posting them to the redis channel
