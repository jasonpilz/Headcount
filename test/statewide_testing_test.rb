require_relative '../lib/statewide_testing'
require_relative '../lib/csv_parser'

class StatewideTestingTest < Minitest::Test

  def setup
    dir = File.expand_path("fixtures", __dir__)
    csv_parser = CSVParser.new(dir, TestFiles)
    @statewide1 = StatewideTesting.new('ACADEMY 20', csv_parser)
    @statewide2 = StatewideTesting.new('Colorado', csv_parser)
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
    assert_equal 0.514, @statewide2.proficient_for_subject_by_grade_in_year(:math, 8, 2013)
    assert_equal 0.523, @statewide2.proficient_for_subject_by_grade_in_year(:math, 8, 2014)
  end

  def test_proficient_for_subject_by_race_in_year_returns_correct_value
    assert_equal 0.694, @statewide1.proficient_for_subject_by_race_in_year(:reading, :black, 2012)
  end

  def test_proficient_for_subject_by_race_in_year_returns_UnknownDataError_for_invalid_parameter
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_by_race_in_year(:reading, :beiber, 2011)
    end
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_by_race_in_year(:phy_ed, :hispanic, 2011)
    end
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_by_race_in_year(:writing, :white, 2020)
    end
  end

  def test_proficient_for_subject_by_race_in_year_returns_percentage_value_as_three_digit_float
    assert_equal 0.486, @statewide2.proficient_for_subject_by_race_in_year(:reading, :black, 2011)
    assert_equal 0.740, @statewide1.proficient_for_subject_by_race_in_year(:writing, :white, 2013)
  end

  def test_proficient_for_subject_in_year_returns_correct_value
    assert_equal 0.689, @statewide1.proficient_for_subject_in_year(:math, 2012)
  end

  def test_proficient_for_subject_in_year_returns_UnknownDataError_for_invalid_parameter
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_in_year(:reading, 'fourty')
    end
    assert_raises UnknownDataError do
      @statewide2.proficient_for_subject_in_year(:phy_ed, 2011)
    end
  end

  def test_proficient_for_subject_in_year_returns_percentage_value_as_three_digit_float
    assert_equal 0.680, @statewide2.proficient_for_subject_in_year(:reading, 2011)
    assert_equal 0.720, @statewide1.proficient_for_subject_in_year(:writing, 2013)
  end

  def test_it_omits_LNE_Excel_bullshit_0s_and_missing_data
    dir = File.expand_path("../data", __dir__)
    csv_parser = CSVParser.new(dir)
    woodlin = StatewideTesting.new('WOODLIN R-104', csv_parser)
    expected_result = {}
    assert_equal expected_result, woodlin.proficient_by_grade(3)

    east_yuma = StatewideTesting.new('EAST YUMA COUNTY RJ-2', csv_parser)
    expected_result  = {2008=>{:writing=>0.341}, 2009=>{:writing=>0.402}}
    assert_equal expected_result, east_yuma.proficient_by_grade(3)

    west_yuma = StatewideTesting.new('WEST YUMA COUNTY RJ-1', csv_parser)
    expected_result = {2008=>{:math=>0.512}, 2009=>{:math=>0.458}}
    assert_equal expected_result, west_yuma.proficient_by_grade(3)
  end

end
