require 'csv'
require 'pry'
require_relative 'input_files'

class EconomicProfileParser
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
    results.each { |row| row.each_pair { |k,v| v.downcase! } }
    results
  end

  def self.parse_median_income(name)
    parse(name, @file_type::MEDIAN_INCOME)
  end

  def self.parse_children_in_poverty(name)
    parse(name, @file_type::CHILDREN_IN_POVERTY)
  end

  def self.parse_reduced_lunch(name)
    parse(name, @file_type::REDUCED_LUNCH)
  end

  def self.parse_title_1(name)
    parse(name, @file_type::TITLE_1)
  end
end
