require_relative 'headcount'
require 'pry'

class HeadcountAnalyst

  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def truncate(float)
    float.to_s[0..4].to_f
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(subject)
    growth_rates = []
    @repo.districts.each_pair do |name, object|
      all_subjects = object.statewide_testing.proficient_by_grade(3)
      district_data = {}
      all_subjects.each_pair do |year, subjects|
        district_data[year] = subjects[:math] unless subjects[:math].nil?
      end
      unless district_data.empty? || district_data.keys.count < 2
        max_year = district_data.keys.max
        min_year = district_data.keys.min
        growth_rate = (district_data[max_year] - district_data[min_year]) / (max_year - min_year)
        growth_rate = truncate(growth_rate)
        growth_rates << [name, growth_rate]
      end
    end
    growth_rates.max_by { |arr| arr[1] }
  end

end
