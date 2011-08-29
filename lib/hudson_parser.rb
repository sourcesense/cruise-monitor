class HudsonParser
    
  def parse(feed)
    title = feed.xpath('//xmlns:feed/xmlns:entry/xmlns:title',
      'xmlns' => 'http://www.w3.org/2005/Atom'
    ).first.text

    project_name = Text.words_in(title).at(0)
    number = Text.words_in(title).at(1).gsub('#', '')
    status = Text.words_in(title).at(2).gsub('(', '').gsub(')', '')
    
    "Hudson #{project_name} #{number} #{as_status(status)}"
  end
  
private
  
  def as_status status
    return status.downcase if status == 'SUCCESS'
    return 'failed'
  end
end