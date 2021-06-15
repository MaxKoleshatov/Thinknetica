require_relative 'train'

puts "Вы хотите создать поезд"


begin
puts "Введите номер поезда который соотвествует формату"
number = gets.chomp

puts "Введите тип поезда какой хотите создать"
type = gets.chomp.to_s

puts "Введите количество вагонов в поезде"
wagon = gets.chomp


user_train = Train.new(number, type, wagon)
rescue Exception => e
    puts "#{e.message}. Попробуйте снова "
retry
end

puts "Вы создали поезд № #{user_train.number}"
