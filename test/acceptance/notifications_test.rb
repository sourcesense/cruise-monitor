require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class NotificationsTest < Test::Unit::TestCase
  
    def test_dont_notify_success_if_build_kept_clean
      previous_and_current_are(
        'myserver myproject 22100 success', 
        'myserver myproject 25300 success'
      )
    
      @monitor.sync
    
      assert_false @notifier.any_notification_sent
    end
  
    def test_notify_build_broken
      previous_and_current_are(
        'myserver myproject 22005 success', 
        'myserver myproject 25034 failed'
      )
    
      @monitor.sync
    
      assert_equal :failed, @server.status
      assert @notifier.has_warned
    end
  
    def test_only_notify_success_on_new_builds
      previous_and_current_are(
        'myserver myproject 15680 success', 
        'myserver myproject 15680 success'
      )
    
      @monitor.sync
        
      assert_false @notifier.any_notification_sent
    end

    def test_support_for_notification_on_each_success
      previous_and_current_are(
        'myserver myproject 22100 success', 
        'myserver myproject 25300 success'
      )
    
      @monitor.enthusiast = true
      @monitor.sync
    
      assert @notifier.has_notified_success
    end
  
    def test_hudson_support_on_failures
      previous_and_current_are_on_hudson(
        'myproject #23 (SUCCESS)', 
        'myproject #22 (FAILURE)'
      )
    
      @monitor.sync
    
      assert_equal :failed, @server.status
      assert @notifier.has_warned
    end

    def test_hudson_support_on_success
      previous_and_current_are_on_hudson(
        'myproject #23 (SUCCESS)', 
        'myproject #22 (SUCCESS)'
      )
    
      @monitor.enthusiast = true
      @monitor.sync

      assert @notifier.has_notified_success
    end

  private

    def previous_and_current_are(previous, current)
      prepare_test_data_for(previous, current, CruiseControlRbParser.new, 'cruisecontrol.rb')
    end
  
    def previous_and_current_are_on_hudson(previous, current)
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