class EconomicProfile
  attr_reader :name

  def initialize(name, parser)
    @name = name
    @parser = parser
  end

  def truncate(string)
    string[0..4].to_f
  end

  def data_by_year(rows, result = {})
    rows.each do |row|
      result[row[:timeframe].to_i] = truncate(row[:data])
    end
    result
  end

  def free_or_reduced_lunch_by_year
    lunch = @parser.parse_reduced_lunch(@name)
    lunch_percents = lunch.select do |row|
      row if (row[:dataformat] == 'percent') &&
             (row[:poverty_level] == 'eligible for free or reduced lunch')
    end
    lunch_percents.empty? ? {} : data_by_year(lunch_percents)
  end

  def free_or_reduced_lunch_in_year(year)
    lunch = @parser.parse_reduced_lunch(@name)
    lunch_in_year = lunch.select do |row|
      row if (row[:dataformat] == 'percent') &&
             (row[:poverty_level] == 'eligible for free or reduced lunch') &&
             (row[:timeframe].to_i == year)
    end
    lunch_in_year.empty? ? return : truncate(lunch_in_year.first[:data])
  end

  def school_aged_children_in_poverty_by_year
    children = @parser.parse_children_in_poverty(@name)
    children_percents = children.select do |row|
      row if row[:dataformat] == 'percent'
    end
    children_percents.empty? ? {} : data_by_year(children_percents)
  end

  def school_aged_children_in_poverty_in_year(year)
    children = @parser.parse_children_in_poverty(@name)
    children_in_year = children.select do |row|
      row if row[:dataformat] == 'percent' && row[:timeframe].to_i == year
    end
    children_in_year.empty? ? return : truncate(children_in_year[0][:data])
  end

  def title_1_students_by_year
    title_1 = @parser.parse_title_1(@name)
    students = title_1.select { |row| row if row[:dataformat] == 'percent' }
    data_by_year(students)
  end

  def title_1_students_in_year(year)
    title_1 = @parser.parse_title_1(@name)
    title_1_in_year = title_1.select do |row|
      row if row[:dataformat] == 'percent' && row[:timeframe].to_i == year
    end
    title_1_in_year.empty? ? return : truncate(title_1_in_year[0][:data])
  end

  def average_median_income
    total = 0
    median_incomes = @parser.parse_median_income(@name)
    median_incomes.each do |row|
      total += row[:data].to_i
    end
    total / median_incomes.count
  end
end
