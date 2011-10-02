require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class ConnectorTest < Test::Unit::TestCase
  
    def setup
      @server = FeedServer.new(10123)
      @server.start
    end
    
    def teardown
      @server.stop
    end
  
    def test_should_connect_via_http
      @server.prepare(feed_file('www.google.com.html'))
      
      connector = Connector.new(@server.url)
      assert_contains "Google", connector.content
    end
  
  end
end