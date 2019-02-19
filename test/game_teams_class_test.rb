require './test/test_helper'


class GameTeamsTest < Minitest::Test

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

  def test_game_team_attributes
    assert_equal "2012030221",@stat_tracker.game_teams[0].game_id
    assert_equal "3",@stat_tracker.game_teams[0].team_id
    assert_equal "away",@stat_tracker.game_teams[0].hoa
    assert_equal "FALSE",@stat_tracker.game_teams[0].won
    assert_equal "OT",@stat_tracker.game_teams[0].settled_in
    assert_equal "John Tortorella",@stat_tracker.game_teams[0].head_coach
    assert_equal 2, @stat_tracker.game_teams[0].goals
    assert_equal 35, @stat_tracker.game_teams[0].shots
    assert_equal 44, @stat_tracker.game_teams[0].hits
    assert_equal 8, @stat_tracker.game_teams[0].pim
    assert_equal 3, @stat_tracker.game_teams[0].power_play_opportunities
    assert_equal 0, @stat_tracker.game_teams[0].power_play_goals
    assert_equal 44.8, @stat_tracker.game_teams[0].face_off_win_percentage
    assert_equal 17, @stat_tracker.game_teams[0].give_aways
    assert_equal 7, @stat_tracker.game_teams[0].take_aways


  end





end
