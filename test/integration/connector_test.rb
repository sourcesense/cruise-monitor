require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class ConnectorTest < Test::Unit::TestCase
  
    def test_should_connect_via_http
      connector = Connector.new('http://www.google.com/')
      assert_contains "Google", connector.content
    end
  
  end
end