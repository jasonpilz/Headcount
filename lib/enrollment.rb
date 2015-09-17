require_relative './graduation_rate'

class Enrollment
  def initialize(data)
    @data = data
  end

  def self.filter_by_graduation(data)

  end

  def in_year(year)
    # expecting year to be an int
    @data[year]
  end

  def graduation_rate
    grad_data = Enrollment.filter_by_graduation(@data)
    GraduationRate.new(grad_data)
  end
end

# ideal @data:
#     {
#     2009=>832368,
#     2010=>843316,
#     2011=>854265,
#     2012=>863561,
#     2013=>876999,
#     2014=>889006
#     }
