require 'pry'
module LeagueAndSeason

  def count_of_teams
    teams.count
  end

  def worst_offense

    goals_by_id = Hash.new{|row, key| row[key] = []}
    game_teams.each do |row|
      goals_by_id[game.team_id] << game.goals
      binding.pry
      end
    end







end
