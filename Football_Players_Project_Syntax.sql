-- Create players_gamedetails table.
CREATE TABLE players_gamedetails (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    ls VARCHAR(10),
    st VARCHAR(10),
    rs VARCHAR(10),
    lw VARCHAR(10),
    lf VARCHAR(10),
    cf VARCHAR(10),
    rf VARCHAR(10),
    rw VARCHAR(10),
    lam VARCHAR(10),
    cam VARCHAR(10),
    ram VARCHAR(10),
    lm VARCHAR(10),
    lcm VARCHAR(10),
    cm VARCHAR(10),
    rcm VARCHAR(10),
    rm VARCHAR(10),
    lwb VARCHAR(10),
    ldm VARCHAR(10),
    cdm VARCHAR(10),
    rdm VARCHAR(10),
    rwb VARCHAR(10),
    lb VARCHAR(10),
    lcb VARCHAR(10),
    cb VARCHAR(10),
    rcb VARCHAR(10),
    rb VARCHAR(10),
    crossing INTEGER,
    finishing INTEGER,
    heading_accuracy INTEGER,
    short_passing INTEGER,
    volleys INTEGER,
    dribbling INTEGER,
    curve INTEGER,
    fk_accuracy INTEGER,
    long_passing INTEGER,
    ball_control INTEGER,
    acceleration INTEGER,
    sprint_speed INTEGER,
    agility INTEGER,
    reactions INTEGER,
    balance INTEGER,
    shot_power INTEGER,
    jumping INTEGER,
    stamina INTEGER,
    strength INTEGER,
    long_shots INTEGER,
    aggression INTEGER,
    interceptions INTEGER,
    positioning INTEGER,
    vision INTEGER,
    penalties INTEGER,
    composure INTEGER,
    marking INTEGER,
    standing_tackle INTEGER,
    sliding_tackle INTEGER,
    gk_diving INTEGER,
    gk_handling INTEGER,
    gk_kicking INTEGER,
    gk_positioning INTEGER,
    gk_reflexes INTEGER,
    release_clause VARCHAR(50));
	
-- View players_gamedetails table.
SELECT * FROM public.players_gamedetails;

-- Create a new table called players_core_gamedetails with only the most important information.
CREATE TABLE players_core_gamedetails AS
SELECT 
    id,
    name,
    crossing,
    finishing,
    heading_accuracy,
    short_passing,
    volleys,
    dribbling,
    curve,
    fk_accuracy,
    long_passing,
    ball_control,
    acceleration,
    sprint_speed,
    agility,
    reactions,
    balance,
    shot_power,
    jumping,
    stamina,
    strength,
    long_shots,
    aggression,
    interceptions,
    positioning,
    vision,
    penalties,
    composure,
    marking,
    standing_tackle,
    sliding_tackle,
    gk_diving,
    gk_handling,
    gk_kicking,
    gk_positioning,
    gk_reflexes,
    release_clause
FROM players_gamedetails;

-- View players_core_gamedetails table.
SELECT * FROM public.players_core_gamedetails;

/*************************************************
players_core_gamedetails data checks.
*************************************************/

-- View the number of rows and columns in players_core_gamedetails.
SELECT 
    (SELECT COUNT(*) FROM players_core_gamedetails) AS total_rows,
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players_core_gamedetails') AS total_columns;

-- List of column names for players_core_gamedetails.
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'players_core_gamedetails'; 

-- Check for duplicates in players_core_gamedetails.
SELECT id, COUNT(*) 
FROM players_core_gamedetails
GROUP BY id
HAVING COUNT(*) > 1;

-- Check each column of players_core_gamedetails for NULL values.
CREATE VIEW players_null_counts AS
SELECT 
    COUNT(NULLIF(id IS NULL, FALSE)) AS id_null,
    COUNT(NULLIF(name IS NULL, FALSE)) AS name_null,
    COUNT(NULLIF(crossing IS NULL, FALSE)) AS crossing_null,
    COUNT(NULLIF(finishing IS NULL, FALSE)) AS finishing_null,
    COUNT(NULLIF(heading_accuracy IS NULL, FALSE)) AS heading_accuracy_null,
    COUNT(NULLIF(short_passing IS NULL, FALSE)) AS short_passing_null,
    COUNT(NULLIF(volleys IS NULL, FALSE)) AS volleys_null,
    COUNT(NULLIF(dribbling IS NULL, FALSE)) AS dribbling_null,
    COUNT(NULLIF(curve IS NULL, FALSE)) AS curve_null,
    COUNT(NULLIF(fk_accuracy IS NULL, FALSE)) AS fk_accuracy_null,
    COUNT(NULLIF(long_passing IS NULL, FALSE)) AS long_passing_null,
    COUNT(NULLIF(ball_control IS NULL, FALSE)) AS ball_control_null,
    COUNT(NULLIF(acceleration IS NULL, FALSE)) AS acceleration_null,
    COUNT(NULLIF(sprint_speed IS NULL, FALSE)) AS sprint_speed_null,
    COUNT(NULLIF(agility IS NULL, FALSE)) AS agility_null,
    COUNT(NULLIF(reactions IS NULL, FALSE)) AS reactions_null,
    COUNT(NULLIF(balance IS NULL, FALSE)) AS balance_null,
    COUNT(NULLIF(shot_power IS NULL, FALSE)) AS shot_power_null,
    COUNT(NULLIF(jumping IS NULL, FALSE)) AS jumping_null,
    COUNT(NULLIF(stamina IS NULL, FALSE)) AS stamina_null,
    COUNT(NULLIF(strength IS NULL, FALSE)) AS strength_null,
    COUNT(NULLIF(long_shots IS NULL, FALSE)) AS long_shots_null,
    COUNT(NULLIF(aggression IS NULL, FALSE)) AS aggression_null,
    COUNT(NULLIF(interceptions IS NULL, FALSE)) AS interceptions_null,
    COUNT(NULLIF(positioning IS NULL, FALSE)) AS positioning_null,
    COUNT(NULLIF(vision IS NULL, FALSE)) AS vision_null,
    COUNT(NULLIF(penalties IS NULL, FALSE)) AS penalties_null,
    COUNT(NULLIF(composure IS NULL, FALSE)) AS composure_null,
    COUNT(NULLIF(marking IS NULL, FALSE)) AS marking_null,
    COUNT(NULLIF(standing_tackle IS NULL, FALSE)) AS standing_tackle_null,
    COUNT(NULLIF(sliding_tackle IS NULL, FALSE)) AS sliding_tackle_null,
    COUNT(NULLIF(gk_diving IS NULL, FALSE)) AS gk_diving_null,
    COUNT(NULLIF(gk_handling IS NULL, FALSE)) AS gk_handling_null,
    COUNT(NULLIF(gk_kicking IS NULL, FALSE)) AS gk_kicking_null,
    COUNT(NULLIF(gk_positioning IS NULL, FALSE)) AS gk_positioning_null,
    COUNT(NULLIF(gk_reflexes IS NULL, FALSE)) AS gk_reflexes_null,
    COUNT(NULLIF(release_clause IS NULL, FALSE)) AS release_clause_null
FROM players_core_gamedetails;

-- Show players_null_counts.
SELECT * FROM players_null_counts;

-- Add a new column release_clause_euro,
ALTER TABLE players_core_gamedetails
ADD COLUMN release_clause_euro BIGINT;

-- Convert the values and update release_clause_euro column.
UPDATE players_core_gamedetails
SET release_clause_euro = 
    CASE
        WHEN release_clause LIKE '%M' THEN ROUND(CAST(REPLACE(REPLACE(release_clause, '€', ''), 'M', '') AS NUMERIC) * 1000000)
        WHEN release_clause LIKE '%K' THEN ROUND(CAST(REPLACE(REPLACE(release_clause, '€', ''), 'K', '') AS NUMERIC) * 1000)
        ELSE NULL
    END
WHERE release_clause IS NOT NULL;

-- View the updated players_core_gamedetails table to check the changes.
SELECT * FROM public.players_core_gamedetails;

-- Check for values outside expected ranges.
SELECT id, name, crossing, finishing, heading_accuracy, short_passing, volleys, dribbling, 
    curve, fk_accuracy, long_passing, ball_control, acceleration, sprint_speed, agility, reactions, 
    balance, shot_power, jumping, stamina, strength, long_shots, aggression, interceptions, 
    positioning, vision, penalties, composure, marking, standing_tackle, sliding_tackle, 
    gk_diving, gk_handling, gk_kicking, gk_positioning, gk_reflexes
FROM players_core_gamedetails
WHERE NOT (crossing BETWEEN 0 AND 100
    AND finishing BETWEEN 0 AND 100
    AND heading_accuracy BETWEEN 0 AND 100
    AND short_passing BETWEEN 0 AND 100
    AND volleys BETWEEN 0 AND 100
    AND dribbling BETWEEN 0 AND 100
    AND curve BETWEEN 0 AND 100
    AND fk_accuracy BETWEEN 0 AND 100
    AND long_passing BETWEEN 0 AND 100
    AND ball_control BETWEEN 0 AND 100
    AND acceleration BETWEEN 0 AND 100
    AND sprint_speed BETWEEN 0 AND 100
    AND agility BETWEEN 0 AND 100
    AND reactions BETWEEN 0 AND 100
    AND balance BETWEEN 0 AND 100
    AND shot_power BETWEEN 0 AND 100
    AND jumping BETWEEN 0 AND 100
    AND stamina BETWEEN 0 AND 100
    AND strength BETWEEN 0 AND 100
    AND long_shots BETWEEN 0 AND 100
    AND aggression BETWEEN 0 AND 100
    AND interceptions BETWEEN 0 AND 100
    AND positioning BETWEEN 0 AND 100
    AND vision BETWEEN 0 AND 100
    AND penalties BETWEEN 0 AND 100
    AND composure BETWEEN 0 AND 100
    AND marking BETWEEN 0 AND 100
    AND standing_tackle BETWEEN 0 AND 100
    AND sliding_tackle BETWEEN 0 AND 100
    AND gk_diving BETWEEN 0 AND 100
    AND gk_handling BETWEEN 0 AND 100
    AND gk_kicking BETWEEN 0 AND 100
    AND gk_positioning BETWEEN 0 AND 100
    AND gk_reflexes BETWEEN 0 AND 100);

-- Show players_null_counts.
SELECT * FROM players_null_counts;

-- ** Keep NULL values in integer columns as they are.

-- Drop players_null_counts.
DROP VIEW IF EXISTS players_null_counts;

-- View players_core_gamedetails table.
SELECT * FROM public.players_core_gamedetails;

-- Drop the release_clause column after check have been done.
ALTER TABLE players_core_gamedetails
DROP COLUMN release_clause;

/*************************************************
players_core_gamedetails data checks completed.
*************************************************/

-- Create players_personalinfo table.
CREATE TABLE players_personalinfo (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    nationality VARCHAR(100),
    overall INTEGER,
    potential INTEGER,
    club VARCHAR(255),
    value_euro NUMERIC,
    wage_k INTEGER,
    special INTEGER,
    preferred_foot VARCHAR(10),
    international_reputation INTEGER,
    weak_foot INTEGER,
    skill_moves INTEGER,
    work_rate VARCHAR(20),
    body_type VARCHAR(20),
    real_face VARCHAR(10),
    position VARCHAR(10),
    jersey_number INTEGER,
    joined_month VARCHAR(10),
    joined_year INTEGER,
    contract_valid_until INTEGER,
    height_cm INTEGER,
    weight_kg INTEGER);

-- View players_personalinfo table.
SELECT * FROM public.players_personalinfo;

/*************************************************
players_personalinfo data checks.
*************************************************/

-- View the number of rows and columns in players_personalinfo.
SELECT 
    (SELECT COUNT(*) FROM players_personalinfo) AS total_rows,
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players_personalinfo') AS total_columns;

-- List of column names for players_personalinfo.
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'players_personalinfo';

-- Check for duplicates in players_personalinfo based on the 'id' column.
SELECT id, COUNT(*)
FROM players_personalinfo
GROUP BY id
HAVING COUNT(*) > 1;

-- Check each column of players_personalinfo for NULL values.
CREATE VIEW players_null_counts AS
SELECT 
    COUNT(NULLIF(id IS NOT NULL, TRUE)) AS id_null,
    COUNT(NULLIF(name IS NOT NULL, TRUE)) AS name_null,
    COUNT(NULLIF(age IS NOT NULL, TRUE)) AS age_null,
    COUNT(NULLIF(nationality IS NOT NULL, TRUE)) AS nationality_null,
    COUNT(NULLIF(overall IS NOT NULL, TRUE)) AS overall_null,
    COUNT(NULLIF(potential IS NOT NULL, TRUE)) AS potential_null,
    COUNT(NULLIF(club IS NOT NULL, TRUE)) AS club_null,
    COUNT(NULLIF(value_euro IS NOT NULL, TRUE)) AS value_euro_null,
    COUNT(NULLIF(wage_k IS NOT NULL, TRUE)) AS wage_k_null,
    COUNT(NULLIF(special IS NOT NULL, TRUE)) AS special_null,
    COUNT(NULLIF(preferred_foot IS NOT NULL, TRUE)) AS preferred_foot_null,
    COUNT(NULLIF(international_reputation IS NOT NULL, TRUE)) AS international_reputation_null,
    COUNT(NULLIF(weak_foot IS NOT NULL, TRUE)) AS weak_foot_null,
    COUNT(NULLIF(skill_moves IS NOT NULL, TRUE)) AS skill_moves_null,
    COUNT(NULLIF(work_rate IS NOT NULL, TRUE)) AS work_rate_null,
    COUNT(NULLIF(body_type IS NOT NULL, TRUE)) AS body_type_null,
    COUNT(NULLIF(real_face IS NOT NULL, TRUE)) AS real_face_null,
    COUNT(NULLIF(position IS NOT NULL, TRUE)) AS position_null,
    COUNT(NULLIF(jersey_number IS NOT NULL, TRUE)) AS jersey_number_null,
    COUNT(NULLIF(joined_month IS NOT NULL, TRUE)) AS joined_month_null,
    COUNT(NULLIF(joined_year IS NOT NULL, TRUE)) AS joined_year_null,
    COUNT(NULLIF(contract_valid_until IS NOT NULL, TRUE)) AS contract_valid_until_null,
    COUNT(NULLIF(height_cm IS NOT NULL, TRUE)) AS height_cm_null,
    COUNT(NULLIF(weight_kg IS NOT NULL, TRUE)) AS weight_kg_null
FROM players_personalinfo;

-- Show players_null_counts.
SELECT * FROM players_null_counts;

-- ** Keep NULL values in euro_value as they are.

-- Drop players_null_counts.
DROP VIEW IF EXISTS players_null_counts;

-- Check each column of players_personalinfo for '0' values.
CREATE VIEW players_zero_counts AS
SELECT 
    COUNT(CASE WHEN id = 0 THEN 1 ELSE NULL END) AS id_zero,
    COUNT(CASE WHEN name = '0' THEN 1 ELSE NULL END) AS name_zero,
    COUNT(CASE WHEN age = 0 THEN 1 ELSE NULL END) AS age_zero,
    COUNT(CASE WHEN nationality = '0' THEN 1 ELSE NULL END) AS nationality_zero,
    COUNT(CASE WHEN overall = 0 THEN 1 ELSE NULL END) AS overall_zero,
    COUNT(CASE WHEN potential = 0 THEN 1 ELSE NULL END) AS potential_zero,
    COUNT(CASE WHEN club = '0' THEN 1 ELSE NULL END) AS club_zero,
    COUNT(CASE WHEN value_euro = 0 THEN 1 ELSE NULL END) AS value_euro_zero,
    COUNT(CASE WHEN wage_k = 0 THEN 1 ELSE NULL END) AS wage_k_zero,
    COUNT(CASE WHEN special = 0 THEN 1 ELSE NULL END) AS special_zero,
    COUNT(CASE WHEN preferred_foot = '0' THEN 1 ELSE NULL END) AS preferred_foot_zero,
    COUNT(CASE WHEN international_reputation = 0 THEN 1 ELSE NULL END) AS international_reputation_zero,
    COUNT(CASE WHEN weak_foot = 0 THEN 1 ELSE NULL END) AS weak_foot_zero,
    COUNT(CASE WHEN skill_moves = 0 THEN 1 ELSE NULL END) AS skill_moves_zero,
    COUNT(CASE WHEN work_rate = '0' THEN 1 ELSE NULL END) AS work_rate_zero,
    COUNT(CASE WHEN body_type = '0' THEN 1 ELSE NULL END) AS body_type_zero,
    COUNT(CASE WHEN real_face = '0' THEN 1 ELSE NULL END) AS real_face_zero,
    COUNT(CASE WHEN position = '0' THEN 1 ELSE NULL END) AS position_zero,
    COUNT(CASE WHEN jersey_number = 0 THEN 1 ELSE NULL END) AS jersey_number_zero,
    COUNT(CASE WHEN joined_month = '0' THEN 1 ELSE NULL END) AS joined_month_zero,
    COUNT(CASE WHEN joined_year = 0 THEN 1 ELSE NULL END) AS joined_year_zero,
    COUNT(CASE WHEN contract_valid_until = 0 THEN 1 ELSE NULL END) AS contract_valid_until_zero,
    COUNT(CASE WHEN height_cm = 0 THEN 1 ELSE NULL END) AS height_cm_zero,
    COUNT(CASE WHEN weight_kg = 0 THEN 1 ELSE NULL END) AS weight_kg_zero
FROM players_personalinfo;

-- Show players_zero_counts.
SELECT * FROM players_zero_counts;

-- Set club to 'No Club' where the current value is '0'.
UPDATE players_personalinfo
SET club = 'No Club'
WHERE club = '0';

-- Set work_rate, body_type, real_face, perferred_foot, position, 
-- and joined_month to 'Unknown' where the current value is '0'.
UPDATE players_personalinfo
SET preferred_foot = CASE WHEN preferred_foot = '0' THEN 'Unknown' ELSE preferred_foot END,
    work_rate = CASE WHEN work_rate = '0' THEN 'Unknown' ELSE work_rate END,
    body_type = CASE WHEN body_type = '0' THEN 'Unknown' ELSE body_type END,
    real_face = CASE WHEN real_face = '0' THEN 'Unknown' ELSE real_face END,
    position = CASE WHEN position = '0' THEN 'Unknown' ELSE position END,
    joined_month = CASE WHEN joined_month = '0' THEN 'Unknown' ELSE joined_month END;

-- Set jersey_number, joined_year, contract_valid_until, height_cm, 
-- and weight_kg to NULL where the current value is '0'.
UPDATE players_personalinfo
SET 
    jersey_number = CASE WHEN jersey_number = 0 THEN NULL ELSE jersey_number END,
    joined_year = CASE WHEN joined_year = 0 THEN NULL ELSE joined_year END,
    contract_valid_until = CASE WHEN contract_valid_until = 0 THEN NULL ELSE contract_valid_until END,
    height_cm = CASE WHEN height_cm = 0 THEN NULL ELSE height_cm END,
    weight_kg = CASE WHEN weight_kg = 0 THEN NULL ELSE weight_kg END;

-- Show players_zero_counts.
SELECT * FROM players_zero_counts;

-- ** Keep 0 values remaining columns as they are.

-- Drop players_zero_counts.
DROP VIEW IF EXISTS players_zero_counts;

-- Check that joined_year is less than or equal to contract_valid_until.
SELECT *
FROM players_personalinfo
WHERE joined_year > contract_valid_until;

-- Distribution of overall and potential.
SELECT ROUND(AVG(overall), 2) AS avg_overall, MIN(overall) AS min_overall, MAX(overall) AS max_overall,
    ROUND(AVG(potential), 2) AS avg_potential, min(potential) AS min_potential, MAX(potential) AS max_potential   
FROM players_personalinfo;

-- Check for values outside expected ranges.
SELECT id, name, international_reputation, weak_foot, skill_moves 
FROM players_personalinfo
WHERE NOT (international_reputation BETWEEN 0 AND 5
    AND weak_foot BETWEEN 0 AND 5
    AND skill_moves BETWEEN 0 AND 5);
	
-- Rename the wage_k column to weekly_wage_euro.
ALTER TABLE players_personalinfo
RENAME COLUMN wage_k TO weekly_wage_euro;

-- Multiply the values in weekly_wage_euro by 1000.
UPDATE players_personalinfo
SET weekly_wage_euro = weekly_wage_euro * 1000;

-- Multiply the values in value_euro by 1,000,000 and round to 0 decimal places.
UPDATE players_personalinfo
SET value_euro = ROUND(value_euro * 1000000, 0);

-- View players_personalinfo table.
SELECT * FROM public.players_personalinfo;

-- Check for any IDs in players_core_gamedetails that do not exist in players_personalinfo.
SELECT pcg.id, pcg.name
FROM players_core_gamedetails pcg
LEFT JOIN players_personalinfo ppi ON pcg.id = ppi.id
WHERE ppi.id IS NULL;

-- Check for mismatched names for the same ID between the two tables.
SELECT ppi.id, ppi.name AS name_in_personalinfo, pcg.name AS name_in_gamedetails
FROM players_personalinfo ppi
JOIN players_core_gamedetails pcg ON ppi.id = pcg.id
WHERE ppi.name != pcg.name;

/*************************************************
players_personalinfo data checks completed.
*************************************************/

-- Create players_combined table by joining on both ID and Name.
CREATE TABLE players_combined AS
SELECT 
    ppi.id,
    ppi.name,
    ppi.age,
    ppi.nationality,
    ppi.overall,
    ppi.potential,
    ppi.club,
    ppi.value_euro,
    ppi.weekly_wage_euro,
    ppi.special,
    ppi.preferred_foot,
    ppi.international_reputation,
    ppi.weak_foot,
    ppi.skill_moves,
    ppi.work_rate,
    ppi.body_type,
    ppi.real_face,
    ppi.position,
    ppi.jersey_number,
    ppi.joined_month,
    ppi.joined_year,
    ppi.contract_valid_until,
    ppi.height_cm,
    ppi.weight_kg,
    pcg.crossing,
    pcg.finishing,
    pcg.heading_accuracy,
    pcg.short_passing,
    pcg.volleys,
    pcg.dribbling,
    pcg.curve,
    pcg.fk_accuracy,
    pcg.long_passing,
    pcg.ball_control,
    pcg.acceleration,
    pcg.sprint_speed,
    pcg.agility,
    pcg.reactions,
    pcg.balance,
    pcg.shot_power,
    pcg.jumping,
    pcg.stamina,
    pcg.strength,
    pcg.long_shots,
    pcg.aggression,
    pcg.interceptions,
    pcg.positioning,
    pcg.vision,
    pcg.penalties,
    pcg.composure,
    pcg.marking,
    pcg.standing_tackle,
    pcg.sliding_tackle,
    pcg.gk_diving,
    pcg.gk_handling,
    pcg.gk_kicking,
    pcg.gk_positioning,
    pcg.gk_reflexes,
    pcg.release_clause_euro
FROM players_personalinfo ppi
JOIN players_core_gamedetails pcg
ON ppi.id = pcg.id
AND ppi.name = pcg.name
ORDER BY ppi.id ASC;

-- View players_combined table.
SELECT * FROM public.players_combined;

/*************************************************
players_combined simply data checks and analysis.
*************************************************/

-- View the number of rows and columns in players_combined.
SELECT 
    (SELECT COUNT(*) FROM players_combined) AS total_rows,
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players_combined') AS total_columns;

-- List of column names for players_combined.
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'players_combined'; 

-- Check for duplicates in players_combined.
SELECT id, COUNT(*) 
FROM players_combined
GROUP BY id
HAVING COUNT(*) > 1;

-- Total number of players per country.
SELECT nationality AS country, COUNT(*) AS player_count
FROM players_combined
GROUP BY nationality
ORDER BY player_count DESC;

-- Total number of players per club.
SELECT club, COUNT(*) AS player_count
FROM players_combined
GROUP BY club
ORDER BY player_count DESC;

-- Average age of players per country.
SELECT nationality AS country, ROUND(AVG(age), 2) AS average_age
FROM players_combined
GROUP BY country
ORDER BY average_age DESC;

-- Average age of players per club.
SELECT club, ROUND(AVG(age), 2) AS average_age
FROM players_combined
GROUP BY club
ORDER BY average_age DESC;

-- Average overall of players per country.
SELECT nationality AS country, ROUND(AVG(overall), 2) AS average_overall
FROM players_combined
GROUP BY country
ORDER BY average_overall DESC;

-- Average overall of players per club.
SELECT club, ROUND(AVG(overall), 2) AS average_overall
FROM players_combined
GROUP BY club
ORDER BY average_overall DESC;

-- Number of players per country with an overall score greater than or equal to 75.
SELECT nationality AS country, COUNT(*) AS player_count
FROM players_combined
WHERE overall > 75
GROUP BY country
ORDER BY player_count DESC;

-- Number of players per club with an overall score greater than or equal to 75.
SELECT club, COUNT(*) AS player_count
FROM players_combined
WHERE overall >= 75
GROUP BY club
ORDER BY player_count DESC;

-- Total value of players in euros by country.
SELECT nationality AS country, SUM(value_euro) AS total_value_euro
FROM players_combined
GROUP BY country 
ORDER BY total_value_euro DESC; 

-- Total value of players in euros by club.
SELECT club, SUM(value_euro) AS total_value_euro
FROM players_combined
GROUP BY club
ORDER BY total_value_euro DESC; 

-- Top 5 players with the highest release clause.
SELECT *
FROM players_combined
WHERE release_clause_euro IS NOT NULL
ORDER BY release_clause_euro DESC
LIMIT 5;

-- Bottom 5 players with the lowest release clause
SELECT *
FROM players_combined
WHERE release_clause_euro IS NOT NULL
ORDER BY release_clause_euro ASC
LIMIT 5;

-- Step 1: Identify the top countries by total player value.
WITH CountryTotals AS (
    SELECT nationality AS country, SUM(value_euro) AS total_value_euro
    FROM players_combined
    GROUP BY country
    ORDER BY total_value_euro DESC
    LIMIT 11),
-- Step 2: Rank players within these top countries and exclude players with NULL value_euro.
RankedPlayers AS (
    SELECT p.nationality AS country, p.name, p.value_euro,
        ROW_NUMBER() OVER (PARTITION BY p.nationality ORDER BY p.value_euro DESC) AS rank
    FROM players_combined p
    JOIN CountryTotals ct
    ON p.nationality = ct.country
    WHERE p.value_euro IS NOT NULL)
-- Step 3: Select top 5 players per country and order results.
SELECT country, name, value_euro
FROM RankedPlayers
WHERE rank <= 5
ORDER BY country, rank;

-- Step 1: Identify the top countries by total player value.
WITH CountryTotals AS (
    SELECT nationality AS country, SUM(value_euro) AS total_value_euro
    FROM players_combined
    GROUP BY country
    ORDER BY total_value_euro DESC
    LIMIT 11),
-- Step 2: Rank players within these top countries based on weekly_wage_euro and exclude players with NULL weekly_wage_euro.
RankedPlayers AS (
    SELECT p.nationality AS country, p.name, p.weekly_wage_euro,
        ROW_NUMBER() OVER (PARTITION BY p.nationality ORDER BY p.weekly_wage_euro DESC) AS rank
    FROM players_combined p
    JOIN CountryTotals ct
    ON p.nationality = ct.country
    WHERE p.weekly_wage_euro IS NOT NULL)
-- Step 3: Select top 5 players per country based on weekly_wage_euro and order results.
SELECT country, name, weekly_wage_euro
FROM RankedPlayers
WHERE rank <= 5
ORDER BY country, rank;

-- Step 1: Identify the highest potential for each position.
WITH MaxPotential AS (
    SELECT position, MAX(potential) AS max_potential
    FROM players_combined
    GROUP BY position)
-- Step 2: Select players with the highest potential, including their overall rating.
SELECT p.position, p.name, p.overall, p.potential
FROM players_combined p
JOIN MaxPotential mp
ON p.position = mp.position 
AND p.potential = mp.max_potential
ORDER BY p.position;

-- Top 25 players with the biggest difference between their overall and potential ratings
SELECT name, age, club, value_euro, weekly_wage_euro, overall, potential, (potential - overall) AS difference
FROM players_combined
ORDER BY difference DESC
LIMIT 25;
