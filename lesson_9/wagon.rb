# frozen_string_literal: true

require_relative 'module_firm'
require_relative 'module_accessors'

class Wagon
  extend Accessors
  include Firm

  attr_reader :type

  def initialize(arg)
    @type = arg
   end

  attr_accessor_with_history :name, :age, :height
  strong_attr_accessor :name, String
end


