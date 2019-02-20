require './test/test_helper'

class GameTest < Minitest::Test
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

  def test_game_attributes
    assert_equal "2012030221", @stat_tracker.games[0].game_id
    assert_equal "20122013", @stat_tracker.games[0].season
    assert_equal "P", @stat_tracker.games[0].type
    assert_equal "2013-05-16", @stat_tracker.games[0].date_time
    assert_equal "3", @stat_tracker.games[0].away_team_id
    assert_equal "6", @stat_tracker.games[0].home_team_id
    assert_equal 2, @stat_tracker.games[0].away_goals
    assert_equal 3, @stat_tracker.games[0].home_goals
  end
end
