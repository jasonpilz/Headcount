require_relative '../lib/enrollment'
require_relative '../lib/test_files'

class EnrollmentTest < Minitest::Test

  def setup
    EnrollmentParser.file_type = TestFiles # sets Parser to use fixtures for the tests
    @enrollment1 = Enrollment.new('ACADEMY 20')
    @enrollment2 = Enrollment.new('Colorado')
  end

  def test_dropout_rate_with_test_file
    assert_equal 0.002 , @enrollment1.dropout_rate_in_year(2011)
  end

  def test_take_district_name_by_default
    assert_equal 'ACADEMY 20', @enrollment1.name
  end

  def test_returns_dropout_rate_for_all_students_in_given_year
    assert_equal 0.002, @enrollment1.dropout_rate_in_year(2011)
    assert_equal 0.030, @enrollment2.dropout_rate_in_year(2011)
  end

  def test_dropout_rate_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_in_year(1)
  end

  def test_dropout_rate_in_year_returns_three_digit_float
    assert_equal 0.030, @enrollment2.dropout_rate_in_year(2011)
    assert_equal 0.004, @enrollment1.dropout_rate_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_returns_a_hash_with_genders_as_keys_pointing_to_floats
    expected_result = {:female => 0.004, :male => 0.004}
    assert_equal expected_result, @enrollment1.dropout_rate_by_gender_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_by_gender_in_year(2008)
  end

  def test_dropout_rate_by_race_in_year_returns_a_hash_with_race_markers_as_keys
    expected_result = {:asian => 0.007,
                       :black => 0.002,
                       :pacific_islander => 0,
                       :hispanic => 0.006,
                       :native_american => 0.036,
                       :two_or_more => 0,
                       :white => 0.004}
    assert_equal expected_result, @enrollment1.dropout_rate_by_race_in_year(2012)
  end

  def test_dropout_rate_by_race_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_by_race_in_year(1)
  end

  def test_dropout_rate_by_race_in_year_returns_three_digit_float
    expected_result = {:asian => 0.007,
                       :black => 0.002,
                       :pacific_islander => 0.000,
                       :hispanic => 0.006,
                       :native_american => 0.036,
                       :two_or_more => 0.000,
                       :white => 0.004}
    assert_equal expected_result, @enrollment1.dropout_rate_by_race_in_year(2012)
  end

  def test_dropout_rate_for_race_or_ethnicity_raises_UnknownRaceError_for_unknown_race
    assert_raises UnknownRaceError do
      @enrollment1.dropout_rate_for_race_or_ethnicity(:jason)
    end
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_a_hash_with_years_as_keys
      expected_result = { 2011 => 0.000,
                          2012 => 0.007 }
      assert_equal expected_result, @enrollment1.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1983)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_raises_UnknownRaceError_for_unknown_race
    assert_raises UnknownRaceError do
      @enrollment1.dropout_rate_for_race_or_ethnicity_in_year(:pat, 2011)
    end
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_three_digit_float
    assert_equal 0.006, @enrollment1.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 2012)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_correct_rate
    assert_equal 0.044, @enrollment2.dropout_rate_for_race_or_ethnicity_in_year(:black, 2012)
  end

  def test_graduation_rate_by_year_returns_hash_with_years_as_keys
    expected_result = { 2010 => 0.895,
                        2011 => 0.895,
                        2012 => 0.889,
                        2013 => 0.913,
                        2014 => 0.898 }
    assert_equal expected_result, @enrollment1.graduation_rate_by_year
  end

  def test_graduation_rate_by_year_returns_percentage_data_as_three_digit_float
    expected_result = { 2010 => 0.895,
                        2011 => 0.895,
                        2012 => 0.889,
                        2013 => 0.913,
                        2014 => 0.898 }
    assert_equal expected_result, @enrollment1.graduation_rate_by_year
  end

  def test_graduation_rate_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.graduation_rate_in_year(1987)
    assert @enrollment1.graduation_rate_in_year(2011)
  end

  def test_graduation_rate_in_year_returns_percentage_data_as_three_digit_float
    assert_equal 0.889, @enrollment1.graduation_rate_in_year(2012)
    assert_equal 0.739, @enrollment2.graduation_rate_in_year(2011)
  end

  def test_kindergarten_participation_by_year_returns_hash_with_years_as_keys_pointing_to_floats
    expected_result = {2004 => 0.302,
                       2005 => 0.267,
                       2006 => 0.353,
                       2007 => 0.391,
                       2008 => 0.384,
                       2009 => 0.390,
                       2010 => 0.436,
                       2011 => 0.489,
                       2012 => 0.478,
                       2013 => 0.487,
                       2014 => 0.490}
    assert_equal expected_result, @enrollment1.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.kindergarten_participation_in_year(3000)
  end

  def test_kindergarten_participation_in_year_returns_a_percentage
    assert_equal 0.436, @enrollment1.kindergarten_participation_in_year(2010)
  end

  def test_participation_by_race_or_ethnicity_in_year_returns_hash_with_race_as_keys_pointing_to_floats
    expected_result = { :asian => 0.038,
                        :black => 0.031,
                        :pacific_islander => 0.004,
                        :hispanic => 0.121,
                        :native_american => 0.004,
                        :two_or_more => 0.053,
                        :white => 0.75}
    assert_equal expected_result, @enrollment1.participation_by_race_or_ethnicity_in_year(2012)
  end

  def test_participation_by_race_or_ethnicity_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.participation_by_race_or_ethnicity_in_year(2015)
    assert @enrollment1.participation_by_race_or_ethnicity_in_year(2011)
  end

  def test_participation_by_race_or_ethnicity_in_year_returns_three_digit_float_as_percents
    expected_result = { :asian => 0.037,
                        :black => 0.029,
                        :pacific_islander => 0.003,
                        :hispanic => 0.125,
                        :native_american => 0.004,
                        :two_or_more => 0.058,
                        :white => 0.740 }
    assert_equal expected_result, @enrollment1.participation_by_race_or_ethnicity_in_year(2014)
  end

  def test_special_education_by_year_returns_hash_with_years_as_keys_pointing_to_floats
    expected_result = { 2009 => 0.096,
                        2010 => 0.096,
                        2011 => 0.097,
                        2012 => 0.098,
                        2013 => 0.100,
                        2014 => 0.100 }
    assert_equal expected_result, @enrollment2.special_education_by_year
  end

  def test_special_education_by_year_returns_hash_with_percent_as_three_digit_float
    expected_result = { 2009 => 0.075,
                        2010 => 0.078,
                        2011 => 0.079,
                        2012 => 0.078,
                        2013 => 0.079,
                        2014 => 0.079 }
    assert_equal expected_result, @enrollment1.special_education_by_year
  end

  def test_special_education_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.special_education_in_year(1999)
    assert @enrollment1.special_education_in_year(2011)
  end

  def test_special_education_in_year_retuns_percent_for_given_year
    assert_equal 0.097, @enrollment2.special_education_in_year(2011)
  end

  def test_special_education_in_year_returns_percent_as_three_digit_float
    assert_equal 0.100, @enrollment2.special_education_in_year(2013)
  end

  def test_remediation_by_year_returns_hash_with_years_as_keys_pointing_to_percent
    expected_result = { 2009 => 0.264,
                        2010 => 0.294,
                        2011 => 0.263 }
    assert_equal expected_result, @enrollment1.remediation_by_year
  end

  def test_remediation_by_year_returns_hash_with_percents_as_three_point_floats
    expected_result = { 2009 => 0.392,
                        2010 => 0.414,
                        2011 => 0.400 }
    assert_equal expected_result, @enrollment2.remediation_by_year
  end

  def test_remediation_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.remediation_in_year(2008)
    assert @enrollment1.remediation_in_year(2009)
  end

  def test_online_participation_by_year_returns_hash_pointing_to_ints
    expected_result = {2011 => 33,
                       2012 => 35,
                       2013 => 341}
    assert_equal expected_result, @enrollment1.online_participation_by_year
  end

  def test_online_participation_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.online_participation_in_year(4000)
  end

  def test_online_participation_in_year_returns_data_as_an_int
    assert_equal 341, @enrollment1.online_participation_in_year(2013)
  end

  def test_participation_by_year_returns_hash_with_years_as_keys_pointing_to_ints
    expected_result = {2009 => 22620,
                       2010 => 23119,
                       2011 => 23657,
                       2012 => 23973,
                       2013 => 24481,
                       2014 => 24578}
    assert_equal expected_result, @enrollment1.participation_by_year
  end

  def test_participation_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.participation_in_year(1945)
  end

  def test_participation_in_year_returns_data_as_an_int
    assert_equal 23119, @enrollment1.participation_in_year(2010)
  end

  def test_participation_by_race_or_ethnicity_raises_UnknownRaceError_for_unknown_race
    assert_raises UnknownRaceError do
      @enrollment1.participation_by_race_or_ethnicity(:jason)
    end
  end

  def test_participation_by_race_or_ethnicity_returns_a_hash_with_years_pointing_to_floats
    expected_result = {2007 => 0.050,
                       2008 => 0.054,
                       2009 => 0.055,
                       2010 => 0.040,
                       2011 => 0.036,
                       2012 => 0.038,
                       2013 => 0.038,
                       2014 => 0.037}
    assert_equal expected_result, @enrollment1.participation_by_race_or_ethnicity(:asian)
  end

  def test_remediation_in_year_returns_percent_for_given_year
    assert_equal 0.414, @enrollment2.remediation_in_year(2010)
  end

  def test_remediation_in_year_returns_percent_as_three_digit_float
    assert_equal 0.414, @enrollment2.remediation_in_year(2010)
  end
end
