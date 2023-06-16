require 'rest-client'
require 'json'
require_relative 'constants'

class League

  attr_accessor :teams

  def initialize
    @uri = "https://fantasy.espn.com/apis/v3/games/fba/seasons/2023/segments/0/leagues/780758162?view=mTeam&view=mRoster&view=mMatchup&view=mSettings&view=mStandings"
    @cookies = {'espn_s2': 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D',
        'SWID': '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'
    }
    @data = JSON.parse(RestClient.get(@uri, {:cookies => @cookies}))
    @teams = make_team_objects
  end

  def team_list
    @teams.map{|r| [r['name'], r['id']]}
  end

  private

  def make_team_objects
    @data['teams'].map{|team| Team.new(team)}
  end
    
end

class Team
  attr_accessor :roster, :name

  def initialize(obj)
    @name = obj['name']
    @roster = roster_maker(obj)
  end

  private

  def roster_maker(obj)
    obj['roster']['entries'].map do |e| 
      player = e['playerPoolEntry']['player']
      avgstats = player['stats'].first['averageStats']
      statcard = avgstats ? avgstats.transform_keys!{ |k| STATS_MAP[k] }.slice(*STATS) : EMPTY_STATS
      statcard = add_calculated_stats(statcard)
      { "#{player['fullName']} : #{POSITION_MAP[player['defaultPositionId']-1]}" => statcard }
    end
  end

  def add_calculated_stats(s)
    s['FGA'] = s['FGA'] + 0.0001
    s['TO'] = s['TO'] + 0.00001
    s['FTA'] = s['FTA'] + 0.00001

    s['AFG%'] = (s['3PTM']*0.5+s['FGM'])/(s['FGA'])
    s['A/TO'] = s['AST']/(s['TO'])
    s['FT%'] = s['FTM']/(s['FTA'])
    s
  end

end

class Player

  def initialize(player)
    @name = player['fullName']
    @stats = stat_card_maker
  end

  private

  def stat_card_maker
  end

end