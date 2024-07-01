#finds player given the roster (as "arr") and name (as "matcher")

module PlayerFinder

  def find_players(arr, matcher)
    arr.select{|p| p.full_name.downcase == matcher.downcase}.first
  end
  
end