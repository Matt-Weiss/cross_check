require './test/test_helper'
require 'pry'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_best_season_helper
    skip
    assert [], @stat_tracker.best_season_helper("16")
  end

  def test_season_helper_next
    skip
    expected = {"20122013"=>6, "20142015"=>6, "20132014"=>6}
    assert_equal expected, @stat_tracker.season_helper_next("16")
  end

  def test_home_wins_per_season
    skip
    expected = {"20122013"=>2, "20142015"=>2, "20132014"=>3}

    assert_equal expected, @stat_tracker.home_wins_per_season("16")
  end

  def test_away_wins_per_season
    skip
    expected = {"20122013"=>1, "20142015"=>2, "20132014"=>1}
    assert_equal expected, @stat_tracker.away_wins_per_season("16")
  end

  def test_sum_of_wins_by_season
    skip
    expected = {"20122013"=>3, "20142015"=>4, "20132014"=>4}

    assert_equal expected, @stat_tracker.sum_of_wins_by_season("16")
  end

  def test_average_win_percentage_by_season
    skip
    expected = {"20122013"=>50.0, "20142015"=>67.0, "20132014"=>67.0}
    assert_equal expected, @stat_tracker.average_win_percentage_by_season("16")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

end
