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

  def dropout_rate_by_race_in_year(year)
    # loader?
    dropout_rates = EnrollmentParser.parse(@name, InputFiles::DROPOUT_RATES)

    # parser?
    by_race_in_year = dropout_rates.select { |row| row if row[:timeframe].to_i == year }
    binding.pry
    by_race_in_year.empty? ? return : result = {}
    by_race_in_year.each do |row|
      # set these relationships to a constant hash?
      result[:asian] = row[:data].to_f if row[:category] == "Asian Students"
      result[:black] = row[:data].to_f if row[:category] == "Black Students"
      result[:pacific_islander] = row[:data].to_f if row[:category] == "Native Hawaiian or Other Pacific Islander"
      result[:hispanic] = row[:data].to_f if row[:category] == "Hispanic Students"
      result[:native_american] = row[:data].to_f if row[:category] == "Native American Students"
      result[:two_or_more] = row[:data].to_f if row[:category] == "Two or More Races"
      result[:white] = row[:data].to_f if row[:category] == "White Students"
    end
    result
  end


end
