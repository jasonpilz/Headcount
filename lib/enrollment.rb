require_relative './input_files'
require_relative './enrollment_parser'

class Enrollment
  attr_reader :name

  def initialize(name)
    @name = name

  end

  def dropout_rate_in_year(year)
    dropout_rates = EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)
    rate = dropout_rates[year][:all]
    rate.to_i
  end
end

enrollment = Enrollment.new("ACADEMY 20")
enrollment.dropout_rate_in_year(2011)
EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)
 # {2011 => {:all => 0.002, :female => 0.004, :male => 0.003,}
 #  2012 {}}
