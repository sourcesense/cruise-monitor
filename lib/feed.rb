require 'rubygems'
require 'nokogiri'

module CruiseMonitor
  class Feed
  
    def Feed.on(url, parser)
      Feed.new(Connector.new(url), parser)
    end
  
    def initialize(connector, parser)
      @connector = connector
      @parser = parser
    end
  
    def latest_info
      xml_feed = Nokogiri::XML(@connector.content)
      @parser.parse(xml_feed)
    end
  
  end
end