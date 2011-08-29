class HudsonParser
    
  def parse(feed)
    title = feed.xpath('//xmlns:feed/xmlns:entry/xmlns:title',
      'xmlns' => 'http://www.w3.org/2005/Atom'
    ).first.text

    project_name = Text.words_in(title).at(0)
    number = as_number(Text.words_in(title).at(1))
    status = as_status(Text.words_in(title).at(2))
    
    "Hudson #{project_name} #{number} #{status}"
  end
  
private

  def as_number(string)
    string.gsub!('#', '')
  end
  
  def as_status(string)
    status = string.gsub!('(', '').gsub!(')', '')

    return status.downcase if status == 'SUCCESS'
    return 'failed'
  end
end