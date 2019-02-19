require './test/test_helper'
require 'pry'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/game_test_preseason_and_regular_season.csv'
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
    skip
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    skip
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_sum_of_games_played_by_team
    skip
    assert_equal 18, @stat_tracker.sum_of_games_played_by_team("16")
  end

  def test_sum_away_wins
    skip
    assert_equal 4, @stat_tracker.sum_away_wins("16")
  end

  def test_sum_all_wins
    skip
    assert_equal 11, @stat_tracker.sum_home_wins("16")
  end

  def test_average_win_percentage
    skip
    assert_equal 0.52, @stat_tracker.average_win_percentage("18")
  end

  def test_most_goals_scored
    skip
    assert_equal 9, @stat_tracker.most_goals_scored("18")
  end

  def test_fewest_goals_scored
    skip
    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_favorite_opponent_wins
    skip
    assert_equal "Oilers", @stat_tracker.favorite_opponent_wins("16")
  end

  def test_favorite_opponent_losses
    skip
    assert_equal "Oilers", @stat_tracker.favorite_opponent_losses("16")
  end

  def test_total_games_vs_opponents
    skip
    assert_equal 6, @stat_tracker.total_games_vs_opponents("16")
  end

  def test_game_total_each_opponent
    skip
    assert_equal 5, @stat_tracker.game_total_each_opponent("16")
  end

  def test_wins_for_each_opponent
    skip
    assert_equal 33, @stat_tracker.wins_for_each_opponent("16")
  end

  def test_opponent_win_percentage
    skip
    assert_equal 22, @stat_tracker.opponent_win_percentage("16")
  end

  def test_return_id_of_favorite_opponent
    skip
    assert_equal "19", @stat_tracker.return_id_of_favorite_opponent("16")
  end

  def test_favorite_opponent
    skip
    assert_equal "Oilers", @stat_tracker.favorite_opponent("18")
  end

  def test_rival
    skip
    assert_equal "Red Wings", @stat_tracker.rival("16")
  end

  def test_biggest_blowout
    skip
    assert_equal 7, @stat_tracker.biggest_team_blowout("18")
  end

  def test_worst_loss
    skip
    assert_equal 3, @stat_tracker.worst_loss("16")
  end

  def test_game_count
    skip
    assert_equal 5, @stat_tracker.game_count("16")
  end

  def test_sum_games_per_team
    skip
    assert_equal 33, @stat_tracker.sum_games_per_team("16")
  end

  def test_wins_against_all_teams
    skip
    assert_equal 3, @stat_tracker.wins_against_all_teams("16")
  end

  def test_win_percentage_by_team
    skip
    assert_equal 3, @stat_tracker.win_percentage_by_team("16")
  end

  def test_name_finder
    skip
    assert_equal "Blackhawks", @stat_tracker.name_finder("16")
  end

  def test_head_to_head

      expected = {
      "Blues" => 0.47,
      "Jets" => 0.55,
      "Avalanche" => 0.63,
      "Flames" => 0.44,
      "Red Wings" => 0.29,
      "Blue Jackets" => 0.6,
      "Stars" => 0.52,
      "Blackhawks" => 0.42,
      "Wild" => 0.44,
      "Devils" => 0.5,
      "Canadiens" => 0.6,
      "Canucks" => 0.5,
      "Rangers" => 0.4,
      "Lightning" => 0.7,
      "Capitals" => 0.7,
      "Sharks" => 0.6,
      "Oilers" => 0.78,
      "Ducks" => 0.48,
      "Penguins" => 0.31,
      "Islanders" => 0.4,
      "Kings" => 0.61,
      "Sabres" => 0.7,
      "Coyotes" => 0.67,
      "Bruins" => 0.5,
      "Panthers" => 0.5,
      "Maple Leafs" => 0.4,
      "Senators" => 0.7,
      "Hurricanes" => 0.3,
      "Golden Knights" => 0.33,
      "Flyers" => 0.5
    }
    assert_equal expected, @stat_tracker.head_to_head("18")
  end

  def test_games_per_regular_season
    assert_equal 45, @stat_tracker.games_per_regular_season("16")
  end

  def test_games_per_preseason
    assert_equal 45, @stat_tracker.games_per_preseason("16")
  end

  def test_wins_per_regular_season
    assert_equal 32, @stat_tracker.wins_per_regular_season("16")
  end

  def test_wins_per_preseason
    assert_equal 2, @stat_tracker.win_percentage_per_preseason("16")
  end

  def test_win_percentage_per_regular_season
    assert_equal 72, @stat_tracker.win_percentage_per_regular_season("16")
  end

  def test_win_percentage_per_preseason
    assert_equal 55, @stat_tracker.win_percentage_per_preseason("16")
  end


  def test_total_goals_scored_by_season
    assert_equal 22, @stat_tracker.total_goals_scored_by_season("16")
  end
end
