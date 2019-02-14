class GameTeams
  attr_reader :game_id,
              :team_id,
              :HoA,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(rows)
    @game_id = rows["game_id"]
    @team_id = rows["team_id"]
    @HoA = rows["HoA"]
    @wom = rows["won"]
    @settled_in = rows["settled_in"]
    @head_coach = rows["head_coach"]
    @goals = rows["goals"]
    @shots = rows["shots"]
    @hits = rows["hits"]
    @pim = rows["pim"]
    @powerPlayOpportunities = rows["powerPlayOpportunities"]
    @powerPlayGoals = rows["powerPlayGoals"]
    @faceOffWinPercentage = rows["faceOffWinPercentage"]
    @giveaways = rows["giveaways"]
    @takeaways = rows["takeaways"]
  end
end
