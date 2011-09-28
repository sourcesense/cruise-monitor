require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class ServerTest < Test::Unit::TestCase

    def setup
      @feed = StubFeed.new
      @storage = StubStorage.new
    
      @server = Server.new(@feed, @storage)
    end

    def test_should_detect_success
      @feed.latest_info = 'myserver MyProject 123 success'
      @server.check_build
    
      assert_equal :success, @server.status
    end
  
    def test_should_detect_failure  
      @feed.latest_info = 'myserver MyProject 123 failed'
      @server.check_build
    
      assert_equal :failed, @server.status
    end
  
    def test_should_detect_build_has_changed
      @feed.latest_info = 'myserver MyProject 100 success'
      @server.check_build
    
      @feed.latest_info = 'myserver MyProject 101 success'
      @server.check_build
    
      assert @server.new_build_performed?
    end
  
    def test_should_detect_build_has_not_changed
      @feed.latest_info = 'myserver MyProject 101 success'
      @server.check_build
    
      @feed.latest_info = 'myserver MyProject 101 success'
      @server.check_build
    
      assert_false @server.new_build_performed?
    end
  
    def test_should_read_previuos_build_info
      @storage.content = BuildInfo.new.to_s
    
      server = Server.new(@feed, @storage)
      assert_false server.new_build_performed?
    end
  
    def test_should_restore_previuos_state_on_start
      @storage.content = 'myserver MyProject 44 success'
    
      server = Server.new(@feed, @storage)
      assert_false server.new_build_performed?
    end
  
    def test_should_store_latest_build_info
      @feed.latest_info = 'myserver MyProject 123 success'
      @server.check_build
    
      assert_equal 'myserver MyProject 123 success', @storage.content
    end
  
    def test_should_not_update_store_when_nothing_changed
      @feed = StubFeed.new
      @storage = StubStorage.new('myserver MyProject 123 success')
    
      @server = Server.new(@feed, @storage)
    
      @feed.latest_info = 'myserver MyProject 123 success'
      @server.check_build
    
      assert_false @storage.has_been_updated
    end
  
    def test_should_store_build_info
      @feed.latest_info = 'myserver MyProject 123 success'
      @server.check_build
    
      assert_equal 'myserver MyProject 123 success', @server.build_info.to_s
    end
  
    def test_should_detect_build_was_failed
      @storage.content = 'myserver MyProject 100 failed'
      @feed.latest_info = 'myserver MyProject 200 success'
      server = Server.new(@feed, @storage)
    
      server.check_build
    
      assert server.was_failed
    end
  
    def test_should_detect_build_wasnt_failed
      @storage.content = 'myserver MyProject 100 success'
      @feed.latest_info = 'myserver MyProject 200 success'
      server = Server.new(@feed, @storage)
    
      server.check_build
    
      assert_false server.was_failed
    end

  end
end