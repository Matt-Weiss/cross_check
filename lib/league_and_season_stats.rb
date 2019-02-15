require 'pry'

module LeagueAndSeason

  def count_of_teams
    teams.count
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




  # def goals_allowed
  #   goals_allowed = Hash.new{|hash, key| hash[key] = []}
  #   games.each do |game|
  #     goals_allowed[game.home_team_id] << game.home_goals
  #     goals_allowed[game.away_team_id] << game.away_goals
  #
  #   end
  #   goals_allowed
  #   binding.pry
  # end



  #   end
  #   goals_allowed_avg = Hash.new{|hash, key| hash[key] = []}
  #   goals_allowed.each_key do |key|
  #     goals_allowed_avg[key] << (goals_allowed[key].sum.to_f / goals_allowed[key].count).round(2)
  #   end
  #   goals_allowed_avg
  # end
