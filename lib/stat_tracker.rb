require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = []
    @teams = []
    @game_teams = []
    load_games(locations[:games])
    # load_teams(locations[:teams])
    # load_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def load_games(file)
    CSV.foreach(file, headers: true) do |row|
      @games << Game.new(row)
    end
  end

  # def load_teams(file)
  #   CSV.foreach(file, headers: true) do |row|
  #     @teams << Team.new(row)
  #   end
  # end

  # def load_game_teams(file)
  #   CSV.foreach(file, headers: true) do |row|
  #     @game_teams << GameTeams.new(row)
  #   end
  # end

  def highest_total_score
    goals_per_game = []
    @games.each do |game|
      goals_per_game << (game.away_goals + game.home_goals)
    end
    goals_per_game.max
    binding.pry
  end
end
