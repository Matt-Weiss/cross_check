require 'pry'

module TeamStatistics

  def best_season_helper(team_id)
    season_hash = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      season_hash[game.season] << game.home_team_id if game.home_team_id == team_id
      season_hash[game.season] << game.away_team_id if game.away_team_id == team_id
    end
    season_hash
  end

  def season_helper_next(team_id) # total games played per season
      games_total = Hash.new {|hash, key| hash[key] = []}
      best_season_helper(team_id).each do |key, value|
      games_total[key] = value.length
    end
    games_total
  end

  def home_wins_per_season(team_id)
      home_wins = Hash.new {|hash, key| hash[key] = []}
      games.each do |game|
        home_sum = 0
        if game.home_team_id == team_id && game.outcome.include?("home win")
        # home_sum += 1
        home_wins[game.season] << home_sum += 1
      end
    end
    home_wins_total = Hash.new
    home_wins.each do |key, value|
      home_wins_total[key] = value.length
    end
    home_wins_total
  end

  def away_wins_per_season(team_id)
    away_wins = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      away_sum = 0
      if game.away_team_id == team_id && game.outcome.include?("away win")
        away_wins[game.season] << away_sum += 1
      end
    end
    away_wins_total = Hash.new
    away_wins.each do |key, value|
      away_wins_total[key] = value.length
    end
    away_wins_total
  end

  def sum_of_wins_by_season(team_id)
    total_sum = home_wins_per_season(team_id).merge(away_wins_per_season(team_id)) {|k, away_value, home_value| away_value + home_value }
    total_sum
  end

  def average_win_percentage_by_season(team_id)
    win_percentages = season_helper_next(team_id).merge(sum_of_wins_by_season(team_id)) {|k, helper_value, sum_value| (sum_value.to_f / helper_value).round(2) * 100 }
    win_percentages
  end

  def best_season(team_id)
    sort_by_best_win_percentage = average_win_percentage_by_season(team_id).sort_by {|key, value| value}
    sort_by_best_win_percentage.last[0]
  end

  def worst_season(team_id)
    sort_by_worst_win_percentage = average_win_percentage_by_season(team_id).sort_by {|key, value| value}
    sort_by_worst_win_percentage.first[0]
  end
end
