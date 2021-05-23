one_shopping = {}
basket_shopping = 0

loop do
       
puts "Please enter the name of the product"
    iteam = gets.chomp
  
 if iteam == "stop"
    break 
 else

puts "Please enter product price"
price = gets.chomp.to_i


puts "Please enter product quantity"
quantity = gets.chomp.to_i

 
one_shopping[iteam] = {price: price, quantity: quantity, amount: price * quantity}

basket_shopping  += price * quantity
 end
end

puts one_shopping
puts "The total amount of your items = #{basket_shopping}" 


