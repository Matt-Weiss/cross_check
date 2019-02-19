module TeamStats

  def team_info(team_id)
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



end
