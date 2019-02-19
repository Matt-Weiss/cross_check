module SeasonStatsHelpers
  def preseason_games(season)
    @preseason_games = []
    games.each do |game|
      if game.season == season && game.type == "P"
        @preseason_games << game.game_id
      end
    end
  end

  def regular_season_games(season)
    @regular_season_games = []
    games.each do |game|
      if game.season == season && game.type == "R"
        @regular_season_games << game.game_id
      end
    end
  end

  def preseason_win_percentage
    preseason_wins_by_team = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if @preseason_games.include?(game.game_id)
        preseason_wins_by_team[game.team_id][1] += 1
        if game.won == "TRUE"
          preseason_wins_by_team[game.team_id][0] += 1
        end
      end
    end
    preseason_win_percentage = {}
    preseason_wins_by_team.each do |key, value|
      preseason_win_percentage[key] = (value[0].to_f / value[1]).round(2)
    end
    preseason_win_percentage
  end

  def regular_season_win_percentage
    regular_season_wins_by_team = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if @regular_season_games.include?(game.game_id)
        regular_season_wins_by_team[game.team_id][1] += 1
        if game.won == "TRUE"
          regular_season_wins_by_team[game.team_id][0] += 1
        end
      end
    end
    regular_season_win_percentage = {}
    regular_season_wins_by_team.each do |key, value|
      regular_season_win_percentage[key] = (value[0].to_f / value[1]).round(2)
    end
    regular_season_win_percentage
  end

  def preseason_vs_regular_season(season)
    preseason_games(season)
    regular_season_games(season)
    win_differential = preseason_win_percentage.merge(regular_season_win_percentage){
      |key, preseason, regular_season| (regular_season - preseason).round(2)
    }
    sorted_win_diff = win_differential.sort_by do |key, value|
      value
    end
    sorted_win_diff
  end

  def all_games_in_season(season)
    preseason_games(season)
    regular_season_games(season)
    @full_season_games = @preseason_games + @regular_season_games
  end

  def coach_wins
    full_season_wins_by_coach = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if @full_season_games.include?(game.game_id)
        full_season_wins_by_coach[game.head_coach][1] += 1
        if game.won == "TRUE"
          full_season_wins_by_coach[game.head_coach][0] += 1
        end
      end
    end
    full_season_wins_by_coach
  end

  def coach_win_percentage(season)
    all_games_in_season(season)
    full_season_win_percentage = {}
    (coach_wins).each do |key, value|
      full_season_win_percentage[key] = (value[0].to_f / value[1]).round(4)
    end
    full_season_sorted = full_season_win_percentage.sort_by do |key, value|
      value
    end
    full_season_sorted
  end

  def accuracy_data
    accuracy_by_team = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if @full_season_games.include?(game.game_id)
        accuracy_by_team[game.team_id][1] += game.shots
        accuracy_by_team[game.team_id][0] += game.goals
      end
    end
    accuracy_by_team
  end

  def accuracy_percentage(season)
    all_games_in_season(season)
    accuracy_percentage = {}
    accuracy_data.each do |key, value|
      accuracy_percentage[key] = (value[0].to_f / value[1]).round(4)
    end
    accuracy_sorted = accuracy_percentage.sort_by do |key, value|
      value
    end
    accuracy_sorted
  end

  def hits_data(season)
    all_games_in_season(season)
    hits_by_team = Hash.new {|hash, key| hash[key] = [0]}
    game_teams.each do |game|
      if @full_season_games.include?(game.game_id)
        hits_by_team[game.team_id][0] += game.hits
      end
    end
    hits_sorted = hits_by_team.sort_by do |key, value|
      value
    end
    hits_sorted
  end

  def power_play_goal_data(season)
    all_games_in_season(season)
    power_play_goals_data = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if @full_season_games.include?(game.game_id)
        power_play_goals_data[season][1] += game.power_play_goals
        power_play_goals_data[season][0] += game.goals
      end
    end
    power_play_percentage = {}
    power_play_goals_data.each do |key, value|
      power_play_percentage[key] = (value[1].to_f / value[0]).round(2)
    end
    power_play_percentage[season]
  end
end
