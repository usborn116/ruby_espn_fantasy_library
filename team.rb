require 'rest-client'
require 'json'
require_relative 'constants'
require_relative 'player'

class Team

  attr_accessor :roster, :name, :teamstats

  def initialize(obj)
    @name = obj['name']
    @roster = roster_maker(obj)
    @teamstats = make_team_stats
  end

  def to_s
    "Team Name: #{name} | Roster: #{roster_names}"
  end

  private

  def roster_maker(obj)
    obj['roster']['entries'].map do |e| 
      player = e['playerPoolEntry']['player']
      Player.new(player)
    end
  end

  def roster_names
    roster.map{|player| player.name}
  end

  def make_team_stats
    stats = {}
    roster.each do |player|
      player.stats.each do |stat, value|
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