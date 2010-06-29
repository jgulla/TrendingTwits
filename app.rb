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
  
  # uncomment next line if offline
  #  %{ [{"placeType":{"code":12,"name":"Country"},"countryCode":"IE","url":"http://where.yahooapis.com/v1/place/23424803","name":"Fryerland","woeid":23424803,"country":"Ireland"},{"country":"Mexico","placeType":{"code":12,"name":"Country"},"countryCode":"MX","name":"Mexico","url":"http://where.yahooapis.com/v1/place/23424900","woeid":23424900},{"country":"United Kingdom","placeType":{"code":12,"name":"Country"},"name":"United Kingdom","url":"http://where.yahooapis.com/v1/place/23424975","countryCode":"GB","woeid":23424975},{"countryCode":"US","woeid":2514815,"url":"http://where.yahooapis.com/v1/place/2514815","name":"Washington","placeType":{"code":7,"name":"Town"},"country":"United States"},{"placeType":{"code":7,"name":"Town"},"countryCode":"US","url":"http://where.yahooapis.com/v1/place/2367105","name":"Boston","woeid":2367105,"country":"United States"},{"country":"Brazil","placeType":{"code":7,"name":"Town"},"countryCode":"BR","name":"Sao Paulo","url":"http://where.yahooapis.com/v1/place/455827","woeid":455827},{"country":"United States","placeType":{"code":7,"name":"Town"},"countryCode":"US","name":"Baltimore","url":"http://where.yahooapis.com/v1/place/2358820","woeid":2358820},{"country":"","placeType":{"code":19,"name":"Supername"},"countryCode":null,"name":"Worldwide","url":"http://where.yahooapis.com/v1/place/1","woeid":1},{"country":"United States","placeType":{"code":7,"name":"Town"},"countryCode":"US","name":"New York","url":"http://where.yahooapis.com/v1/place/2459115","woeid":2459115},{"countryCode":"US","country":"United States","name":"San Antonio","url":"http://where.yahooapis.com/v1/place/2487796","placeType":{"code":7,"name":"Town"},"woeid":2487796},{"country":"United States","placeType":{"code":12,"name":"Country"},"name":"United States","url":"http://where.yahooapis.com/v1/place/23424977","countryCode":"US","woeid":23424977},{"country":"Brazil","placeType":{"code":12,"name":"Country"},"name":"Brazil","url":"http://where.yahooapis.com/v1/place/23424768","countryCode":"BR","woeid":23424768},{"country":"United States","placeType":{"code":7,"name":"Town"},"countryCode":"US","name":"Philadelphia","url":"http://where.yahooapis.com/v1/place/2471217","woeid":2471217},{"placeType":{"code":7,"name":"Town"},"woeid":2379574,"countryCode":"US","url":"http://where.yahooapis.com/v1/place/2379574","country":"United States","name":"Chicago"},{"countryCode":"US","country":"United States","name":"Houston","url":"http://where.yahooapis.com/v1/place/2424766","placeType":{"code":7,"name":"Town"},"woeid":2424766},{"country":"United States","placeType":{"code":7,"name":"Town"},"name":"Los Angeles","url":"http://where.yahooapis.com/v1/place/2442047","countryCode":"US","woeid":2442047},{"countryCode":"US","country":"United States","name":"San Francisco","url":"http://where.yahooapis.com/v1/place/2487956","placeType":{"code":7,"name":"Town"},"woeid":2487956},{"country":"Canada","placeType":{"code":12,"name":"Country"},"name":"Canada","url":"http://where.yahooapis.com/v1/place/23424775","countryCode":"CA","woeid":23424775},{"country":"United States","placeType":{"code":7,"name":"Town"},"countryCode":"US","name":"Atlanta","url":"http://where.yahooapis.com/v1/place/2357024","woeid":2357024},{"countryCode":"US","country":"United States","name":"Fort Worth","url":"http://where.yahooapis.com/v1/place/2406080","placeType":{"code":7,"name":"Town"},"woeid":2406080},{"placeType":{"code":7,"name":"Town"},"woeid":2388929,"countryCode":"US","url":"http://where.yahooapis.com/v1/place/2388929","country":"United States","name":"Dallas"},{"country":"United States","placeType":{"code":7,"name":"Town"},"countryCode":"US","name":"Seattle","url":"http://where.yahooapis.com/v1/place/2490383","woeid":2490383},{"country":"United Kingdom","placeType":{"code":7,"name":"Town"},"countryCode":"GB","name":"London","url":"http://where.yahooapis.com/v1/place/44418","woeid":44418}]}
end

__END__
@@ layout
<html>
  <body>
   <%= yield %>
  </body>
</html>
