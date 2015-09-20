require_relative '../lib/smart_input_files'

class SmartInputFilesTest < Minitest::Test
  def test_it_loads_in_all_files_from_a_directory
    filenames = ["/Users/patwey/code/headcount/data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                 "/Users/patwey/code/headcount/data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                 "/Users/patwey/code/headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                 "/Users/patwey/code/headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                 "/Users/patwey/code/headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv",
                 "/Users/patwey/code/headcount/data/Dropout rates by race and ethnicity.csv",
                 "/Users/patwey/code/headcount/data/High school graduation rates.csv",
                 "/Users/patwey/code/headcount/data/Kindergartners in full-day program.csv",
                 "/Users/patwey/code/headcount/data/Median household income.csv",
                 "/Users/patwey/code/headcount/data/Online pupil enrollment.csv",
                 "/Users/patwey/code/headcount/data/Pupil enrollment by race_ethnicity.csv",
                 "/Users/patwey/code/headcount/data/Pupil enrollment.csv",
                 "/Users/patwey/code/headcount/data/Remediation in higher education.csv",
                 "/Users/patwey/code/headcount/data/School-aged children in poverty.csv",
                 "/Users/patwey/code/headcount/data/Special education.csv",
                 "/Users/patwey/code/headcount/data/Students qualifying for free or reduced price lunch.csv",
                 "/Users/patwey/code/headcount/data/Title I students.csv"]
    assert_equal filenames, SmartInputFiles.new('../data').filenames
  end

  def test_it_sorts_all_files_based_on_keywords_in_filenames
    sif = SmartInputFiles.new('../data')
    assert_equal ["/Users/patwey/code/headcount/data/Dropout rates by race and ethnicity.csv", 'csv'], sif.dropout_rates.first
    assert_equal ["/Users/patwey/code/headcount/data/High school graduation rates.csv", 'csv'], sif.grad_rates.first
    assert_equal ["/Users/patwey/code/headcount/data/Kindergartners in full-day program.csv", 'csv'], sif.kindergarten.first
    assert_equal ["/Users/patwey/code/headcount/data/Online pupil enrollment.csv", 'csv'], sif.online_pupil_enroll.first
    assert_equal ["/Users/patwey/code/headcount/data/Pupil enrollment by race_ethnicity.csv", 'csv'], sif.pupil_enroll_by_race.first
    assert_equal ["/Users/patwey/code/headcount/data/Special education.csv", 'csv'], sif.special_ed.first
    assert_equal ["/Users/patwey/code/headcount/data/Remediation in higher education.csv", 'csv'], sif.remediation.first
  end

  def test_it_returns_array_with_information_on_file_type
    sif = SmartInputFiles.new('../data')
    assert_equal 'csv', sif.dropout_rates.flatten.last
  end
end
