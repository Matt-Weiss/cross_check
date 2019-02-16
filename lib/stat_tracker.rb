require 'csv'
require_relative './game_class'
require_relative './teams_class'
require_relative './game_teams_class'

require_relative './game_stats'
require_relative './league_and_season_stats'
require_relative './league_helpers'
require_relative './team_stats'
require_relative './team_helpers'
require 'pry'

class StatTracker
  include GameStats
  include LeagueStats
  include LeagueStatsHelpers
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = []
    @teams = []
    @game_teams = []
    load_games(locations[:games])
    load_teams(locations[:teams])
    load_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def load_games(file)
    CSV.foreach(file, headers: true) do |row|
      @games << Game.new(row)
    end
  end

  def load_teams(file)
    CSV.foreach(file, headers: true) do |row|
      @teams << Teams.new(row)
    end
  end

  def load_game_teams(file)
    CSV.foreach(file, headers: true) do |row|
      @game_teams << GameTeams.new(row)
    end
  end

end
