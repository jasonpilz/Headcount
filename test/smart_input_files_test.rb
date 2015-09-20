require_relative '../lib/smart_input_files'

class SmartInputFilesTest < Minitest::Test
  def test_it_loads_in_all_files_from_a_directory
    filenames = ["/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                 "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                 "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                 "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                 "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv",
                 "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv",
                 "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv",
                 "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv",
                 "/Users/patwey/code/headcount/fake_dir/Median household income.csv",
                 "/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv",
                 "/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv",
                 "/Users/patwey/code/headcount/fake_dir/Pupil enrollment.csv",
                 "/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv",
                 "/Users/patwey/code/headcount/fake_dir/School-aged children in poverty.csv",
                 "/Users/patwey/code/headcount/fake_dir/Special education.csv",
                 "/Users/patwey/code/headcount/fake_dir/Students qualifying for free or reduced price lunch.csv",
                 "/Users/patwey/code/headcount/fake_dir/Title I students.csv"]
    assert_equal filenames, SmartInputFiles.new('../fake_dir').filenames
  end

  def test_it_sorts_all_files_based_on_keywords_in_filenames
    sif = SmartInputFiles.new('../fake_dir')
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv"], sif.dropout_rates
    assert_equal ["/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv"], sif.grad_rates
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv"], sif.kindergarten
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv"], sif.online_pupil_enroll
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"], sif.pupil_enroll_by_race
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Special education.csv"], sif.special_ed
    assert_equal ["/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv"], sif.remediation
  end
end
