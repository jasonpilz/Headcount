require_relative'../lib/enrollment_loader'

class EnrollmentLoaderTest < Minitest::Test
  # '../fake_data' dir is used for testing
  # file data enters result array based on
  #   their filename's alphabetical order
  # json data is currently represented by { json: 'json data' }

  # So far:
  # => dropout files test loading 2 files into one result

  def test_it_loads_two_files_into_one_array
    skip
    EnrollmentLoader.file_dir = '/fixtures/fake_data' # find the right path
    expected_result = [{location: 'ACADEMY 20',
                        dropout_a_header_1: '1',
                        dropout_a_header_2: '2',
                        dropout_a_header_3: '3'},
                       {location: 'ACADEMY 20',
                        dropout_b_header_1: 'l',
                        dropout_b_header_2: 'o',
                        dropout_b_header_3: 'l'}]
    assert_equal expected_result, EnrollmentLoader.load_dropout_rates('ACADEMY 20')
  end

  def test_it_sends_mixed_file_types_to_the_right_parse_methods
    skip
    EnrollmentLoader.file_dir = 'fixtures/fake_data' # find the right path
    expected_result = [{ json: 'json data' },
                       {location: 'ACADEMY 20',
                        grad_data: 'graduation!'},
                       ]
    assert_equal expected_result, EnrollmentLoader.load_grad_rates('ACADEMY 20')
  end
end

# Heads => Location, ..., ...
# Data => NO SPACES AFTER COMMAS!
