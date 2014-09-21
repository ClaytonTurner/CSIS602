module FunWithStrings
  def palindrome?
    str = self.delete ",!.*&^%$#@()[]\s;:"
    return true if str==str.reverse.downcase
    return false
  end
  def count_words
    h = Hash.new(0)
    arr = self.split.delete ",!.*&^%$#@()[]\s;:"
    arr.each{|word|
	newWord = word.downcase
	h[newWord] += 1	
    }
    return h
  
  def anagram_groups
    groups = []
    words = self.split
    words.each{|word|
    	anagramsTemp = []
	words.each{|word2|
		if word.downcase.split(//).sort==word2.downcase.split(//).sort
			anagramsTemp << word2
	}	
	# By this point, we will have built a single anagram group
	groups << anagramsTemp
    }
    return groups.uniq
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
