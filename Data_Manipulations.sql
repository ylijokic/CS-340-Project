
--get all Team Names
SELECT `team_name` FROM `Team`

--get all Bars
SELECT * FROM `Bar`

--get all Pinball Table Names
SELECT `mach_name` FROM `Machine`

-- Add info to a new Match
INSERT INTO `Match`(`id`, `date`, `home_team`, `away_team`) 
VALUES (1,'01-11-2001', 1, 2);

-- Select what Team won Game and what pinball table the game was played on
SELECT `machine`, `winning_team` FROM `Game`

-- Add info to a new Game
INSERT INTO `Game`(`id`, `machine`, `winning_team`) 
VALUES (1, 2, 10);

--Add a new Team
INSERT INTO `Team`(`id`, `team_name`, `home_bar`)
VALUES (15, 'team fifteen' , 20)

--Update a Game to include what team won
UPDATE `Game` WHERE `winning_team` = 'teamID'

