require 'csv'

class Teams
  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link
  def initialize(row)
    @team_id = row["team_id"]
    @franchise_id = row["franchiseId"]
    @short_name = row["shortName"]
    @team_name = row["teamName"]
    @abbreviation = row["abbreviation"]
    @link = row["link"]
  end

end
