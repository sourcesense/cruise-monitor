require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class BaseIntegrationTest < Test::Unit::TestCase

    def setup
      @server = FeedServer.new(10123)
      @server.start
    
      @notifier = StubNotifier.new
    end
  
    def teardown
      @server.stop
    end
    
    def test_ignore_this; end
    
    protected

      def any_resource_url
        "#{@server.url}/any-resource"
      end

  end
  
end