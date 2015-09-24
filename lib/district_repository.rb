require_relative 'district'
require 'csv'
require 'csv_parser'

class DistrictRepository
  attr_reader :districts

  def initialize(districts)
    @districts = districts
  end

  def self.from_csv(data_dir)
    filename = Dir.glob("#{data_dir}/*").first
    districts = {}
    CSV.foreach(filename) do |row|
      unless row[0].downcase == 'location'
        districts[row[0].upcase] ||= District.new(row[0], CSVParser.new(data_dir))
      end
    end
    DistrictRepository.new(districts)
  end

  def self.from_json(data_dir)
    # TODO
  end

  def find_by_name(name)
    @districts[name.upcase]
  end

  def find_all_matching(fragment, matches = [])
    @districts.each_pair { |k, v| matches << v if k.include?(fragment.upcase) }
    matches
  end
end
