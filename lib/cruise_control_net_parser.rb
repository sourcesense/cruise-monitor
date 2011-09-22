class CruiseControlNetParser
  
  def parse(feed)
    channel_title = feed.xpath('//channel/title').first.text
    item_title = feed.xpath('.//item').last.text

    project_name = Text.words_in(channel_title).at(2)
    number = Text.words_in(item_title).at(1)
    status = as_status(Text.words_in(item_title).at(3))
    
    "Cruise #{project_name} #{number} #{status}"
  end

private

  def as_status(string)
    return 'success' if string.downcase == 'success'
    return 'failed'
  end
  
end