require 'csv'
require_relative 'input_files'

class StatewideTestingLoader
  # initialized with a SIF instance referencing ../data
  # data_dir can be specified by calling the self.input_files method
  #   and passing in a dir_name
  # load methods load each file in array passed in by SIF based on
  #   file type

  @input_files = InputFiles.new('../data')

  def self.file_dir=(dir_name)
    @input_files = InputFiles.new(dir_name)
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

  def self.load_json(name, file)
    # MAKE THIS WORK!
    [{ json: 'json data' }]
  end

  def self.load_third_grade(name)
    data = []
    @input_files.third_grade_testing.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_eighth_grade(name)
    data = []
    @input_files.eighth_grade_testing.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_math(name)
    data = []
    @input_files.math_proficiency_by_race.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_reading(name)
    data = []
    @input_files.reading_proficiency_by_race.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end

  def self.load_writing(name)
    data = []
    @input_files.writing_proficiency_by_race.each do |file_info|
      if file_info[1] == 'csv'
        data << load_csv(name, file_info[0])
      elsif file_info[1] == 'json'
        data << load_json(name, file_info[0])
      end
    end
    data.flatten
  end
end
