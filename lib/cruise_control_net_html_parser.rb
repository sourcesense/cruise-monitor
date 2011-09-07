class CruiseControlNetHtmlParser
  
  def parse(feed)    
    project_name = feed.xpath("//table[@class='breadcrumbs']//a").last.text
    item_title = feed.xpath("//a[@class='build-passed-link']").first.text

    number = as_number(Text.words_in(item_title).at(2))
    status = as_status(Text.words_in(item_title).at(2))
    
    "Cruise #{project_name} #{number} #{status}"
  end

private

  def as_number(string)
    string.gsub('(', '').gsub(')', '')
  end

  def as_status(string)
    status = as_number(string).downcase

    return 'failed' if status == 'Failed'
    return 'success'
  end
  
end