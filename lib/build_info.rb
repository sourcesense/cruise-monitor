class BuildInfo
  
  def initialize(info = '')
    @info = info.empty? ? 'server project 0 success' : info
  end
  
  def update_from(info)
    @info = info
  end
  
  def status
    Text.words_in(@info).last
  end

  def number
    Text.words_in(@info).at(BUILD_NUMBER_POSITION)
  end
  
  def project
    Text.words_in(@info).at(PROJECT_POSITION)
  end
  
  def server
    Text.words_in(@info).first
  end
  
  def to_s
    @info
  end
  
private

  BUILD_NUMBER_POSITION = 2
  PROJECT_POSITION = 1
  
end