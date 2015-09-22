require_relative 'statewide_testing'
require_relative 'enrollment'
require_relative 'economic_profile'

class District
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def name
    result = @name.upcase
  end

  def statewide_testing
    #returns an instance of StatewideTesting
    StatewideTesting.new(@name)
  end

  def enrollment
    #returns an instance of Enrollment
    Enrollment.new(@name)
  end

  def economic_profile
    EconomicProfile.new(@name)
  end

end
