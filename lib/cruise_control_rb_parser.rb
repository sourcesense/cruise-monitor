module CruiseMonitor
  class CruiseControlRbParser
  
    def parse(feed)
      title = feed.xpath('//channel/item/title').first.text

      project_name = Text.words_in(title).at(0)
      number = Text.words_in(title).at(2)
      status = Text.words_in(title).at(3)
    
      "Cruise #{project_name} #{number} #{status}"
    end
  
  end
end