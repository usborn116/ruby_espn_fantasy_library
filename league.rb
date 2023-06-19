require 'rest-client'
require 'json'
require_relative 'constants'
require_relative 'team'

class League

  attr_accessor :teams, :stat_data

  def initialize
    @uri = "https://fantasy.espn.com/apis/v3/games/fba/seasons/2023/segments/0/leagues/780758162?view=mTeam&view=mRoster&view=mMatchup&view=mSettings&view=mStandings"
    @cookies = {'espn_s2': 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D',
        'SWID': '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'
    }
    @data = JSON.parse(RestClient.get(@uri, {:cookies => @cookies}))
    @teams = make_team_objects
    @stat_data = make_stat_data
  end

  def team_list
    @teams.map{|r| [r['name'], r['id']]}
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