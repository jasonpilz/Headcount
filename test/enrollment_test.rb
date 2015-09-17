require_relative '../lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup
    @enrollment1 = Enrollment.new('ACADEMY 20')
    @enrollment2 = Enrollment.new('Colorado')
  end

  def test_take_district_name_by_default
    assert_equal 'ACADEMY 20', @enrollment1.name
  end

  def test_returns_dropout_rate_for_all_students_in_given_year
    assert_equal 0.002, @enrollment1.dropout_rate_in_year(2011)
    assert_equal 0.03, @enrollment2.dropout_rate_in_year(2011)
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
    skip
  end

  def test_dropout_rate_for_race_or_ethnicity_raises_UnknownRaceError_for_unknown_race
    assert_raises UnknownRaceError do
      @enrollment1.dropout_rate_for_race_or_ethnicity(:jason)
    end
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_a_hash_with_years_as_keys
      expected_result = {2011 => 0,
                         2012 => 0.007}
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
    skip
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_correct_rate
    assert_equal 0.044, @enrollment2.dropout_rate_for_race_or_ethnicity_in_year(:black, 2012)
  end

end
