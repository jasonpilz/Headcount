require_relative './enrollment'

class District
  attr_reader :name

  def initialize(name)
    @name = name.upcase
  end

  def enrollment
    Enrollment.new(name)
  end
end
