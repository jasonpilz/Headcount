require_relative 'headcount'
require 'pry'

class UnknownDataError < StandardError
end

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

  def kindergarten_participation_rate_variation(name, compare_against)
    if compare_against[:against] == 'state'
      compared_name = 'COLORADO'
    else
      compared_name = compare_against[:against]
    end
    district1 = @repo.find_by_name(name)
    district2 = @repo.find_by_name(compared_name)
    districts = [district1, district2]
    both_rates = []
    districts.each do |dist|
      raise UnknownDataError unless dist
      total = 0.0
      participation = dist.enrollment.kindergarten_participation_by_year
      unless participation.empty? || participation.keys.count < 2
        participation.each_value do |v|
          total += v
        end
        rate = total / participation.values.count
        both_rates << rate
      end
    end
    truncate(both_rates[0] / both_rates[1])
  end

  def kindergarten_participation_against_household_income(name)
    district = @repo.find_by_name(name)
    state = @repo.find_by_name('colorado')

    avg_income = district.economic_profile.average_median_income
    avg_participation = district.enrollment.average_kindergarten_participation
    avg_state_income = state.economic_profile.average_median_income
    avg_state_participation = state.enrollment.average_kindergarten_participation
    if avg_income && avg_participation && avg_state_income && avg_state_participation
       district_ratio = avg_income / avg_participation
       state_ratio = avg_state_income / avg_state_participation

       truncate(state_ratio / district_ratio)
    end
  end

  def kindergarten_participation_correlates_with_household_income(compare_for)
    if compare_for[:for] == 'state'
      count = 0
      @repo.districts.each_key do |name|
        correlation = kindergarten_participation_against_household_income(name)
        (0.6..1.5).include?(correlation) ? count += 1 : next
      end
      percent = count / @repo.districts.count
      return percent > 0.70
    else
      district = @repo.find_by_name(compare_for[:for])
      correlation = kindergarten_participation_against_household_income(district.name)
      return (0.6..1.5).include?(correlation)
    end
  end

  def kindergarten_participation_against_high_school_graduation(name)
    district = @repo.find_by_name(name)
    state = @repo.find_by_name('colorado')

    avg_graduation = district.enrollment.average_graduation
    avg_participation = district.enrollment.average_kindergarten_participation
    avg_state_graduation = state.enrollment.average_graduation
    avg_state_participation = state.enrollment.average_kindergarten_participation

    if avg_graduation && avg_participation && avg_state_graduation && avg_state_participation
       district_ratio = avg_graduation / avg_participation
       state_ratio = avg_state_graduation / avg_state_participation

       truncate(state_ratio / district_ratio)
    end
  end

  def kindergarten_participation_correlates_with_high_school_graduation(name)
    if name == 'state'
      count = 0
      @repo.districts.each_key do |name|
        correlation = kindergarten_participation_against_high_school_graduation(name)
        (0.6..1.5).include?(correlation) ? count += 1 : next
      end
      percent = count / @repo.districts.count
      return percent > 0.70
    else
      district = @repo.find_by_name(name)
      correlation = kindergarten_participation_against_high_school_graduation(district.name)
      return (0.6..1.5).include?(correlation)
    end
  end
end
