require_relative '../lib/district'

class DistrictTest < Minitest::Test
  def setup
    @data_dir = File.expand_path('fixtures', __dir__)
    @a20 = District.new('ACADEMY 20', CSVParser.new(@data_dir, TestFiles))
  end

  def test_name_returns_the_upcased_name_of_the_district
    lowercased_dist = District.new('academy 20', CSVParser.new(@data_dir))
    assert_equal 'ACADEMY 20', lowercased_dist.name
  end

  def test_statewide_testing_returns_an_instance_of_statewide_testing
    assert_equal StatewideTesting, @a20.statewide_testing.class
  end

  def test_enrollment_returns_an_instance_of_enrollment
    assert_equal Enrollment, @a20.enrollment.class
  end
end
