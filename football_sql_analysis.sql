/* ============================================================
   FOOTBALL SQL ANALYTICS PROJECT
   Database: MySQL
   Description: Football competitions, players, matches, and
                match-level player statistics analytics
   ============================================================ */

-- =========================
-- TABLE CREATION
-- =========================

CREATE TABLE players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    nationality VARCHAR(50),
    position VARCHAR(30),
    market_value BIGINT,
    jersey_number INT DEFAULT 0 NOT NULL
);

CREATE TABLE competitions (
    competition_id INT PRIMARY KEY AUTO_INCREMENT,
    competition_name VARCHAR(50)
);

CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    competition_id INT,
    match_date DATE,
    FOREIGN KEY (competition_id) REFERENCES competitions(competition_id)
);

CREATE TABLE player_stats_match (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    match_id INT,
    goals_scored INT DEFAULT 0,
    yellow_cards INT DEFAULT 0,
    red_cards INT DEFAULT 0,
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);

-- =========================
-- ANALYTICAL QUERIES
-- =========================

-- 1. Count matches per competition
SELECT
    c.competition_name,
    COUNT(m.match_id) AS NumberOfMatches
FROM competitions AS c
JOIN matches AS m ON m.competition_id = c.competition_id
GROUP BY c.competition_name;

-- 2. Average market value by nationality
SELECT
    p.nationality,
    AVG(p.market_value) AS avg_market_value
FROM players AS p
GROUP BY p.nationality;

-- 3. Total yellow cards and red cards by player
SELECT
    p.first_name,
    p.last_name,
    SUM(psm.yellow_cards) AS yellow_cards,
    SUM(psm.red_cards) AS red_cards
FROM players AS p
JOIN player_stats_match AS psm ON psm.player_id = p.player_id
GROUP BY p.first_name, p.last_name;

-- 4. Players with more than 0 yellow cards (HAVING)
SELECT
    p.first_name,
    p.last_name,
    SUM(psm.yellow_cards) AS yellowcards,
    SUM(psm.red_cards) AS redcards
FROM players AS p
JOIN player_stats_match AS psm ON psm.player_id = p.player_id
GROUP BY p.first_name, p.last_name
HAVING yellowcards > 0;

-- 5. Count players per position and nationality
SELECT
    p.position,
    p.nationality,
    COUNT(p.player_id) AS NoOfPlayers
FROM players AS p
GROUP BY p.position, p.nationality;

-- 6. Players who played in 'LA LIGA' matches (IN)
SELECT
    p.first_name,
    p.last_name
FROM players AS p
WHERE p.player_id IN (
    SELECT DISTINCT psm.player_id
    FROM player_stats_match AS psm
    JOIN matches AS m ON psm.match_id = m.match_id
    JOIN competitions AS c ON m.competition_id = c.competition_id
    WHERE c.competition_name = 'LA LIGA'
);

-- 7. Players who scored more than 1 goal in any single match (EXISTS)
SELECT
    p.first_name,
    p.last_name
FROM players AS p
WHERE EXISTS (
    SELECT 1
    FROM player_stats_match AS psm
    WHERE psm.player_id = p.player_id
      AND psm.goals_scored > 1
);

-- 8. Total goals by player (including players without stats)
SELECT
    p.first_name,
    p.last_name,
    COALESCE(SUM(psm.goals_scored), 0) AS total_goals
FROM players AS p
LEFT JOIN player_stats_match AS psm
    ON p.player_id = psm.player_id
GROUP BY p.first_name, p.last_name;

-- =========================
-- DATA MODIFICATION
-- =========================

-- 9. Update player market value
UPDATE players
SET market_value = 160000000
WHERE player_id = 1;

-- 10. Update multiple fields
UPDATE players
SET position = 'FORWARD',
    market_value = 100000000
WHERE player_id = 2;

-- 11. Delete player record
DELETE FROM players
WHERE player_id = 3;

-- =========================
-- SCHEMA MODIFICATION
-- =========================

-- 12. Add jersey_number column
ALTER TABLE players
ADD jersey_number INT;

-- 13. Modify jersey_number column
ALTER TABLE players
MODIFY jersey_number INT DEFAULT 0 NOT NULL;

-- 14. Drop date_of_birth column
ALTER TABLE players
DROP COLUMN date_of_birth;
