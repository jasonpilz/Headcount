require 'pry'
require_relative './statewide_testing_parser'

class UnknownDataError < StandardError
end

class StatewideTesting
  attr_reader :name

  RACES = {asian: "Asian",
           black: "Black",
           pacific_islander: "Hawaiian/Pacific Islander",
           hispanic: "Hispanic",
           native_american: "Native American",
           two_or_more: "Two or more",
           white: "White"}

  def initialize(name)
    @name = name
  end

  def proficient_by_grade(grade)
    if grade.to_i == 3
      pro_by_grade = StatewideTestingParser.parse_third_grade(@name)
    elsif grade.to_i == 8
      pro_by_grade = StatewideTestingParser.parse_eighth_grade(@name)
    else
      raise UnknownDataError
    end
    result = {}
    pro_by_grade = pro_by_grade.group_by { |row| row[:timeframe] }
    pro_by_grade.each_pair do |year, arr|
      subjects = {}
      arr.each do |row|
        subjects[row[:score].downcase.to_sym] = row[:data][0..4].to_f
      end
      result[year.to_i] = subjects
    end
    result
  end

  def proficient_by_race_or_ethnicity(race)
    raise UnknownDataError unless RACES[race]
    math = StatewideTestingParser.parse_math(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'Math' }
    reading = StatewideTestingParser.parse_reading(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'Reading' }
    writing = StatewideTestingParser.parse_writing(@name).select { |row| row if row[:race_ethnicity] == RACES[race] }.each { |row| row[:score] = 'Writing' }
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
      pro_by_grade = StatewideTestingParser.parse_third_grade(@name)
    elsif grade.to_i == 8
      pro_by_grade = StatewideTestingParser.parse_eighth_grade(@name)
    else
      raise UnknownDataError
    end


    
  end

end
