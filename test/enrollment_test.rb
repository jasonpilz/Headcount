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
    skip
  end

  def test_dropout_rate_returns_three_digit_float
    skip
  end

  # Dropout rate by gender
end
