def palindrome?(string)
  filtered_string = string.downcase.gsub(/\W/, "")
  filtered_string == filtered_string.reverse
end

puts palindrome?("A man, a plan, a canal -- Panama")
puts palindrome?("Madam, I'm Adam!")
puts palindrome?("Abracadabra")

def count_words(string)
  string.downcase.scan(/\w+/).each_with_object(Hash.new(0)) do |word, counts|
    counts[word] += 1
  end
end

p count_words("A man, a plan, a canal -- Panama")
p count_words("Doo bee doo bee doo")
p count_words("Go!")
p count_words("No words, just punctuation!!!")

