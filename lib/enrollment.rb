require_relative './input_files'
require_relative './enrollment_parser'
require 'pry'

class Enrollment
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def dropout_rate_in_year(year)
    # loader?
    dropout_rates = EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)
    # parser class/method?
    row = dropout_rates.select { |row| row if row[:timeframe].to_i == year && row[:category] == "All Students" }
    rate = row[0][:data].to_f unless row.empty?
    # return a truncated 3-digit float
    truncated_rate = rate.round(3) if rate != nil
  end

  def dropout_rate_by_gender_in_year(year)
    # loader?
    dropout_rates = EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)

    # parser class/method?
    rows = dropout_rates.select { |row| row if row[:timeframe].to_i == year && (row[:category] == "Male Students" || row[:category] == "Female Students") }
    result = {}
    rows.each do |row|
      result[:male] = row[:data].to_f if row[:category] == "Male Students"
      result[:female] = row[:data].to_f if row[:category] == "Female Students"
    end
    return result unless result == {}
  end
end
