require File.dirname(__FILE__) + '/../test_helper'

class FeedTest < Test::Unit::TestCase

  def test_should_parse_rss_feed_for_cruise_control_rb
    @connector = FakeConnector.new(feed_file('cruisecontrol.rb.template.rss'))
    @feed = Feed.new(@connector, CruiseControlRbParser.new)
    
    @connector.item_title = 'MyProject build 123 success'
    assert_equal 'Cruise MyProject 123 success', @feed.latest_info
  end
  
  def test_should_parse_atom_feed_for_hudson
    @connector = FakeConnector.new(feed_file('hudson.template.rss'))
    @feed = Feed.new(@connector, HudsonParser.new)    

    @connector.item_title = 'MyProject #123 (SUCCESS)'
    assert_equal 'Hudson MyProject 123 success', @feed.latest_info
  end
  
end