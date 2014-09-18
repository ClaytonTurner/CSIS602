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
    hash_array = []
    words = self.split
    words.each{|word|
	t = word.size - 1
	index = 0
	h = Hash.new(0)
	t.times{
		h[word[index]] += 1
		index += 1	
	}	
	hash_array << h
    }
    
    #index = 0
    #hash_array.each{
#	index2 = 0
#	hash_array.each{
#	if index != index2
#		
#	end
#	index2 += 1
 #       }
#	index += 1
 #   }
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
