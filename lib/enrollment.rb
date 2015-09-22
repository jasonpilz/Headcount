require 'pry'

class UnknownRaceError < StandardError
end

class Enrollment
  attr_reader :name

  RACES = {asian: "asian students",
           black: "black students",
           pacific_islander: "native hawaiian or other pacific islander",
           hispanic: "hispanic students",
           native_american: "native american students",
           two_or_more: "two or more races",
           white: "white students"}

  def initialize(name, parser)
    @parser = parser
    @name = name
  end

  def format(value)
    value[0..4].to_f
  end

  def dropout_rate_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)
    # parser class/method?
    row = dropout_rates.select { |row| row if row[:timeframe].to_i == year && row[:category] == "all students" }
    format(row[0][:data]) unless row.empty?
  end

  def dropout_rate_by_gender_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)
    # parser class/method?
    rows = dropout_rates.select { |row| row if row[:timeframe].to_i == year && (row[:category] == "male students" || row[:category] == "female students") }
    result = {}
    rows.each do |row|
      result[:male] = row[:data].to_f if row[:category] == "male students"
      result[:female] = row[:data].to_f if row[:category] == "female students"
    end
    return result unless result == {}
  end

  def dropout_rate_by_race_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)

    # parser?
    by_race_in_year = dropout_rates.select { |row| row if row[:timeframe].to_i == year }
    by_race_in_year.empty? ? return : result = {}
    by_race_in_year.each do |row|
      # set these relationships to a constant hash?
      result[:asian] = format(row[:data]) if row[:category] == RACES[:asian]
      result[:black] = format(row[:data]) if row[:category] == RACES[:black]
      result[:pacific_islander] = format(row[:data]) if row[:category] == RACES[:pacific_islander]
      result[:hispanic] = format(row[:data]) if row[:category] == RACES[:hispanic]
      result[:native_american] = format(row[:data]) if row[:category] == RACES[:native_american]
      result[:two_or_more] = format(row[:data]) if row[:category] == RACES[:two_or_more]
      result[:white] = format(row[:data]) if row[:category] == RACES[:white]
    end
    result
  end

  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = @parser.parse_dropout_rates(@name)
    race_by_year = dropout_rates.select { |row| row if row[:category] == RACES[race]}
    race_by_year.empty? ? return : result = {}
    race_by_year.each do |row|
      result[row[:timeframe].to_i] = format(row[:data])
    end
    result
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = @parser.parse_dropout_rates(@name)
    # repeated code --> method?
    rate = dropout_rates.select { |row| row if row[:category] == RACES[race] && row[:timeframe].to_i == year }
    rate.empty? ? return : format(rate.first[:data])
  end

  def graduation_rate_by_year
    grad_rates = @parser.parse_grad_rates(@name)
    grad_rates.empty? ? return : result = {}
    grad_rates.each do |row|
      result[row[:timeframe].to_i] = format(row[:data])
    end
    result
  end

  def graduation_rate_in_year(year)
    grad_rates = @parser.parse_grad_rates(@name)
    # repeated code --> method?
    rate = grad_rates.select { |row| row if row[:timeframe].to_i == year }
    rate.empty? ? return : format(rate.first[:data])
  end

  def kindergarten_participation_by_year
    kindergarten = @parser.parse_kindergarten(@name)
    kindergarten.empty? ? return : results = {}
    kindergarten.sort_by! { |row| row[:timeframe] }
                .each { |row| results[row[:timeframe].to_i] = format(row[:data]) }
    results
  end

  def kindergarten_participation_in_year(year)
    kindergarten = @parser.parse_kindergarten(@name)
    # repeated code --> method?
    result = kindergarten.select { |row| row if row[:timeframe].to_i == year }
    result.empty? ? return : format(result.first[:data])
  end

  def online_participation_by_year
    online_enrollment = @parser.parse_online_pupil_enrollment(@name)
    online_enrollment.empty? ? return : results = {}
    online_enrollment.sort_by! { |row| row[:timeframe] }
                     .each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
    results
  end

  def online_participation_in_year(year)
    online_enrollment = @parser.parse_online_pupil_enrollment(@name)
    # repeated code --> method?
    enrollment_in_year = online_enrollment.select { |row| row if row[:timeframe].to_i == year }
    enrollment_in_year.empty? ? return : enrollment_in_year.first[:data].to_i
  end

  def participation_by_year
    pupil_enrollment = @parser.parse_pupil_enrollment(@name)
    pupil_enrollment.empty? ? return : results = {}
    pupil_enrollment.sort_by! { |row| row[:timeframe] }
                    .each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
    results
  end

  def participation_in_year(year)
    pupil_enrollment = @parser.parse_pupil_enrollment(@name)
    # repeated code --> method?
    enrollment_in_year = pupil_enrollment.select { |row| row if row[:timeframe].to_i == year }
    enrollment_in_year.empty? ? return : enrollment_in_year.first[:data].to_i
  end

  def participation_by_race_or_ethnicity(race)
    # RACES constant doesn't include 'American Indian Students'
    # :race key vs. :category key
    raise UnknownRaceError unless RACES[race]
    enrollment_by_race = @parser.parse_enrollment_by_race(@name)
    enrollment_by_race.select! { |row| row if (row[:race] == RACES[race] || row[:race] == "american indian students") }
    enrollment_by_race.empty? ? return : results = {}
    enrollment_by_race.each { |row| results[row[:timeframe].to_i] = format(row[:data]) if row[:dataformat] == 'percent' }
    results
  end

  def participation_by_race_or_ethnicity_in_year(year)
    participation = @parser.parse_enrollment_by_race(@name)
    by_race_in_year = participation.select do |row|
      row if (row[:timeframe].to_i == year && (row[:dataformat] == 'percent'))
    end
    by_race_in_year.empty? ? return : result = {}
    by_race_in_year.each do |row|
      result[:asian] = format(row[:data]) if row[:race] == RACES[:asian]
      result[:black] = format(row[:data]) if row[:race] == RACES[:black]
      result[:pacific_islander] = format(row[:data]) if row[:race] == RACES[:pacific_islander]
      result[:hispanic] = format(row[:data]) if row[:race] == RACES[:hispanic]
      result[:native_american] = format(row[:data]) if row[:race] == "american indian students"
      result[:two_or_more] = format(row[:data]) if row[:race] == RACES[:two_or_more]
      result[:white] = format(row[:data]) if row[:race] == RACES[:white]
    end
    result
  end

  def special_education_by_year
    special_ed = @parser.parse_special_ed(@name)
    special_by_year = special_ed.select do |row|
      row if (row[:dataformat] == 'percent')
    end
    special_by_year.empty? ? return : result = {}
    special_by_year.each do |row|
      result[row[:timeframe].to_i] = format(row[:data])
    end
    result
  end

  def special_education_in_year(year)
    special_ed = @parser.parse_special_ed(@name)
    result = special_ed.select do |row|
      row if (row[:timeframe].to_i == year) && (row[:dataformat] == 'percent')
    end
    result.empty? ? return : format(result.first[:data])
  end

  def remediation_by_year
    remediation = @parser.parse_remediation(@name)
    rem = remediation.select { |row| row if row[:dataformat] == 'percent' }
    rem.empty? ? return : result = {}
    rem.each do |row|
      result[row[:timeframe].to_i] = format(row[:data])
    end
    result
  end

  def remediation_in_year(year)
    remediation = @parser.parse_remediation(@name)
    result = remediation.select do |row|
      row if (row[:timeframe].to_i == year) && (row[:dataformat] == 'percent')
    end
    result.empty? ? return : format(result.first[:data])
  end

end
