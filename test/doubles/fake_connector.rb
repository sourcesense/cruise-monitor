class FakeConnector
  attr_accessor :item_title
  
  def initialize(file_path)
    @file_path = file_path
  end
  
  def content
    content = File.open(@file_path).read
    content.gsub(/@TOKEN@/, item_title)
  end
  
end