# frozen_string_literal: true

require_relative 'module_firm'

class Wagon
  include Firm

  attr_reader :type

  def initialize(arg); end
end
