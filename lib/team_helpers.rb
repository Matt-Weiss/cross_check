module TeamStatisticsHelpers

  def best_season_helper(team_id) #helper
    season_hash = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      season_hash[game.season] << game.home_team_id if game.home_team_id == team_id
      season_hash[game.season] << game.away_team_id if game.away_team_id == team_id
    end
    season_hash
  end#counts number of games played per season by pushing in team id's.

  def season_helper_next(team_id) #team id's counted to figure out number of games played
      games_total = Hash.new {|hash, key| hash[key] = []}
      best_season_helper(team_id).each do |key, value|
      games_total[key] = value.length
    end
    games_total
  end

  def home_wins_per_season(team_id) #helper for best season
      home_wins = Hash.new {|hash, key| hash[key] = []}
      games.each do |game|
        home_sum = 0
        if game.home_team_id == team_id && game.outcome.include?("home win")
        home_wins[game.season] << home_sum += 1
        end
      end
    home_wins_total = Hash.new
    home_wins.each do |key, value|
    home_wins_total[key] = value.length
    end
    home_wins_total
  end

  def away_wins_per_season(team_id) #helper for best and worst season
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

  def sum_of_wins_by_season(team_id) #helper for best and worst season, merges home and away wins to give win total in order to calculate win percentage.
    total_sum = home_wins_per_season(team_id).merge(away_wins_per_season(team_id)) {|k, away_value, home_value| away_value + home_value }
    total_sum
  end

  def average_win_percentage_by_season(team_id) #helper for avg win percentage
    win_percentages = season_helper_next(team_id).merge(sum_of_wins_by_season(team_id)) {|k, helper_value, sum_value| (sum_value.to_f / helper_value).round(2) * 100 }
    win_percentages
  end

  def sum_of_games_played_by_team(team_id) #helper for average_win_percentage
    total_games = 0
    games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        total_games += 1
      end
    end
    total_games
  end

  def sum_away_wins(team_id) #helper win percentage method
    wins = 0
    games.each do |game|
      if game.away_team_id == team_id && game.outcome.include?("away win")
        wins += 1
      end
    end
    wins
  end

  def sum_all_wins(team_id) #helper for avg win percentage
    wins = 0
    games.each do |game|
      if game.home_team_id == team_id && game.outcome.include?("home win")
        wins +=1
      end
    end
    wins + sum_away_wins(team_id)
  end

  def favorite_opponent_wins(team_id) #helper for favorite_opponent method
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

  def favorite_opponent_losses(team_id) #helper for favorite_opponent method
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

  def total_games_vs_opponents(team_id) #helper for favorite_opponent method
    games_per_opponent = favorite_opponent_wins(team_id) + favorite_opponent_losses(team_id)
    games_per_opponent
  end

  def wins_for_each_opponent(team_id) #helper for 7
    opponent_wins_key = Hash.new {|hash, key| hash[key] = []}
    favorite_opponent_losses(team_id).each do |team|
      opponent_wins_key[team] << team
    end
    opponent_wins_key.each {|key, value| opponent_wins_key[key] = value.length}
    opponent_wins_key
  end

  def opponent_win_percentage(team_id) #helper for 7
    win_percentage = game_total_each_opponent(team_id).merge(wins_for_each_opponent(team_id)) {|key, games, wins| (wins.to_f/games).round(2) * 100}
    win_percentage
  end

  def return_id_of_favorite_opponent(team_id) #helper for 7,
    sorted_percentages = opponent_win_percentage(team_id).sort_by {|key, value| value}
    opponent_id = sorted_percentages.first[0]
    opponent_id
  end
end
