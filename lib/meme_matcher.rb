require 'meme_generator'

class MemeMatcher
  REGEXS = [
    /^(\w+)\s+"(.*)"\s+"(.*)"$/i,
    /^(\w+)\s+"(.*)"$/i
  ]

  def self.match(str)
    REGEXS.each do |regex|
      matches = str.match(regex)
      if matches
        return MemeGenerator.url(matches[1], matches[2], matches[3])
      end
    end

    return nil
  end
end
