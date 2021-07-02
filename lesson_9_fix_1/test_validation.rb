require_relative 'module_validation'

class User
    include Validation
    
    attr_accessor :name

    validate :name, :presence
    validate :name, :format_name
    validate :name, :type, String

    def initialize(name)
        @name = name
        validate!
    end

end

user = User.new("Макс") # Все хорошо
user = User.new(nil) # Выбрасывает первое исключение из модуля 
user = User.new("Max")  # Выбрасывает второе исключение из модуля
user = User.new(5) # Выбрасывает третье исключение из модуля, при условии отключения второй валидации, потому что формат регулярного выражения во второй валидации подразумевает строку. Получается она исключает третью валидацию и руби до нее не доходит. 

user = User.new("Макс")
user.validate! # вернет true
user.name= "Max"
user.validate! # выбросит второе исключение из модуля

user = User.new("Макс")
user.valid? # вернет true
user.name= "Max"
user.valid?  # вернет false







