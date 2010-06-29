require "rubygems"
require "sinatra"
require "json"
require 'httpclient'
require 'nokogiri'
require 'TwitterTopics'

get "/" do
  redirect "index.html"
end



get "/topics" do
  content_type "application/json"
  tc = TwitterTopics.new
  topics = tc.get_topics(params[:woeid])
  pl = params[:place]
  puts params[:woeid]
  puts params[:place]
  
  erb :topics, :layout => false, :locals => {:loc=>topics,:place=>pl}
end



get "/locations.json" do
  content_type "application/json"
  c = HTTPClient.new
  c.get_content("http://api.twitter.com/1/trends/available.json")
end

__END__
@@ layout
<html>
  <body>
   <%= yield %>
  </body>
</html>
