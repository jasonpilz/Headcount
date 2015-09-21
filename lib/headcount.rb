

class DistrictRepository
  attr_reader :districts

  def initialize
    @districts = {}
  end

  def self.from_csv(data_dir)
    DistrictRepository.new
  end

  def find_by_name(name)

  end

  def self.find_all_matching(name)

  end

  def statewide_testing


end
