
module Validation

    NUMBER_FORMAT = /^[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i.freeze


    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end
  
    module ClassMethods

        def validate(attr, validate_type, arg = nil)
            @a ||= [] 
            c = []
            c << attr
            c << validate_type
            c << arg
            @a.push(c)     
        end

        def test_method
            @a
        end
    end
  
    module InstanceMethods
     
        def valid?
            validate!
            true
            rescue StandardError => e
            false               
        end

        def validate!
            self.class.test_method.each do |attr, validate_type, arg| 
                if validate_type == :presence
                  raise "Не может быть с пустым номером" if instance_variable_get("@#{attr}".to_sym) == nil
                elsif validate_type == :format
                    raise "Не подходит формат номера" if instance_variable_get("@#{attr}".to_sym) !~ NUMBER_FORMAT
                elsif validate_type == :type
                    raise "Не подходит тип номера" if instance_variable_get("@#{attr}".to_sym).class != arg               
                end
            end
        end     
    end
end


  