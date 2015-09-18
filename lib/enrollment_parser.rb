require 'csv'
require 'pry'
require_relative './input_files'

class EnrollmentParser
  
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
    results
  end

  def self.parse_dropout_rates(name)
    parse(name, @file_type::DROPOUT_RATES)
  end

  def self.parse_grad_rates(name)
    parse(name, @file_type::GRAD_RATES)
  end

  def self.parse_kindergarten(name)
    parse(name, @file_type::KINDERGARTEN)
  end

  def self.parse_enrollment_by_race(name)
    parse(name, @file_type::PUPIL_ENROLL_BY_RACE)
  end

  def self.parse_special_ed(name)
    parse(name, @file_type::SPECIAL_ED)
  end

  def self.parse_online_pupil_enrollment(name)
    parse(name, @file_type::ONLINE_PUPIL_ENROLL)
  end

  def self.parse_pupil_enrollment(name)
    parse(name, @file_type::PUPIL_ENROLL)
  end

  def self.parse_remediation(name)
    parse(name, @file_type::REMEDIATION)
  end
end
