require_relative '../lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup
    @enrollment1 = Enrollment.new('ACADEMY 20')
  end

  def test_take_district_name_by_default
    assert_equal 'ACADEMY 20', @enrollment1.name
  end

  def test_returns_dropout_rate_for_all_students_in_given_year
    assert_equal 0.002, @enrollment1.dropout_rate_in_year(2011)
  end

  def test_dropout_rate_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_in_year(1)
  end

  def test_dropout_rate_returns_three_digit_float
    skip
  end

  def test_dropout_rate_by_gender_in_year_returns_a_hash_with_genders_as_keys_pointing_to_floats
    expected_result = {:female => 0.004, :male => 0.004}
    assert_equal expected_result, @enrollment1.dropout_rate_by_gender_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_returns_nil_for_unknown_year
    assert_nil @enrollment1.dropout_rate_in_year(1)
  end

  def test_dropout_rate_by_race_in_year_returns_a_hash_with_race_markers_as_keys_pointing_to_floats
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
  
end
