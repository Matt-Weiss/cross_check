require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
class GameStatsTest < Minitest::Test

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

  def test_highest_total_score
    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.68, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.32, @stat_tracker.percentage_visitor_wins
  end


  def test_count_of_games_by_season
    assert_equal ({"20122013" => 25}), @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_by_season
    assert_equal ({"20122013" => 4.96}), @stat_tracker.average_goals_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.96, @stat_tracker.average_goals_per_game
  end
end
