def combine_anagrams(words)
  anagram_groups = {}

  words.each do |word|
    key = word.downcase.chars.sort.join

    if anagram_groups.has_key?(key)
      anagram_groups[key].push(word)
    else
      anagram_groups[key] = [word]
    end
  end

  return anagram_groups.values
end

input_words = ['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream']
p combine_anagrams(input_words)
