require 'rubygems'
require 'httpclient'
#require 'feedzirra'
require 'nokogiri'
require 'json'

class TwitterTopics

  def get_topics(woeid)
    c = HTTPClient.new

    content =  c.get_content("http://api.twitter.com/1/trends/#{woeid}.xml")

    doc = Nokogiri::HTML(content)
    topic_names = Array.new
    index = 0

    doc.xpath('.//matching_trends/trends/trend').each do |node|
      puts node.content
      topic_names.push(node.content)
    end
    topic_names
  end
end