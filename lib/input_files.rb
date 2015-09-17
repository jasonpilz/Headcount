# have the loaders communicate with this class?
class InputFiles
  DROPOUT_RATES = File.expand_path("../data/Dropout rates by race and ethnicity.csv", __dir__)
  GRAD_RATES = File.expand_path("../data/High school graduation rates.csv", __dir__)
  KINDERGARTEN = File.expand_path("../data/Kindergartners in full-day program.csv", __dir__)
  ONLINE_PUPIL_ENROLL = File.expand_path("../data/Online pupil enrollment.csv", __dir__)
  PUPIL_ENROLL_BY_RACE = File.expand_path("../data/Pupil enrollment by race_ethnicity.csv", __dir__)
  PUPIL_ENROLL = File.expand_path("../data/Pupil enrollment.csv", __dir__)
  SPECIAL_ED = File.expand_path("../data/Special education.csv", __dir__)
  REMEDIATION = File.expand_path("../data/Remediation in higher education.csv", __dir__)
end
