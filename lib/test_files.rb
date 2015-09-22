class TestFiles

  # Enrollment
  DROPOUT_RATES = File.expand_path("../test/fixtures/dropout_rates.csv", __dir__)
  GRAD_RATES = File.expand_path("../test/fixtures/grad_rates.csv", __dir__)
  KINDERGARTEN = File.expand_path("../test/fixtures/kindergarten.csv", __dir__)
  ONLINE_PUPIL_ENROLL = File.expand_path("../test/fixtures/online_enrollment.csv", __dir__)
  PUPIL_ENROLL_BY_RACE = File.expand_path("../test/fixtures/enrollment_by_race.csv", __dir__)
  PUPIL_ENROLL = File.expand_path("../test/fixtures/pupil_enrollment.csv", __dir__)
  SPECIAL_ED = File.expand_path("../test/fixtures/special_education.csv", __dir__)
  REMEDIATION = File.expand_path("../test/fixtures/remediation.csv", __dir__)

  # Statewide Testing
  THIRD_GRADE_TESTING = File.expand_path("../test/fixtures/third_grade.csv", __dir__)
  EIGHTH_GRADE_TESTING = File.expand_path("../test/fixtures/eighth_grade.csv", __dir__)
  MATH_PROFICIENCY_BY_RACE = File.expand_path("../test/fixtures/math_proficiency_by_race.csv", __dir__)
  READING_PROFICIENCY_BY_RACE = File.expand_path("../test/fixtures/reading_proficiency_by_race.csv", __dir__)
  WRITING_PROFICIENCY_BY_RACE = File.expand_path("../test/fixtures/writing_proficiency_by_race.csv", __dir__)

  # Economic Profile
  MEDIAN_INCOME = File.expand_path("../test/fixtures/median_income.csv", __dir__)
  CHILDREN_IN_POVERTY = File.expand_path("../test/fixtures/children_in_poverty.csv", __dir__)
  REDUCED_LUNCH = File.expand_path("../test/fixtures/reduced_lunch.csv", __dir__)
  TITLE_I = File.expand_path("../test/fixtures/title_i.csv", __dir__)
end
