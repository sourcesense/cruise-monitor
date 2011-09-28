require 'rubygems'
require 'httpclient'

module CruiseMonitor
  class Connector
  
    def initialize(url)
      @http_client = HTTPClient.new
      @url = url
    end
  
    def content
      @http_client.get_content(@url)
    end
  
  end
end