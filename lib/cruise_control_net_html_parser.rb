class CruiseControlNetHtmlParser
  
  def parse(feed)    
    project_name = feed.xpath("//table[@class='breadcrumbs']//a").last.text
    item_title = feed.xpath("//a[starts-with(@class,'build-')]").first.text

    status = as_status(Text.words_in(item_title).at(2))
    if(status == 'failed')
      date = Text.words_in(item_title).at(0)
      time = Text.words_in(item_title).at(1)
      number = as_timestamp(date, time)
    else
      number = as_number(Text.words_in(item_title).at(2))
    end
    
    "Cruise #{project_name} #{number} #{status}"
  end

private

  def as_number(value)
    value.gsub('(', '').gsub(')', '')
  end

  def as_status(value)
    return 'failed' if as_number(value) == 'Failed'
    return 'success'
  end
  
  def as_timestamp(date, time)
    "#{date.gsub('-', '')}#{time.gsub(':', '')}"
  end
  
end