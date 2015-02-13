require 'set'

f = File.open("text.txt", "r")
contents = f.read

# 1
all_words = contents.scan(/\b[\w|'|-]+\b/)
puts all_words.size

# 2
unique_words = Set.new
contents.scan(/\b[\w|'|-]+\b/).each do |word|
  unique_words.add(word.downcase)  
end
puts unique_words.size

# 3
puts unique_words.size.to_f / all_words.size.to_f

# 4
bigrams = Array.new
all_words.each_with_index do |word, index|
  if all_words.size > (index + 1)
    bigrams.push([word.downcase, all_words[index+1].downcase])
  end
end

# 5
def return_n_grams n, text
  n_grams = Array.new
  all_words = text.scan(/\b[\w|'|-]+\b/)
  all_words.each_with_index do |word, index|
    if all_words.size > (index + (n-1))
      n_gram = Array.new
      (0..(n-1)).each do |i|
        n_gram.push(all_words[index + i].downcase)
      end
      n_grams.push(n_gram)
    end
  end
  n_grams
end

def most_common_n_grams n, text
  n_grams = return_n_grams n, text
  frequencies = n_grams.inject(Hash(0)){|hash, array_item| hash[array_item] += 1; hash}
end

p most_common_n_grams 2, contents
