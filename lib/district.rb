require_relative './enrollment'
require 'pry'

class District
  attr_reader :name

  def initialize(name, district_data)
    @name = name.upcase
    @district_data = district_data
  end

  def self.filter_by_enrollment(district_data)
    # filter by year
    data = Hash.new
    district_data.each do |hash|
      data[hash[:timeframe].to_i] = hash[:data].to_i
    end
    data
  end

  def enrollment
    data = District.filter_by_enrollment(@district_data)
    Enrollment.new(data)
  end

  def statewide_testing
    StatewideTesting.new
  end
end
