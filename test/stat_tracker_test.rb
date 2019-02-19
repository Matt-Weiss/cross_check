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
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_stat_tracker_holds_game_team_and_gameteam_objects
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Teams, @stat_tracker.teams[0]
    assert_instance_of GameTeams, @stat_tracker.game_teams[0]
  end

end
