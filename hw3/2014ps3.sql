-- ******************************************************
-- 2014ps3.sql
--
-- Loader for PS-3 Database
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              INVENTORY database
--
-- There are 6 tables on this DB
--
-- Author:  Maria R. Garcia Altobello
--
-- Student:  Emiliy Keuthen
--
-- Date:   October 13, 2014
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool 2014ps3.lst


-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- EK: Drop children first; purge avoids recycle bin
-- ******************************************************

DROP table tborderitem purge;
DROP table tborder purge;
DROP table tbitem purge;
DROP table tbproduct purge;
DROP table tbvendor purge;
DROP table tbcustomer purge; 


-- ******************************************************
--    DROP SEQUENCES
-- Note:  Issue the appropiate commands to drop sequences
-- ******************************************************

DROP sequence seqorder;


-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tbcustomer (
        customerid      char(4)                 null
        customername    varchar2(40)            null
        customeraddress varchar2(50)            null
        customercity    varchar2(30)            null
        customerstate   char(2)                 null
        customerzip     varchar2(10)            null
        customercontact varchar2(30)            null
        customerphone   varchar2(12)            null
        customeremail   varchar2(50)            null
);


CREATE table tbitem (
        productid       char(4)                 null
        vendorid        char(4)                 null
        itemprice       number(10,2)            null
        qoh             number(8,0)             null
);


CREATE table tborder (
        orderno         number(11,0)            null
        orderdate       date                    null
        customerid      char(4)                 null
);


CREATE table tborderitem (
        orderno         number(11,0)            null
        orderitemno     char(2)                 null
        productid       char(3)                 null
        vendorid        char(4)                 null
        quantity        number(4,0)             null
        itemprice       number(10,2)            null
);


CREATE table tbproduct (
        productid       char(3)                 null
        productname     varchar2(30)            null
        budgetsales     number(4,0)             null
);


CREATE table tbvendor (
        vendorid        char(4)                 null
        vendorname      varchar2(25)            null
        vendoraddress   varchar2(50)            null
        vendorcity      varchar2(30)            null
        vendorstate     char(2)                 null
        vendorzip       varchar2(10)            null
);


-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

CREATE sequence seqorder;
    
    
-- ******************************************************
--    POPULATE TABLES
--
-- Note:  Follow instructions and data provided on PS-3
--        to populate the tables
-- ******************************************************

/* inventory tbcustomer */


/* inventory tbitem */


/* inventory tborder */


/* inventory tborderitem */


/* inventory tbproduct */


/* inventory tbvendor */


-- ******************************************************
--    VIEW TABLES
--
-- Note:  Issue the appropiate commands to show your data
-- ******************************************************

SELECT * FROM tbcustomer;
SELECT * FROM tbitem;
SELECT * FROM tborder;
SELECT * FROM tborderitem;
SELECT * FROM tbproduct;
SELECT * FROM tbvendor;


-- ******************************************************
--    QUALITY CONTROLS
--
-- Note:  Test only 5 constraints of the following types:
--        *) Entity integrity
--        *) Referential integrity
--        *) Column constraints
-- ******************************************************


-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
