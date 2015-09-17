require 'csv'  # => true
require 'pry'

class EnrollmentParser
  def self.parse(name, file)
    results = []
    rows = CSV.read(file, headers: true, header_converters: :symbol)
    rows.each do |row|
      results << row.to_h if row[:location] == name
    end
    results
  end
end
