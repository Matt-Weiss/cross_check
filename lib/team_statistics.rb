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

  def sum_of_games_played_by_team(team_id)
    total_games = 0
    games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        total_games += 1
      end
    end
    total_games
  end

  def sum_away_wins(team_id)
    wins = 0
    games.each do |game|
      if game.away_team_id == team_id && game.outcome.include?("away win")
        wins += 1
      end
    end
    wins
  end

  def sum_all_wins(team_id)
    wins = 0
    games.each do |game|
      if game.home_team_id == team_id && game.outcome.include?("home win")
        wins +=1
      end
    end
    total_wins = wins + sum_away_wins(team_id)
  end

  def average_win_percentage(team_id)
      win_percentage = (sum_all_wins(team_id).to_f /
    sum_of_games_played_by_team(team_id)).round(2)
    win_percentage
  end

  def most_goals_scored(team_id)
    goals_by_team = []
    games.each do |game|
      if team_id == game.away_team_id
        goals_by_team << game.away_goals
      end
      if team_id == game.home_team_id
        goals_by_team << game.home_goals
     end
   end
   goals_by_team.max
  end

  def fewest_goals_scored(team_id)
      goals_by_team = []
      games.each do |game|
      if team_id == game.away_team_id
        goals_by_team << game.away_goals
      end
      if team_id == game.home_team_id
      goals_by_team << game.home_goals
      end
    end
    goals_by_team.min
  end

  def favorite_opponent_wins(team_id)
    home_wins = []
    away_wins = []
    games.each do |game|
      if team_id == game.home_team_id && game.outcome.include?("home win")
        home_wins << game.away_team_id
      end
      if team_id == game.away_team_id && game.outcome.include?("away win")
        away_wins << game.home_team_id
      end
    end
    total_wins_vs_opponent = home_wins + away_wins
    total_wins_vs_opponent
  end

  def favorite_opponent_losses(team_id)
    home_losses = []
    away_losses = []
    games.each do |game|
      if team_id == game.home_team_id && game.outcome.include?("away win")
        home_losses << game.away_team_id
      end
      if team_id == game.away_team_id && game.outcome.include?("home win")
        away_losses << game.home_team_id
      end
    end
    total_losses_vs_opponent = home_losses + away_losses
    total_losses_vs_opponent
  end

  def total_games_vs_opponents(team_id)
    games_per_opponent = favorite_opponent_wins(team_id) + favorite_opponent_losses(team_id)
    games_per_opponent
  end

  def games_played_with_each_opponent(team_id)
    teams_and_games = Hash.new {|hash, key| hash[key] = []}
    total_games_vs_opponents(team_id).each do |team|
    teams_and_games[team] << team
  end
  teams_and_games
  end
end




# ["17", "17", "14", "14", "19", "19", "19", "17", "14", "14", "19"]
#   ["17", "14", "17", "17", "14", "19", "19"]
