module Text

  def Text.words_in(content)
    content.split(' ')
  end
  
  def Text.find_in(content, pattern)
    match = pattern.match(content)
    match.to_a.first
  end
  
end