require File.dirname(__FILE__) + '/../test_helper'

module CruiseMonitor
  class BuildTest < Test::Unit::TestCase
    include Build
  
    ANY_STORAGE = Utils.temp_file('any.file')
  
    def test_set_parser_for_cruise_rb
      server = cruise_at("", ANY_STORAGE)
      assert_parser_type CruiseControlRbParser, server
    end
  
    def test_set_parser_for_hudson
      server = hudson_at("", ANY_STORAGE)
      assert_parser_type HudsonParser, server
    end
  
    def test_set_parser_for_ccnet_with_feed_url
      feed_url = 'http://anyserver/ccnet/server/local/project/myproject/RSSFeed.aspx'
      server = ccnet_at(feed_url, ANY_STORAGE)

      assert_parser_type CruiseControlNetParser, server
    end
  
    def test_set_parser_for_ccnet_with_page_url
      feed_url = 'http://anyserver/ccnet/server/local/project/myproject/ViewAllBuilds.aspx'
      server = ccnet_at(feed_url, ANY_STORAGE)

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