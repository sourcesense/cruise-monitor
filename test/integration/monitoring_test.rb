require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class RssAndFileTest < BaseIntegrationTest
    include Build
  
    def test_should_connect_to_local_feed_and_notify_success_on_build_back_clean
      Utils.write_content(STORAGE_FILE, 'myproject build 1000 failed')
      @server.prepare(feed_file('cruisecontrol.rb.success.rss'))

      build = cruise_at(any_resource_url, STORAGE_FILE)
      Monitor.failures_on(build, @notifier).sync
    
      assert @notifier.has_notified_success
    end
  
    def test_should_connect_to_local_feed_and_warn_build_failure
      Utils.write_content(STORAGE_FILE, 'myproject build 1000 success')
      @server.prepare(feed_file('cruisecontrol.rb.failed.rss'))
    
      build = cruise_at(any_resource_url, STORAGE_FILE)
      Monitor.failures_on(build, @notifier).sync
    
      assert @notifier.has_warned
    end

    def test_support_monitoring_on_each_success
      @server.prepare(feed_file('cruisecontrol.rb.success.rss'))

      build = cruise_at(any_resource_url, STORAGE_FILE)
      Monitor.all_builds_on(build, @notifier).sync
    
      assert @notifier.has_notified_success
    end

  end
end