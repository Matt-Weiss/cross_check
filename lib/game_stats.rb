require './lib/stat_tracker'
class GameStats

  def initialize
    game_path = './data/game_test.csv'
    locations = {games: game_path}
    stat_tracker = StatTracker.from_csv(locations)
    @all_games = stat_tracker[:games]
  end

  def highest_total_score
    goals_per_game = []
    @games.each do |game|
      goals_per_game << (game[:away_goals] + game[:home_goals])
    end
    goals_per_game.max
  end

  def lowest_total_score
    goals_per_game = []
    @all_games.each do |game|
      goals_per_game << (game[:away_goals] + game[:home_goals])
    end
    goals_per_game.min
  end

  def biggest_blowout
    goals_differential = []
    @all_games.each do |game|
      goals_differential << (game[:away_goals] - game[:home_goals]).abs
    end
    goals_differential.max
  end

  def percentage_home_wins
    winners = 0
    @all_games.each do |game|
      if game[:home_goals] > game[:away_goals]
      winners += 1
      end
    end
    (100 * winners.to_f/@all_games.length).round(2)
  end

  def percentage_visitor_wins
    100 - percentage_home_wins
  end

  def game_ids_by_season #helper
    seasons_hash = Hash.new {|hash, key| hash[key] = []}
    @all_games.each do |game|
      seasons_hash[game[:season]] << game[:game_id]
    end
    seasons_hash
  end

  def count_of_games_by_season
    season_game_count = {}
    game_ids_by_season.each do |key, value|
      season_game_count[key] = value.count
    end
    season_game_count
  end

  def goals_per_game_by_season #helper
    goals_hash = Hash.new {|hash, key| hash[key] = []}
    @all_games.each do |game|
      goals_hash[game[:season]] << (game[:home_goals] + game[:away_goals])
    end
    goals_hash
  end

  def average_goals_by_season
    averages_hash = {}
    goals_per_game_by_season.each do |key, value|
      averages_hash[key] = (value.sum.to_f / value.count).round(2)
    end
    averages_hash
  end

end
