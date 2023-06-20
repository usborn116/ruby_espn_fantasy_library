require 'rest-client'
require 'json'
require_relative 'constants'
require_relative 'player'

class Team

  attr_accessor :roster, :name, :teamstats, :league

  def initialize(obj, league)
    @name = obj['name']
    @roster = roster_maker(obj)
    @teamstats = make_team_stats(@roster)
    @league = league
  end

  def to_s
    "Team Name: #{name} | Roster: #{roster_names}"
  end

  def trade_players(to_trade = [], to_receive = [], other_team_name)
    other_team = league.teams.select{|team| team.name == other_team_name}.first
    return "No team named #{other_team_name}" unless other_team
    own_players = to_trade.map{|player| roster.select{|p| p.name.downcase == player.downcase}.first}
    other_players = to_receive.map{|player| other_team.roster.select{|p| p.name.downcase == player.downcase}.first}
    return "This trade included players not one of the specified teams" if (own_players.include?(nil)|| other_players.include?(nil))
    print "Player Trading: #{own_players.map{|p| p.name}.join(', ')}\n\n"
    print "Player Getting: #{other_players.map{|p| p.name}.join(', ')}\n\n"
    new_team_stats(own_players, other_players)
  end

  private

  def stat_differences(old, new)
    new.map do |stat, val|
      [stat, val - old[stat]]
    end.to_h
  end

  def new_team_stats(own, others)
    new_ros = roster.dup
    others.each{|other| new_ros << other}
    own.each do |own|
      i = new_ros.index(own)
      new_ros.delete_at(i)
    end
    newstats = make_team_stats(new_ros)
    "Stats before trade: #{teamstats}\n\nStats after trade: #{newstats}\n\nDifference: #{stat_differences(teamstats, newstats)}"
  end

  def roster_maker(obj)
    obj['roster']['entries'].map do |e| 
      player = e['playerPoolEntry']['player']
      Player.new(player, self)
    end
  end

  def roster_names
    roster.map{|player| player.name}
  end

  def make_team_stats(ros)
    stats = {}
    ros.each do |player|
      player&.stats.each do |stat, value|
        stats[stat] ? stats[stat] += value : stats[stat] = value
      end
    end
    calculate_team_stats(stats)
    stats
  end

  def calculate_team_stats(s)
    s['AFG%'] = (s['3PTM']*0.5+s['FGM'])/(s['FGA'])
    s['A/TO'] = s['AST']/(s['TO'])
    s['FT%'] = s['FTM']/(s['FTA'])
    s
  end

end