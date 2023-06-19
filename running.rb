require_relative 'league'

league = League.new
team = league.teams[5]
teamstats = team.teamstats
roster = team.roster
roster_names = league.teams[5]
player = roster[0]
data = league.stat_data

print(teamstats, roster_names, player, data)