require 'rubygems'
require 'httpclient'
require 'nokogiri'

class TwitterTopics

  def get_topics(woeid)
    c = HTTPClient.new

    content = %{
      <?xml version="1.0" encoding="UTF-8"?>
      <matching_trends type="array">
      <trends created_at="2010-06-29T15:08:13Z" as_of="2010-06-29T15:22:10Z">
        <locations>
          <location>
            <woeid>44418</woeid>
            <name>London</name>
          </location>
        </locations>
        <trend query="Harry+Potter" url="http://search.twitter.com/search?q=Harry+Potter">Scary Potter</trend>
        <trend query="Over+Capacity" url="http://search.twitter.com/search?q=Over+Capacity">Over Capacity</trend>
        <trend query="%23worldcup" url="http://search.twitter.com/search?q=%23worldcup">#worldcup</trend>
        <trend query="Japan" url="http://search.twitter.com/search?q=Japan">Japan</trend>
        <trend query="%23oneletterextrabands" url="http://search.twitter.com/search?q=%23oneletterextrabands">#oneletterextrabands</trend>
        <trend query="%23jpn" url="http://search.twitter.com/search?q=%23jpn">#jpn</trend>
        <trend query="Paraguay" url="http://search.twitter.com/search?q=Paraguay">Paraguay</trend>
        <trend query="Spain" url="http://search.twitter.com/search?q=Spain">Spain</trend>
        <trend query="Honda" url="http://search.twitter.com/search?q=Honda">Honda</trend>
        <trend query="Echt" url="http://search.twitter.com/search?q=Echt">Echt</trend>
      </trends>
      </matching_trends>
    }

    # comment out following line to use offfline
    content =  c.get_content("http://api.twitter.com/1/trends/#{woeid}.xml")
    doc = Nokogiri::HTML(content)
    topic_names = Array.new
    
    doc.xpath('.//matching_trends/trends/trend').each do |node|
      topic_names.push(node.content)
    end
    topic_names
  end
end