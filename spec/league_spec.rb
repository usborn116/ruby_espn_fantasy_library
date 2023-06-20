require 'rest-client'
require_relative '../league'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

describe League do

  before do
    @league = League.new(780758162, 2023, s2, sw)
  end

  describe "#initialize" do
    it "creates a league" do
      expect(@league).to be_a League
    end
    it "has teams" do
      expect(@league.teams).to be_a Array
    end

    it "has league stats" do
      expect(@league.stat_data).to be_a Object
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
    it "creates a league" do
      expect(@league).to be_a League
    end
    it "has teams" do
      expect(@league.teams).to be_a Array
    end

    it "has league stats" do
      expect(@league.stat_data).to be_a Object
    end
  end

end