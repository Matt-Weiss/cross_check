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
end
