class String

  def with_word! word
    unless self =~ /\b#{Regexp.escape word}\b/
      self << ' ' unless self[-1] == ' '
      self << word
    end
    self
  end

  def with_word word
    dup.with_word! word
  end

end
