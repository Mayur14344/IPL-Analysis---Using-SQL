create database ipl_stats;
use ipl_stats;

create table ipl (
    team1  varchar(100),
    team2  varchar(100),
    match_date date,
    toss_winner varchar(100),
    toss_decision varchar(20),
    winner varchar(100),
    player_of_match varchar(100),
    venue varchar(200),
    city varchar(100),
    team1_players text,
    team2_players text,
    season int,
    match_number int,
    match_type varchar(50),
    result varchar(50),
    result_margin decimal(5,2),
    target_runs int,
    target_overs decimal(4,1),
    super_over varchar(10)
);



select * from ipl;

# Team Analysis :

#Teams Played Total Matches
select COUNT(*) as total_matches
from ipl;

#Most win by Each Team
select winner, COUNT(*) AS wins
from ipl
where winner is not null
group by winner
order by wins desc;

#most matches played in Each venues
select venue, COUNT(*) as matches
from ipl
group by venue
order by matches desc;


#Highest Matches win by Team 
select winner, COUNT(*) as total_wins
from ipl
group by winner
order by total_wins desc
limit 1;

#highest total runs scored by a team
select winner as team, MAX(target_runs) as highest_runs
from ipl
group by winner
order by highest_runs desc
limit 1;

#Matches Won Batting First vs field first
SELECT toss_decision, COUNT(*) AS wins
FROM ipl
WHERE winner = toss_winner
GROUP BY toss_decision;


# Player Anyalsis :


#Most Player of the Match Awards
select player_of_match, COUNT(*) as awards
from ipl
group by player_of_match
order by awards desc;

#Top 5 players with most player of the match awards
select player_of_match, COUNT(*) as awards
from ipl
group by player_of_match
order by awards desc
limit 5;

#Most Player of the Match awards won in a single season by player
select season, player_of_match, COUNT(*) AS awards
from ipl
group by season, player_of_match
order by awards desc
limit 1;

#Matches played where a player won Player of the Match
select match_number, season, venue
from ipl
where player_of_match = 'ms dhoni';


#venue/team/player combine anaylsis

#Most Player of the Match Awards won by Venue 
select venue, player_of_match, COUNT(*) as awards
from ipl
group by venue, player_of_match;

#Match Victories per Team at Each Stadium
select venue, winner, COUNT(*) as wins
from ipl
group by venue, winner
order by wins desc;

#super over 
select match_number, season, team1, team2, winner
from ipl
where super_over = 'N';

#CTE
#pom(player of match)

#Top 10 players with most player of the match awards
with pom_count as (
    select
        player_of_match,
        COUNT(*) as awards
    from ipl
    where player_of_match is not null
    group by  player_of_match
)
select *
from pom_count
order by awards desc
limit 10;
