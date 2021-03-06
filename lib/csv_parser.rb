require 'csv'
require_relative 'input_files'
require_relative 'test_files'

class CSVParser
  attr_accessor :test_file_type, :data_dir

  BAD_VALUES = ['#value!', 'n/a', 'lne']

  def initialize(data_dir, test_file_type = InputFiles)
    @test_file_type = test_file_type
    @data_dir = data_dir
  end

  def parse(name, file)
    rows = get_csv_rows(file)
    results = validate_rows(rows, name)
    downcase(results)
  end

  def get_csv_rows(file)
    file = File.join(data_dir, file)
    CSV.read(file, headers: true, header_converters: :symbol)
  end

  def validate_rows(rows, name, validated = [])
    rows.each do |row|
      if row[:location] == name && row[:data]
        validated << row.to_h unless BAD_VALUES.include?(row[:data].downcase)
      end
    end
    validated
  end

  def parse_dropout_rates(name)
    parse(name, @test_file_type::DROPOUT_RATES)
  end

  def downcase(results)
    results.each { |row| row.each_value(&:downcase!) }
  end

  def parse_grad_rates(name)
    parse(name, @test_file_type::GRAD_RATES)
  end

  def parse_kindergarten(name)
    parse(name, @test_file_type::KINDERGARTEN)
  end

  def parse_enrollment_by_race(name)
    parse(name, @test_file_type::PUPIL_ENROLL_BY_RACE)
  end

  def parse_special_ed(name)
    parse(name, @test_file_type::SPECIAL_ED)
  end

  def parse_online_pupil_enrollment(name)
    parse(name, @test_file_type::ONLINE_PUPIL_ENROLL)
  end

  def parse_pupil_enrollment(name)
    parse(name, @test_file_type::PUPIL_ENROLL)
  end

  def parse_remediation(name)
    parse(name, @test_file_type::REMEDIATION)
  end

  def parse_third_grade(name)
    parse(name, @test_file_type::THIRD_GRADE_TESTING)
  end

  def parse_eighth_grade(name)
    parse(name, @test_file_type::EIGHTH_GRADE_TESTING)
  end

  def parse_math(name)
    parse(name, @test_file_type::MATH_PROFICIENCY_BY_RACE)
  end

  def parse_reading(name)
    parse(name, @test_file_type::READING_PROFICIENCY_BY_RACE)
  end

  def parse_writing(name)
    parse(name, @test_file_type::WRITING_PROFICIENCY_BY_RACE)
  end

  def parse_median_income(name)
    parse(name, @test_file_type::MEDIAN_INCOME)
  end

  def parse_children_in_poverty(name)
    parse(name, @test_file_type::CHILDREN_IN_POVERTY)
  end

  def parse_reduced_lunch(name)
    parse(name, @test_file_type::REDUCED_LUNCH)
  end

  def parse_title_1(name)
    parse(name, @test_file_type::TITLE_1)
  end
end
