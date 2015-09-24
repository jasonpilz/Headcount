require_relative '../lib/economic_profile'
require_relative '../lib/csv_parser'

class EconomicProfileTest < Minitest::Test
  def setup
    dir = File.expand_path("fixtures", __dir__)
    csv_parser = CSVParser.new(dir, TestFiles)
    @economic1 = EconomicProfile.new('ACADEMY 20', csv_parser)
    @economic2 = EconomicProfile.new('Colorado', csv_parser)
    @economic_unknown = EconomicProfile.new('JOSHCHEEK', csv_parser)
  end

  def test_free_or_reduced_lunch_by_year_returns_hash_with_years_as_keys_pointing_to_floats
    expected_result = { 2000 => 0.040, 2001 => 0.047,
                        2002 => 0.048, 2003 => 0.060,
                        2004 => 0.059, 2005 => 0.058,
                        2006 => 0.072, 2007 => 0.080,
                        2008 => 0.093, 2009 => 0.103,
                        2010 => 0.113, 2011 => 0.119,
                        2012 => 0.125, 2013 => 0.131,
                        2014 => 0.127 }
    assert_equal expected_result, @economic1.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year_returns_nil_for_unknown_year
    assert_nil @economic1.free_or_reduced_lunch_in_year(3452)
  end

  def test_free_or_reduced_lunch_in_year_returns_three_digit_float
    assert_equal 0.383, @economic2.free_or_reduced_lunch_in_year(2009)
  end

  def test_school_aged_children_in_poverty_by_year_returns_hash_with_years_as_keys_pointing_to_floats
    expected_result = {1995=>0.032, 1997=>0.035,
                       1999=>0.032, 2000=>0.031,
                       2001=>0.029, 2002=>0.033,
                       2003=>0.037, 2004=>0.034,
                       2005=>0.042, 2006=>0.036,
                       2007=>0.039, 2008=>0.044,
                       2009=>0.047, 2010=>0.057,
                       2011=>0.059, 2012=>0.064,
                       2013=>0.048}

    assert_equal expected_result, @economic1.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_by_year_returns_empty_hash_if_district_not_found
    assert_equal Hash.new, @economic2.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year_returns_nil_for_unknown_year
    assert_nil @economic1.school_aged_children_in_poverty_in_year(2021)
  end

  def test_school_aged_children_in_poverty_in_year_returns_three_digit_float
    assert_equal 0.044, @economic1.school_aged_children_in_poverty_in_year(2008)
  end

  def test_title_1_students_by_year_returns_hash_with_years_as_keys_pointing_to_floats
    expected_result = { 2009 => 0.014, 2011 => 0.011, 2012 => 0.010,
                        2013 => 0.012, 2014 => 0.027  }
    assert_equal expected_result, @economic1.title_1_students_by_year
  end

  def test_title_1_students_by_year_returns_empty_hash_if_district_not_found
    assert_equal Hash.new, @economic_unknown.title_1_students_by_year
  end

  def test_title_1_students_in_year_returns_nil_for_unknown_year
    assert_nil @economic1.title_1_students_in_year(1967)
  end

  def test_title_1_students_in_year_returns_three_digit_float
    assert_equal 0.231, @economic2.title_1_students_in_year(2013)
  end

  def test_average_median_income_returns_average_of_incomes_as_int
    assert_equal 87635, @economic1.average_median_income
  end
end
