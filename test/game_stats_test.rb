require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_stats'
require 'pry'
class GameStatsTest < Minitest::Test

  def setup
    @games = GameStats.new
  end

  def test_game_stats_exist

    assert_instance_of GameStats, @games
  end

  def test_highest_total_score

    assert_equal 9, @games.highest_total_score
  end

  def test_lowest_total_score

    assert_equal 1, @games.lowest_total_score
  end
  def test_biggest_blowout

    assert_equal 5, @games.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 68.00, @games.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 32.00, @games.percentage_visitor_wins
  end

  # def test_count_of_games_per_season
  #
  # end
  def test_average_goals_per_game
    assert_equal 2.48, @games.average_goals_per_game
  end
end
