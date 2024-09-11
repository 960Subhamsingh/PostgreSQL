DROP TABLE IF EXISTS OLYMPICS_HISTORY;  
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY  
(  
    id          INT,  
    name        VARCHAR,  
    sex         VARCHAR,  
    age         VARCHAR,  
    height      VARCHAR,  
    weight      VARCHAR,  
    team        VARCHAR,  
    noc         VARCHAR,  
    games       VARCHAR,  
    year        INT,  
    season      VARCHAR,  
    city        VARCHAR,  
    sport       VARCHAR,  
    event       VARCHAR,  
    medal       VARCHAR  
);

DROP TABLE IF EXISTS  OLYMPICS_HISTORY_NOC_REGIONS;  
CREATE TABLE IF NOT EXISTS   OLYMPICS_HISTORY_NOC_REGIONS  
(  
    noc         VARCHAR,  
    region      VARCHAR,  
    notes       VARCHAR  
); 

select count(*) from OLYMPICS_HISTORY;  

## see , how many data has been inserted in a table
select count(*) from   OLYMPICS_HISTORY_NOC_REGIONS;  