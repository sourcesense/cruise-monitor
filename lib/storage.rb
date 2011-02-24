class Storage
  
  def initialize(path)
    @path = path
  end
  
  def read
    Utils.create_if_missing(@path)
    Utils.read_from(@path)
  end
  
  def write(content)
    Utils.write_content(@path, "#{content}\n")
  end
  
end