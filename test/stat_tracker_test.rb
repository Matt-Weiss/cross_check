require './test/test_helper'

class StatTrackerTest < Minitest::Test

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
    # binding.pry
  end

  def test_it_exists

    assert_instance_of StatTracker, @stat_tracker
  end

  # Test that StatTracker is loaded with game objects


end
