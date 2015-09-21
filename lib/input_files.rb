class InputFiles
  # can be initialized with a dir name
  # file groups are called as methods on the instance
  # e.g. sif = SmartInputFiles.new('../fake_dir')
  #      returns a nested array: [[filepath, csv]]
  #                        also: [[file1, csv], [file2, json]]

  # CURRENTLY ONLY WORKS FOR ENROLLMENT RELATED FILES

  attr_reader :filenames

  def initialize(dir_name = '../data')
    @data_dir = File.expand_path dir_name, __dir__
    @filenames = Dir.glob("#{@data_dir}/*")
  end

  def get_formatted_filename(filepath)
    filepath.split('/').last.split('.').first.downcase
  end

  def get_file_type(filepath)
    filepath.split('/').last.split('.').last.downcase
  end

  def dropout_rates
    dropout_rates = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      dropout_rates << [filename, type] if name.include?('dropout') ||
                                           name.include?('drop')
    end
    dropout_rates.uniq
  end

  def grad_rates
    grad_rates = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      grad_rates << [filename, type] if (name.include?('graduation') ||
                                        name.include?('grad')) &&
                                        !name.include?('grade')
    # binding.pry
    end
    grad_rates.uniq
  end

  def kindergarten
    kindergarten = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      kindergarten << [filename, type] if name.include?('kindergartners') ||
                                          name.include?('kindergarten')
    end
    kindergarten.uniq
  end

  def online_pupil_enroll
    online_pupil_enroll = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      online_pupil_enroll << [filename, type] if name.include?('online') &&
                                                 (name.include?('enrollment') ||
                                                 name.include?('enroll'))
    end
    online_pupil_enroll.uniq
  end

  def pupil_enroll_by_race
    pupil_enroll_by_race = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      pupil_enroll_by_race << [filename, type] if (name.include?('race') ||
                                                  name.include?('ethnicity')) &&
                                                  (name.include?('enrollment') ||
                                                  name.include?('enroll'))
    end
    pupil_enroll_by_race.uniq
  end

  def pupil_enroll
    pupil_enroll = []
    @filenames.each do |filename|
    name = get_formatted_filename(filename)
    type = get_file_type(filename)
    pupil_enroll << [filename, type] if (name.include?('enrollment') ||
                                        name.include?('enroll')) &&
                                        (!name.include?('online') &&
                                        !name.include?('race') &&
                                        !name.include?('ethnicity'))
    end
    pupil_enroll.uniq
  end

  def special_ed
    special_ed = []
    @filenames.each do |filename|
    name = get_formatted_filename(filename)
    type = get_file_type(filename)
    special_ed << [filename, type] if name.include?('special') ||
                                      name.include?('special-education') ||
                                      name.include?('special-ed')
    end
    special_ed.uniq
  end

  def remediation
    remediation = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      remediation << [filename, type] if name.include?('remediation') ||
                                         name.include?('remed')
    end
    remediation.uniq
  end

  def third_grade_testing
    third_grade_testing = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      third_grade_testing << [filename, type] if name.include?('3rd') ||
                                                 name.include?('third')
    end
    third_grade_testing.uniq
  end

  def eighth_grade_testing
    eighth_grade_testing = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      eighth_grade_testing << [filename, type] if name.include?('8th') ||
                                                 name.include?('eighth')
    end
    eighth_grade_testing.uniq
  end

  def math_proficiency_by_race
    math_proficiency_by_race = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      math_proficiency_by_race << [filename, type] if name.include?('math')
    end
    math_proficiency_by_race.uniq
  end

  def reading_proficiency_by_race
    reading_proficiency = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      reading_proficiency << [filename, type] if name.include?('reading')
    end
    reading_proficiency.uniq
  end

  def writing_proficiency_by_race
    writing_proficiency = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      type = get_file_type(filename)
      writing_proficiency << [filename, type] if name.include?('writing')
    end
    writing_proficiency.uniq
  end
end
