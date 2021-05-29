day = gets.chomp.to_i
mount = gets.chomp.to_i
year = gets.chomp.to_i

mounts = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30,
           12 => 31 }
mounts[2] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0

sum_1 = 0
sum_2 = 0
mounts.each do |k, v|
    if k == mount
sum_1 = v - (v - day)


  while k !=  0
    
    k -= 1
    
    sum_2 += mounts[k].to_i
  end    
  end
end
p sum_1
p sum_2
p sum_count = sum_1 + sum_2
