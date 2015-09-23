require 'pry'

class UnknownDataError < StandardError
end

class StatewideTesting
  attr_reader :name, :parser

  RACES = {asian: "asian",
           black: "black",
           pacific_islander: "hawaiian/pacific islander",
           hispanic: "hispanic",
           native_american: "native american",
           two_or_more: "two or more",
           white: "white"}

  def initialize(name, parser)
    @name = name
    @parser = parser
  end

  def proficient_by_grade(grade)
    if grade.to_i == 3
      pro_by_grade = @parser.parse_third_grade(@name)
    elsif grade.to_i == 8
      pro_by_grade = @parser.parse_eighth_grade(@name)
    else
      raise UnknownDataError
    end
    result = {}
    pro_by_grade = pro_by_grade.group_by { |row| row[:timeframe] }
    pro_by_grade.each_pair do |year, arr|
      subjects = {}
      arr.each do |row|
        unless row[:data] == "#value!" || row[:data] == "n/a" || row[:data] == "lne"
          subjects[row[:score].downcase.to_sym] = row[:data][0..4].to_f
        end
      end
      result[year.to_i] = subjects unless subjects.empty?
    end
    result
  end

  def proficient_by_race_or_ethnicity(race)
    raise UnknownDataError unless RACES[race]
    math = @parser.parse_math(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'math' }
    reading = @parser.parse_reading(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'reading' }
    writing = @parser.parse_writing(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'writing' }
    pro_by_race = (math + reading + writing).flatten

    result = {}
    pro_by_race = pro_by_race.group_by { |row| row[:timeframe] }
    pro_by_race.each_pair do |year, arr|
      subjects = {}
      arr.each do |row|
        subjects[row[:score].downcase.to_sym] = row[:data][0..4].to_f
      end
      result[year.to_i] = subjects
    end
    result
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if grade.to_i == 3
      pro_by_grade = @parser.parse_third_grade(@name)
    elsif grade.to_i == 8
      pro_by_grade = @parser.parse_eighth_grade(@name)
    else
      raise UnknownDataError
    end
    result = pro_by_grade.select do |row|
      row if (row[:score] == subject.to_s) && (row[:timeframe].to_i == year)
    end
    raise UnknownDataError if result.empty?
    result.first[:data][0..4].to_f
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    case subject
    when :math
      pro_by_subject = @parser.parse_math(@name)
    when :reading
      pro_by_subject = @parser.parse_reading(@name)
    when :writing
      pro_by_subject = @parser.parse_writing(@name)
    else
      raise UnknownDataError
    end
    result = pro_by_subject.select do |row|
      row if (row[:race_ethnicity] == RACES[race]) && (row[:timeframe].to_i == year)
    end
    raise UnknownDataError if result.empty?
    result.first[:data][0..4].to_f
  end

  def proficient_for_subject_in_year(subject, year)
    case subject
    when :math
      pro_by_subject = @parser.parse_math(@name)
    when :reading
      pro_by_subject = @parser.parse_reading(@name)
    when :writing
      pro_by_subject = @parser.parse_writing(@name)
    else
      raise UnknownDataError
    end
    result = pro_by_subject.select do |row|
      row if (row[:race_ethnicity] == 'all students') &&
             (row[:timeframe].to_i == year)
    end
    raise UnknownDataError if result.empty?
    result.first[:data][0..4].to_f
  end
end
