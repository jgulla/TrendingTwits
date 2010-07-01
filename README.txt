This is a simple jQTouch app I threw together for a talk I did on the subject.

The back-end server is written in Ruby using Sinatra as a simple web server.  The Twitter APIs were
chosen because they were simple and don't require an API key.

If you're interested in jQTouch, I highly recommend the peepcode.com screencast ($9) on the
subject. It was very helpful to me.

Don't use this as any kind of example of a "best practice" or even so-so practice. It's a quick and
dirty example. Hopefully you will find it useful. I put it under the MIT license.

Start it up by going to the top-level directory and running:

ruby app.rb

Then go to <hostname>:4567 with your iPhone, Android or Webkit based browser.

It should also run in jRuby, but I haven't tried it yet.