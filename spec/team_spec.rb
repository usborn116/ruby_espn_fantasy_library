require 'rest-client'
require_relative '../lib/espn_nba_fantasy.rb'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

describe Team do

  before do
    @league = League.new(780758162, 2023, s2, sw)
    @team = @league.teams[5]
  end

  describe "#initialize" do

    it "has a name" do
      puts 'TEAM'
      puts @team
      expect(@team.name).to eql("SGA Holes")
    end

    it "has an id" do
      expect(@team.team_id).to be_a Integer
    end

    it "has players" do
      expect(@team.players).to be_a Array
      expect(@team.players.first).to be_a Player
    end

    it "has a roster name" do
      expect(@team.roster).to be_a Array
      expect(@team.roster.first).to be_a String
    end

    it "has team stats" do
      expect(@team.teamstats.keys()).to eql(['PTS','BLK','STL','AST','OREB','DREB','TO','FGM','FTM','3PTM', 'FGA', '3PTA', 'FTA', 'AFG%', 'A/TO', 'FT%'])
    end

    it "attached to a league" do
      expect(@team.league).to eql(@league)
    end

  end

  describe "#trade_players" do

    before do
      @other = 'Cobra Kai'
      @to_trade = ['Kris Dunn', 'James Bouknight']
      @to_receive = ['Anthony Davis', 'James Harden']
      @result = @team.trade_players(@to_trade, @to_receive, @other)
    end

    it "returns players traded" do
      expect(@result['Trading:']).to be_a Array
    end

    it "returns players received" do
      expect(@result['Receiving:']).to be_a Array
    end

    it "returns your teamstats" do
      expect(@result['Before:']).to eql(@team.teamstats)
    end

    it "returns new stats" do
      expect(@result['After:'].keys()).to eql(['PTS','BLK','STL','AST','OREB','DREB','TO','FGM','FTM','3PTM', 'FGA', '3PTA', 'FTA', 'AFG%', 'A/TO', 'FT%'])
    end

    it "returns stat differences" do
      expect(@result['Changes:'].keys()).to eql(['PTS','BLK','STL','AST','OREB','DREB','TO','FGM','FTM','3PTM', 'FGA', '3PTA', 'FTA', 'AFG%', 'A/TO', 'FT%'])
    end

  end

    describe "#trade_players errors" do

      before do
        @other = 'Cobra Kai'
        @other_bad = 'Cobra Kaiz'
        @to_trade = ['Kris Dunn', 'James Bouknight']
        @to_trade_bad = ['Kris Dunn', 'James Bouknightz']
        @to_receive = ['Anthony Davis', 'James Harden']
        @result_bad_team = @team.trade_players(@to_trade, @to_receive, @other_bad)
        @result_bad_player = @team.trade_players(@to_trade_bad, @to_receive, @other)
      end
  
      it "returns error if no team" do
        expect(@result_bad_team).to eql("No team named Cobra Kaiz")
      end

      it "returns error if no player" do
        expect(@result_bad_player).to eql("This trade included players not one of the specified teams")
      end
  
  end

end