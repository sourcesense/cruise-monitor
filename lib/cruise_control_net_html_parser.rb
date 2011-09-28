module CruiseMonitor
  class CruiseControlNetHtmlParser
  
    class HtmlInfo
    
      def initialize(content)
        @content = content
      end
    
      def build_number
        failed? ? timestamp : number
      end
    
      def status
        as_status(Text.words_in(@content).at(2))
      end
    
    private

      def number
        as_number(Text.words_in(@content).at(2))
      end
    
      def timestamp
        date = Text.words_in(@content).at(0)
        time = Text.words_in(@content).at(1)

        "#{date.gsub('-', '')}#{time.gsub(':', '')}"
      end

      def failed?
        status == 'failed'
      end
    
      def as_status(value)
        return 'failed' if as_number(value) == 'Failed'
        return 'success'
      end

      def as_number(value)
        Text.within_brackets_in(value)
      end
    end
  
    def parse(feed)
      project_name = feed.xpath("//table[@class='breadcrumbs']//a").last.text
      item_title = feed.xpath("//a[starts-with(@class,'build-')]").first.text

      html_info = HtmlInfo.new(item_title)
      "Cruise #{project_name} #{html_info.build_number} #{html_info.status}"
    end
  
  end
end