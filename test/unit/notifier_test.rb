require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class NotifierForTesting < Notifier
    attr_reader :message
  
    def say(message)
      @message = message
    end
  
  end

  class NotifierTest < Test::Unit::TestCase
  
    def setup
      @build_info = BuildInfo.new('Cruise MyProject project 1 whatever')    
      @notifier = NotifierForTesting.new    
    end
  
    def test_should_say_server_is_happy_on_success
      @notifier.success(@build_info)
      assert_contains 'Cruise is happy with MyProject', @notifier.message
    end
  
    def test_should_say_build_broken_on_warn
      @notifier.warn(@build_info)
      assert_contains 'build broken for MyProject', @notifier.message
    end
  
  end
end