require_relative 'constants'
require_relative 'player'
require_relative 'calculate_stats'
require_relative 'player_finder'

module ESPNNBAFantasy
  class Team

    include CalculateStats
    include PlayerFinder

    attr_accessor :roster, :players, :name, :teamstats, :league, :team_id

    #basic initialization with the various attributes

    def initialize(obj, league)
      @name = obj['name']
      @team_id = obj['id']
      @players = roster_maker(obj)
      @roster = roster_names
      @teamstats = make_team_stats(@players)
      @league = league
    end

    #method that lets you input who you're trading (Array of names), who you're receiving (Array of names),
    #and what team you're trading with (String). 

    #returns data including the players trading away and receiving, your stats before and after the trade, and your 
    #change in stats for each category

    def to_s
      "Team Name: #{name} | Roster: #{roster_names}"
    end

    def trade_players(to_trade = [], to_receive = [], other_team_name)
      other_team = league.teams.select{|team| team.name == other_team_name}.first
      return "No team named #{other_team_name}" unless other_team
      own_players = to_trade.map{|player| find_players(players, player)}
      other_players = to_receive.map{|player| find_players(other_team.players, player)}
      return "This trade included players not one of the specified teams" if (own_players.include?(nil)|| other_players.include?(nil))
      {'Trading:' => own_players.map{|p| p.name}, 
      'Receiving:' => other_players.map{|p| p.name}}.merge(new_team_stats(own_players, other_players))
      
    end

    private

    def roster_names
      players.map(&:name)
    end

    def stat_differences(old, new)
      new.map {|stat, val| [stat, val - old[stat]]}.to_h
    end

    def new_team_stats(own, others)
      new_ros = players.dup
      others.each{|other| new_ros << other}
      own.each {|p| new_ros.delete_at(new_ros.index(p))}
      newstats = make_team_stats(new_ros)
      {'Before:' => teamstats, 'After:' => newstats, 'Changes:' => stat_differences(teamstats, newstats) }
    end

    def roster_maker(obj)
      obj['roster']['entries'].map {|e| Player.new(e['playerPoolEntry']['player'], self)}
    end

    def make_team_stats(ros)
      stats = {}
      ros.each do |player|
        player.stats.each {|stat, value| stats[stat] ? stats[stat] += value : stats[stat] = value}
      end
      add_calculated_stats(stats)
    end

  end
end