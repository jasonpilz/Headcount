require 'pry'
require_relative './statewide_testing_parser'

class UnknownDataError < StandardError
end

class StatewideTesting
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def proficient_by_grade(grade)

  end

end
