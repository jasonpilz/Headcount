class Enrollment
  def initialize(data)
    @data = data
  end

  def in_year(year)
    # expecting year to be an int
    @data[year]
    22620
    # access hash returning value for year
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
