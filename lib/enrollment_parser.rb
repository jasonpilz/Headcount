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

  def self.parse_enrollment_by_race(name)
    parse(name, InputFiles::PUPIL_ENROLL_BY_RACE)
  end

  def self.parse_special_ed(name)
    parse(name, InputFiles::SPECIAL_ED)
  end

  def self.parse_online_pupil_enrollment(name)
    parse(name, InputFiles::ONLINE_PUPIL_ENROLL)
  end

  def self.parse_pupil_enrollment(name)
    parse(name, InputFiles::PUPIL_ENROLL)
  end
end
