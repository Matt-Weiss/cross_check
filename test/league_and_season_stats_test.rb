require './test/test_helper'
require 'pry'

class LeagueStatsTest < Minitest::Test

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

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Bruins", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Ducks", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Senators", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Senators", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Penguins", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Penguins", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "Bruins", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Blackhawks", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Red Wings"], @stat_tracker.worst_fans
  end
end
