require_relative './input_files'
require_relative './enrollment_parser'
require 'pry'
class Enrollment
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def dropout_rate_in_year(year)
    # loader class?
    dropout_rates = EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)
    # parser class?
    rate = dropout_rates.select { |row| row if row[:timeframe].to_i == year && row[:category] == "All Students" }
    rate = rate[0][:data].to_f unless rate.empty?
  end
end

__END__
enrollment = Enrollment.new("ACADEMY 20")
enrollment.dropout_rate_in_year(2011)

EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)
