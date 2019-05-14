
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
UPDATE `Game` WHERE `winning_team` = 'teamID'

--Delete Teams from a Match
DELETE FROM `Match` WHERE `home_team` = 10;

--Delete a Pinaball Machine
DELETE FROM `Machine` WHERE 'mach_name_short' = '8BD';

