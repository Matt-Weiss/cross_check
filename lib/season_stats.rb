module SeasonStats
  def biggest_bust(season)
    team_name_finder(preseason_vs_regular_season(season).first)
  end

  def biggest_surprise(season)
    team_name_finder(preseason_vs_regular_season(season).last)
  end

  def winningest_coach(season)
    coach_win_percentage(season).last[0]
  end

  def worst_coach(season)
    coach_win_percentage(season).first[0]
  end

  def most_accurate_team(season)
    team_name_finder(accuracy_percentage(season).last)
  end

  def least_accurate_team(season)
    team_name_finder(accuracy_percentage(season).first)
  end

  def most_hits(season)
    team_name_finder(hits_data(season).last)
  end

  def least_hits(season)
    team_name_finder(hits_data(season).first)
  end

  def power_play_goal_percentage(season)
    power_play_goal_data(season)
  end
end
