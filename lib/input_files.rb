class InputFiles

  # Enrollment
  DROPOUT_RATES = File.expand_path("../data/Dropout rates by race and ethnicity.csv", __dir__)
  GRAD_RATES = File.expand_path("../data/High school graduation rates.csv", __dir__)
  KINDERGARTEN = File.expand_path("../data/Kindergartners in full-day program.csv", __dir__)
  ONLINE_PUPIL_ENROLL = File.expand_path("../data/Online pupil enrollment.csv", __dir__)
  PUPIL_ENROLL_BY_RACE = File.expand_path("../data/Pupil enrollment by race_ethnicity.csv", __dir__)
  PUPIL_ENROLL = File.expand_path("../data/Pupil enrollment.csv", __dir__)
  SPECIAL_ED = File.expand_path("../data/Special education.csv", __dir__)
  REMEDIATION = File.expand_path("../data/Remediation in higher education.csv", __dir__)

  # Statewide Testing
  THIRD_GRADE_TESTING = File.expand_path("../data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", __dir__)
  EIGHTH_GRADE_TESTING = File.expand_path("../data/8th grade students scoring proficient or above on the CSAP_TCAP.csv", __dir__)
  MATH_PROFICIENCY_BY_RACE = File.expand_path("../data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", __dir__)
  READING_PROFICIENCY_BY_RACE = File.expand_path("../data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", __dir__)
  WRITING_PROFICIENCY_BY_RACE = File.expand_path("../data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", __dir__)

  # Economic Profile
  MEDIAN_INCOME = File.expand_path("../data/Median household income.csv", __dir__)
  CHILDREN_IN_POVERTY = File.expand_path("../data/School-aged children in poverty.csv", __dir__)
  REDUCED_LUNCH = File.expand_path("../data/Students qualifying for free or reduced price lunch.csv", __dir__)
  TITLE_1 = File.expand_path("../data/Title I students.csv", __dir__)
end
