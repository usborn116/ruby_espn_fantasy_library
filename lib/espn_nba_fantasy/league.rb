require 'rest-client'
require 'json'
require_relative 'constants'
require_relative 'team'
require_relative 'player_finder'

module ESPNNBAFantasy
  class League

    include PlayerFinder

    attr_accessor :teams, :stat_data

    #initializes the league

    def initialize(league_id, year, s2, sw)
      @league_id = league_id

      @uri = "https://lm-api-reads.fantasy.espn.com/apis/v3/games/fba/seasons/#{year}/segments/0/leagues/#{league_id}?view=mRoster&view=mSettings&view=mTeam&view=modular&view=mNav"
      @cookies = {'espn_s2': "#{s2}", 'SWID': "#{sw}"}
      @data = JSON.parse(RestClient.get(@uri, {cookies: @cookies}))
      @teams = make_team_objects
      @stat_data = make_stat_data
    end

    def to_s
      "League #{@league_id}"
    end

    #gives you an array of each team's name and id in the league

    def team_list
      @teams.map{|r| [r.name, r.team_id]}
    end

    #pull up a Player object based on their name and their team

    def findplayer(team_name, str)
      team = teams.select{|t| t.name == team_name}.first
      return "No team named #{team_name}" unless team

      find_players(team.players, str) || "#{str} cannot be found in #{team_name}'s roster"
    end

    private

    def make_team_objects
      @data['teams'].map{|team| Team.new(team, self)}
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
end