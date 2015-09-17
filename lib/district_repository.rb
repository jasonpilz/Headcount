require_relative './district'
require 'csv'

class DistrictRepository
  def initialize(results)
    @results = results
  end

  def self.from_csv(data_dir)
    data_dir = File.expand_path '../data', __dir__
    filenames = Dir.glob("#{data_dir}/*")
    # filenames = ["/Users/patwey/code/headcount/data/Pupil enrollment.csv"]
      # results stores hashes of each file's data in an array? ... 'the MOTHER HASH'
    filename = "/Users/patwey/code/headcount/data/Pupil enrollment.csv"
    results = CSV.read(filename, headers: true, header_converters: :symbol).map { |row| row.to_h }
    DistrictRepository.new(results)
  end

  def find_by_name(name)
    # returns either nil, or an instance of District having done a case insensitive search
    districts = @results.group_by { |x| x[:location] }
    District.new(name, districts[name]) # Pass in the 'slice' of data that represents just the district
  end

  def find_all_matching(name_fragment)
    # returns either [] or one or more matches which contain the supplied
    # name fragment, case insensitive
  end
end
