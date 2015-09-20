require 'csv'
require 'pry'
require_relative './smart_input_files'

class SmartEnrollmentLoader
  # initialized with a SIF instance referencing ../data
  # data_dir can be specified by calling the self.input_files method
  #   and passing in a dir_name
  # load methods load each file in array passed in by SIF based on
  #   file type

  @input_files = SmartInputFiles.new

  def self.input_files=(dir_name)
    @input_files = SmartInputFiles.new(dir_name)
  end

  def self.load_csv(name, file)
    # returns an array of hashes of each line of
    #   file with headers as keys. 
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
    data.flatten
  end

  def self.load_grad_rates(name)
    data = []
    @input_files.grad_rates.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_kindergarten(name)
    data = []
    @input_files.kindergarten.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_enrollment_by_race(name)
    data = []
    @input_files.pupil_enroll_by_race.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_special_ed(name)
    data = []
    @input_files.special_ed.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_online_enrollment(name)
    data = []
    @input_files.online_pupil_enroll.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_enrollment(name)
    data = []
    @input_files.pupil_enroll.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_remediation(name)
    data = []
    @input_files.remediation.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end
end


if $0 == __FILE__ # if file is run (testing purposes)
  dropout_rates = SmartEnrollmentLoader.load_dropout_rates('ACADEMY 20')
  grad_rates = SmartEnrollmentLoader.load_grad_rates('ACADEMY 20')
  kindergarten = SmartEnrollmentLoader.load_kindergarten('ACADEMY 20')
  enroll_by_race = SmartEnrollmentLoader.load_enrollment_by_race('ACADEMY 20')
  special_ed = SmartEnrollmentLoader.load_special_ed('ACADEMY 20')
  online_enroll = SmartEnrollmentLoader.load_online_enrollment('ACADEMY 20')
  enrollment = SmartEnrollmentLoader.load_enrollment('ACADEMY 20')
  remediation = SmartEnrollmentLoader.load_remediation('ACADEMY 20')
end
