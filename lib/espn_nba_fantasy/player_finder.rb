module PlayerFinder

  def find_players(arr, matcher)
    arr.select{|p| p.name.downcase == matcher.downcase}.first
  end
  
end