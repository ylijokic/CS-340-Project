
--Display all Team Names
SELECT `team_name` FROM `Team`;

--Display Team Names and Home Bar Names
SELECT `Team.id`, `team_name`, `Bar.name` AS `home_bar_name` 
FROM `Team` 
INNER JOIN `Bar` 
ON `home_bar_id` = `Bar.id`;

--Select a Single Team to Update--
SELECT `id` AS `id`, `team_name`, `home_bar_id` 
FROM `Team` 
WHERE `id` = ?;

--Display all Bars
SELECT * FROM `Bar`;

--Display all Bar information--
SELECT `id`, `name`, `street_addr`, `city`, `state` 
FROM `Bar`;

--Filter Bars by certain city--
SELECT `Bar.id`, `Bar.name`, `city`, `state` 
FROM `Bar` 
WHERE `city` = ?;

--Display all Pinball Machine Names
SELECT `id`, `mach_name`, `mach_name_short` 
FROM `Machine`;

--Display all Matches--
SELECT `Match.id`, `match_date`, `Bar.name` AS `location_name` 
FROM `Match` INNER JOIN `Bar` 
ON `location_id` = `Bar.id`;

--Display Machine_Bar relationships--
SELECT `Machine.id`, `mach_name`, `Bar.id`, `Bar.name` AS `bar_name` 
FROM `Bar` 
INNER JOIN `Machine_Bar` ON `Bar.id` = `bar_id` 
INNER JOIN `Machine` ON `machine_id` = `Machine.id` 
ORDER BY `mach_name` ASC;

--Insert a new Team
INSERT INTO `Team`(`id`, `team_name`, `home_bar`)
VALUES (1, 'Away Team Is Lit' , 1), (2, 'Clinton Street Pub FC', 2);

--Insert a new Bar--
INSERT INTO `Bar` (`name`, `street_addr`, `city`, `state`) 
VALUES (?,?,?,?);

--Insert a new Pinball Machine
INSERT INTO `Machine`(`id`, `mach_name`, `mach_name_short`) 
VALUES (1, 'Eight Ball Deluxe', '8BD'), (2, 'AC/DC', 'ACD'), (3, 'Attack From Mars', 'AFM');

-- Insert a new Match
INSERT INTO `Match`(`id`, `match_date`, `location_id`) 
VALUES (1,'05-26-2019', 9), (2, '05-26-2020', 4), (3, '05-26-2021', 6);

--Insert a new Machine_Bar relationship--
INSERT INTO `Machine_Bar` (`machine_id`, `bar_id`) VALUES (?,?);


--Update a Team--
UPDATE `Team` SET `team_name`=?, `home_bar_id`=? 
WHERE `id`=?;

--Update a Bar--
UPDATE `Bar` SET `name`=?, `street_addr`=?, `city`=?, `state`=? 
WHERE `id`=?;


--Delete a Team--
DELETE FROM `Team` 
WHERE `id`=?;

--Delete a Bar--
DELETE FROM `Bar` 
WHERE `id`=?;

--Delete a Pinaball Machine by Shortened Name--
DELETE FROM `Machine` 
WHERE 'mach_name_short' = '8BD';

--Delete a Match--
DELETE FROM `Match` 
WHERE `id`=?;

--Delete a Machine_Bar relationship--
DELETE FROM `Machine_Bar` 
WHERE `machine_id` =? AND `bar_id` =?;


-- Display all Bars with address and home team
SELECT `Bar.id` as 'bar-id', `name`, `street_addr`, `city`, `state`, `team.id` AS 'Team-id', `team_name`
FROM `Bar` 
LEFT JOIN `Team` ON `Bar.id` = `Team.id`;

-- Display a team's schedule showing both teams for each match
SELECT `match_id`, `team_id`
FROM `Match_Team`
WHERE `match_id` IN (
SELECT `match_id`
FROM `Match_Team`
WHERE `team_id` = 1
);


-- Display full schedule for a team (team1)	
SELECT `match_id`, `team_id` AS 'oponent id', `team_name` AS 'oponent', `match_date`, `Bar.id` AS 'location id', `Bar.name` AS 'location'
FROM `Team`
INNER JOIN `Match_Team` on `Team.id` = `team_id`
INNER JOIN `Match ` ON `Match_Team.match_id` = `Match.id`
INNER JOIN `Bar` ON `location_id` = `Bar.id`
WHERE `match_id` IN (
SELECT `match_id`
FROM `Match_Team`
WHERE `team_id` = 1
)
AND `team_id` != 1;

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




