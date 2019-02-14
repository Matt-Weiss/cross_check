class Game
  attr_reader :game_id

  def initialize(row)
    @game_id = row["game_id"]
  end


end
