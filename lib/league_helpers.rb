module LeagueStatisticsHelpers

  def all_goals_scored #helper for 2 and 3
    goals_by_id = Hash.new{|hash, key| hash[key] = []}
    game_teams.each do |game|
      goals_by_id[game.team_id] << game.goals
    end
    sum_goals_by_id = Hash.new{|hash, key| hash[key] = []}
    goals_by_id.each_key do |key|
      sum_goals_by_id[key] << (goals_by_id[key].sum.to_f / goals_by_id[key].length).round(2)
    end
    sum_goals_by_id
  end

  def goals_allowed #helper for 4 and 5
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

  def goals_scored_as_visitors #helper for 6 and 8
    goals_scored_as_visitors = Hash.new{|hash, key| hash[key] = []}
    games.each do |game|
      goals_scored_as_visitors[game.away_team_id] << game.away_goals
    end
    goals_scored_avg = Hash.new{|hash, key| hash[key] = []}
    goals_scored_as_visitors.each_key do |key|
      goals_scored_avg[key] << (goals_scored_as_visitors[key].sum.to_f / goals_scored_as_visitors[key].count).round(2)
    end
    goals_scored_avg
  end

  def goals_scored_at_home #helper for 7 and 9
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

  def team_win_rates #helper for 10
    team_wins_hash = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      team_wins_hash[game.team_id][1] += 1
      if game.won == "TRUE"
        team_wins_hash[game.team_id][0] += 1
      end
    end
    team_win_rates = {}
    team_wins_hash.each do |key, value|
      team_win_rates[key] = (value[0].to_f / value[1]).round(2)
    end
    team_win_rates
  end

  def team_wins_home_and_away #helper for 11 and 12
    team_wins_hash = Hash.new {|hash, key| hash[key] = [0,0,0,0]}
    game_teams.each do |game|
      if game.hoa == "home"
        team_wins_hash[game.team_id][1] += 1
        if game.won == "TRUE"
          team_wins_hash[game.team_id][0] += 1
        end
      else
        team_wins_hash[game.team_id][3] += 1
        if game.won == "TRUE"
          team_wins_hash[game.team_id][2] += 1
        end
      end
    end
    team_wins_hash
  end

  def team_home_vs_away #helper for 11 and 12
    team_win_percentages = Hash.new {|hash, key| hash[key] = [0,0]}
    team_wins_home_and_away.each do |key, value|
      team_win_percentages[key][0] = (value[0].to_f / value[1]).round(2)
      team_win_percentages[key][1] = (value[2].to_f / value[3]).round(2)
    end
    team_home_vs_away = {}
    team_win_percentages.each do |key, value|
      team_home_vs_away[key] = value[0] - value[1]
    end
    team_home_vs_away
  end

  def teams_with_better_away_records #helper for 12
    worst_fans = {}
    team_home_vs_away.each do |key, value|
      if value < 0
        worst_fans[key] = value
      end
    end
    worst_fans
  end

  def team_name_finder(sorted_hash) #helper for 2-11
    team = teams.find do |team|
      team.team_id == sorted_hash[0]
    end
    "#{team.team_name}"
  end
end
