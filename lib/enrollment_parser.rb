require 'csv'  # => true
require 'pry'
require_relative './input_files'

class EnrollmentParser
  def self.parse(name, file)
    results = []
    rows = CSV.read(file, headers: true, header_converters: :symbol)
    rows.each do |row|
      results << row.to_h if row[:location] == name
    end
    results
  end

  def self.parse_dropout_rates(name)
    parse(name, InputFiles::DROPOUT_RATES)
  end

  def self.parse_grad_rates(name)
    parse(name, InputFiles::GRAD_RATES)
  end

  def self.parse_kindergarten(name)
    parse(name, InputFiles::KINDERGARTEN)
  end
end
