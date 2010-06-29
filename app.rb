require "rubygems"
require "sinatra"
require "json"
require 'httpclient'
#require 'feedzirra'
require 'nokogiri'
require 'cclists'
require 'TwitterTopics'

@username
@password

# use Rack::Auth::Basic do |username, password|
#   puts "USER=#{username}, PASS=#{password}"
#   [username, password] == [username, password]
#   true
# end


helpers do
  def protected!
    puts "AAAA"
    unless authorized?
      puts "1111"
      response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    puts "BBBB"
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['jerrygulla', 'webpass']
  end



  helpers do
  def request_headers
    puts "getting headers"
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end
  end
  get '/headers' do
  puts request_headers.inspect
  puts '-------'
  puts request_headers
  puts '-------'
  end

end

get '/protected' do
  puts "Welcome, authenticated client"
  protected!
  puts "Welcome, authenticated client"
  puts "USER=#{username}, PASS=#{password}"
end




get "/" do
  redirect "index.html"
end

get "/month.json" do
  content_type "application/json"
  [ {"title"=>"April", "quantity"=> 18},
    {"title"=>"May",   "quantity"=> 5},
    {"title"=>"June",  "quantity"=> 28}
  ].to_json
end




get "/lists.json" do
  content_type "application/json"
  [ {"list"=>"General Interest", "subscribercount"=> 18},
    {"list"=>"Skydiving",   "subscribercount"=> 7},
    {"list"=>"Bowling",  "subscribercount"=> 28}
  ].to_json
end


get "/dlists" do
  erb :dlists, :layout => false
end

get "/dlists2" do
  content_type "application/json"
  # c = HTTPClient.new
  # content =  c.get_content("http://api.twitter.com/1/trends/#{params[:woeid]}.xml")
  # puts content
  # content

  tc = TwitterTopics.new
  topics = tc.get_topics(params[:woeid])



  puts params[:woeid]
  erb :dlists2, :layout => false, :locals => {:loc=>topics}
end

get "/wslists.json" do
  content_type "application/json"
  puts request_headers.inspect
  @username = request_headers["username"]
  @password = request_headers["password"]
  puts "#{@username}, #{@password}"
#  protected!
  cc_lists = CCLists.new
  cc_lists.get_lists(@username,@password).to_json
end


get "/locations.json" do
  content_type "application/json"
  c = HTTPClient.new
  content =  c.get_content("http://api.twitter.com/1/trends/available.json")
  puts content
  content
end

get "/topics.json" do
  content_type "application/json"
  c = HTTPClient.new
  content =  c.get_content("http://api.twitter.com/1/trends/44418.json")
  puts content
  content
end

post '/jerry' do
  puts "hello"
  puts "You just asked for login, with username/password equal to #{params[:username]}\n"
  puts "You just asked for login, with username/password equal to #{params[:password]}\n"
  erb :hello
  content_type "application/json"
  return ["ok"].to_json
end

post "/sessions" do
  if params[:username].downcase == "ctctlabs" && params[:password].downcase == "123456"
    content_type "application/json"
    return ["ok"].to_json
  else
    error 406, nil
  end
end

__END__
@@ layout
<html>
  <body>
   <%= yield %>
  </body>
</html>

@@ hello
<h3>Helloooo <%= @name %>!</h3>

