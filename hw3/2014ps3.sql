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
-- Student:  Emily Keuthen
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
        customerid      char(4)                 not null
                constraint rg_customerid check 
                        (customerid between '1000' and '4999')
                constraint pk_customer primary key,
        customername    varchar2(40)            not null,
        customeraddress varchar2(50)            null,
        customercity    varchar2(30)            null,
        customerstate   char(2)                 null,
        customerzip     varchar2(10)            null,
        customercontact varchar2(30)            null,
        customerphone   varchar2(20)            null,
        customeremail   varchar2(50)            null
);


CREATE table tbvendor (
        vendorid        char(4)                 not null
                constraint pk_vendor primary key
                constraint rg_vendorid check (vendorid between '5000' and '9999'),
        vendorname      varchar2(25)            not null,
        vendoraddress   varchar2(50)            null,
        vendorcity      varchar2(30)            null,
        vendorstate     char(2)                 null,
        vendorzip       varchar2(10)            null
);


CREATE table tbproduct (
        productid       char(3)                         not null
                constraint pk_product primary key
                constraint rg_productid check (productid between '100' and '999'),
        productname     varchar2(30)                    not null,
        budgetsales     number(4,0)     default 0       null
);


CREATE table tbitem (
        productid       char(4)                         not null
                constraint fk_productid_tbitem references tbproduct (productid),
        vendorid        char(4)                         not null
                constraint fk_vendorid_tbitem references tbvendor (vendorid),
        itemprice       number(10,2)    default 0.00    null
                constraint rg_itemprice check (itemprice > 0),
        qoh             number(8,0)     default 0       not null,
                constraint pk_task primary key (productid, vendorid)
);


CREATE table tborder (
        orderno         number(11,0)            not null
                constraint pk_order primary key,
        orderdate       date    default SYSDATE not null,
        customerid      char(4)                 not null
                constraint fk_customerid_tborder references tbcustomer (customerid) on delete cascade
);


CREATE table tborderitem (
        orderno         number(11,0)            not null
                constraint fk_orderno_tbborderitem references tborder (orderno) on delete cascade,
        orderitemno     char(2)                 not null,
        productid       char(3)                 null,
        vendorid        char(4)                 null,
        quantity        number(4,0) default 0   not null,
        itemprice       number(10,2)            null,
                constraint pk_orderitem primary key (orderno, orderitemno),
                constraint fk_prodid_vendid_bitem foreign key (productid, vendorid) references tbitem (productid, vendorid) on delete cascade
);


-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

CREATE sequence seqorder
        increment by 1
        start with 1;

    
    
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
