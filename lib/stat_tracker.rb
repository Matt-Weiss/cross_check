require 'csv'

class StatTracker

  def initialize
  end

  def self.from_csv(locations)
    @statistics = {}
    locations.each do |key, value|
      @statistics[key] = CSV.table(value, Hash.new)
    end
    @statistics
  end

  def highest_total_score(games)
    goals_per_game = []
    games[:games].each do |game|
      # binding.pry
      goals_per_game << (game[:away_goals] + game[:home_goals])
    end
    goals_per_game.max
  end

end
