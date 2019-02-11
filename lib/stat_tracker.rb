require 'csv'

class StatTracker

  def initialize
  end

  def self.from_csv(locations)
    @test = {}
    locations.each do |key, value|
      # @test[key] = File.new(value).readlines
      @test[key] = CSV.read(value)
    end
    @test
    # binding.pry
  end

  

end
