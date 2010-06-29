require 'rubygems'
require 'httpclient'
#require 'feedzirra'
require 'nokogiri'
require 'json'

class CCLists

  def get_lists(username, password)
    @username = username
    @password = password
    
    api_key="086d1f8b-bebb-4a3d-a28f-62f124e42034%jerrygulla"
    c = HTTPClient.new

    # for WWW authentication: supports Basic, Digest and Negotiate.
    c.set_auth(nil, api_key, password)
    content =  c.get_content("https://api.constantcontact.com/ws/customers/#{username}/lists")

    doc = Nokogiri::HTML(content)
    list_names = Array.new
    index = 0

    doc.xpath('.//feed/entry/content/contactlist').each do |node|
     list = ""
     subscribercount = 0
      nodeset = node.xpath("name")
      nodeset.each do |n|
        list = n.content
      end

      nodeset = node.xpath("contactcount")
      nodeset.each do |n|
        subscribercount = n.content
      end

     list_names.push({"list" => list,"subscribercount"=>subscribercount})
    end
    list_names
  end
end