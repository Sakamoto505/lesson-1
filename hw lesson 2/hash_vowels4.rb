a = 'a'...'z'
vowels = ['a', 'e', 'i', 'o', 'u']
hash = {}
a.each_with_index do |letter, index| 
    hash[index + 1] = letter if vowels.include?(letter)
end
puts hash


    