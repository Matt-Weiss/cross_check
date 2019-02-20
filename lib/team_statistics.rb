module TeamStatistics

  def team_info(team_id) #method 1
    team_info = {}
    teams.each do |team|
      if team.team_id == team_id
      team.instance_variables.each do |ivar|
        team_info[ivar.to_s.delete "@"] = team.instance_variable_get(ivar)
        end
      end
    end
    team_info
  end

  def best_season(team_id) #method 2
    sort_by_best_win_percentage = average_win_percentage_by_season(team_id).sort_by {|key, value| value}
    sort_by_best_win_percentage.last[0]
  end

  def worst_season(team_id) #method 3
    sort_by_worst_win_percentage = average_win_percentage_by_season(team_id).sort_by {|key, value| value}
    sort_by_worst_win_percentage.first[0]
  end

  def average_win_percentage(team_id) #method 4
      win_percentage = (sum_all_wins(team_id).to_f/
    sum_of_games_played_by_team(team_id)).round(2)
    win_percentage
  end

  def most_goals_scored(team_id) #method 5
    goals_by_team = []
    games.each do |game|
      if team_id == game.away_team_id
        goals_by_team << game.away_goals
      elsif team_id == game.home_team_id
        goals_by_team << game.home_goals
      end
    end
   goals_by_team.max
  end

  def fewest_goals_scored(team_id) #method 6
      goals_by_team = []
      games.each do |game|
      if team_id == game.away_team_id
        goals_by_team << game.away_goals
      elsif team_id == game.home_team_id
      goals_by_team << game.home_goals
      end
    end
    goals_by_team.min
  end

  def favorite_opponent(team_id) #method 7
    name = []
    opponent_id = return_id_of_favorite_opponent(team_id)
    teams.find do |team|
      if team.team_id == opponent_id
        name << team.team_name
      end
    end
    name[0]
  end

  def rival(team_id) #method 8
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

  def biggest_team_blowout(team_id) #method 9
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

  def worst_loss(team_id) #method 10
    lost_by = []
    games.each do |game|
      if team_id == game.away_team_id && game.outcome.include?("home win")
        lost_by << (game.home_goals - game.away_goals)
      elsif team_id == game.home_team_id && game.outcome.include?("away win")
        lost_by << (game.away_goals - game.home_goals)
      end
    end
    lost_by.max
  end

  def head_to_head(team_id) #method 11
    final_head_to_head = {}
    team_win_percentage = win_percentage_by_team(team_id)
    team_win_percentage.each do |key, value|
      final_head_to_head[name_finder(key)] = value
    end
    final_head_to_head
  end

  def seasonal_summary(team_id)
    seasons = find_seasons(team_id)
    season_summary_hash = {}
      seasons.each do |season|
        season_summary_hash[season] = {
          preseason: {
            :win_percentage=> if win_percentage_per_preseason(team_id)[season] == []
              0.0
            else win_percentage_per_preseason(team_id)[season]
            end,
            :total_goals_scored=> if total_goals_preseason(team_id)[season] == []
              0
            else total_goals_preseason(team_id)[season]
            end,
            :total_goals_against=> if total_goals_against_preseason(team_id)[season] == []
              0
            else total_goals_against_preseason(team_id)[season]
            end,
            :average_goals_scored=> if average_goals_scored_preseason(team_id)[season] == []
              0.0
            else average_goals_scored_preseason(team_id)[season]
            end,
            :average_goals_against=> if average_goals_against_preseason(team_id)[season] == []
              0.0
            else average_goals_against_preseason(team_id)[season]
            end},
          :regular_season => {
            :win_percentage=> win_percentage_per_regular_season(team_id)[season],
            :total_goals_scored=>total_goals_regular_season(team_id)[season],
            :total_goals_against=>total_goals_against_regular_season(team_id)[season],
            :average_goals_scored=>average_goals_scored_regular_season(team_id)[season],
            :average_goals_against=>average_goals_against_regular_season(team_id)[season]}}
      end
      season_summary_hash
  end
end
