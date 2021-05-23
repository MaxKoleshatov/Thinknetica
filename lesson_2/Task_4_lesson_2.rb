hash = {}
range = ('a'..'z')
arr = range.to_a
arr.each_with_index do |x, index|
  index += 1
  hash[x] = index
end

hash.select! do |k, _v|
  k =~ /[aeiou]/
end

p hash
