require 'rest-client'
require_relative '../lib/espn_nba_fantasy.rb'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

describe Player do

  before do
    @league = League.new(780758162, 2023, s2, sw)
    @team = @league.teams[5]
    @player = @team.players[0]
  end

  describe "#initialize" do

    it "has a name" do
      expect(@player.name).to eql("Shai Gilgeous-Alexander")
    end

    it "has an id" do
        expect(@player.player_id).to be_a Integer
      end

    it "has a position" do
      expect(@player.position).to be_a String
    end

    it "has stats" do
      expect(@player.stats.keys()).to eql(['PTS','BLK','STL','AST','OREB','DREB','TO','FGM','FTM','3PTM', 'FGA', '3PTA', 'FTA', 'AFG%', 'A/TO', 'FT%'])
    end

    it "attached to a team" do
      expect(@player.team).to eql(@team)
    end

  end

end