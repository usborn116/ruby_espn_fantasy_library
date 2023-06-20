require_relative 'constants'
require './modules/calculate_stats'

class Player

  include CalculateStats

  attr_reader :name, :position, :stats

  def initialize(player, team)
    @name = player['fullName']
    @position = POSITION_MAP[player['defaultPositionId']-1]
    @stats = stat_card_maker(player)
    @team = team
  end

  private

  def to_s 
    "Player: #{name} | Position: #{position} | Stats: #{stats}"
  end

  def stat_card_maker(player)
    avgstats = player['stats'].first['averageStats']
    statcard = avgstats ? avgstats.transform_keys!{ |k| STATS_MAP[k] }.slice(*STATS) : EMPTY_STATS
    calculate_stats(statcard)
  end

  def calculate_stats(s)
    s['FGA'] = s['FGA'] + 0.0001
    s['TO'] = s['TO'] + 0.00001
    s['FTA'] = s['FTA'] + 0.00001
    add_calculated_stats(s)
  end

end