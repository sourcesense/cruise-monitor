require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class BaseIntegrationTest < Test::Unit::TestCase

    STORAGE_FILE = Utils.temp_file('/latest.info')
  
    def setup
      Utils.delete_if_exists(STORAGE_FILE)
  
      @server = FeedServer.new(10123)
      @server.start
    
      @notifier = StubNotifier.new
    end
  
    def teardown
      @server.stop
      Utils.delete_if_exists(STORAGE_FILE)
    end
    
    def test_ignore_this; end
    
    protected

      def any_resource_url
        "#{@server.url}/any-resource"
      end

  end
  
end