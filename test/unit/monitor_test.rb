require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class MonitorTest < Test::Unit::TestCase
  
    def setup
      @notifier = StubNotifier.new
      @server = StubServer.new
    
      @monitor = Monitor.new(@server, @notifier)
    end
  
    def test_should_warn_on_build_failure
      @server.status = :failed

      @monitor.sync
      assert @notifier.has_warned
    end
  
    def test_should_notify_success_only_on_new_builds_by_default
      @server.status = :success
      @server.new_build_performed = false
    
      @monitor.sync
    
      assert_false @notifier.any_notification_sent
      assert @server.has_checked_for_build
    end
  
    def test_should_notify_success_only_each_success_when_enthusiast
      @server.status = :success
      @server.new_build_performed = true
      @server.was_failed = false
    
      @monitor.enthusiast = true
      @monitor.sync
    
      assert @notifier.has_notified_success
    end
  
    def test_should_not_notify_success_if_build_was_clean
      @server.status = :success
      @server.new_build_performed = true
      @server.was_failed = false
    
      @monitor.sync
    
      assert_false @notifier.any_notification_sent
    end
  
    def test_should_notify_current_build_info_on_success
      build_info = BuildInfo.new('MyProject project 0 any')
      @server.build_info = build_info
    
      @server.status = :success
      @server.new_build_performed = true
      @server.was_failed = true
    
      @monitor.sync
      assert_equal build_info, @notifier.notified_build_info
    end

    def test_should_notify_current_build_info_on_warn
      build_info = BuildInfo.new('MyProject project 0 any')
      @server.status = :failed
      @server.build_info = build_info
    
      @monitor.sync
      assert_equal build_info, @notifier.notified_build_info
    end
  
  end
end