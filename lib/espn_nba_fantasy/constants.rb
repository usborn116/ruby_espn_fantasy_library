#these are some of the constants necessary to map ids from the ESPN Fantasy Library to, 
#so that things like position, stat name, etc are readable!

module ESPNNBAFantasy
    
    POSITION_MAP = ['PG', 'SG', 'SF', 'PF', 'C', 'G', 'F', 'SG/SF', 'G/F', 'PF/C', 'F/C', 'UT', 'BE', 'IR', '', 'Rookie']

    PRO_TEAM_MAP = ['FA', 'ATL','BOS','NOP','CHI','CLE','DAL','DEN','DET','GSW','HOU','IND',
        'LAC','LAL','MIA','MIL','MIN','BKN','NYK','ORL','PHL','PHO','POR','SAC','SAS','OKC',
        'UTA','WAS','TOR','MEM','CHA']

    STATS_MAP = {
        '0' => 'PTS',
        '1' => 'BLK',
        '2' => 'STL',
        '3' => 'AST',
        '4' => 'OREB',
        '5' => 'DREB',
        '6' => 'REB',
        '7'=> '7',
        '8'=> '8',
        '9'=> 'PF',
        '10'=> '10',
        '11'=> 'TO',
        '12'=> '12',
        '13'=> 'FGM',
        '14'=> 'FGA',
        '15'=> 'FTM',
        '16'=> 'FTA',
        '17'=> '3PTM',
        '18'=> '3PTA',
        '19'=> 'FG%',
        '20'=> 'FT%',
        '21'=> '3PT%',
        '22'=> '22',
        '23'=> '23',
        '24'=> '24',
        '25'=> '25',
        '26'=> '26',
        '27'=> '27',
        '28'=> 'MPG',
        '29'=> '29',
        '30'=> '30',
        '31'=> '31',
        '32'=> '32',
        '33'=> '33',
        '34'=> '34',
        '35'=> '35',
        '36'=> '36',
        '37'=> '37',
        '38'=> '38',
        '39'=> '39',
        '40'=> 'MIN',
        '41'=> 'GS',
        '42'=> 'GP',
        '43'=> '43',
        '44'=> '44',
        '45'=> '45',
        }

    STAT_ID_MAP = {
        '00': 'total',
        '10': 'projected',
        '01': 'last_7',
        '02': 'last_15',
        '03': 'last_30'
    }

    ACTIVITY_MAP = {
        178 => 'FA ADDED',
        180 => 'WAIVER ADDED',
        179 => 'DROPPED',
        181 => 'DROPPED',
        239 => 'DROPPED',
        244 => 'TRADED',
        'FA': 178,
        'WAIVER': 180,
        'TRADED': 244
    }

    NINE_CAT_STATS = [
        '3PTM',
        'AST',
        'BLK',
        'FG%',
        'FT%',
        'PTS',
        'REB',
        'STL',
        'TO'
    ]

    STATS = ['PTS','BLK','STL','AST','OREB','DREB','TO','FGM','FTM','3PTM', 'FGA', '3PTA', 'FTA']

    EMPTY_STATS = {'PTS'=>0,'BLK'=>0,'STL'=>0,'AST'=>0,'OREB'=>0,'DREB'=>0,'TO'=>0,'FGM'=>0,'FTM'=>0,'3PTM'=>0, 'FGA'=>0, '3PTA'=>0, 'FTA'=>0}

end