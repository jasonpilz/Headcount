require_relative '../lib/statewide_testing'
require_relative '../lib/test_files'

class StatewideTestingTest < Minitest::Test

  def setup
    StatewideTestingParser.file_type = TestFiles # sets Parser to use fixtures for the tests
    @statewide1 = StatewideTesting.new('ACADEMY 20')
    @statewide2 = StatewideTesting.new('Colorado')
  end

  def test_it_takes_district_name_by_default
    assert_equal 'ACADEMY 20', @statewide1.name
  end

  def test_proficient_by_grade_returns_a_hash_with_years_pointing_to_hashes_of_subjects
    skip
  end

  def test_proficient_by_grade_returns_UnknownDataError_for_unknown_grade
    skip
  end

  def test_proficient_by_grade_returns_percentage_values_as_three_digit_floats
    skip
  end

  def test_proficient_by_race_or_ethnicity_returns_hash_with_years_pointing_to_hashes_of_subjects
    skip
  end

  def test_proficient_by_race_or_ethnicity_returns_UnknownDataError_for_unknown_race
    skip
  end

  def test_proficient_by_race_or_ethnicity_returns_percentage_values_as_three_digit_floats
    skip
  end

  def test_proficient_for_subject_by_grade_in_year_returns_correct_value
    skip
  end

  def test_proficient_for_subject_by_grade_in_year_returns_UnknownDataError_for_invalid_parameter
    skip
  end

  def test_proficient_for_subject_by_grade_in_year_returns_percentage_value_as_three_digit_float
    skip
  end

  def test_proficient_for_subject_by_race_in_year_returns_correct_value
    skip
  end

  def test_proficient_for_subject_by_race_in_year_returns_UnknownDataError_for_invalid_parameter
    skip
  end

  def test_proficient_for_subject_by_race_in_year_returns_percentage_value_as_three_digit_float
    skip
  end

  def test_proficient_for_subject_in_year_returns_correct_value
    skip
  end

  def test_proficient_for_subject_in_year_returns_UnknownDataError_for_invalid_parameter
    skip
  end

  def test_proficient_for_subject_in_year_returns_percentage_value_as_three_digit_float
    skip
  end

end
