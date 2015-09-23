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

  def truncate(value)
    value[0..4].to_f
  end

  def dropout_rate_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)
    row = dropout_rates.select { |row| row if row[:timeframe].to_i == year &&
                                              row[:category] == "all students" }
    truncate(row[0][:data]) unless row.empty?
  end

  def dropout_rate_by_gender_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)
    rows = dropout_rates.select { |row| row if row[:timeframe].to_i == year &&
                                              (row[:category] == "male students" ||
                                               row[:category] == "female students") }
    result = {}
    rows.each do |row|
      result[:male] = row[:data].to_f if row[:category] == "male students"
      result[:female] = row[:data].to_f if row[:category] == "female students"
    end
    return result unless result == {}
  end

  def dropout_rate_by_race_in_year(year)
    dropout_rates = @parser.parse_dropout_rates(@name)
    by_race_in_year = dropout_rates.select { |row| row if row[:timeframe].to_i == year }
    by_race_in_year.empty? ? return : set_race_data(by_race_in_year, :category)
  end

  def set_race_data(rows, race_sym, result = {})
    rows.each do |row|
      result[:asian] = truncate(row[:data]) if row[race_sym] == RACES[:asian]
      result[:black] = truncate(row[:data]) if row[race_sym] == RACES[:black]
      result[:pacific_islander] = truncate(row[:data]) if row[race_sym] == RACES[:pacific_islander]
      result[:hispanic] = truncate(row[:data]) if row[race_sym] == RACES[:hispanic]
      result[:native_american] = truncate(row[:data]) if row[race_sym] == RACES[:native_american] ||
                                                         row[race_sym] == 'american indian students'
      result[:two_or_more] = truncate(row[:data]) if row[race_sym] == RACES[:two_or_more]
      result[:white] = truncate(row[:data]) if row[race_sym] == RACES[:white]
    end
    result
  end

  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = @parser.parse_dropout_rates(@name)
    race_by_year = dropout_rates.select { |row| row if row[:category] == RACES[race]}
    race_by_year.empty? ? return : result = {}
    race_by_year.each do |row|
      result[row[:timeframe].to_i] = truncate(row[:data])
    end
    result
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    raise UnknownRaceError unless RACES[race]
    dropout_rates = @parser.parse_dropout_rates(@name)
    rate = dropout_rates.select { |row| row if row[:category] == RACES[race] &&
                                               row[:timeframe].to_i == year }
    rate.empty? ? return : truncate(rate[0][:data])
  end

  def graduation_rate_by_year
    grad_rates = @parser.parse_grad_rates(@name)
    grad_rates.empty? ? return : result = {}
    grad_rates.each do |row|
      result[row[:timeframe].to_i] = truncate(row[:data])
    end
    result
  end

  def graduation_rate_in_year(year)
    grad_rates = @parser.parse_grad_rates(@name)
    rate = grad_rates.select { |row| row if row[:timeframe].to_i == year }
    rate.empty? ? return : truncate(rate[0][:data])
  end

  def kindergarten_participation_by_year
    kindergarten = @parser.parse_kindergarten(@name)
    kindergarten.empty? ? return : results = {}
    kindergarten.sort_by { |row| row[:timeframe] }
                .each { |row| results[row[:timeframe].to_i] = truncate(row[:data]) }
    results
  end

  def kindergarten_participation_in_year(year)
    kindergarten = @parser.parse_kindergarten(@name)
    result = kindergarten.select { |row| row if row[:timeframe].to_i == year }
    result.empty? ? return : truncate(result[0][:data])
  end

  def online_participation_by_year
    online_enrollment = @parser.parse_online_pupil_enrollment(@name)
    online_enrollment.empty? ? return : results = {}
    online_enrollment.sort_by { |row| row[:timeframe] }
                     .each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
    results
  end

  def online_participation_in_year(year)
    online_enrollment = @parser.parse_online_pupil_enrollment(@name)
    enrollment_in_year = online_enrollment.select { |row| row if row[:timeframe].to_i == year }
    enrollment_in_year.empty? ? return : enrollment_in_year[0][:data].to_i
  end

  def participation_by_year
    pupil_enrollment = @parser.parse_pupil_enrollment(@name)
    pupil_enrollment.empty? ? return : results = {}
    pupil_enrollment.sort_by { |row| row[:timeframe] }
                    .each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
    results
  end

  def participation_in_year(year)
    pupil_enrollment = @parser.parse_pupil_enrollment(@name)
    enrollment_in_year = pupil_enrollment.select { |row| row if row[:timeframe].to_i == year }
    enrollment_in_year.empty? ? return : enrollment_in_year[0][:data].to_i
  end

  def participation_by_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES[race]
    enrollment_by_race = @parser.parse_enrollment_by_race(@name)
    enrollment_by_race.select! { |row| row if (row[:race] == RACES[race] ||
                                               row[:race] == "american indian students") }
    enrollment_by_race.empty? ? return : results = {}
    enrollment_by_race.each do |row|
      results[row[:timeframe].to_i] = truncate(row[:data]) if row[:dataformat] == 'percent' }
    end
    results
  end

  def participation_by_race_or_ethnicity_in_year(year)
    participation = @parser.parse_enrollment_by_race(@name)
    by_race_in_year = participation.select do |row|
      row if (row[:timeframe].to_i == year &&
             (row[:dataformat] == 'percent'))
    end
    by_race_in_year.empty? ? return : set_race_data(by_race_in_year, :race)
  end

  def special_education_by_year
    special_ed = @parser.parse_special_ed(@name)
    special_by_year = special_ed.select do |row|
      row if (row[:dataformat] == 'percent')
    end
    special_by_year.empty? ? return : result = {}
    special_by_year.each do |row|
      result[row[:timeframe].to_i] = truncate(row[:data])
    end
    result
  end

  def special_education_in_year(year)
    special_ed = @parser.parse_special_ed(@name)
    result = special_ed.select do |row|
      row if (row[:timeframe].to_i == year) &&
             (row[:dataformat] == 'percent')
    end
    result.empty? ? return : truncate(result[0][:data])
  end

  def remediation_by_year
    remediation = @parser.parse_remediation(@name)
    rem = remediation.select { |row| row if row[:dataformat] == 'percent' }
    rem.empty? ? return : result = {}
    rem.each do |row|
      result[row[:timeframe].to_i] = truncate(row[:data])
    end
    result
  end

  def remediation_in_year(year)
    remediation = @parser.parse_remediation(@name)
    result = remediation.select do |row|
      row if (row[:timeframe].to_i == year) &&
             (row[:dataformat] == 'percent')
    end
    result.empty? ? return : truncate(result[0][:data])
  end

end
