require_relative 'constants'
require_relative 'calculate_stats'

module ESPNNBAFantasy
  class Player

    include CalculateStats

    attr_reader :name, :player_id, :position, :stats, :team

    #basic initialization with attributes

    def initialize(player, team)
      @name = player['fullName']
      @player_id = player['id']
      @position = ESPNNBAFantasy::POSITION_MAP[player['defaultPositionId']-1]
      @stats = stat_card_maker(player)
      @team = team
    end

    def to_s 
      "Player: #{name} | Position: #{position} | Stats: #{stats}"
    end

    private

    def stat_card_maker(player)
      avgstats = player['stats'].first['averageStats']
      statcard = avgstats ? avgstats.transform_keys!{ |k| ESPNNBAFantasy::STATS_MAP[k] }.slice(*ESPNNBAFantasy::STATS) : ESPNNBAFantasy::EMPTY_STATS
      calculate_stats(statcard)
    end

    def calculate_stats(s)
      s['FGA'] = s['FGA'] + 0.0001
      s['TO'] = s['TO'] + 0.00001
      s['FTA'] = s['FTA'] + 0.00001
      add_calculated_stats(s)
    end

  end
end