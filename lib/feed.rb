require 'rubygems'
require 'nokogiri'

class Feed
  
  def Feed.on(url, parser)
    Feed.new(Connector.new(url), parser)
  end
  
  def initialize(connector, parser)
    @connector = connector
    @parser = parser
  end
  
  def latest_info
    feed = Nokogiri::XML(@connector.content)
    @parser.parse(feed)
  end
  
end