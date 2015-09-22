require 'pry'
require_relative 'csv_parser'

class EconomicProfile
  attr_reader :name, :parser

  def initialize(name, parser)
    @name = name
    @parser = parser
  end

  def free_or_reduced_lunch_by_year
    lunch_by_year = @parser.parse_reduced_lunch(@name)
    lunch_percent = lunch_by_year.select do |row|
      row if (row[:dataformat] == "percent") && (row[:poverty_level] == "eligible for free or reduced lunch")
    end
    lunch_percent.empty? ? return : result = {}
    lunch_percent.each do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    result
  end

  def free_or_reduced_lunch_in_year(year)
    lunch_by_year = @parser.parse_reduced_lunch(@name)
    lunch_in_year = lunch_by_year.select do |row|
      row if (row[:dataformat] == "percent") && (row[:poverty_level] == "eligible for free or reduced lunch") && (row[:timeframe].to_i == year)
    end
    lunch_in_year.empty? ? return : lunch_in_year.first[:data][0..4].to_f
  end

  def school_aged_children_in_poverty_by_year
    children = @parser.parse_children_in_poverty(@name)
    children_by_year = children.select do |row|
      row if row[:dataformat] == 'percent'
    end
    result = {}
    return result if children_by_year.empty?
    children_by_year.each do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    result
  end

  def school_aged_children_in_poverty_in_year(year)
    children = @parser.parse_children_in_poverty(@name)
    children_by_year = children.select do |row|
      row if row[:dataformat] == 'percent' && row[:timeframe].to_i == year
    end
    children_by_year.empty? ? return : children_by_year.first[:data][0..4].to_f
  end

  def title_1_students_by_year
    title_1 = @parser.parse_title_1(@name)
    result = {}
    students_by_year = title_1.select do |row|
      result[row[:timeframe].to_i] = row[:data][0..4].to_f if row[:dataformat] == 'percent'
    end
    result
  end

  def title_1_students_in_year(year)
    title_1 = @parser.parse_title_1(@name)
    title_1_in_year = title_1.select do |row|
        row if row[:dataformat] == 'percent' && row[:timeframe].to_i == year
    end
    title_1_in_year.empty? ? return : title_1_in_year.first[:data][0..4].to_f
  end

end
