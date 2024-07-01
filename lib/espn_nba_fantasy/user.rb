module ESPNNBAFantasy
  class User

    attr_accessor :display_name, :first_name, :last_name, :fantasy_id,
                  :teams, :league, :add_team

    #basic initialization with the various attributes

    def initialize(obj, league)
      @display_name = obj['displayName']
      @first_name = obj['firstName']
      @last_name = obj['lastName']
      @fantasy_id = obj['id']
      @teams = []
      @league = league
    end

    #method that lets you input who you're trading (Array of names), who you're receiving (Array of names),
    #and what team you're trading with (String). 

    #returns data including the players trading away and receiving, your stats before and after the trade, and your 
    #change in stats for each category

    def to_s
      "User Name: #{first_name} #{last_name} | Teams: #{teams.map(&:name)}"
    end

    def add_team(team)
      @teams << team
    end

  end
end