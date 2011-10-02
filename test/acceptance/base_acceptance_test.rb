require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class BaseAcceptanceTest < Test::Unit::TestCase

    def test_ignore_this; end

  protected
    
      def prepare_test_data_for(previous, current, parser, build_server)
        storage = StubStorage.new
        storage.content = previous
    
        connector = FakeConnector.new(feed_file("#{build_server}.template.rss"))
        connector.item_title = current
    
        @server = Server.new(Feed.new(connector, parser), storage)
    
        @notifier = StubNotifier.new    
        @monitor = Monitor.new(@server, @notifier)
      end

  end
end