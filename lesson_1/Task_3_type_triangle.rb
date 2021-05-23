puts "Hey! This program will help you find out what type your triangle belongs to.
Enter the values ​​of all three sides of your triangle one by one"
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

if a**2 + b**2 == c**2 || b**2 + c**2 == a**2 || c**2 + a**2 == b**2
  puts "это прямоугольный" 

elsif a == b || b == c || a == c
  puts "это равнобедренный" 

elsif a == b && a == c && b == c
  puts "это равносторонний" 

else
    puts " Это другой треугольник"

end















