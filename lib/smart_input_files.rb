class SmartInputFiles
  # can be initialized with a dir name
  # file groups are called as methods on the instance
  # e.g. sif = SmartInputFiles.new('../fake_dir')
  #      sif.dropout_rates == InputFiles::DROPOUT_RATES
  
  attr_reader :filenames

  def initialize(dir_name = '../data')
    @data_dir = File.expand_path dir_name, __dir__
    @filenames = Dir.glob("#{@data_dir}/*")
  end

  def get_formatted_filename(filepath)
    filepath.split('/').last.split('.').first.downcase
  end

  def dropout_rates
    dropout_rates = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      dropout_rates << filename if name.include?('dropout' || 'drop')
    end
    dropout_rates.uniq
  end

  def grad_rates
    grad_rates = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      grad_rates << filename if name.include?('graduation' || 'grad')
    end
    grad_rates.uniq
  end

  def kindergarten
    kindergarten = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      kindergarten << filename if name.include?('kindergartners' || 'kindergarten')
    end
    kindergarten.uniq
  end

  def online_pupil_enroll
    online_pupil_enroll = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      online_pupil_enroll << filename if name.include?('online') &&
                                     name.include?('enrollment' || 'enroll')
    end
    online_pupil_enroll.uniq
  end

  def pupil_enroll_by_race
    pupil_enroll_by_race = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      pupil_enroll_by_race << filename if name.include?('race' || 'ethnicity') &&
                                      name.include?('enrollment' || 'enroll')
    end
    pupil_enroll_by_race.uniq
  end

  def pupil_enroll
    pupil_enroll = []
    @filenames.each do |filename|
    name = get_formatted_filename(filename)
    pupil_enroll << filename if name.include?('enrollment' || 'enroll') &&
                            !name.include?('online') &&
                            !name.include?('race') &&
                            !name.include?('ethnicity')
    end
    pupil_enroll.uniq
  end

  def special_ed
    special_ed = []
    @filenames.each do |filename|
    name = get_formatted_filename(filename)
    special_ed << filename if name.include?('special' || 'special-education' ||
                                      'special-ed')
    end
    special_ed.uniq
  end

  def remediation
    remediation = []
    @filenames.each do |filename|
      name = get_formatted_filename(filename)
      remediation << filename if name.include?('remediation' || 'remed')
    end
    remediation.uniq
  end
end
