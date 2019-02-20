module TeamSeasonalSummaryHelpers
  def games_per_regular_season(team_id) #helper
    collect_games = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      collect_games[game.season] << team_id if game.home_team_id == team_id &&
                                               game.type.include?("R")
      collect_games[game.season] << team_id if game.away_team_id == team_id &&
                                               game.type.include?("R")
    end
    collect_games.each {|key, value| collect_games[key] = value.length}
    collect_games
  end

  def games_per_preseason(team_id) #helper
    collect_games = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      collect_games[game.season] << team_id if game.away_team_id == team_id &&
                                               game.type.include?("P")
      collect_games[game.season] << team_id if game.home_team_id == team_id &&
                                               game.type.include?("P")
    end
    collect_games.each {|key, value| collect_games[key] = value.length}
    collect_games
  end

  def wins_per_regular_season(team_id) #helper
    wins = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      wins[game.season] << team_id if game.home_team_id == team_id &&
                                      game.outcome.include?("home win") &&
                                      game.type.include?("R")
      wins[game.season] << team_id if game.away_team_id == team_id &&
                                      game.outcome.include?("away win") &&
                                      game.type.include?("R")
    end
    wins.each {|key, value| wins[key] = value.length}
    wins
  end

  def wins_per_preseason(team_id) #helper
    wins = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      wins[game.season] << team_id if game.home_team_id == team_id &&
                                      game.outcome.include?("home win") &&
                                      game.type.include?("P")
      wins[game.season] << team_id if game.away_team_id == team_id &&
                                      game.outcome.include?("away win") &&
                                      game.type.include?("P")
    end
      wins.each {|key, value| wins[key] = value.length}
    wins
  end

  def win_percentage_per_regular_season(team_id) #helper
    reg_games = games_per_regular_season(team_id)
    reg_wins = wins_per_regular_season(team_id)
    reg_games.merge(reg_wins) do |key, games, wins|
      (wins.to_f / games).round(2)
    end
  end

  def win_percentage_per_preseason(team_id) #helper
    pre_games = games_per_preseason(team_id)
    pre_wins = wins_per_preseason(team_id)
    pre_games.merge(pre_wins) do |key, games, wins|
      (wins.to_f / games).round(2)
    end
  end

  def hash_of_goals_regular_season(team_id)
    goals = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if game.home_team_id == team_id && game.type.include?("R")
        goals[game.season] << game.home_goals
      elsif game.away_team_id == team_id && game.type.include?("R")
        goals[game.season] << game.away_goals
      end
    end
    goals
  end

  def hash_of_goals_preseason(team_id)
    goals = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if game.home_team_id == team_id && game.type.include?("P")
        goals[game.season] << game.home_goals
      elsif game.away_team_id == team_id && game.type.include?("P")
        goals[game.season] << game.away_goals
      end
    end
    goals
  end

  def total_goals_regular_season(team_id)
    goals = hash_of_goals_regular_season(team_id)
    goals.each do |key, value|
      goals[key] = value.sum
    end
    goals
  end

  def total_goals_preseason(team_id)
    goals = hash_of_goals_preseason(team_id)
    goals.each do |key, value|
      goals[key] = value.sum
    end
    goals
  end

  def total_goals_against_regular_season(team_id)
    against_goals = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if game.home_team_id == team_id && game.type.include?("R")
        against_goals[game.season] << game.away_goals
      elsif game.away_team_id == team_id && game.type.include?("R")
        against_goals[game.season] << game.home_goals
      end
    end
    against_goals.each do |key, value|
      against_goals[key] = value.sum
    end
      against_goals
  end

  def total_goals_against_preseason(team_id)
    against_goals = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if game.home_team_id == team_id && game.type.include?("P")
        against_goals[game.season] << game.away_goals
      elsif game.away_team_id == team_id && game.type.include?("P")
        against_goals[game.season] << game.home_goals
      end
    end
    against_goals.each do |key, value|
      against_goals[key] = value.sum
    end
    against_goals
  end

  def average_goals_scored_regular_season(team_id)
    goal_total = total_goals_regular_season(team_id)
    games_total = games_per_regular_season(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def average_goals_scored_preseason(team_id)
    goal_total = total_goals_preseason(team_id)
    games_total = games_per_preseason(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def average_goals_against_regular_season(team_id)
    goal_total = total_goals_against_regular_season(team_id)
    games_total = games_per_regular_season(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def average_goals_against_preseason(team_id)
    goal_total= total_goals_against_preseason(team_id)
    games_total = games_per_preseason(team_id)
    avg_goals = games_total.merge(goal_total) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
    avg_goals
  end

  def find_seasons(team_id)
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
