fibonacci_numbers = [0, 1]
x = 0
while x < 100
  x = fibonacci_numbers[-1] + fibonacci_numbers[-2]
  fibonacci_numbers << x if x < 100
end

puts fibonacci_numbers
