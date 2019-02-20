module TeamSecondaryHelpers

  def name_finder(team_id) #helper
    team_name = []
    teams.each do |team|
      if team_id == team.team_id
        team_name << team.team_name
      end
    end
    team_name[0]
  end


  def game_total_each_opponent(team_id) #returns a hash with team id as key, and each value represents total games played with team_id argument
    teams_and_games = Hash.new {|hash, key| hash[key] = []}
    total_games_vs_opponents(team_id).each do |team|
      teams_and_games[team] << team
    end
    teams_and_games.each {|key, value| teams_and_games[key] = value.length}
    teams_and_games
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

  def wins_against_all_teams(team_id) #helper for 11
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

  def win_percentage_by_team(team_id) #helper for 11
    game_sum = sum_games_per_team(team_id)
    all_wins = wins_against_all_teams(team_id)
    game_sum.merge(all_wins) {|key, games, wins| (wins.to_f / games).round(2)}
  end

  def average_goals_scored_preseason(team_id) #helper for seasonal summary
    goal_total = total_goals_preseason(team_id)
    games_total = games_per_preseason(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def average_goals_against_regular_season(team_id)#helper for seasonal summary
    goal_total = total_goals_against_regular_season(team_id)
    games_total = games_per_regular_season(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def average_goals_against_preseason(team_id)#helper for seasonal summary
    goal_total= total_goals_against_preseason(team_id)
    games_total = games_per_preseason(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def find_seasons(team_id)#helper for seasonal summary
  seasons = []
    games.each do |game|
      if game.away_team_id == team_id ||
        game.home_team_id == team_id
        seasons << game.season
      end
    end
    seasons.uniq
  end
end
