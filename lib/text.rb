module Text

  WITHIN_BRACKETS = /\((.*)\)/

  def Text.words_in(content)
    content.split(' ')
  end
  
  def Text.find_in(content, pattern)
    match = pattern.match(content)
    return group_in(match)
  end
  
  def Text.within_brackets_in(text)
    find_in(text, WITHIN_BRACKETS)
  end
  
private

  def Text.group_in(match)
    match.to_a.last
  end
  
end