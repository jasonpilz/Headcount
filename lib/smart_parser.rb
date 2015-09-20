require 'csv'
require 'pry'
require_relative './smart_input_files'

class SmartEnrollmentLoader
  @input_files = SmartInputFiles.new

  def self.file_type=(dir_name)
    @input_files = SmartInputFiles.new(dir_name)
  end

  def self.load_csv(name, file)
    results = []
    rows = CSV.read(file, headers: true, header_converters: :symbol)
    rows.each do |row|
      results << row.to_h if row[:location] == name
    end
    results
  end

  def self.load_dropout_rates(name)
    data = []
    @input_files.dropout_rates.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data
  end
end

SmartEnrollmentLoader.load_dropout_rates('ACADEMY 20')

__END__
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
