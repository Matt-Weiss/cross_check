module SeasonStatsHelpers
  def preseason_games(season)
    preseason_games = []
    games.each do |game|
      if game.season == season && game.type == "P"
        preseason_games << game.game_id
      end
    end
    preseason_games
  end

  def regular_season_games(season)
    regular_season_games = []
    games.each do |game|
      if game.season == season && game.type == "R"
        regular_season_games << game.game_id
      end
    end
    regular_season_games
  end

  def preseason_win_percentage(season)
    preseason_wins_by_team = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if preseason_games(season).include?(game.game_id)
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

  def regular_season_win_percentage(season)
    regular_season_wins_by_team = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if regular_season_games(season).include?(game.game_id)
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
    win_differential = preseason_win_percentage(season).merge(regular_season_win_percentage(season)){
      |key, preseason, regular_season| (regular_season - preseason).round(2)
    }
    sorted_win_diff = win_differential.sort_by do |key, value|
      value
    end
    sorted_win_diff
  end

  def all_games_in_season(season)
    full_season_games = []
    games.each do |game|
      if game.season == season
        full_season_games << game.game_id
      end
    end
    full_season_games
  end

  def coach_wins(season)
    full_season_wins_by_coach = Hash.new {|hash, key| hash[key] = [0,0]}
    game_teams.each do |game|
      if all_games_in_season(season).include?(game.game_id)
        full_season_wins_by_coach[game.head_coach][1] += 1
        if game.won == "TRUE"
          full_season_wins_by_coach[game.head_coach][0] += 1
        end
      end
    end
    full_season_wins_by_coach
  end

  def coach_win_percentage(season)
    full_season_win_percentage = {}
    (coach_wins(season)).each do |key, value|
      full_season_win_percentage[key] = (value[0].to_f / value[1]).round(4)
    end
    full_season_sorted = full_season_win_percentage.sort_by do |key, value|
      value
    end
    full_season_sorted
  end

end
