require_relative './district'
require 'csv'

class DistrictRepository
  def initialize(results)
    @results = results
  end

  def self.from_csv(data_dir)
    data_dir = File.expand_path '../data', __dir__
    filenames = Dir.glob("#{data_dir}/*")
    filnames.each do |filename|
      # results stores hashes of each file's data in an array? ... 'the MOTHER HASH'
      results << CSV.read(filename, headers: true, header_converters: :symbol).map { |row| row.to_h }
    end
    DistrictRepository.new(results)
  end

  def find_by_name(name)
    District.new(name) # Pass in the 'slice' of data that represents just the district
  end
end
