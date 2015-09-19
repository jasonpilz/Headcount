require 'csv'
require 'pry'
require_relative './input_files'

class StatewideTestingParser
  @file_type = InputFiles

  def self.file_type=(type)
    @file_type = type
  end

  def self.parse(name, file)
    results = []
    rows = CSV.read(file, headers: true, header_converters: :symbol)
    rows.each do |row|
      results << row.to_h if row[:location] == name
    end
    # iterate through results and downcase :category/race

    # results.each do |row|
    #   row.each_pair do |k,v|
    #     v.downcase!
    #   end
    # end

    results
  end

  def self.parse_third_grade(name)
    parse(name, @file_type::THIRD_GRADE_TESTING)
  end

  def self.parse_eighth_grade(name)
    parse(name, @file_type::EIGHTH_GRADE_TESTING)
  end

  def self.parse_math(name)
    parse(name, @file_type::MATH_PROFICIENCY_BY_RACE)
  end

  def self.parse_reading(name)
    parse(name, @file_type::READING_PROFICIENCY_BY_RACE)
  end

  def self.parse_writing(name)
    parse(name, @file_type::WRITING_PROFICIENCY_BY_RACE)
  end
end
