require File.dirname(__FILE__) + '/../test_helper'
require 'tmpdir'

module CruiseMonitor
  class BuildTest < Test::Unit::TestCase
    include Build
  
    STORAGE_FILE = Dir.tmpdir + '/latest.info'
  
    def test_cruise_rb
      server = cruise_at("", STORAGE_FILE)
      assert_parser_type(CruiseControlRbParser, server)
    end
  
    def test_hudson
      server = hudson_at("", STORAGE_FILE)
      assert_parser_type(HudsonParser, server)
    end
  
    def test_ccnet_feed_url
      feed_url = 'http://localhost/ccnet/server/local/project/myproject/RSSFeed.aspx'
      server = ccnet_at(feed_url, STORAGE_FILE)

      assert_parser_type CruiseControlNetParser, server
    end
  
    def test_ccnet_page_url
      feed_url = 'http://localhost/ccnet/server/local/project/myproject/ViewAllBuilds.aspx'
      server = ccnet_at(feed_url, STORAGE_FILE)

      assert_parser_type CruiseControlNetHtmlParser, server
    end

  private

    def assert_parser_type(expected, server)
      parser = ''
      server.instance_eval { @feed.instance_eval { parser = @parser } }

      assert_equal expected, parser.class
    end
  
  end
end