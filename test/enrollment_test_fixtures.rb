require_relative '../lib/enrollment'
require_relative '../lib/enrollment_parser'
require_relative '../lib/test_files'

class EnrollmentTestFixtures < Minitest::Test

  def setup
    @enrollment1 = Enrollment.new('ACADEMY 20')
    @enrollment2 = Enrollment.new('Colorado')
  end

  def test_dropout_rate_with_test_file
    EnrollmentParser.file_type = TestFiles
    assert_equal 0.999 , @enrollment1.dropout_rate_in_year(2011)
  end
end
