require 'meme_generator'

class MemeMatcher
  REGEXS = [
    /^(\w+)\s+"(.*)"\s+"(.*)"$/i,
    /^(\w+)\s+"(.*)"$/i
  ]

  def self.match(str)
    REGEXS.each do |regex|
      if resp = match_meme(regex, str)
        return resp
      end
    end
    return nil
  end

  def self.match_meme(regex, str)
    str.match(regex) do |matches|
      MemeGenerator.url(matches[1], matches[2], matches[3])
    end
  end
end
