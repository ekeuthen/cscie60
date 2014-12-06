-- ******************************************************
-- hiking_headquarters.sql
--
-- Loader for White Mountain Hiking Headquarters
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              White Mountains Hiking Headquarters database
--
-- Assignment:  CSCIE-60 Final Project 
--
-- Student:  Emily Keuthen
--
-- Date:   November 23, 2014
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool hiking_headquarters.lst


-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- EK: Drop children first; purge avoids recycle bin
-- ******************************************************

DROP table tbreview purge;
DROP table tbphoto purge; 
DROP table tbtriplocation purge;
DROP table tbtrip purge;
DROP table tbmountain purge;
DROP table tbregion purge;


-- ******************************************************
--    DROP SEQUENCES
-- Note:  Issue the appropiate commands to drop sequences
-- ******************************************************


-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tbregion (
    regionid      number(2,1)     not null
        constraint pk_region primary key,
    regionname    varchar2(32)    not null
);

CREATE table tbmountain (
    mountainid      number(3,0)     not null
        constraint pk_mountain primary key,
    mountainname    varchar2(30)    not null,
    height          number(4,0)
        constraint rg_height check (height > 0),
    regionid        number(2,1)
        constraint fk_regionid_tbmountain references tbregion (regionid) on delete set null  
);

CREATE table tbtrip (
    tripid          number(3,0)     not null
        constraint pk_trip primary key,
    tripname        varchar2(64),
    distance        number(3,1)
        constraint rg_distance check (distance > 0),
    difficulty      varchar2(32),
    elevationgain   number (4,0),
    fee             number (1,0),
    dogsallowed     number (1,0)
);

CREATE table tbphoto (
    photoid         number(4,0)     not null
        constraint pk_photo primary key,
    photourl        varchar2(256)    not null
);

CREATE table tbreview (
    reviewId      number(5,0)       not null
        constraint pk_review primary key,
    tripid        number(3,0)       not null
        constraint fk_tripid_tbreview references tbtrip (tripid) on delete cascade,
    rating        number(1,2)       not null
        constraint rg_rating_min check (rating > 0)
        constraint rg_rating_max check (rating <= 5),
    comments      varchar2(256),
    createDate    date    default SYSDATE not null,
    modifyDate    date
);

CREATE table tbtriplocation (
    mountainid    number(3,0)     not null
        constraint fk_mountainid_tbtriplocation references tbmountain (mountainid) on delete cascade,
    tripid        number(3,0)     not null
        constraint fk_tripid_tbtriplocation references tbtrip (tripid) on delete cascade,
        constraint pk_triplocation primary key (mountainid, tripid)
);


-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

     
-- ******************************************************
--    POPULATE TABLES
-- ******************************************************

/* seed tbregion */
Insert into tbregion values (1, 'Southwest and Waterville Valley');
Insert into tbregion values (2, 'Franconia Notch');
Insert into tbregion values (3, 'Kancamagus');
Insert into tbregion values (4, 'Chocorua and North Conway');
Insert into tbregion values (5, 'Crawford Notch and Zealand Notch');
Insert into tbregion values (6, 'Pinkham Notch');
Insert into tbregion values (7, 'Evans Notch');
Insert into tbregion values (8, 'North Country');


-- ******************************************************
--    VIEW TABLES
--
-- Note:  Issue the appropiate commands to show your data
-- ******************************************************

SELECT * FROM tbregion;
SELECT * FROM tbmountain;
SELECT * FROM tbtriplocation;
SELECT * FROM tbtrip;
SELECT * FROM tbreview;
SELECT * FROM tbphoto;


-- ******************************************************
--    QUALITY CONTROLS
--
--        *) Entity integrity
--        *) Referential integrity
--        *) Column constraints
-- ******************************************************


-- ******************************************************
--    
-- CREATE TRIGGERS
--
-- ******************************************************


-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
