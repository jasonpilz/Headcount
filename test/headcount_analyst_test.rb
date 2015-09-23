require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test

  def setup
    dir = File.expand_path("../data", __dir__)
    repo = DistrictRepository.from_csv(dir)
    @ha = HeadcountAnalyst.new(repo)
  end

  def test_top_statewide_testing_year_over_year_growth_returns_array_of_top_district_name_and_growth
    assert_equal ["WILEY RE-13 JT", 0.300], @ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
  end

end
