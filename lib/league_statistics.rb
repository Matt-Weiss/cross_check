module LeagueStatistics

  def count_of_teams #method 1
    teams.count
  end

  def best_offense #method 2
   sorted_goal_stats = all_goals_scored.sort_by do |key, value|
     value
   end.last
   sorted_goal_stats
   team_name_finder(sorted_goal_stats)
  end

  def worst_offense #method 3
    sorted_goal_stats = all_goals_scored.sort_by do |key, value|
      value
    end.first
    sorted_goal_stats
    team_name_finder(sorted_goal_stats)
  end

  def best_defense #method 4
    best_defense_id = goals_allowed.sort_by do |key, value|
      value
    end.first
    team_name_finder(best_defense_id)
  end

  def worst_defense #method 5
    worst_defense_id = goals_allowed.sort_by do |key, value|
      value
    end.last
    team_name_finder(worst_defense_id)
  end

  def highest_scoring_visitor #method 6
    high_scoring_away_id = goals_scored_as_visitors.sort_by do |key, value|
      value
    end.last
    team_name_finder(high_scoring_away_id)
  end

  def highest_scoring_home_team #method 7
    high_scoring_home_id = goals_scored_at_home.sort_by do |key, value|
      value
    end.last
    team_name_finder(high_scoring_home_id)
  end

  def lowest_scoring_visitor #method 8
    low_scoring_away_id = goals_scored_as_visitors.sort_by do |key, value|
      value
    end.first
    team_name_finder(low_scoring_away_id)
  end

  def lowest_scoring_home_team #method 9
    low_scoring_home_id = goals_scored_at_home.sort_by do |key, value|
      value
    end.first

    team_name_finder(low_scoring_home_id)
  end

  def winningest_team #method 10
    winningest_team = team_win_rates.sort_by do |key, value|
      value
    end.last
    team_name_finder(winningest_team)
  end

  def best_fans #method 11
    best_fans = team_home_vs_away.sort_by do |key, value|
      value
    end.last
    team_name_finder(best_fans)
  end

  def worst_fans #method 12
    worst_fans = []
    teams_with_better_away_records.each do |key, value|
      worst_fans << team_name_finder([key])
    end
    worst_fans
  end
end
