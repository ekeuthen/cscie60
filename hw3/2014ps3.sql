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
        productid       char(3)                         not null
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
Insert into tbcustomer values ('1123','Z Best', '123 Main Street', 'Cambridge', 'MA', '02139', 'Carol Jenkins', '(617) 555-2222', 'jenkinsc@abc.com');
Insert into tbcustomer values ('1234','Pop Shop', '2233 Spring Street', 'Boston', 'MA', '02114', 'Mandy Peters', '(617) 344-1111', 'mpeters@def.com');
Insert into tbcustomer values ('1667','Zoom', '4545 Winter Street', 'Boston', 'MA', '02112', 'James Hughes', '(617) 433-3333', 'jhughes@zoomco.com');

/* inventory tbvendor */
Insert into tbvendor values ('5100', 'WeSell', '233 South Willow Street', 'Manchester', 'NH', '03102');
Insert into tbvendor values ('5200', 'Givin''', '33 Harvard Place', 'Boston', 'MA', '02211');
Insert into tbvendor values ('5300', 'Z A List', '4500 Summer Street', 'Quincy', 'MA', '02161');

/* inventory tbproduct */
Insert into tbproduct values ('100', 'Microwave', 40);
Insert into tbproduct values ('121', 'Toaster', 30);
Insert into tbproduct values ('434', 'Steamer', 40);
Insert into tbproduct values ('677', 'Coffee Maker', 20);

/* inventory tbitem */
Insert into tbitem values ('100', '5100', 55, 22);
Insert into tbitem values ('100', '5200', 66, 20);
Insert into tbitem values ('100', '5300', 70, 35);
Insert into tbitem values ('121', '5100', 12, 20);
Insert into tbitem values ('121', '5300', 15, 15);
Insert into tbitem values ('434', '5100', 18, 35);
Insert into tbitem values ('434', '5200', 25, 25);
Insert into tbitem values ('677', '5100', 40, 20);
Insert into tbitem values ('677', '5200', 46, 30);
Insert into tbitem values ('677', '5300', 48, 20);

/* inventory tborder */
Insert into tborder values (1, to_date('10-10', 'mm-yy'), '1667');
Insert into tborder values (2, to_date('10-12', 'mm-yy'), '1234');
Insert into tborder values (3, to_date('10-13', 'mm-yy'), '1667');

/* inventory tborderitem */
Insert into tborderitem values (1, '01', '100', '5300', 5, 70);
Insert into tborderitem values (1, '02', '100', '5100', 5, 55);
Insert into tborderitem values (1, '03', '121', '5100', 5, 12);
Insert into tborderitem values (2, '01', '100', '5200', 10, 65);
Insert into tborderitem values (2, '02', '677', '5300', 5, 48);
Insert into tborderitem values (3, '01', '121', '5100', 5, 12);
Insert into tborderitem values (3, '02', '677', '5300', 3, 45);
Insert into tborderitem values (3, '03', '100', '5100', 2, 55);

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

-- Validate entity integrity - unable to insert a duplicate primary key into tbcustomer  
Insert into tbcustomer (customerid, customername) values ('1234', 'Duplicate customerid');

-- Validate entity integrity - unable to insert a NULL primary key into tbproduct  
Insert into tbproduct (productid, productname) values (null, 'Null productid');

-- Validate referential integrity - unable to insert into tborderitem a foriegn key which does not match a primary key
Insert into tborderitem values (4, '03', '999', '9999', 2, 55);

-- Validate referential integrity - unable to update a primary key in tborder with an existing foriegn key
Update tborder set orderno = 4 where orderno =3;

-- Validate column constraint - unable to insert into tbitem.itemprice a negative number
Update tbitem set itemprice = -22 where productid = '100' and vendorid = '5100';


-- ******************************************************
--    QUERY TABLES
--
-- ******************************************************

-- Are there any products that are not selling?

SELECT DISTINCT P.PRODUCTNAME
FROM TBPRODUCT P
WHERE NOT EXISTS
  (SELECT DISTINCT PRODUCTID
  FROM TBORDERITEM IO
  WHERE IO.PRODUCTID = P.PRODUCTID
  );


-- Which customers have purchased toasters?

SELECT DISTINCT C.CUSTOMERNAME
FROM TBCUSTOMER C,
  TBORDER O,
  TBORDERITEM IO,
  TBPRODUCT P
WHERE C.CUSTOMERID = O.CUSTOMERID
AND O.ORDERNO      = IO.ORDERNO
AND IO.PRODUCTID   = P.PRODUCTID
AND P.PRODUCTNAME  = 'Toaster';


-- Validate that at least three vendors have offered quotes on every product.

SELECT P.PRODUCTID,
  P.PRODUCTNAME,
  COUNT (V.VENDORID) AS "NUMBER OF QUOTES"
FROM TBPRODUCT P,
  TBVENDOR V,
  TBITEM I
WHERE P.PRODUCTID = I.PRODUCTID
AND I.VENDORID    = V.VENDORID
GROUP BY P.PRODUCTID,
  P.PRODUCTNAME
HAVING COUNT (V.VENDORID) >= 3
ORDER BY 1;


-- Which vendor has the lowest price for each product?

SELECT V.VENDORNAME,
  I.PRODUCTID,
  I.ITEMPRICE
FROM TBVENDOR V,
  TBITEM I
WHERE I.VENDORID = V.VENDORID
AND I.ITEMPRICE IN
  (SELECT MIN (I.ITEMPRICE) FROM TBITEM I GROUP BY I.PRODUCTID
  )
ORDER BY 1,2;


-- Which products have been ordered or not?

SELECT DISTINCT P.PRODUCTID,
  IO.ORDERNO
FROM TBORDERITEM IO,
  TBPRODUCT P
WHERE IO.PRODUCTID (+) = P.PRODUCTID
ORDER BY 1;


-- Which customeres are located in the same city?

SELECT C.CUSTOMERNAME,
  C2.CUSTOMERNAME,
  C.CUSTOMERCITY
FROM TBCUSTOMER C,
  TBCUSTOMER C2
WHERE C.CUSTOMERCITY = C2.CUSTOMERCITY
-- ensure that customer name 1 and customer name 2 are different:
AND C.CUSTOMERNAME  != C2.CUSTOMERNAME
-- ensure that redundant rows are not included
-- could use only this limit and not the prior one, but this is clearer
AND C.CUSTOMERNAME > C2.CUSTOMERNAME
ORDER BY 1, 2;


-- How many weeks before Wiggly, Inc. runs out of some product necessary to meet the sales budget?

-- Create view listing # of weeks left for each product
CREATE VIEW WEEKS_LEFT
  (
    PRODUCTNAME,
    WEEKSLEFT
  ) AS
SELECT P.PRODUCTNAME,
  SUM (I.QOH) / P.BUDGETSALES AS WEEKSLEFT
FROM TBPRODUCT P,
  TBITEM I
WHERE P.PRODUCTID = I.PRODUCTID
GROUP BY (P.PRODUCTNAME, P.BUDGETSALES)
ORDER BY 1;

-- Query view to find minimum number of weeks
SELECT W.PRODUCTNAME,
  MIN (W.WEEKSLEFT) AS WEEKKSLEFT
FROM WEEKS_LEFT W
WHERE W.WEEKSLEFT =
  (SELECT MIN (W.WEEKSLEFT) FROM WEEKS_LEFT W
  )
GROUP BY W.PRODUCTNAME;


-- ******************************************************
--    
CREATE TRIGGERS
--
-- ******************************************************

--Create a trigger to validate the each product has quotes from at least 3 vendors.
--If product does not meet this criteria, triggers should alert the user.

CREATE or REPLACE trigger vendor_offers_rule
after insert or update or delete on tbitem
declare
  x number; /*create PL/SQL variable for count of vendors per product*/
begin
  /*products with no quotes considered */
  SELECT count (*) into x
    from TBPRODUCT p
    where not exists (select count (*)
      from TBITEM i 
      where p.PRODUCTID = i.PRODUCTID
      group by i.productid
      having count(*) >= 3);
if x > 0 then
  dbms_output.put_line (
    '***Warning each product must have at least 3 vendor quotes.***');
end if;
end vendor_offers_rule;
/


-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
