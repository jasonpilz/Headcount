require_relative './input_files'
require_relative './enrollment_parser'
require 'pry'

class UnknownRaceError < KeyError
end

class Enrollment
  attr_reader :name

  RACES = {asian: "Asian Students",
           black: "Black Students",
           pacific_islander: "Native Hawaiian or Other Pacific Islander",
           hispanic: "Hispanic Students",
           native_american: "Native American Students",
           two_or_more: "Two or More Races",
           white: "White Students"}

  def initialize(name)
    @name = name
  end

  def dropout_rate_in_year(year)
    dropout_rates = EnrollmentParser.parse_dropout_rates(@name)

    # parser class/method?
    row = dropout_rates.select { |row| row if row[:timeframe].to_i == year && row[:category] == "All Students" }
    rate = row[0][:data][0..4].to_f unless row.empty?
  end

  def dropout_rate_by_gender_in_year(year)
    dropout_rates = EnrollmentParser.parse_dropout_rates(@name)

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
    dropout_rates = EnrollmentParser.parse_dropout_rates(@name)

    # parser?
    by_race_in_year = dropout_rates.select { |row| row if row[:timeframe].to_i == year }
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

  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = EnrollmentParser.parse_dropout_rates(@name)
    race_by_year = dropout_rates.select { |row| row if row[:category] == RACES.fetch(race)}
    race_by_year.empty? ? return : result = {}
    race_by_year.each do |row|
      result[row[:timeframe].to_i] = row[:data].to_f
    end
    result
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = EnrollmentParser.parse_dropout_rates(@name)
    rate = dropout_rates.select { |row| row if row[:category] == RACES.fetch(race) && row[:timeframe].to_i == year }
    rate.empty? ? return : rate.first[:data][0..4].to_f
  end

  def graduation_rate_by_year
    grad_rates = EnrollmentParser.parse_grad_rates(@name)
    grad_rates.empty? ? return : result = {}
    grad_rates.each do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    result
  end

  def graduation_rate_in_year(year)
    grad_rates = EnrollmentParser.parse_grad_rates(@name)
    rate = grad_rates.select { |row| row if row[:timeframe].to_i == year }
    rate.empty? ? return : rate.first[:data][0..4].to_f
  end

  def kindergarten_participation_by_year
    kindergarten = EnrollmentParser.parse_kindergarten(@name)
    kindergarten.empty? ? return : results = {}
    kindergarten.sort_by! { |row| row[:timeframe] }
                .each { |row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
    results
  end

  def kindergarten_participation_in_year(year)
    kindergarten = EnrollmentParser.parse_kindergarten(@name)
    result = kindergarten.select { |row| row if row[:timeframe].to_i == year }
    result.empty? ? return : result.first[:data][0..4].to_f
  end

  def online_participation_by_year

  end

  def online_participation_in_year(year)

  end

  def participation_by_year

  end

  def participation_in_year(year)

  end

  def participation_by_race_or_ethnicity(race)

  end

  def participation_by_race_or_ethnicity_in_year(year)
    participation = EnrollmentParser.parse_enrollment_by_race(@name)
    by_race_in_year = participation.select do |row|
      row if (row[:timeframe].to_i == year && (row[:dataformat] == 'Percent'))
    end
    by_race_in_year.empty? ? return : result = {}
    by_race_in_year.each do |row|
      result[:asian] = row[:data].to_f if row[:race] == RACES[:asian]
      result[:black] = row[:data].to_f if row[:race] == RACES[:black]
      result[:pacific_islander] = row[:data].to_f if row[:race] == RACES[:pacific_islander]
      result[:hispanic] = row[:data].to_f if row[:race] == RACES[:hispanic]
      result[:native_american] = row[:data].to_f if row[:race] == 'American Indian Students'
      result[:two_or_more] = row[:data].to_f if row[:race] == 'Two or more races'
      result[:white] = row[:data].to_f if row[:race] == RACES[:white]
    end
    result
  end

  def special_education_by_year
    special_ed = EnrollmentParser.parse_special_ed(@name)
    special_by_year = special_ed.select do |row|
      row if (row[:dataformat] == 'Percent')
    end
    special_by_year.empty? ? return : result = {}
    special_by_year.each do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    result
  end

  def special_education_in_year(year)
    special_ed = EnrollmentParser.parse_special_ed(@name)
    result = special_ed.select do |row|
      row if (row[:timeframe].to_i == year) && (row[:dataformat] == 'Percent')
    end
    result.empty? ? return : result.first[:data][0..4].to_f
  end

  def remediation_by_year
    remediation = EnrollmentParser.parse_remediation(@name)
    rem = remediation.select { |row| row if row[:dataformat] == 'Percent' }
    rem.empty? ? return : result = {}
    rem.each do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    result
  end

  def remediation_in_year(year)
    remediation = EnrollmentParser.parse_remediation(@name)
    result = remediation.select do |row|
      row if (row[:timeframe].to_i == year) && (row[:dataformat] == 'Percent')
    end
    result.empty? ? return : result.first[:data][0..4].to_f
  end

end
