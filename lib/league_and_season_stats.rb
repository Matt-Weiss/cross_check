module LeagueAndSeason

  def count_of_teams
    teams.count
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
    best_defense_team_object = teams.select do |team|
      team.team_id == best_defense_id[0]
    end[0]
    return "#{best_defense_team_object.short_name} #{best_defense_team_object.team_name}"
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

  def highest_scoring_home_team
    high_scoring_home_id = goals_scored_at_home.sort_by do |key, value|
      value
    end.last
    high_scoring_home_object = teams.find do |team|
      team.team_id == high_scoring_home_id[0]
    end
    return "#{high_scoring_home_object.short_name} #{high_scoring_home_object.team_name}"
  end

end
