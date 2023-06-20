require 'rest-client'
require 'json'
require_relative 'constants'

class Player

  attr_reader :name, :position, :stats

  def initialize(player, team)
    @name = player['fullName']
    @position = POSITION_MAP[player['defaultPositionId']-1]
    @stats = stat_card_maker(player)
    @team = team
  end

  def to_s 
    "Player: #{name} | Position: #{position} | Stats: #{stats}"
  end

  private

  def stat_card_maker(player)
    avgstats = player['stats'].first['averageStats']
    statcard = avgstats ? avgstats.transform_keys!{ |k| STATS_MAP[k] }.slice(*STATS) : EMPTY_STATS
    add_calculated_stats(statcard)
    statcard
  end

  def add_calculated_stats(s)
    s['FGA'] = s['FGA'] + 0.0001
    s['TO'] = s['TO'] + 0.00001
    s['FTA'] = s['FTA'] + 0.00001
    s['AFG%'] = (s['3PTM']*0.5+s['FGM'])/(s['FGA'])
    s['A/TO'] = s['AST']/(s['TO'])
    s['FT%'] = s['FTM']/(s['FTA'])
    s
  end

end