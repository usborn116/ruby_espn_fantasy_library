require 'rest-client'
require 'json'
require_relative 'constants'
require_relative 'team'

class League

  attr_accessor :teams, :stat_data

  def initialize(league_id, year, s2, sw)
    @uri = "https://fantasy.espn.com/apis/v3/games/fba/seasons/#{year}/segments/0/leagues/#{league_id}?view=mTeam&view=mRoster&view=mMatchup&view=mSettings&view=mStandings"
    @cookies = {'espn_s2': "#{s2}", 'SWID': "#{sw}"}
    @data = JSON.parse(RestClient.get(@uri, {:cookies => @cookies}))
    @teams = make_team_objects
    @stat_data = make_stat_data
  end

  def team_list
    @teams.map{|r| [r['name'], r['id']]}
  end

  def findplayer(team_name, str)
    team = teams.select{|team| team.name == team_name}.first
    return "No team named #{team_name}" unless team
    team.roster.select{|p| p.name.downcase == str.downcase}.first || "#{str} cannot be found in #{team_name}'s roster"
  end

  private

  def make_team_objects
    @data['teams'].map{|team| Team.new(team)}
  end

  def make_stat_data
    stats = {}
    teams.each do |team|
      team.teamstats.each do |stat, value|
        stats[stat] ? stats[stat] << value : stats[stat] = [value]
      end
    end
    calculate_league_stats(stats)
  end

  def calculate_league_stats(s)
    calc = {}
    s.each do |stat, values|
      avg = (values.sum/values.length).to_f
      calc["#{stat} Average"] = avg
      calc["#{stat} Standard Deviation"] = std_dev(avg, values)
    end
    calc
  end

  def std_dev(mean, values)
    sum = values.inject(0){|accum, i| accum +(i-mean)**2 }
    variance = sum/(values.length - 1).to_f
    Math.sqrt(variance)
  end
    
end