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
      win_percentage = (sum_all_wins(team_id).to_f/
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

  def game_total_each_opponent(team_id) #returns a hash with team id as key, and each value represents total games played with team_id argument
    teams_and_games = Hash.new {|hash, key| hash[key] = []}
    total_games_vs_opponents(team_id).each do |team|
    teams_and_games[team] << team
  end
  teams_and_games.each {|key, value| teams_and_games[key] = value.length}
  teams_and_games
  end

  def wins_for_each_opponent(team_id)
    opponent_wins_key = Hash.new {|hash, key| hash[key] = []}
    favorite_opponent_losses(team_id).each do |team|
      opponent_wins_key[team] << team
    end
    opponent_wins_key.each {|key, value| opponent_wins_key[key] = value.length}
    opponent_wins_key
  end

  def opponent_win_percentage(team_id)
    win_percentage = game_total_each_opponent(team_id).merge(wins_for_each_opponent(team_id)) {|key, games, wins| (wins.to_f/games).round(2) * 100}
    win_percentage
  end

  def return_id_of_favorite_opponent(team_id)
    sorted_percentages = opponent_win_percentage(team_id).sort_by {|key, value| value}
    opponent_id = sorted_percentages.first[0]
    opponent_id
  end

  def favorite_opponent(team_id)
      name = []
      opponent_id = return_id_of_favorite_opponent(team_id)
      teams.find do |team|
      if team.team_id == opponent_id
      name << team.team_name
      end
    end
    name[0]
  end

  def rival(team_id)
    name = []
    sorted_percentages = opponent_win_percentage(team_id).sort_by {|key, value| value}
    opponent_id = sorted_percentages.last[0]
    teams.find do |team|
      if team.team_id == opponent_id
        name << team.team_name
      end
    end
    name[0]
  end

  def biggest_team_blowout(team_id)
    won_by = []
    games.each do |game|
      if team_id == game.away_team_id && game.outcome.include?("away win")
      won_by << (game.away_goals - game.home_goals)
      end
      if team_id == game.home_team_id && game.outcome.include?("home win")
      won_by << (game.home_goals - game.away_goals)
      end
    end
    won_by.max
  end

  def worst_loss(team_id)
    lost_by = []
    games.each do |game|
      if team_id == game.away_team_id && game.outcome.include?("home win")
        lost_by << (game.home_goals - game.away_goals)
      end
      if team_id == game.home_team_id && game.outcome.include?("away win")
        lost_by << (game.away_goals - game.home_goals)
      end
    end
    lost_by.max
  end

  def game_count(team_id)#helper method for head to head
    gather_games = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if team_id == game.away_team_id
      gather_games[game.home_team_id] << game.away_team_id
      end
      if team_id == game.home_team_id
      gather_games[game.away_team_id] << game.home_team_id
      end
    end
    gather_games
  end

  def sum_games_per_team(team_id)#second helper for head to head calculated total games played against all teams for given team id
    game_sum = game_count(team_id)
    game_sum.each do |key, value| game_sum[key] = value.length
    end
    game_sum
  end

  def wins_against_all_teams(team_id)
    wins = Hash.new {|hash, key| hash[key] = [] }
    games.each do |game|
      if team_id == game.home_team_id && game.outcome.include?("home win")
        wins[game.away_team_id] << game.home_team_id
      end
      if team_id == game.away_team_id && game.outcome.include?("away win")
        wins[game.home_team_id] << game.away_team_id
      end
    end
    wins.each do |key, value|
      wins[key] = value.length
    end
    wins
  end

  def win_percentage_by_team(team_id)
    game_sum = sum_games_per_team(team_id)
    wins = wins_against_all_teams(team_id)
    win_percentages = game_sum.merge(wins) {|key, games, wins| (wins.to_f / games).round(2)}
  end

  def name_finder(team_id)
    team_name = []
    teams.each do |team|
      if team_id == team.team_id
        team_name << team.team_name
      end
    end
    team_name[0]
  end

  def head_to_head(team_id)
    final_head_to_head = {}
    team_win_percentage = win_percentage_by_team(team_id)
    team_win_percentage.each do |key, value|
      final_head_to_head[name_finder(key)] = value
    end
    final_head_to_head
  end


  def games_per_regular_season(team_id)
    collect_games = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      collect_games[game.season] << team_id if game.home_team_id == team_id && game.type.include?("R")
      collect_games[game.season] << team_id if game.away_team_id == team_id && game.type.include?("R")
      end
      collect_games.each do |key, value|
      collect_games[key] = value.length
    end
    collect_games
  end

  def games_per_preseason(team_id)
    collect_games = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      collect_games[game.season] << team_id if game.away_team_id == team_id && game.type.include?("P")
      collect_games[game.season] << team_id if game.home_team_id == team_id && game.type.include?("P")
    end
    collect_games.each do |key, value|
      collect_games[key] = value.length
    end
    collect_games
  end

  def wins_per_regular_season(team_id)
    wins = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      wins[game.season] << team_id if game.home_team_id == team_id && game.outcome.include?("home win") && game.type.include?("R")
      wins[game.season] << team_id if game.away_team_id == team_id && game.outcome.include?("away win") && game.type.include?("R")
    end
    wins.each do |key, value|
      wins[key] = value.length
    end
    wins
  end

  def wins_per_preseason(team_id)
    wins = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      wins[game.season] << team_id if game.home_team_id == team_id && game.outcome.include?("home win") && game.type.include?("P")
      wins[game.season] << team_id if game.away_team_id == team_id && game.outcome.include?("away win") && game.type.include?("P")
    end
    wins.each do |key, value|
      wins[key] = value.length
    end
    wins
  end

  def win_percentage_per_regular_season(team_id)
    games = games_per_regular_season(team_id)
    wins = wins_per_regular_season(team_id)
    win_percentage = games.merge(wins) do |key, games, wins|
      (wins.to_f / games).round(2)
    end
    win_percentage
  end

  def win_percentage_per_preseason(team_id)
    games = games_per_preseason(team_id)
    wins = wins_per_preseason(team_id)
    win_percentage = games.merge(wins) do |key, games, wins|
      (wins.to_f / games).round(2)
    end
    win_percentage
  end

  def total_goals_scored_by_season(team_id)
    goals = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      goals[game.season] << game.home_goals if game.home_team_id == team_id && game.type.include?("P")
      goals[game.season] << game.away_goals if game.away_team_id == team_id && game.type.include?("P")
    end
    goals
    binding.pry
  end


end
