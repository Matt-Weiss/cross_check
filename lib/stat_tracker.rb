require 'csv'
require './lib/game_stats'

class StatTracker
  include GameStats
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
