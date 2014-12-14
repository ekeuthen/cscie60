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

DROP sequence seq_review;

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
    tripid        number(3,0)       not null
        constraint fk_tripid_tbphoto references tbtrip (tripid) on delete cascade,
    photourl        varchar2(256)    not null
);

CREATE table tbreview (
    reviewId      number(5,0)       not null
        constraint pk_review primary key,
    tripid        number(3,0)       not null
        constraint fk_tripid_tbreview references tbtrip (tripid) on delete cascade,
    rating        number(2,1)       not null
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

CREATE sequence seq_review
    increment by 1
    start with 1;
     
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

/* seed tbmountain */
Insert into tbmountain values (1, 'Mount Lafayette', 5249, 2);
Insert into tbmountain values (2, 'Mount Lincoln', 5089, 2);
Insert into tbmountain values (3, 'Little Haystack Mountain', 4780, 2);
Insert into tbmountain values (4, 'Welch Mountain', 2605, 1);
Insert into tbmountain values (5, 'Dickey Mountain', 2634, 1);
Insert into tbmountain values (6, 'Stinson Mountain', 2900, 1);
Insert into tbmountain values (7, 'Mount Percival', 2212, 1);
Insert into tbmountain values (8, 'Mount Morgan', 2220, 1);
Insert into tbmountain values (9, 'Mount Osceola', 4340, 1);
Insert into tbmountain values (10, 'Mount Moosilauke', 4820, 1);
Insert into tbmountain values (11, 'South Peak', 4523, 1);
Insert into tbmountain values (12, 'Bald Mountain', 2340, 2);
Insert into tbmountain values (13, 'Artists'' Bluff', 2180, 2);
Insert into tbmountain values (14, 'Mount Pemigewasset', 2557, 2);
Insert into tbmountain values (15, 'Bald Peak', 2470, 2);
Insert into tbmountain values (16, 'Hedgehog Mountain', 2532, 3);
Insert into tbmountain values (17, 'Blackcap Mountain', 2369, 4);
Insert into tbmountain values (18, 'Mount Willard', 2865, 5);
Insert into tbmountain values (19, 'North Sugarloaf', 2310, 5);
Insert into tbmountain values (20, 'Middle Sugarloaf', 2539, 5);
Insert into tbmountain values (21, 'Mount Avalon', 3442, 5);
Insert into tbmountain values (22, 'Mount Crawford', 3119, 5);
Insert into tbmountain values (23, 'Pine Mountain', 2405, 6);
Insert into tbmountain values (24, 'Mount Washington', 6289, 6);
Insert into tbmountain values (25, 'Blueberry Mountain', 1781, 7);
Insert into tbmountain values (26, 'Caribou Mountain', 2870, 7);

/* seed tbtrip */
Insert into tbtrip values (1, 'Franconia Ridge', 9, 'Moderate - Strenous', 3850, 0, 1);
Insert into tbtrip values (2, 'Welch-Dickey Loop', 4.4, 'Moderate - Strenous', 1600, 1, 1);
Insert into tbtrip values (3, 'Stinson Mountain Trail', 3.6, 'Moderate', 1400, 0, 1);
Insert into tbtrip values (4, 'Percival-Morgan Loop', 5.2, 'Moderate', 1550, 0, 1);
Insert into tbtrip values (5, 'Mount Osceola', 6.4, 'Strenuous', 2050, 1, 1);
Insert into tbtrip values (6, 'Mount Moosilauke', 7.9, 'Strenuous', 2600, 0, 1);
Insert into tbtrip values (7, 'Bald Mountain and Artists Bluff', 1.5, 'Moderate', 550, 0, 1);
Insert into tbtrip values (8, 'Mount Pemigewasset Trail', 3.6, 'Moderate', 1300, 0, 1);
Insert into tbtrip values (9, 'Bald Peak via the Mount Kinsman Trail', 4.6, 'Moderate', 1450, 0, 1);
Insert into tbtrip values (10, 'UNH Trail to Hedgehog Mountain', 4.8, 'Moderate', 1450, 0, 1);
Insert into tbtrip values (11, 'Black Cap', 2.2, 'Moderate', 650, 0, 1);
Insert into tbtrip values (12, 'Mount Willard', 3.2, 'Moderate', 900, 0, 1);
Insert into tbtrip values (13, 'Sugarloaf Trail', 3.4, 'Moderate', 900, 1, 1);
Insert into tbtrip values (14, 'Mount Avalon', 3.7, 'Moderate', 1550, 0, 1);
Insert into tbtrip values (15, 'Mount Crawford', 5, 'Strenuous', 2100, 0, 1);
Insert into tbtrip values (16, 'Pine Mountain', 3.5, 'Moderate', 850, 0, 1);
Insert into tbtrip values (17, 'Tuckerman Ravine and Mount Washington', 8.4, 'Strenuous', 4250, 0, 0);
Insert into tbtrip values (18, 'Blueberry Mountain via Stone House Trail', 4.5, 'Moderate', 1150, 0, 1);
Insert into tbtrip values (19, 'Caribou Mountain', 6.9, 'Strenuous', 1900, 0, 1);

/*seed tbtriplocation*/
Insert into tbtriplocation values (1, 1);
Insert into tbtriplocation values (2, 1);
Insert into tbtriplocation values (3, 1);
Insert into tbtriplocation values (4, 2);
Insert into tbtriplocation values (5, 2);
Insert into tbtriplocation values (6, 3);
Insert into tbtriplocation values (7, 4);
Insert into tbtriplocation values (8, 4);
Insert into tbtriplocation values (9, 5);
Insert into tbtriplocation values (10, 6);
Insert into tbtriplocation values (11, 6);
Insert into tbtriplocation values (12, 7);
Insert into tbtriplocation values (13, 7);
Insert into tbtriplocation values (14, 8);
Insert into tbtriplocation values (15, 9);
Insert into tbtriplocation values (16, 10);
Insert into tbtriplocation values (17, 11);
Insert into tbtriplocation values (18, 12);
Insert into tbtriplocation values (19, 13);
Insert into tbtriplocation values (20, 13);
Insert into tbtriplocation values (21, 14);
Insert into tbtriplocation values (22, 15);
Insert into tbtriplocation values (23, 16);
Insert into tbtriplocation values (24, 17);
Insert into tbtriplocation values (25, 18);
Insert into tbtriplocation values (26, 19);

/*seed tbphotos*/
Insert into tbphoto values (1, 1, '1.JPG');
Insert into tbphoto values (2, 2, '2.JPG');
Insert into tbphoto values (3, 3, '3.JPG');
Insert into tbphoto values (4, 4, '4.JPG');
Insert into tbphoto values (5, 5, '5.JPG');
Insert into tbphoto values (6, 6, '6.JPG');
Insert into tbphoto values (7, 7, '7.JPG');
Insert into tbphoto values (8, 8, '8.JPG');
Insert into tbphoto values (9, 9, '9.JPG');
Insert into tbphoto values (10, 10, '10.JPG');
Insert into tbphoto values (11, 11, '11.JPG');
Insert into tbphoto values (12, 12, '12.JPG');
Insert into tbphoto values (13, 13, '13.JPG');
Insert into tbphoto values (14, 14, '14.JPG');
Insert into tbphoto values (15, 15, '5.JPG');
Insert into tbphoto values (16, 16, '6.JPG');
Insert into tbphoto values (17, 17, '7.JPG');
Insert into tbphoto values (18, 18, '8.JPG');
Insert into tbphoto values (19, 19, '9.JPG');


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

CREATE or REPLACE trigger TR_new_review_IN
/* trigger executes before an insert into the review table */
before insert on tbreview
/* trigger executes for each row being inserted */
for each row
/* begin a PL/SQL block */
begin
    /* get the value of the PK sequence */
    SELECT seq_review.nextval
        /*insert them into the :NEW row columns */
        into :new.reviewId
        FROM dual;
end TR_new_review_IN;
/

-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
