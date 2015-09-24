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

  # def test_top_statewide_testing_year_over_year_growth_can_return_mulitple_leaders
  # def test_top_statewide_testing_year_over_year_growth_can_return_growth_across_all_subjects

  def test_kindergarten_participation_rate_variation_against_state
    assert_equal 0.766, @ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'state')
    assert_equal 1.0, @ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'ACADEMY 20')
    assert_equal 0.406, @ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'ASPEN 1')
    assert_raises(UnknownDataError) { @ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'NEW YORK') }
  end


  def test_kindergarten_participation_against_household_income
    assert_equal 0.501, @ha.kindergarten_participation_against_household_income('ACADEMY 20')
    # 0.001 difference, truncation/rounding?
    assert_equal 1.632, @ha.kindergarten_participation_against_household_income('ASPEN 1')
    assert_equal 1.282, @ha.kindergarten_participation_against_household_income('DEL NORTE C-7')
  end

  def test_kindergarten_participation_correlates_with_household_income
    assert_equal true, @ha.kindergarten_participation_correlates_with_household_income(for: 'DEL NORTE C-7')
    assert_equal false, @ha.kindergarten_participation_correlates_with_household_income(for: 'AGUILAR REORGANIZED 6')
    assert_equal false, @ha.kindergarten_participation_correlates_with_household_income(for: 'state')
  end

  def test_kindergarten_participation_against_high_school_graduation_for_one_district
    # 0.001 difference, truncation/rounding?
    assert_equal 0.640, @ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    # 0.021 differnce, truncation/rounding?
    assert_equal 0.243, @ha.kindergarten_participation_against_high_school_graduation('CHERRY CREEK 5')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation('CHERRY CREEK 5')
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation('ARICKAREE R-2')
    assert_equal false, @ha.kindergarten_participation_correlates_with_high_school_graduation('state')
  end
end
