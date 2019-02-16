require './test/test_helper'
require 'pry'

class LeagueAndSeasonStatsTest < Minitest::Test

  def setup
    game_path = './data/game_test.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)

  end

  def test_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end


  def test_find_goals_allowed #helper
    skip
    @stat_tracker.goals_allowed
  end

  def test_best_offense
    assert_equal "Boston Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Pittsburgh Penguins", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Boston Bruins", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Anaheim Ducks", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Ottawa Senators", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Ottawa Senators", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Pittsburgh Penguins", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Pittsburgh Penguins", @stat_tracker.lowest_scoring_home_team
  end

  def test_avg_goals_scored_at_home #helper
    @stat_tracker.goals_scored_at_home
  end

end
