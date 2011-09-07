module Build
  
  def cruise_at(rss_feed_url, storage_path)
    Server.new(
      Feed.on(rss_feed_url, CruiseControlRbParser.new), 
      Storage.new(storage_path)
    )
  end
  
  def hudson_at(atom_feed_url, storage_path)
    Server.new(
      Feed.on(atom_feed_url, HudsonParser.new), 
      Storage.new(storage_path)
    )
  end

  def ccnet_at(url, storage_path)
    Server.new(
      Feed.on(url, ccnet_parser_for(url)), 
      Storage.new(storage_path)
    )
  end

private

  def ccnet_parser_for(url)
    return CruiseControlNetParser.new if url.end_with?('RSSFeed.aspx')
    return CruiseControlNetHtmlParser.new
  end

end