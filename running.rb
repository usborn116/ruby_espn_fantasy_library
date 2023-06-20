require_relative 'league'

s2 = 'AEBZYDetmiWDzCsv91y%2B2bmAqE7WWTx2uT8JhJOE7pLZMjjQLcEt7DrPCRAqVyq0fiMyckLFBdJC1uID0R37CIaMmkghHDG62VAYnNAf7kVimrJfpf4KFUDm97dHy1NUa2TstxStusNhXVIbZbnVuuuKCRbdbQBDNyVRk9AW6Z0I%2FZIIwOFmStwPerqIiDejDTib94305LWGdRW7CLTcZwcmqtxGvOcq7hGOqYi26CdIPtzNSyEVfwlpdNg0dQuMyYzO%2Fw4w6h%2Fuh2OVah59Rw5DVajg%2FDvGZX9xNTiXTTdCow%3D%3D'
sw = '{817F7C41-C9C5-43F7-BF7C-41C9C5F3F7EB}'

league = League.new(780758162, 2023, s2, sw)
team = league.teams[5]
#teamstats = team.teamstats
#roster = team.roster
#roster_names = league.teams[5]
#player = roster[0]
#data = league.stat_data

#print(league.findplayer('SGA Holessss', 'lebron jamesss'))
print(team.trade_players(['LeBron James'], ['Anthony Davis'], 'Cobra Kai'))