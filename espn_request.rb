require 'rest-client'
require 'json'

class League

  def initialize
    @uri = "https://fantasy.espn.com/apis/v3/games/fba/seasons/2023/segments/0/leagues/780758162?view=mTeam&view=mRoster&view=mMatchup&view=mSettings&view=mStandings"
    @cookies = {'espn_s2': 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D',
        'SWID': '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'
    }
    @data = JSON.parse(RestClient.get(@uri, {:cookies => @cookies}))
    @teams = make_team_objects

  end

  def team_list
    @data['teams'].map{|r| [r['name'], r['id']]}
  end

  private

  def make_team_objects
    @data['teams'].each{|team| Team.new(team)}
  end


  def teams
    result = @data['teams']
    result.map{|r| [r['name'], r['id']]}
  end
    
end

class Team

  def initialize(obj)
    @name = obj['name']
    @roster
  end

end

class Player
end

print(ESPNData.new.league)