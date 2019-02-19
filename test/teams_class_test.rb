require './test/test_helper'


class TeamsTest < Minitest::Test

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

  def test_team_attributes
    assert_equal "1", @stat_tracker.teams[0].team_id
    assert_equal "23", @stat_tracker.teams[0].franchise_id
    assert_equal "New Jersey", @stat_tracker.teams[0].short_name
    assert_equal "Devils", @stat_tracker.teams[0].team_name
    assert_equal "NJD", @stat_tracker.teams[0].abbreviation
    assert_equal "/api/v1/teams/1", @stat_tracker.teams[0].link
  end


end
