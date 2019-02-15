require 'pry'

module LeagueAndSeason

  def count_of_teams
    teams.count
  end

  def worst_offense
    goals_by_id = Hash.new{|row, key| row[key] = []}
    game_teams.each do |row|
      goals_by_id[game.team_id] << game.goals
      binding.pry
     end
  end

  def goals_allowed
    goals_allowed = Hash.new{|hash, key| hash[key] = []}
    games.each do |game|
      goals_allowed[game.home_team_id] << game.away_goals
      goals_allowed[game.away_team_id] << game.home_goals
    end
    goals_allowed_avg = Hash.new{|hash, key| hash[key] = []}
    goals_allowed.each_key do |key|
      goals_allowed_avg[key] << (goals_allowed[key].sum.to_f / goals_allowed[key].count).round(2)
    end
    goals_allowed_avg
  end

  def best_defense
    best_defense_id = goals_allowed.sort_by do |key, value|
      value
    end.first
    team_name_finder(best_defense_id)
  end

  def goals_scored_at_home
    goals_scored_at_home = Hash.new{|hash, key| hash[key] = []}
    games.each do |game|
      goals_scored_at_home[game.home_team_id] << game.home_goals
    end
    goals_scored_avg = Hash.new{|hash, key| hash[key] = []}
    goals_scored_at_home.each_key do |key|
      goals_scored_avg[key] << (goals_scored_at_home[key].sum.to_f / goals_scored_at_home[key].count).round(2)
    end
    goals_scored_avg
  end

  def best_offense
    goals_by_id = Hash.new{|hash, key| hash[key] = []}
    game_teams.each do |game|
      goals_by_id[game.team_id] << game.goals
    end
    sum_goals_by_id = Hash.new{|hash, key| hash[key] = []}
    goals_by_id.each_key do |key|
      sum_goals_by_id[key] << (goals_by_id[key].sum.to_f / goals_by_id[key].length).round(2)
    end
    sorted_goal_stats = sum_goals_by_id.sort_by do |key, value|
      value
    end.last
    sorted_goal_stats
    team_name_finder(sorted_goal_stats)
  end

  def team_name_finder(sorted_hash)
    team = teams.find do |team|
      team.team_id == sorted_hash[0]
      end
    "#{team.short_name} #{team.team_name}"
    end
  end


  def highest_scoring_home_team
    high_scoring_home_id = goals_scored_at_home.sort_by do |key, value|
      value
    end.last
    team_name_finder(high_scoring_home_id)
  end
end