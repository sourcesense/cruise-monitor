require File.dirname(__FILE__) + '/../test_helper'

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

private

  def previous_and_current_are(previous, current)  
    storage = StubStorage.new
    storage.content = previous
    
    connector = FakeConnector.new(feed_file('cruisecontrol.rb.template.rss'))
    connector.item_title = current
    
    @server = Server.new(Feed.new(connector, CruiseControlRbParser.new), storage)
    
    @notifier = StubNotifier.new    
    @monitor = Monitor.new(@server, @notifier)
  end

end