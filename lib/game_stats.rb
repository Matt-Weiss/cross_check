require './lib/stat_tracker'
require 'pry'
class GameStats < StatTracker
  def initialize

    game_path = './data/game_test.csv'
    locations = {games: game_path}
    @stat_tracker = StatTracker.from_csv(locations)
    @all_games = @stat_tracker[:games]
  end

  def highest_total_score
    goals_per_game = []
    @all_games.each do |game|
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
    winners = 0
    @all_games.each do |game|
      if game[:away_goals] > game[:home_goals]
      winners += 1
        end
        #inding.pry

      end
    (100 * winners.to_f/@all_games.length).round(2)
  end

  def average_goals_per_game
    total_scores = 0
    @all_games.each do |game|
      total_scores += (game[:away_goals] + game[:home_goals])
      #binding.pry
      end
      (total_scores/50.00)

    end
end
