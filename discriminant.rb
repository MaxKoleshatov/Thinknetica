puts "Hey! This program will help you calculate the discriminant and roots of the equation.
Enter the values ​​of the coefficients"

a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

d = b**2 - 4*a*c

if d < 0
 puts "Your discriminant = #{d}, but no roots"

elsif d > 0
    x1 = (-b + Math.sqrt(d)) / (2*a)
    x2 = (-b - Math.sqrt(d)) / (2*a)
    puts "Your discriminant = #{d}, and you roots x1 = #{x1} , x2 = #{x2}"

else
    x1 = x2 = -b/(2*a)
    puts "Your discriminant = #{d}, and you roots x1=x2 = #{x1}"
end
