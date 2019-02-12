require 'csv'

class StatTracker

  def initialize
  end

  def self.from_csv(locations)
    statistics = {}
    locations.each do |key, value|
      statistics[key] = CSV.table(value, Hash.new)
    end
    statistics
  end



end
