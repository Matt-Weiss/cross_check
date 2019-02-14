class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :give_aways,
              :take_aways

  def initialize(rows)
    @game_id = rows["game_id"]
    @team_id = rows["team_id"]
    @hoa = rows["HoA"]
    @won = rows["won"]
    @settled_in = rows["settled_in"]
    @head_coach = rows["head_coach"]
    @goals = rows["goals"].to_i
    @shots = rows["shots"].to_i
    @hits = rows["hits"].to_i
    @pim = rows["pim"].to_i
    @power_play_opportunities = rows["powerPlayOpportunities"].to_i
    @power_play_goals = rows["powerPlayGoals"].to_i
    @face_off_win_percentage = rows["faceOffWinPercentage"].to_f.round(1)
    @give_aways = rows["giveaways"].to_i
    @take_aways = rows["takeaways"].to_i
  end
end
