require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  def setup
    data_dir = File.expand_path('../data', __dir__)
    @dr = DistrictRepository.from_csv(data_dir)
  end

  def test_find_by_name_returns_nil_for_unknown_district
    assert_nil @dr.find_by_name('PATRICK')
  end

  def test_find_by_name_returns_district_from_case_insensitive_search
    assert_equal @dr.find_by_name('academy 20'),
                 @dr.find_by_name('ACADEMY 20')
  end

  def test_find_all_matching_returns_empty_array_for_unmatched_name_fragment
    assert_equal [], @dr.find_all_matching('ZZZ')
  end

  def test_find_all_matching_returns_array_of_district_names_matching_fragment
    expected = ["ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J"]
    assert_equal expected, @dr.find_all_matching('AdAmS').map { |dist| dist.name }
  end
end
