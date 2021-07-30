select away_tbl.*, home_tbl.PA_Home, home_tbl.AB_Home, home_tbl.H_Home, home_tbl.singles_Home, home_tbl.doubles_Home, 
home_tbl.triples_Home, home_tbl.HR_Home, home_tbl.BB_Home, home_tbl.SO_Home, home_tbl.HBP_Home, home_tbl.SF_Home,
lefty_tbl.PA_L, lefty_tbl.AB_L, lefty_tbl.H_L, lefty_tbl.singles_L, lefty_tbl.doubles_L, 
lefty_tbl.triples_L, lefty_tbl.HR_L, lefty_tbl.BB_L, lefty_tbl.SO_L, lefty_tbl.HBP_L, lefty_tbl.SF_L,
righty_tbl.PA_R, righty_tbl.AB_R, righty_tbl.H_R, righty_tbl.singles_R, righty_tbl.doubles_R, 
righty_tbl.triples_R, righty_tbl.HR_R, righty_tbl.BB_R, righty_tbl.SO_R, righty_tbl.HBP_R, righty_tbl.SF_R,
running_tbl.SB, running_tbl.CS, advanced_tbl.`wrC+`, advanced_tbl.BsR, advanced_tbl.`Off`, advanced_tbl.Def 

from

(
select lhh_away.Season, lhh_away.Name, lhh_away.playerId, lhh_away.Tm, 'S' as Bats, (lhh_away.PA + rhh_away.PA) as PA_Away,
(lhh_away.AB + rhh_away.AB) as AB_Away, (lhh_away.H + rhh_away.H) as H_Away, (lhh_away.`1B` + rhh_away.`1B`) as singles_Away, 
(lhh_away.`2B` + rhh_away.`2B`) as doubles_Away, (lhh_away.`3B` + rhh_away.`3B`) as triples_Away, (lhh_away.HR + rhh_away.HR) as HR_Away, 
(lhh_away.BB + rhh_away.BB) as BB_Away, (lhh_away.SO + rhh_away.SO) as SO_Away,(lhh_away.HBP + rhh_away.HBP) as HBP_Away, (lhh_away.SF + rhh_away.SF) as SF_Away
from `splits leaderboard data as lhh away` lhh_away
left join `splits leaderboard data as rhh away` rhh_away on (lhh_away.Season = rhh_away.Season and lhh_away.playerId = rhh_away.playerId)
where not isnull(lhh_away.playerId) and not isnull(rhh_away.playerId)
and (select sum(PA) from `splits leaderboard data as lhh away` group by playerId having playerId = lhh_away.playerId) >= 5
and (select sum(PA) from `splits leaderboard data as rhh away` group by playerId having playerId = rhh_away.playerId) >= 5

union

select lhh_away.Season, lhh_away.Name, lhh_away.playerId, lhh_away.Tm, 'L' as Bats, lhh_away.PA as PA_Away,
lhh_away.AB as AB_Away, lhh_away.H as H_Away, lhh_away.`1B` as singles_Away, lhh_away.`2B` as doubles_Away, 
lhh_away.`3B` as triples_Away, lhh_away.HR as HR_Away, lhh_away.BB as BB_Away, lhh_away.SO as SO_Away,
lhh_away.HBP as HBP_Away, lhh_away.SF as SF_Away
from `splits leaderboard data as lhh away` lhh_away
where (select sum(PA) from `splits leaderboard data as lhh away` group by playerId having playerId = lhh_away.playerId) >= 5
and ((select sum(PA) from `splits leaderboard data as rhh away` group by playerId having playerId = lhh_away.playerId) < 5
     or lhh_away.playerId not in (select playerId from `splits leaderboard data as rhh away`))

union

select rhh_away.Season, rhh_away.Name, rhh_away.playerId, rhh_away.Tm, 'R' as Bats, rhh_away.PA as PA_Away,
rhh_away.AB as AB_Away, rhh_away.H as H_Away, rhh_away.`1B` as singles_Away, rhh_away.`2B` as doubles_Away, 
rhh_away.`3B` as triples_Away, rhh_away.HR as HR_Away, rhh_away.BB as BB_Away, rhh_away.SO as SO_Away,
rhh_away.HBP as HBP_Away, rhh_away.SF as SF_Away
from `splits leaderboard data as rhh away` rhh_away
where ((select sum(PA) from `splits leaderboard data as lhh away` group by playerId having playerId = rhh_away.playerId) < 5
       or rhh_away.playerId not in (select playerId from `splits leaderboard data as lhh away`))
and (select sum(PA) from `splits leaderboard data as rhh away` group by playerId having playerId = rhh_away.playerId) >= 5
) away_tbl

left outer join 

(
select lhh_home.Season, lhh_home.Name, lhh_home.playerId, lhh_home.Tm, 'S' as Bats, (lhh_home.PA + rhh_home.PA) as PA_Home,
(lhh_home.AB + rhh_home.AB) as AB_Home, (lhh_home.H + rhh_home.H) as H_Home, (lhh_home.`1B` + rhh_home.`1B`) as singles_Home, 
(lhh_home.`2B` + rhh_home.`2B`) as doubles_Home, (lhh_home.`3B` + rhh_home.`3B`) as triples_home, (lhh_home.HR + rhh_home.HR) as HR_Home, 
(lhh_home.BB + rhh_home.BB) as BB_Home, (lhh_home.SO + rhh_home.SO) as SO_Home,(lhh_home.HBP + rhh_home.HBP) as HBP_Home, (lhh_home.SF + rhh_home.SF) as SF_Home
from `splits leaderboard data as lhh home` lhh_home
left join `splits leaderboard data as rhh home` rhh_home on (lhh_home.Season = rhh_home.Season and lhh_home.playerId = rhh_home.playerId)
where not isnull(lhh_home.playerId) and not isnull(rhh_home.playerId)
and (select sum(PA) from `splits leaderboard data as lhh home` group by playerId having playerId = lhh_home.playerId) >= 5
and (select sum(PA) from `splits leaderboard data as rhh home` group by playerId having playerId = rhh_home.playerId) >= 5

union

select lhh_home.Season, lhh_home.Name, lhh_home.playerId, lhh_home.Tm, 'L' as Bats, lhh_home.PA as PA_Home,
lhh_home.AB as AB_Home, lhh_home.H as H_home, lhh_home.`1B` as singles_Home, lhh_home.`2B` as doubles_Home, 
lhh_home.`3B` as triples_Home, lhh_home.HR as HR_Home, lhh_home.BB as BB_Home, lhh_home.SO as SO_Home,
lhh_home.HBP as HBP_Home, lhh_home.SF as SF_Home
from `splits leaderboard data as lhh home` lhh_home
where (select sum(PA) from `splits leaderboard data as lhh home` group by playerId having playerId = lhh_home.playerId) >= 5
and ((select sum(PA) from `splits leaderboard data as rhh home` group by playerId having playerId = lhh_home.playerId) < 5
     or lhh_home.playerId not in (select playerId from `splits leaderboard data as rhh home`))

union

select rhh_home.Season, rhh_home.Name, rhh_home.playerId, rhh_home.Tm, 'R' as Bats, rhh_home.PA as PA_Home,
rhh_home.AB as AB_Home, rhh_home.H as H_Home, rhh_home.`1B` as singles_Home, rhh_home.`2B` as doubles_Home, 
rhh_home.`3B` as triples_Home, rhh_home.HR as HR_Home, rhh_home.BB as BB_Home, rhh_home.SO as SO_Home,
rhh_home.HBP as HBP_Home, rhh_home.SF as SF_Home
from `splits leaderboard data as rhh home` rhh_home
where ((select sum(PA) from `splits leaderboard data as lhh home` group by playerId having playerId = rhh_home.playerId) < 5
       or rhh_home.playerId not in (select playerId from `splits leaderboard data as lhh home`))
and (select sum(PA) from `splits leaderboard data as rhh home` group by playerId having playerId = rhh_home.playerId) >= 5
) home_tbl

on (away_tbl.Season = home_tbl.Season and away_tbl.playerId = home_tbl.playerId) 

left outer join

(
select lhh_vs_lefty.Season, lhh_vs_lefty.Name, lhh_vs_lefty.playerId, lhh_vs_lefty.Tm, 
'L' as Bats, lhh_vs_lefty.PA as PA_L,
lhh_vs_lefty.AB as AB_L, lhh_vs_lefty.H as H_L, lhh_vs_lefty.`1B` as singles_L, lhh_vs_lefty.`2B` as doubles_L, 
lhh_vs_lefty.`3B` as triples_L, lhh_vs_lefty.HR as HR_L, lhh_vs_lefty.BB as BB_L, lhh_vs_lefty.SO as SO_L,
lhh_vs_lefty.HBP as HBP_L, lhh_vs_lefty.SF as SF_L
from `splits leaderboard data vs lhp as lhh` lhh_vs_lefty
where ((select sum(PA) from `splits leaderboard data vs lhp as rhh` group by playerId having playerId = lhh_vs_lefty.playerId) < 5
       or lhh_vs_lefty.playerId not in (select playerId from `splits leaderboard data vs lhp as rhh`))
and (select sum(PA) from `splits leaderboard data vs lhp as lhh` group by playerId having playerId = lhh_vs_lefty.playerId) >= 5

union

select rhh_vs_lefty.Season, rhh_vs_lefty.Name, rhh_vs_lefty.playerId, rhh_vs_lefty.Tm, 
case when (select sum(PA) from `splits leaderboard data vs rhp as lhh` group by playerId having playerId = rhh_vs_lefty.playerId) >= 5 then 'S' 
     else 'R' end as Bats, 
rhh_vs_lefty.PA as PA_L, rhh_vs_lefty.AB as AB_L, rhh_vs_lefty.H as H_L, rhh_vs_lefty.`1B` as singles_L, rhh_vs_lefty.`2B` as doubles_L, 
rhh_vs_lefty.`3B` as triples_L, rhh_vs_lefty.HR as HR_L, rhh_vs_lefty.BB as BB_L, rhh_vs_lefty.SO as SO_L,
rhh_vs_lefty.HBP as HBP_L, rhh_vs_lefty.SF as SF_L
from `splits leaderboard data vs lhp as rhh` rhh_vs_lefty
where (select sum(PA) from `splits leaderboard data vs lhp as rhh` group by playerId having playerId = rhh_vs_lefty.playerId) >= 5
) lefty_tbl

on (away_tbl.Season = lefty_tbl.Season and away_tbl.playerId = lefty_tbl.playerId) 

left outer join 

(
select lhh_vs_righty.Season, lhh_vs_righty.Name, lhh_vs_righty.playerId, lhh_vs_righty.Tm, 
case when (select sum(PA) from `splits leaderboard data vs lhp as rhh` group by playerId having playerId = lhh_vs_righty.playerId) >= 5 then 'S' 
     else 'L' end as Bats, 
lhh_vs_righty.PA as PA_R, lhh_vs_righty.AB as AB_R, lhh_vs_righty.H as H_R, lhh_vs_righty.`1B` as singles_R, lhh_vs_righty.`2B` as doubles_R, 
lhh_vs_righty.`3B` as triples_R, lhh_vs_righty.HR as HR_R, lhh_vs_righty.BB as BB_R, lhh_vs_righty.SO as SO_R,
lhh_vs_righty.HBP as HBP_R, lhh_vs_righty.SF as SF_R
from `splits leaderboard data vs rhp as lhh` lhh_vs_righty
where (select sum(PA) from `splits leaderboard data vs rhp as lhh` group by playerId having playerId = lhh_vs_righty.playerId) >= 5

union

select rhh_vs_righty.Season, rhh_vs_righty.Name, rhh_vs_righty.playerId, rhh_vs_righty.Tm, 'R' as Bats,
rhh_vs_righty.PA as PA_R, rhh_vs_righty.AB as AB_R, rhh_vs_righty.H as H_R, rhh_vs_righty.`1B` as singles_R, rhh_vs_righty.`2B` as doubles_R, 
rhh_vs_righty.`3B` as triples_R, rhh_vs_righty.HR as HR_R, rhh_vs_righty.BB as BB_R, rhh_vs_righty.SO as SO_R,
rhh_vs_righty.HBP as HBP_R, rhh_vs_righty.SF as SF_R
from `splits leaderboard data vs rhp as rhh` rhh_vs_righty
where ((select sum(PA) from `splits leaderboard data vs rhp as lhh` group by playerId having playerId = rhh_vs_righty.playerId) < 5
       or rhh_vs_righty.playerId not in (select playerId from `splits leaderboard data vs rhp as lhh`))
and (select sum(PA) from `splits leaderboard data vs rhp as rhh` group by playerId having playerId = rhh_vs_righty.playerId) >= 5
) righty_tbl

on (away_tbl.Season = righty_tbl.Season and away_tbl.playerId = righty_tbl.playerId)

left outer join

(
select running.Season, running.playerid, running.SB, running.CS
from `batter baserunning` running) running_tbl

on (away_tbl.Season = running_tbl.Season and away_tbl.playerId = running_tbl.playerId)

left outer join

(
select advanced.Season, advanced.playerid, advanced.`wrC+`, advanced.BsR, advanced.`Off`, advanced.Def
from `batter baserunning and advanced` advanced) advanced_tbl

on (away_tbl.Season = advanced_tbl.Season and away_tbl.playerId = advanced_tbl.playerId);