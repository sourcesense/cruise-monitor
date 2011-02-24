class StubStorage
  attr_accessor :content, :has_been_updated
  
  def initialize(content='')
    @content = content
    @has_been_updated = false
  end
  
  def read
    @content
  end
  
  def write(content)
    @has_been_updated = true
    @content = content
  end
  
end