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
    expected_result = { 2008 => {math: 0.857, reading: 0.866, writing: 0.671},
                        2009 => {math: 0.824, reading: 0.862, writing: 0.706},
                        2010 => {math: 0.849, reading: 0.864, writing: 0.662},
                        2011 => {math: 0.819, reading: 0.867, writing: 0.678},
                        2012 => {math: 0.830, reading: 0.870, writing: 0.655},
                        2013 => {math: 0.855, reading: 0.859, writing: 0.668},
                        2014 => {math: 0.834, reading: 0.831, writing: 0.639} }
    assert_equal expected_result, @statewide1.proficient_by_grade(3)
  end

  def test_proficient_by_grade_returns_UnknownDataError_for_unknown_grade
    assert_raises UnknownDataError do
      @statewide1.proficient_by_grade(9)
    end
  end

  def test_proficient_by_grade_returns_percentage_values_as_three_digit_floats
    expected_result = { 2008 => {math: 0.469, reading: 0.703, writing: 0.529},
                        2009 => {math: 0.499, reading: 0.726, writing: 0.528},
                        2010 => {math: 0.510, reading: 0.679, writing: 0.549},
                        2011 => {math: 0.513, reading: 0.670, writing: 0.543},
                        2012 => {math: 0.515, reading: 0.671, writing: 0.548},
                        2013 => {math: 0.514, reading: 0.668, writing: 0.557},
                        2014 => {math: 0.523, reading: 0.663, writing: 0.561} }
    assert_equal expected_result, @statewide2.proficient_by_grade(8)
  end

  def test_proficient_by_race_or_ethnicity_returns_hash_with_years_pointing_to_hashes_of_subjects
    expected_result = { 2011 => {math: 0.568, reading: 0.748, writing: 0.606},
                        2012 => {math: 0.572, reading: 0.771, writing: 0.597},
                        2013 => {math: 0.588, reading: 0.772, writing: 0.623},
                        2014 => {math: 0.604, reading: 0.007, writing: 0.624} }
    assert_equal expected_result, @statewide1.proficient_by_race_or_ethnicity(:hispanic)
  end

  def test_proficient_by_race_or_ethnicity_returns_UnknownDataError_for_unknown_race
    assert_raises UnknownDataError do
      @statewide1.proficient_by_race_or_ethnicity(:jason)
    end
  end

  def test_proficient_by_race_or_ethnicity_returns_percentage_values_as_three_digit_floats
    expected_result = { 2011 => {math: 0.541, reading: 0.658, writing: 0.558},
                        2012 => {math: 0.505, reading: 0.642, writing: 0.512},
                        2013 => {math: 0.524, reading: 0.681, writing: 0.518},
                        2014 => {math: 0.518, reading: 0.667, writing: 0.530} }
    assert_equal expected_result, @statewide2.proficient_by_race_or_ethnicity(:pacific_islander)
  end

  def test_proficient_for_subject_by_grade_in_year_returns_correct_value
    assert_equal 0.819, @statewide1.proficient_for_subject_by_grade_in_year(:math, 3, 2011)
  end

  def test_proficient_for_subject_by_grade_in_year_returns_UnknownDataError_for_invalid_parameter
    assert_raises UnknownDataError do
      @statewide1.proficient_for_subject_by_grade_in_year(:science, 3, 2011)
    end
    assert_raises UnknownDataError do
      @statewide1.proficient_for_subject_by_grade_in_year(:math, 4, 2011)
    end
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_by_grade_in_year(:reading, 3, 1999)
    end
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
