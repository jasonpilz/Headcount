require 'csv'  # => true
require 'pry'

class EnrollmentParser

  def self.parse(name, file)
    results = []
    rows = CSV.read(file, headers: true, header_converters: :symbol)
    rows.each do |row|
      results << row.to_h if row[:location] == 'ACADEMY 20'
    end
    # group_by ?
    results.each do |result|
      result.delete :location
      # result.delete :dataformat
      # result.delete :timeframe
    end
    binding.pry
  end                                                                   # => :parse
end  # => :parse


# CSV.open(file, headers: true, :symbol)
