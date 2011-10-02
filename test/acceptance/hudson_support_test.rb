require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class HudsonSupportTest < BaseAcceptanceTest

    def test_on_failures
      previous_and_current_are(
        'myproject #23 (SUCCESS)', 
        'myproject #22 (FAILURE)'
      )
    
      @monitor.sync
    
      assert_equal :failed, @server.status
      assert @notifier.has_warned
    end

    def test_on_success
      previous_and_current_are(
        'myproject #23 (SUCCESS)', 
        'myproject #22 (SUCCESS)'
      )
    
      @monitor.enthusiast = true
      @monitor.sync

      assert @notifier.has_notified_success
    end

  private
  
    def previous_and_current_are(previous, current)
      prepare_test_data_for(previous, current, HudsonParser.new, 'hudson')
    end
  
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