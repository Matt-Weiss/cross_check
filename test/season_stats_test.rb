require './test/test_helper'
require 'pry'

class SeasonStatsTest < Minitest::Test

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal "Kings", @stat_tracker.biggest_bust("20132014")
    assert_equal "Blackhawks", @stat_tracker.biggest_bust("20142015")
  end

  def test_biggest_surprise
    assert_equal "Lightning", @stat_tracker.biggest_surprise("20132014")
    assert_equal "Jets", @stat_tracker.biggest_surprise("20142015")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Craig MacTavish", @stat_tracker.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Ducks", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Flames", @stat_tracker.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    assert_equal "Sabres", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Coyotes", @stat_tracker.least_accurate_team("20142015")
  end

  def test_most_hits_in_season
    assert_equal "Kings", @stat_tracker.most_hits("20132014")
    assert_equal "Islanders", @stat_tracker.most_hits("20142015")
  end

  def test_least_hits_in_season
    assert_equal "Devils", @stat_tracker.least_hits("20132014")
    assert_equal "Wild", @stat_tracker.least_hits("20142015")
  end

  def test_power_play_goal_percentage
    assert_equal 0.22, @stat_tracker.power_play_goal_percentage("20132014")
    assert_equal 0.21, @stat_tracker.power_play_goal_percentage("20142015")
  end
end
