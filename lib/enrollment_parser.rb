require 'csv'  # => true
require 'pry'

class EnrollmentParser

  def self.parse(name, file)
    CSV.foreach(file) do |district_name, category, year, metric, rate|
      district_name
      category
      year
      metric
      rate
      binding.pry
    end
  end                                                                   # => :parse
end  # => :parse


# CSV.open(file, headers: true, :symbol)
