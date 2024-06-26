require 'rest-client'
require_relative '../lib/espn_nba_fantasy.rb'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

describe ESPNNBAFantasy::League do

  before do
    @league = ESPNNBAFantasy::League.new(780758162, 2023, s2, sw)
  end

  describe "#initialize" do
    it "creates a league" do
      expect(@league).to be_a ESPNNBAFantasy::League
      expect(@league.to_s).to eq('League 780758162')
    end

    it "has teams" do
      expect(@league.teams).to be_a Array
    end

    it "has league stats" do
      expect(@league.stat_data.keys().first).to eql("PTS Average")
      expect(@league.stat_data.keys().last).to eql("FT% Standard Deviation")
    end
  end

  describe "#team_list" do

    it "generates a list" do
      expect(@league.team_list).to be_a Array
    end

    it "each team has a name and id" do
      expect(@league.team_list).to be_a Array
      expect(@league.team_list.first[0]).to be_a String
      expect(@league.team_list.first[1]).to be_a Integer
    end

  end

  describe "#find_player" do
    it "returns error if team does not exist" do
      expect(@league.findplayer('SGA holz', 'Kris Dunn')).to eql('No team named SGA holz')
    end
    it "returns error if player is not in roster" do
      expect(@league.findplayer('SGA Holes', 'Kris Dunnz')).to eql("Kris Dunnz cannot be found in SGA Holes's roster")
    end

    it "returns a player" do
      expect(@league.findplayer('SGA Holes', 'Kris Dunn')).to be_a ESPNNBAFantasy::Player
    end
  end

  
end