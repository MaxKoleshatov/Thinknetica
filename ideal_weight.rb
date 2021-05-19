puts "Hello! What's your name?"
name = gets.chomp

puts "Ok #{name}, let's figure out your ideal weight. Write your height. "
height = gets.chomp.to_i

ideal_weight = (height -110) *1.15

if ideal_weight < 0
puts "Your weight is already optimal"
else
puts "Your optimal weight = #{ideal_weight}"
end