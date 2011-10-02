require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class NotificationsTest < BaseAcceptanceTest
  
    def test_notify_build_broken
      previous_and_current_are(
        'myserver myproject 22005 success', 
        'myserver myproject 25034 failed'
      )
    
      @monitor.sync
    
      assert_equal :failed, @server.status
      assert @notifier.has_warned
    end
    
    def test_dont_notify_success_if_build_kept_clean
      previous_and_current_are(
        'myserver myproject 22100 success', 
        'myserver myproject 25300 success'
      )
    
      @monitor.sync
    
      assert_false @notifier.any_notification_sent
    end

    def test_support_for_enthusiastic_mode
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
      prepare_test_data_for(previous, current, CruiseControlRbParser.new, 'cruisecontrol.rb')
    end

  end
end