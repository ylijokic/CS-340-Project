
--get all Team Names
SELECT `team_name` FROM `Team`

--get all Bars
SELECT * FROM `Bar`

--get all Pinball Table Names
SELECT `mach_name` FROM `Machine`

-- Add info to a new Match
INSERT INTO `Match`(`id`, `date`, `home_team`, `away_team`) 
VALUES (1,'05-26-2019', 10, 9), (2, '05-26-2020', 4, 9), (3, '05-26-2021', 6, 5);

-- Select what Team won Game and what pinball table the game was played on
SELECT `machine`, `winning_team` FROM `Game`

-- Add info to a new Game
INSERT INTO `Game`(`id`, `machine`, `winning_team`) 
VALUES (1, 2, 10);

--Add a new Team
INSERT INTO `Team`(`id`, `team_name`, `home_bar`)
VALUES (1, 'Away Team Is Lit' , 1), (2, 'Clinton Street Pub FC', 2);

--Insert a new Pinball Machine
INSERT INTO `Machine`(`id`, `mach_name`, `mach_name_short`) 
VALUES (1, 'Eight Ball Deluxe', '8BD'), (2, 'AC/DC', 'ACD'), (3, 'Attack From Mars', 'AFM');

--Update a Game to include what team won
UPDATE `Game` SET 'winning_team' = `Team`('id') WHERE `winning_team` = 1;

--Delete Teams from a Match
DELETE FROM `Match` WHERE `home_team` = 10;

--Delete a Pinaball Machine
DELETE FROM `Machine` WHERE 'mach_name_short' = '8BD';

-- machines_by_bar
SELECT Bar.id AS 'bar-id', Bar.name, Machine.id AS 'machine-id', mach_name FROM Bar 
LEFT JOIN Machine_Bar ON Bar.id = bar_id 
LEFT JOIN Machine ON machine_id = Machine.id;


-- all_teams_and_their_bars
SELECT Team.id, team_name, home_bar_id, Bar.name FROM Team
LEFT JOIN Bar ON Team.id = Bar.id


-- all_bars_with_address_&_team
SELECT Bar.id as 'bar-id', name, street_addr, city, state, team.id AS 'Team-id', team_name
FROM Bar LEFT JOIN Team ON Bar.id = Team.id;

-- a team's schedule showing both teams for each match
SELECT match_id, team_id FROM Match_Team WHERE match_id IN (
     SELECT match_id FROM Match_Team WHERE team_id = 1
     );
	

-- full_schedule_for_a_team_(team1)	
SELECT match_id, team_id AS 'oponent id', team_name AS 'oponent', match_date, Bar.id AS 'location id', 
Bar.name AS 'location' FROM Team
INNER JOIN Match_Team on Team.id = team_id 
INNER JOIN `Match` ON Match_Team.match_id = `Match`.id
INNER JOIN Bar ON location_id = Bar.id
WHERE match_id IN (
     SELECT match_id FROM Match_Team WHERE team_id = 1
     )
     AND team_id != 1;
	 

-- get all machines at bars, and the bar name
-- ordered alphabetically by machine
SELECT Machine.id, mach_name, Bar.id, Bar.name FROM Bar
INNER JOIN Machine_Bar ON Bar.id = bar_id
INNER JOIN Machine ON machine_id = Machine.id
ORDER BY Mach_name ASC;


-- Filter Bars by City Name
-- filter bars by city name
SELECT Bar.id, Bar.name, city, state FROM Bar 
WHERE city = 'Portland';

-- Delete a machine from a bar
-- example deletes machine 32 from bar 2)
DELETE FROM Machine_Bar
WHERE bar_id = 2 AND machine_id = 32;


-- Insert a machine into a bar
-- (Example inserts Machine 25 into bar 1)
INSERT INTO Machine_Bar (machine_id, bar_id)
VALUES (25, 1);

-- List all machines at a single bar
-- (Example lists all machines at bar 5)
SELECT Machine.id, mach_name FROM Machine
INNER JOIN Machine_Bar ON Machine.id = machine_id
INNER JOIN Bar ON bar_id = Bar.id
WHERE Bar.id = 5;

-- Master schedule.
-- Gives two rows per match - one for each team in the match.
SELECT Match.id AS 'match-id', match_date, Bar.id as 'bar-id', Bar.name as 'match-location', Team.id, team_name FROM `Match`
INNER JOIN Bar ON location_id = Bar.id
INNER JOIN Match_Team ON Match.id = Match_Team.match_id
INNER JOIN Team ON Match_Team.team_id = Team.id
ORDER BY match_date, match_id ASC;




