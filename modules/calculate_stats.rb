module CalculateStats

  def add_calculated_stats(stats)
    stats['AFG%'] = (stats['3PTM']*0.5+stats['FGM'])/(stats['FGA'])
    stats['A/TO'] = stats['AST']/(stats['TO'])
    stats['FT%'] = stats['FTM']/(stats['FTA'])
    stats
  end

end