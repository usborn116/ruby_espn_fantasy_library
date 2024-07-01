Gem::Specification.new do |s|
    s.name        = "espn_nba_fantasy"
    s.version     = "1.0.2"
    s.summary     = "Get info from your ESPN NBA Fantasy League as JSON data"
    s.description = "A way to get your league, team, and player information from your ESPN NBA Fantasy League"
    s.authors     = ["Usborn Ocampo"]
    s.email       = "usborn116@gmail.com"
    s.files       = ["lib/espn_nba_fantasy.rb", "lib/espn_nba_fantasy/league.rb", 
        "lib/espn_nba_fantasy/team.rb", "lib/espn_nba_fantasy/player.rb", "lib/espn_nba_fantasy/constants.rb",
        "lib/espn_nba_fantasy/calculate_stats.rb", "lib/espn_nba_fantasy/player_finder.rb", "lib/espn_nba_fantasy/user.rb"]
    s.homepage    =
      "https://rubygems.org/gems/espn_nba_fantasy"
    s.license       = "MIT"
    s.add_development_dependency "rspec", ">= 3.12.0"
    s.add_development_dependency "rest-client"
    s.add_development_dependency "json"
    s.add_runtime_dependency 'rest-client'
    s.add_runtime_dependency 'json'
    s.required_ruby_version = '>= 2.7.0'
  end