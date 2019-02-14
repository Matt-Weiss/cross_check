require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'
require 'pry'
class GameStatsTest < Minitest::Test

  def test_game_stats_exist
    skip
    games = GameStats.new

    assert_instance_of GameStats, games
  end

  def test_highest_total_score
    skip
    games = GameStats.new

    assert_equal 9, games.highest_total_score
  end

  def test_lowest_total_score
    skip
    games = GameStats.new

    assert_equal 1, games.lowest_total_score
  end
  def test_biggest_blowout
    skip
    games = GameStats.new

    assert_equal 5, games.biggest_blowout
  end

  def test_percentage_home_wins
    skip
    games = GameStats.new

    assert_equal 68.00, games.percentage_home_wins
  end

  def test_percentage_visitor_wins
    skip
    games = GameStats.new

    assert_equal 32.00, games.percentage_visitor_wins
  end

  def test_gather_game_ids_by_season
    skip
    # binding.pry
  end

  def test_count_of_games_by_season
    skip
    games = GameStats.new

    assert_equal ({20122013 => 25}), games.count_of_games_by_season
  end

  def test_goals_per_game_by_season
    skip
  end

  def test_average_goals_by_season
    skip
    games = GameStats.new
    assert_equal ({20122013 => 4.96}), games.average_goals_by_season
  end
end
