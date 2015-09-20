filenames = ["/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",  # => "/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
             "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv",  # => "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv"
             "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",     # => "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"
             "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",  # => "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"
             "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv",  # => "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
             "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv",                              # => "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv"
             "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv",                                     # => "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv"
             "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv",                               # => "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv"
             "/Users/patwey/code/headcount/fake_dir/Median household income.csv",                                          # => "/Users/patwey/code/headcount/fake_dir/Median household income.csv"
             "/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv",                                          # => "/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv"
             "/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv",                               # => "/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"
             "/Users/patwey/code/headcount/fake_dir/Pupil enrollment.csv",                                                 # => "/Users/patwey/code/headcount/fake_dir/Pupil enrollment.csv"
             "/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv",                                  # => "/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv"
             "/Users/patwey/code/headcount/fake_dir/School-aged children in poverty.csv",                                  # => "/Users/patwey/code/headcount/fake_dir/School-aged children in poverty.csv"
             "/Users/patwey/code/headcount/fake_dir/Special education.csv",                                                # => "/Users/patwey/code/headcount/fake_dir/Special education.csv"
             "/Users/patwey/code/headcount/fake_dir/Students qualifying for free or reduced price lunch.csv",              # => "/Users/patwey/code/headcount/fake_dir/Students qualifying for free or reduced price lunch.csv"
             "/Users/patwey/code/headcount/fake_dir/Title I students.csv"]                                                 # => ["/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv", "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv", "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv", "/Users/patwey/code/headcount/fake_dir/Median household income.csv", "/Users/patwey/code/he...


DROPOUT_RATES = []         # => []
GRAD_RATES = []            # => []
KINDERGARTEN = []          # => []
ONLINE_PUPIL_ENROLL = []   # => []
PUPIL_ENROLL_BY_RACE = []  # => []
PUPIL_ENROLL = []          # => []
SPECIAL_ED = []            # => []
REMEDIATION = []           # => []

filenames.each do |file|                                                     # => ["/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv", "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv", "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv", "/Users/patwey/code/headcount/fake_dir/Median household income.csv", "/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv",...
  name = file.split('/')                                                     # => ["", "Users", "patwey", "code", "headcount", "fake_dir", "3rd grade students scoring proficient or above on the CSAP_TCAP.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "8th grade students scoring proficient or above on the CSAP_TCAP.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "Dropout rates by race and ethnicity.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "High school graduation rates.csv"], ["", "Users", "patwey", "code", "headcount", "fake_dir", "Kindergartners in fu...
      .last                                                                  # => "3rd grade students scoring proficient or above on the CSAP_TCAP.csv", "8th grade students scoring proficient or above on the CSAP_TCAP.csv", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", "Dropout rates by race and ethnicity.csv", "High school graduation rates.csv", "Kindergartners in full-day program.csv", "Median household income.csv", "Online pupil enrollment.csv", "Pupil enrollment by race_ethnicity.csv", "Pupil enrollment.csv", "Remediation in higher education.csv", "School-aged children in poverty.csv", "Special education.csv", "Students qualifying for free or reduced price lunch.csv", "Title I students.csv"
      .split('.')                                                            # => ["3rd grade students scoring proficient or above on the CSAP_TCAP", "csv"], ["8th grade students scoring proficient or above on the CSAP_TCAP", "csv"], ["Average proficiency on the CSAP_TCAP by race_ethnicity_ Math", "csv"], ["Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading", "csv"], ["Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing", "csv"], ["Dropout rates by race and ethnicity", "csv"], ["High school graduation rates", "csv"], ["Kindergartners in full-day program", "csv"], ["Median household income", "csv"], ["Online pupil enrollment", "csv"], ["Pupil enrollment by race_ethnicity", "csv"], ["Pupil enrollment", "csv"], ["Remediation in higher education", "csv"], ["School-aged children in poverty", "csv"], ["Special education", "csv"], ["Students qualifying for free or reduced price lunch", "csv"], ["Title I students", "csv"]
      .first                                                                 # => "3rd grade students scoring proficient or above on the CSAP_TCAP", "8th grade students scoring proficient or above on the CSAP_TCAP", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Math", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading", "Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing", "Dropout rates by race and ethnicity", "High school graduation rates", "Kindergartners in full-day program", "Median household income", "Online pupil enrollment", "Pupil enrollment by race_ethnicity", "Pupil enrollment", "Remediation in higher education", "School-aged children in poverty", "Special education", "Students qualifying for free or reduced price lunch", "Title I students"
      .downcase                                                              # => "3rd grade students scoring proficient or above on the csap_tcap", "8th grade students scoring proficient or above on the csap_tcap", "average proficiency on the csap_tcap by race_ethnicity_ math", "average proficiency on the csap_tcap by race_ethnicity_ reading", "average proficiency on the csap_tcap by race_ethnicity_ writing", "dropout rates by race and ethnicity", "high school graduation rates", "kindergartners in full-day program", "median household income", "online pupil enrollment", "pupil enrollment by race_ethnicity", "pupil enrollment", "remediation in higher education", "school-aged children in poverty", "special education", "students qualifying for free or reduced price lunch", "title i students"
      # .gsub!(' ', '_')
  PUPIL_ENROLL_BY_RACE << file if name.include?('race') &&                   # => false, false, true, true, true, true, false, false, false, false, true, false, false, false, false, false, false
                                  name.include?('enrollment' || 'enroll')    # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"], nil, nil, nil, nil, nil, nil
  GRAD_RATES << file if name.include?('graduation' || 'grad')                # => nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv"], nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  KINDERGARTEN << file if name.include?('kindergartners' || 'kindergarten')  # => nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv"], nil, nil, nil, nil, nil, nil, nil, nil, nil
  ONLINE_PUPIL_ENROLL << file if name.include?('online') &&                  # => false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false
                                 name.include?('enrollment' || 'enroll')     # => nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv"], nil, nil, nil, nil, nil, nil, nil
  PUPIL_ENROLL_BY_RACE << file if name.include?('race' || 'ethnicity') &&    # => false, false, true, true, true, true, false, false, false, false, true, false, false, false, false, false, false
                                  name.include?('enrollment' || 'enroll')    # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv", "/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"], nil, nil, nil, nil, nil, nil
  PUPIL_ENROLL << file if name.include?('enrollment' || 'enroll') &&         # => false, false, false, false, false, false, false, false, false, true, true, true, false, false, false, false, false
                          !name.include?('online') &&                        # => false, false, false, false, false, false, false, false, false, false, true, true, false, false, false, false, false
                          !name.include?('race') &&                          # => false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false
                          !name.include?('ethnicity')                        # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment.csv"], nil, nil, nil, nil, nil
  SPECIAL_ED << file if name.include?('special' || 'special-education' ||    # => "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special", "special"
                                      'special-ed')                          # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Special education.csv"], nil, nil
  REMEDIATION << file if name.include?('remediation' || 'remed')             # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, ["/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv"], nil, nil, nil, nil
end                                                                          # => ["/Users/patwey/code/headcount/fake_dir/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/8th grade students scoring proficient or above on the CSAP_TCAP.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", "/Users/patwey/code/headcount/fake_dir/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", "/Users/patwey/code/headcount/fake_dir/Dropout rates by race and ethnicity.csv", "/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv", "/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv", "/Users/patwey/code/headcount/fake_dir/Median household income.csv", "/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv",...

GRAD_RATES            # => ["/Users/patwey/code/headcount/fake_dir/High school graduation rates.csv"]
KINDERGARTEN          # => ["/Users/patwey/code/headcount/fake_dir/Kindergartners in full-day program.csv"]
ONLINE_PUPIL_ENROLL   # => ["/Users/patwey/code/headcount/fake_dir/Online pupil enrollment.csv"]
PUPIL_ENROLL_BY_RACE  # => ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv", "/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"]
PUPIL_ENROLL          # => ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment.csv"]
SPECIAL_ED            # => ["/Users/patwey/code/headcount/fake_dir/Special education.csv"]
REMEDIATION           # => ["/Users/patwey/code/headcount/fake_dir/Remediation in higher education.csv"]



PUPIL_ENROLL_BY_RACE.uniq  # => ["/Users/patwey/code/headcount/fake_dir/Pupil enrollment by race_ethnicity.csv"]


# KEYWORDS
# --------

# Statewide Testing Keywords: csap_tcap, proficiency
# --------------------------------------------------
# THIRD_GRADE_TESTING Keywords: 3rd, third
# EIGHTH_GRADE_TESTING Keywords: 8th, eighth
# MATH_PROFICIENCY_BY_RACE Keywords: math
# READING_PROFICIENCY_BY_RACE Keywords: reading
# WRITING_PROFICIENCY_BY_RACE Keywords: writing

# Enrollment Keywords: dropout, graduation, kindergartners,
#                      enrollment, remediation, special
# ---------------------------------------------------------
# DROPOUT_RATES Keywords: dropout, drop
# GRAD_RATES Keywords: graduation, grad
# KINDERGARTEN Keywords: kindergarteners, kindergarten
# ONLINE_PUPIL_ENROLL Keywords: online && PUPIL_ENROLL_KEYWORDS
# PUPIL_ENROLL_BY_RACE Keywords: (race, ethnicity) && PUPIL_ENROLL_KEYWORDS
# PUPIL_ENROLL Keywords: !(ONLINE_PUPIL_ENROLL_KEYWORDS && PUPIL_ENROLL_BY_RACE_KEYWORDS)
#                        && PUPIL_ENROLL_KEYWORDS => (enrollment, enroll)
# SPECIAL_ED Keywords: special, special-education, special-ed
# REMEDIATION Keywords: remediation, remed

# Economic Profile Keywords: income, poverty, lunch, price, title, I

# MEDIAN_INCOME Keywords: median
# CHILDREN_IN_POVERTY Keywords: poverty
# REDUCED_LUNCH Keywords: lunch
# TITLE_I Keywords: title-i, (title && i)
