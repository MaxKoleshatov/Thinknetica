require_relative 'module_accessors'


class User
    extend Accessors
    
    attr_accessor_with_history :name, :email
    strong_attr_accessor :name, String

end


user = User.new
user.name = "John"
user.email = "john@doe.com"
user.email = "johndoe@gmail.com"
puts user.name # все хорошо
puts user.email_history # все хорошо

user.name= 5 #Выбрасывает исключение.

