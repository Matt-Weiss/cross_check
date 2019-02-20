require 'csv'

require_relative './game_class'
require_relative './teams_class'
require_relative './game_teams_class'

require_relative './game_statistics'
require_relative './league_statistics'
require_relative './league_helpers'
require_relative './team_statistics'
require_relative './team_helpers'
require_relative './team_secondary_helpers'
require_relative './team_seasonal_summary_helpers'
require_relative './season_statistics'
require_relative './season_helpers'


require 'pry'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include LeagueStatisticsHelpers
  include TeamStatistics
  include TeamStatisticsHelpers
  include TeamSeasonalSummaryHelpers
  include TeamSecondaryHelpers
  include SeasonStatistics
  include SeasonStatisticsHelpers

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
