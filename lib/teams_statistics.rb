
module TeamStats
  def favorite_opponent(team_name)
    arr = []
    hash = {}
    teams.group_by do |row|
    hash[row.team_id] = Array.new[row.team_name]
    row.team_name
    hash.each do |key, value|
      binding.pry

    end
  end

  def rival

  end

  def biggest_team_blowout

  end

  def worst_loss
    arr = []
    hash = {}
    games.group_by do |game|
      if game.away_goals > game.home_goals
        gameg = Array.new [game.away_goals - game.home_goals]
        hash[game.game_id] = gameg
      else
        gameg = Array.new [game.home_goals - game.away_goals]
        hash[game.game_id] = gameg
      end
      #binding.pry
      game.game_id
    end
      hash.group_by do |key, value|
        arr << value
        #binding.pry
      end
       nimb = arr.max
       return nimb



  end
end
