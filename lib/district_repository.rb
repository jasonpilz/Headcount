require_relative 'district'
require 'csv'

class DistrictRepository
  attr_reader :districts

  def initialize(data_dir)
    @districts = get_districts(data_dir)
  end

  def get_districts(data_dir)
    filename = Dir.glob("#{data_dir}/*").first
    districts = {}
    CSV.foreach(filename) do |row|
      next if row[0].upcase == 'location'.upcase
      districts[row[0].upcase] = District.new(row[0])
    end
    districts
  end

  def self.from_csv(data_dir)
    DistrictRepository.new(data_dir)
  end

  def find_by_name(name)
    return unless @districts[name.upcase]
    @districts[name.upcase]
  end

  def find_all_matching(name_fragment)
    matches = []
    @districts.each_pair do |k, v|
      matches << v if k.include?(name_fragment.upcase)
    end
    matches
  end

end

dr = DistrictRepository.new(File.expand_path '../data', __dir__)
