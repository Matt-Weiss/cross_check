require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require 'pry'
class TeamStatsTest < Minitest::Test

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

  def test_favorite_opponent
    @stat_tracker.favorite_opponent("3")
  end
  def test_worst_loss
    skip
    assert_equal 5, @stat_tracker.worst_loss
  end

end
