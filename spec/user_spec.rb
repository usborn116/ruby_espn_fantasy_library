require 'rest-client'
require_relative '../lib/espn_nba_fantasy.rb'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

describe ESPNNBAFantasy::User do

  before do
    @league = ESPNNBAFantasy::League.new(780758162, 2024, s2, sw)
    @user = @league.users[0]
  end

  describe "#initialize" do

    it "has all attributes" do
      expect(@user.display_name).to eql("Dippy Bupkins")
      expect(@user.first_name).to eql("Jaken")
      expect(@user.last_name).to eql("Garcia")
      expect(@user.fantasy_id).to match(/\{.*-.*-.*-.*-.*\}/)
      expect(@user.teams).to be_a Array
    end

  end

  describe "#add_team" do

    it "can add teams" do
      expect(@user.teams.length).to eql(0)
      @user.add_team('test')
      expect(@user.teams.length).to eql(1)
    end

  end

end