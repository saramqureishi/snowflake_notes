https://kgbnsyp-mw41958.snowflakecomputing.com
krishna
Happybirthday1


--DBT 
https://github.com/krishnaspark2005-ctrl/dbrepository/

hdfc_db
banking_schema
hdfc_Wh
accountadmin


a--> account_name   -->  orqiacv-vp82227
u--> user_name      -->  krishna 
p--> password       -->  Happybirthday1 
hdfc_db 
banking_schema 
hdfc_Wh 


snowsql -a orqiacv-vp82227 -u krishna
Happybirthday1

snowsql -a orqiacv-vp82227 -u ravi
Happybirthday1



DBT --> UI --> dbtcloud 
Happybirthday1$









---.snowsql folder 
---config


[connections.hdfc]
accountname = orqiacv-vp82227  
username = krishna
password = Happybirthday1
dbname = hdfc_db
schemaname = banking_schema
warehousename = hdfc_Wh
rolename = accountadmin

snowsql -c hdfc;

use database hdfc_db;
use schema banking_schema;
use warehouse hdfc_Wh;



UI:-
--------------------------
snowsight  --> from  2023 
classic UI --> prior 2023 

CLI:-
--------
snowsql


SQL 



Snowflake --> DB 


Oracle 
Sqlserver
Terdata        ------------->     Snowflake 
Postgresql
Mysql



HDFC   -->    Database 
------------------------------------------------------------------------------------------------------------------------------------------------
Insurance --> Schame1
Banking   --> Schame2
Loans     --> Schame3
------------------------------------------------------------------------------------------------------------------------------------------------
DB --> Schemas --> Objects 
Objects:- Tables, Views, Procedures, Functions 
Table :- Rows and rows 
Data Type :- Number , Varchar, Date


Venkat 
------------------------
On-Premise:-  24*7 
-----------------------------------------------------------------------------------------------------
Software --> V1  --> V2 
Hardware --> 1 TB , 32 GB RAM 
upgrade 
24*7 
Patches 


50 --> 2 months  --> 2000
50 --> 2 months  --> 20

Hardware --> 1 TB , 32 GB RAM   --> 2 TB , 64 GB RAM    --> Scale up 
Hardware --> 1 TB , 32 GB RAM   --> 500 GB , 8 GB RAM   --> Scale Down 


Cloud :-
-------
AWS 
Azure
GCP 


Saas
Paas 
Iaas
Daas 



url --> username/password 



PC1            PC2            PC3 
4gb RAM       8gb RAM        16gb RAM 

external Hard Disk --> 1 TB --> fiels/images/Videos 

Read  --> select 
write  --> insert/update/delete 


Data Engineer:-
------------------
AWS Data Engineer
Azure Data Engineer
GCP Data Engineer
Snwoflake Data Engineer


DB                     + Cloud      + ETL + Scripting  + Repoting 
Snwoflake/ORacle         AWS          DBT   Python       PowerBI/Sigma  
                         AZURE 
						 GCP 


Snowflake  --> 25
DBT        --> 12 
AWS     ---> AWS Glue , buckets, roles , policies 
Azure   -->  ADF , container, storage account 
GCP 
Python 
Astronomoer
Github
Vscode 
Airflow   --> 2 
Docker 
PowerBI/Sigma      --> 2 


Oracle --> IICS --> Snowflake 

ORacle --> AWS Glue --> S3  --> Snowflake 

DBT Project 
 


DBT --> 
--------
DBT Core 
DBT Cloud 


Snowflake
Snowflake+ SQL 
Snowflake+ AWS 
Snowflake+ DBT 



TCS :-
---------
10 people  --> 10 Laks 


5 people   --> 5 laks 

AI -->   chatgop , copolit , cursor ,devi ai , amazon bedrock , 


HDFC   -->    Database 
------------------------------------------------------------------------------------------------------------------------------------------------
Insurance --> Schame1
Banking   --> Schame2
Loans     --> Schame3
------------------------------------------------------------------------------------------------------------------------------------------------
DB --> Schemas --> Objects 
Objects:- Tables, Views, Procedures, Functions 
Table :- Rows and rows 
Data Type :- Number , Varchar, Date
;


create database hdfc_db;
create schema loans_schema;  --- ctrl+enter 
create schema insurance_schema;
create schema banking_schema;




create or replace table viewers
(
viewerid number,
programmeid number,
viewername varchar(30) 
);

create or replace table programme
(
programmeid number,
channelid number,
programme_name varchar(40) 
);

create or replace table channel
(
channelid number,
category varchar(1),
channelname varchar(30) 
);

create or replace table channelcategory
(
categoryid varchar(1),
categoryname varchar(30) 
);



----------------------

create or replace table train_details_tbl
(
train_id int,
train_name varchar(50),
train_type varchar(5) ,
train_time varchar(4) ,
train_from varchar(5) ,
train_to varchar(5),
train_speed int
);

create or replace table train_type_tbl
(
train_type varchar(5),
train_description varchar(30)
);

create or replace table train_stations_tbl
(
station_id varchar(5),
station_name varchar(30)
);



create or replace table registration
(
reg_id decimal(10,0),
reg_year decimal(10,0),
reg_date date,
student_id decimal(10,0),
section_id decimal(10,0),
midterm_grade varchar(10),
fullterm_grade varchar(10)
);

create or replace table student
(
student_id decimal(10,0),
last_name varchar(40),
first_name varchar(40),
email varchar(100),
phone decimal(20,0)
);

create or replace table section
(
section_id decimal(10,0),
course_id decimal(10,0),
schedule_id decimal(10,0),
instructor_id decimal(10,0),
room varchar(20)
);

create or replace table course
(
course_id decimal(10,0),
name varchar(40),
type varchar(30),
term decimal(10,0)
);


create or replace table schedule
(
schedule_id decimal(10,0),
day varchar(20),
starttime varchar(30),
endtime varchar(30)
);

create or replace table instructor
(
instructor_id decimal(10,0),
last_name varchar(40),
first_name varchar(40),
type varchar(40),
dept_id decimal(10,0)
);



create or replace table department
(
dept_id decimal(10,0),
name varchar(40)
);



create or replace table product_category
(
product_category_id decimal(18,0),
product_id decimal(18,0),
category_id decimal(18,0)
);

create or replace table order_item
(
order_item_id decimal(18,0),
order_id decimal(18,0),
order_delivery_id decimal(18,0),
product_id decimal(18,0),
quantity decimal(10,0)
);

create or replace table category
(
category_id decimal(18,0),
code varchar(20),
name  varchar(40)
);

create or replace table product
(
product_id decimal(18,0),
code varchar(20),
name  varchar(40),
unit_price decimal(10,0)
);


create or replace table order_delivery
(
order_delivery_id decimal(18,0),
order_id decimal(18,0),
tracking_no decimal(10,0),
status varchar(90)
);

create or replace table payment
(
payment_id decimal(18,0),
order_id decimal(18,0),
status varchar(90),
cctype varchar(40),
ccname varchar(200),
ccdate varchar(200)
);

create or replace table customer_order
(
order_id decimal(18,0),
customer_id decimal(18,0),
username varchar(40) 
);


create or replace table customer_address
(
customer_address_id decimal(18,0),
customer_id decimal(18,0),
first_name varchar(40) ,
last_name varchar(40) ,
address varchar(200) ,
phone decimal(10,0),
email varchar(60) 
);


create or replace table customer
(
customer_id decimal(18,0),
username varchar(40) ,
password varchar(40) 
);


create or replace table emp_leave_info
(
empid varchar(10),
from_date date,
to_date date,
total_leaves decimal(10,0),
leave_type varchar(5)
);

create or replace table emp_payroll
(
transno decimal(10,0),
empid varchar(10),
month varchar(10),
year decimal(4,0),
totalearning decimal(10,0),
netpay decimal(10,0)
);

create or replace table employee_info
(
empid varchar(10),
empname varchar(20),
deptid varchar(10),
joining_dt date,
dob date,
yrs_of_exp decimal(10,0),
employee_category  varchar(1)
);


create or replace table dept_info
(
deptid varchar(10),
deptname varchar(20),
location varchar(20)
);

create or replace table allocated_leave_info
(
employee_category varchar(1),
cl decimal(10,0),
el decimal(10,0),
ml decimal(10,0)
);

create or replace table salary_info
(
employee_category varchar(1),
basic decimal(7,2),
travelling_allowance decimal(6,2),
dearness_allowance decimal(6,2),
house_rent_allowance decimal(6,2),
location_allowance decimal(6,2),
provident_fund decimal(6,2),
medical_allowance decimal(6,2),
proftax decimal(6,2),
insurance decimal(6,2)
);


Read    --> select 
Write   --> insert/update/delete 

;

alter warehouse hdfc_wh set auto_Resume=false;
alter warehouse hdfc_wh suspend;

;
alter warehouse hdfc_wh resume;

insert into programme values('101','1','Sportscenter');
insert into programme values('102','2','Ace');
insert into programme values('103','3','Kingkong');
insert into programme values('104','4','Terminator');
insert into programme values('105','5','Roadies');
insert into programme values('106','6','Remix');
insert into programme values('107','7','Comedy Circus');
insert into programme values('108','8','Mahadev');

select * from programme;

-- metadata 
select * from information_schema.databases;
select * from information_schema.schemata;
show warehouses;
select * from information_schema.tables where table_type='BASE TABLE';





insert into viewers values('1001','101','Rohit');
insert into viewers values('1002','102','Akash');
insert into viewers values('1003','103','Vicky');
insert into viewers values('1004','104','Ajay');
insert into viewers values('1005','105','Vishal');
insert into viewers values('1006','106','Mohit');
insert into viewers values('1007','107','Nakul');
insert into viewers values('1008','108','Himanshu');
insert into viewers values('1006','102','Mohit');
insert into viewers values('1007','101','Nakul');

select * from viewers;
alter warehouse hdfc_wh resume;


select current_user();

select current_database();
select current_schema();
select current_warehouse();
select current_role();



TCS:-
----
Role        user      privilege     object_Type     object_name
---------------------------------------------------------
MANAGER     RAVI       usage           database        hdfc_Db
MANAGER     RAVI       usage           schema          banking_Schema 
MANAGER     RAVI       usage           warehouse       hdfc_Wh
MANAGER     RAVI       select          table           programme
MANAGER     RAVI       select          table           viewers

;
grant <privilege> on object_Type <object_name> to role <role_name>;

grant usage on database   hdfc_Db to role MANAGER;
grant usage on schema   banking_Schema to role MANAGER;
grant usage on warehouse   hdfc_wh to role MANAGER;
grant select on table   programme to role MANAGER;
grant select on table   viewers to role MANAGER;




show users;

create user ravi 
password='Happybirthday1';

create role manager;

create user balaji 
password='Happybirthday1';

 grant role manager to user balaji;

--assign role to a user 
grant role <role_name> to user <user_name>;

grant role manager to user ravi;

RBAC --> Role based access control 





;

create database dev_Db;
create schema bronze;
create schema silver;
create schema gold;



select current_user();
select current_database();
select current_date();
select current_timestamp();



Full load 
incremntal load 
scd type 2 
soft delete 
upsert 



--------------31st August 
create database dev_db;  --- ctrl+enter
create schema dev_schema;
create warehouse dev_Wh;

select * from information_schema.tables where table_type='BASE TABLE';
select * from information_schema.columns where table_name='T_CUSTOMER';

select current_date(); -- 2026-08-30   America/Los_Angeles

show parameters like 'timezone';

select current_user();
select current_database();
select current_schema();

select dayofyear(current_date());

select get_ddl('TABLE','T_CUSTOMER');

create or replace TABLE T_CUSTOMER (
	ID NUMBER(38,0),
	FIRSTNAME VARCHAR(16777216),
	LASTNAME VARCHAR(16777216),
	EMAIL VARCHAR(16777216),
	COMPANY VARCHAR(16777216),
	PHONE NUMBER(38,0),
	AREA VARCHAR(16777216),
	LOCALITY VARCHAR(16777216),
	CITY VARCHAR(16777216),
	STATECODE VARCHAR(16777216),
	PINCODE NUMBER(38,0),
	COUNTRY VARCHAR(16777216)
);

show functions;


select * from information_schema.databases;
select * from information_schema.schemata;

select * from information_schema.tables where table_type='BASE TABLE';
show warehouses;
;

create schema loans_schema;

show tables;
select * from information_schema.tables where table_type='BASE TABLE';


use schema loans_schema;
use schema dev_schema;


create database hdfc_db;
create schema banking_Schema;
create schema insurance_Schema;

use database hdfc_db;
use schema banking_schema;

use schema dev_db.dev_schema;

use schema hdfc_db.banking_schema;

show users;

TCS:-
-----
--Role_name------user-------privilege ------object_type-------object_name
MANAGER     Ravi        usage          database          dev_Db
MANAGER     Ravi        usage          schema            dev_schema
MANAGER     Ravi        usage          warehouse         dev_wh
MANAGER     Ravi        select         table             t_customer
MANAGER     Ravi        select         table             t_new_customer
;

grant <privilege> on <object_type> <object_name> to role <Role_name>;
grant usage on database dev_Db to role MANAGER;
grant usage on schema dev_schema to role MANAGER;
grant usage on warehouse dev_wh to role MANAGER;
grant select on table t_customer to role MANAGER;
grant select on table t_new_customer to role MANAGER;


grant create database on account  to role manager;








create user ravi password='Happybirthday1';
create role manager;

-- assign role to the user 
grant role <role_name> to user <user_name>;

grant role manager to user ravi;


RBAC :- Role based Access Control 
;

------ log in as Ravi and execute the below commands 
select current_user();
select current_role();

show grants to role manager;

create database sales_db;
create schema sales_schema;

create table t_emp(empno number,ename varchar);

 

use database hdfc_db;
use schema banking_schema;
use warehouse hdfc_Wh;



create warehouse hdfc_Wh;


list @~;

D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv   -->   @~

put file://<source_location> <target_stage>;


put file://D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv @~;


rm @~/Cust_Info.csv.gz;
rm @~/Cust_Info.csv;

list @~;


select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~;
select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv;

show tables;

show file formats;


create file format csv_format
type=csv 
field_delimiter=','
skip_header=1;

select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv ;
select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv (file_format=>csv_format);


create table t_cust_info
(
ID number,
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number,
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
); 

Copy into <table_name> from (select $1,$2,$3.... from @stage_name (file_format=>format_name));


copy into t_cust_info from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv (file_format=>csv_format));

select * from t_cust_info;



list @~;



C:\Users\Balakrishna>snowsql -a orqiacv-vp82227 -u krishna
Password:
* SnowSQL * v1.5.1
Type SQL statements or !help
krishna#COMPUTE_WH@(no database).(no schema)>use database hdfc_db;
+----------------------------------+
| status                           |
|----------------------------------|
| Statement executed successfully. |
+----------------------------------+
1 Row(s) produced. Time Elapsed: 0.113s
krishna#COMPUTE_WH@HDFC_DB.PUBLIC>use schema banking_schema;
+----------------------------------+
| status                           |
|----------------------------------|
| Statement executed successfully. |
+----------------------------------+
1 Row(s) produced. Time Elapsed: 0.129s
krishna#COMPUTE_WH@HDFC_DB.BANKING_SCHEMA>use warehouse hdfc_Wh;
+----------------------------------+
| status                           |
|----------------------------------|
| Statement executed successfully. |
+----------------------------------+
1 Row(s) produced. Time Elapsed: 0.117s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>list @~;
+------+------+-----+---------------+
| name | size | md5 | last_modified |
|------+------+-----+---------------|
+------+------+-----+---------------+
0 Row(s) produced. Time Elapsed: 0.128s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>put file://D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv @~;
+---------------+------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source        | target           | source_size | target_size | source_compression | target_compression | status   | message |
|---------------+------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| Cust_Info.csv | Cust_Info.csv.gz |        5174 |        1840 | NONE               | GZIP               | UPLOADED |         |
+---------------+------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 2.704s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>put file://D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv @~ autocompress=false;
001006 (22023): SQL compilation error:
invalid parameter 'autocompress'
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>put file://D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv @~ auto_compress=false;
+---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source        | target        | source_size | target_size | source_compression | target_compression | status   | message |
|---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------|
| Cust_Info.csv | Cust_Info.csv |        5174 |        5184 | NONE               | NONE               | UPLOADED |         |
+---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 0.570s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>put file://D:\2026\Sep_2026\stg_csv_files\Cust_Info.csv @~ auto_compress=false;
+---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source        | target        | source_size | target_size | source_compression | target_compression | status   | message |
|---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------|
| Cust_Info.csv | Cust_Info.csv |        5174 |        5184 | NONE               | NONE               | UPLOADED |         |
+---------------+---------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 0.621s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>put file://D:\2026\Sep_2026\stg_csv_files\t_emp.csv @~ auto_compress=false;
+-----------+-----------+-------------+-------------+--------------------+--------------------+----------+---------+
| source    | target    | source_size | target_size | source_compression | target_compression | status   | message |
|-----------+-----------+-------------+-------------+--------------------+--------------------+----------+---------|
| t_emp.csv | t_emp.csv |         718 |         720 | NONE               | NONE               | UPLOADED |         |
+-----------+-----------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 0.931s
krishna#HDFC_WH@HDFC_DB.BANKING_SCHEMA>





show users;

list @~;

list @%t_cust_info;

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));

list @%emp;


grant usage on database   hdfc_Db to role MANAGER;
grant usage on schema   banking_Schema to role MANAGER;
grant usage on warehouse   hdfc_wh to role MANAGER;
grant select on table   emp to role MANAGER;


select current_region();

put file://D:\2026\Sep_2026\stg_csv_files\t_emp.csv @%emp auto_compress=false;

rm @%emp/t_emp.csv.gz;


select $1,$2,$3,$4,$5,$6,$7,$8 from @%emp;

show file formats;

create file format csv_Format 
type=csv 
skip_header=1
field_delimiter=',';


create file format csv_Format_new
type=csv 
skip_header=1
field_delimiter='_';

select $1,$2,$3,$4,$5,$6,$7,$8 from @%emp (file_format=>csv_Format);

drop file format csv_format;
drop file format csv_format_new;

list @%emp;


select $1,$2,$3,$4,$5,$6,$7,$8 from @%emp/t_emp.csv (file_format=>csv_Format);

select $1,$2,$3,$4,$5,$6,$7,$8 from @%emp/emp_other.csv (file_Format=>csv_Format_new);

select * from emp;

Copy into emp from (select $1,$2,$3,$4,$5,$6,$7,$8 from @%emp/emp_other.csv (file_Format=>csv_Format_new));

show stages;

 
create stage stg_csv_stage;  -- CSV_FORMAT
create stage stg_json_stage; -- json_format
create stage stg_xml_stage;  --  xml_format
create stage stg_parquet_stage; -- parquet_format_
create stage stg_avro_stage;    -- avro_format 
  
show file formats;

create file format json_format
type=json;

create file format xml_format
type=xml;

create file format parquet_format
type=parquet;

create file format avro_format
type=avro;



select * from t_cust_info;

select id,firstname from t_cust_info where id =1;


select object_construct(*) from t_cust_info;


delete from t_cust_info;


select * from t_cust_info;

list @stg_json_stage;

select $1 from @stg_json_stage (file_Format=>json_format);



----




select object_construct(*) from t_cust_info;


delete from t_cust_info;


select * from t_cust_info;

list @stg_json_stage;

select $1 from @stg_json_stage (file_Format=>json_format);

show stages;

list @stg_json_stage;

desc stage stg_json_stage;

show file formats;
select * from information_schema.file_formats;

alter stage stg_json_stage set file_format=JSON_FORMAT;


select $1 from @stg_json_stage/cust_info.json ;

json --> Key:value 
;



create table t_cust_info 
(
AREA    varchar,                                 
CITY    varchar,                                 
COMPANY    varchar,                              
COUNTRY    varchar,                              
EMAIL    varchar,                                
FIRSTNAME    varchar,                            
ID    number,                                   
LASTNAME    varchar,                             
LOCALITY    varchar,                             
PHONE    number,                                
PINCODE    varchar,                              
STATECODE    varchar 
);

:: --> cast operator 


select $1 from @stg_json_stage/cust_info.json ;

value --> column_name:key_name
;
select $1:AREA from @stg_json_stage/cust_info.json ;

select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info.json ;

select * from t_cust_info;

copy into t_cust_info from (select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info.json);


select * from [1,2,3,4,5];

select * from  lateral flatten(['Ravi','Krishna','Vijay']);

select value::varchar as name  from  lateral flatten(['Ravi','Krishna','Vijay']);



select * from [10,20,30,40,50];
select * from lateral flatten([10,20,30,40,50]);

select value::number as empno from lateral flatten([10,20,30,40,50]);

select '1';
select '1'::number;

select cast('1' as number);


---- tablular functions --> output is in the form a table 

select * from table(information_schema.query_history());

copy into <table_name> from (select statement (file_format));

copy into t_cust_info from ();

select $1 from @stg_json_Stage/cust_info_20260902.json;
select $1 from @stg_json_Stage/cust_info_20260903.json;


select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info_20260902.json;

select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info_20260903.json;


copy into t_cust_info from (
select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info_20260903.json
);

copy into t_cust_info from (
select $1:AREA::varchar as area ,
$1:CITY::varchar as CITY ,
$1:COMPANY::varchar as COMPANY ,
$1:COUNTRY::varchar as COUNTRY ,
$1:EMAIL::varchar as EMAIL ,
$1:FIRSTNAME::varchar as FIRSTNAME ,
$1:ID::number as id ,
$1:LASTNAME::varchar as LASTNAME ,
$1:LOCALITY::varchar as LOCALITY ,
$1:PHONE::number as PHONE ,
$1:PINCODE::varchar as PINCODE ,
$1:STATECODE::varchar as STATECODE 
from @stg_json_stage/cust_info_20260902.json
);

t_cust_info:
-------------------------------
cust_info.json           ---50
cust_info_20260902.json  ---1 
cust_info_20260903.json  ---2 

;

select * from table(information_schema.copy_history(table_name=>'t_cust_info',start_time=>dateadd('days',-3,current_timestamp())));


select current_timestamp();

2026-09-02 19:14:17.064 -0700
2026-08-31 19:14:17.064 -0700
;

select dateadd('days',3,current_date());
select dateadd('days',5,current_date());

select dateadd('days',-3,current_date());


select * from table(infer_schema(LOCATION => '@stg_json_Stage' , FILE_FORMAT => 'json_format' , FILES => 'cust_info_20260902.json'));


select concat('My name is ',' KRsihna');

select expression,' as ',column_name from table(infer_schema(LOCATION => '@stg_json_Stage' , FILE_FORMAT => 'json_format' , FILES => 'cust_info_20260902.json'));
select concat(expression,' as ',column_name,',') from table(infer_schema(LOCATION => '@stg_json_Stage' , FILE_FORMAT => 'json_format' , FILES => 'cust_info_20260902.json'));


copy into t_cust_info from (
select $1:AREA::TEXT as AREA,
$1:CITY::TEXT as CITY,
$1:COMPANY::TEXT as COMPANY,
$1:COUNTRY::TEXT as COUNTRY,
$1:EMAIL::TEXT as EMAIL,
$1:FIRSTNAME::TEXT as FIRSTNAME,
$1:ID::NUMBER(2, 0) as ID,
$1:LASTNAME::TEXT as LASTNAME,
$1:LOCALITY::TEXT as LOCALITY,
$1:PHONE::NUMBER(10, 0) as PHONE,
$1:PINCODE::TEXT as PINCODE,
$1:STATECODE::TEXT as STATECODE
from @stg_json_stage/cust_info_20260902.json
);



drop table t_cust_info;

show file formats;




select * from table(information_schema.query_history());
select * from table(information_schema.copy_history(table_name=>'t_Cust_info',start_time=>dateadd('days',-3,current_timestamp())));

select * from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));


select * from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));

create table t_Sales(sid number, product varchar);

insert into t_Sales values(1,'P1');
insert into t_Sales values(2,'P2');

select * from t_Sales;

select object_construct(*) from t_Sales;


select expression,' as ', column_name from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));

select concat(expression,' as ', column_name,',') from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));


select object_construct(*) from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));

select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'));

create table t_cust_info 
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@stg_json_stage' , FILE_FORMAT => 'JSON_FORMAT' , FILES => 'cust_info_20260902.json'))
);


select * from t_cust_info;


list @stg_json_Stage;


copy into t_cust_info from (select  $1:AREA::TEXT as AREA,
$1:CITY::TEXT as CITY,
$1:COMPANY::TEXT as COMPANY,
$1:COUNTRY::TEXT as COUNTRY,
$1:EMAIL::TEXT as EMAIL,
$1:FIRSTNAME::TEXT as FIRSTNAME,
$1:ID::NUMBER(2, 0) as ID,
$1:LASTNAME::TEXT as LASTNAME,
$1:LOCALITY::TEXT as LOCALITY,
$1:PHONE::NUMBER(10, 0) as PHONE,
$1:PINCODE::TEXT as PINCODE,
$1:STATECODE::TEXT as STATECODE
from @stg_json_Stage/cust_info.json 
);

copy into t_cust_info from (select  $1:AREA::TEXT as AREA,
$1:CITY::TEXT as CITY,
$1:COMPANY::TEXT as COMPANY,
$1:COUNTRY::TEXT as COUNTRY,
$1:EMAIL::TEXT as EMAIL,
$1:FIRSTNAME::TEXT as FIRSTNAME,
$1:ID::NUMBER(2, 0) as ID,
$1:LASTNAME::TEXT as LASTNAME,
$1:LOCALITY::TEXT as LOCALITY,
$1:PHONE::NUMBER(10, 0) as PHONE,
$1:PINCODE::TEXT as PINCODE,
$1:STATECODE::TEXT as STATECODE
from @stg_json_Stage/cust_info_20260903.json 
);

copy into t_cust_info from (select  $1:AREA::TEXT as AREA,
$1:CITY::TEXT as CITY,
$1:COMPANY::TEXT as COMPANY,
$1:COUNTRY::TEXT as COUNTRY,
$1:EMAIL::TEXT as EMAIL,
$1:FIRSTNAME::TEXT as FIRSTNAME,
$1:ID::NUMBER(2, 0) as ID,
$1:LASTNAME::TEXT as LASTNAME,
$1:LOCALITY::TEXT as LOCALITY,
$1:PHONE::NUMBER(10, 0) as PHONE,
$1:PINCODE::TEXT as PINCODE,
$1:STATECODE::TEXT as STATECODE
from @stg_json_Stage/cust_info_20260902.json 
);

select * from table(information_schema.copy_history(table_name=>'t_Cust_info',start_time=>dateadd('days',-3,current_timestamp())));


select * from t_cust_info;

select get_ddl(object_Type,object_name);
select get_ddl('TABLE','T_CUST_INFO');

create or replace TABLE T_CUST_INFO (
	AREA VARCHAR(16777216),
	CITY VARCHAR(16777216),
	COMPANY VARCHAR(16777216),
	COUNTRY VARCHAR(16777216),
	EMAIL VARCHAR(16777216),
	FIRSTNAME VARCHAR(16777216),
	ID NUMBER(2,0),
	LASTNAME VARCHAR(16777216),
	LOCALITY VARCHAR(16777216),
	PHONE NUMBER(10,0),
	PINCODE VARCHAR(16777216),
	STATECODE VARCHAR(16777216)
);



-------------------  7th Sep 
show stages;

list @stg_json_Stage/kids_data.json;

select $1 from @stg_json_Stage/kids_data.json;

value --> column:key_name
;

select * from lateral flatten(['Pavan', 'Chandra']);


select a.$1:Name::varchar as Name,
a.$1:Gender::varchar as Gender,
a.$1:DOB::date as DOB,
from @stg_json_Stage/kids_data.json a ;


select a.$1:Name::varchar as Name,
a.$1:Gender::varchar as Gender,
a.$1:DOB::date as DOB,
a.$1:Kids
from @stg_json_Stage/kids_data.json a ;

select b.*
from @stg_json_Stage/kids_data.json a ,
lateral flatten(a.$1:Kids) b ;

select  b.*
from @stg_json_Stage/kids_data.json a ,
lateral flatten(a.$1:Kids) b;

select c.*
from @stg_json_Stage/kids_data.json a ,
lateral flatten(a.$1:Kids_School) c;

create table t_kids_info as 
select a.$1:Name::varchar as Name,
a.$1:Gender::varchar as Gender,
a.$1:DOB::date as DOB,
b.value::varchar as kids_name,
c.value::varchar as kids_school_name,
a.$1:Address:House_Number::varchar as hno,
a.$1:Address:City::varchar as City,
a.$1:Address:State::varchar as State,
a.$1:Phone:Office::number as office_number,
a.$1:Phone:Personal::number as personal_number
from @stg_json_Stage/kids_data.json a ,
lateral flatten(a.$1:Kids) b ,
lateral flatten(a.$1:Kids_School) c
where b.index=c.index;



select * from t_kids_info;


select $1 from @stg_json_Stage/cust_ordered_products.json;

select b.value:customer_id::varchar as customer_id,
b.value:name::varchar as name,
b.value:email::varchar as email,
c.value:order_id::varchar as order_id,
c.value:date::varchar as ordered_date,
c.value:total::number as total_amount,
d.value:product_id::varchar as product_id,
d.value:name::varchar as name,
d.value:qty::number as qty,
d.value:price::number as price,
from @stg_json_Stage/cust_ordered_products.json a , 
lateral flatten(a.$1:customers) b ,
lateral flatten(b.value:orders) c ,
lateral flatten(c.value:products) d ;


The query uses three levels of LATERAL FLATTEN to unnest the nested JSON:

FLATTEN(a.$1:customers) — expands each customer into a row
FLATTEN(b.value:orders) — expands each customer's orders
FLATTEN(c.value:products) — expands each order's products
This will produce 6 rows — one per product line item — with all the customer and order context carried along. You can run it directly to see the result.


---8th Sep

list @stg_parquet_Stage;

list @stg_parquet_stage/Items_Info.parquet;

select $1 from @stg_parquet_stage/Items_Info.parquet;

desc stage stg_parquet_stage;

show file formats;

alter stage stg_parquet_stage set file_format=PARQUET_FORMAT;

select $1 from @stg_parquet_stage/Items_Info.parquet;

select * from table(infer_schema(LOCATION => '@stg_parquet_stage' , FILE_FORMAT => 'PARQUET_FORMAT' , FILES => 'Items_Info.parquet'));


select concat(expression,' as ',column_name,',') from table(infer_schema(LOCATION => '@stg_parquet_stage' , FILE_FORMAT => 'PARQUET_FORMAT' , FILES => 'Items_Info.parquet'));


create table t_items_info 
using template(
select array_Agg(object_construct(*)) from table(infer_schema(LOCATION => '@stg_parquet_stage' , FILE_FORMAT => 'PARQUET_FORMAT' , FILES => 'Items_Info.parquet'))
);

select  
$1:id::TEXT as id,
$1:item_id::TEXT as item_id,
$1:dept_id::TEXT as dept_id,
$1:cat_id::TEXT as cat_id,
$1:store_id::TEXT as store_id,
$1:state_id::TEXT as state_id,
$1:d::NUMBER(38, 0) as d,
$1:value::NUMBER(38, 0) as value,
$1:date::NUMBER(38, 0) as date,
$1:__index_level_0__::NUMBER(38, 0) as __index_level_0__,
from @stg_parquet_Stage/Items_Info.parquet;



copy into t_items_info from (select  
$1:id::TEXT as id,
$1:item_id::TEXT as item_id,
$1:dept_id::TEXT as dept_id,
$1:cat_id::TEXT as cat_id,
$1:store_id::TEXT as store_id,
$1:state_id::TEXT as state_id,
$1:d::NUMBER(38, 0) as d,
$1:value::NUMBER(38, 0) as value,
$1:date::NUMBER(38, 0) as date,
$1:__index_level_0__::NUMBER(38, 0) as __index_level_0__,
from @stg_parquet_Stage/Items_Info.parquet);


select * from table(information_schema.copy_history(table_name=>'t_items_info',start_time=>dateadd(hours,-1,current_timestamp())));



select * from table(information_schema.query_history());

select * from snowflake.account_usage.query_history;
select * from snowflake.account_usage.copy_history;

select * from snowflake.account_usage.query_history where database_name='HDFC_DB' and schema_name='BANKING_SCHEMA'
and warehouse_name='HDFC_WH'
and start_time>='2026-09-06 00:00:00.000 -0700';


select * from t_cust_info;


list @stg_xml_stage;

list @stg_xml_stage/emp.xml;

select $1,$2 from @stg_xml_stage/emp.xml; -- XML file format can produce one and only one column


alter stage stg_xml_stage set file_format=xml_format;


select $1 from @stg_xml_stage/emp.xml;


TAGS 

-- Root TAg
<EMPLOYEES>
</EMPLOYEES>

--Record Tag
 <EMP>
 </EMP>

-- Column Tag 
 <EMPNO>
 </EMPNO>

;

select $1:"@" from @stg_xml_stage/emp.xml;

select a.$1:"$" from @stg_xml_stage/emp.xml a ;

select b.* from @stg_xml_stage/emp.xml a ,
lateral flatten(a.$1:"$") b ;

select b.value from @stg_xml_stage/emp.xml a ,
lateral flatten(a.$1:"$") b ;

select xmlget(b.value, 'EMPNO') from @stg_xml_stage/emp.xml a ,
lateral flatten(a.$1:"$") b ;

select xmlget(b.value, 'EMPNO'):"$"::number as empno,
xmlget(b.value, 'ENAME'):"$"::varchar as ENAME,
xmlget(b.value, 'JOB'):"$"::varchar as JOB,
xmlget(b.value, 'MGR'):"$"::number as MGR,
xmlget(b.value, 'HIREDATE'):"$"::date as HIREDATE,
xmlget(b.value, 'SAL'):"$"::number as SAL,
xmlget(b.value, 'COMM'):"$"::number as COMM,
xmlget(b.value, 'DEPTNO'):"$"::number as DEPTNO,
from @stg_xml_stage/emp.xml a ,
lateral flatten(a.$1:"$") b ;

create or replace  table t_Emp_info as 
select xmlget(b.value, 'EMPNO'):"$"::number as empno,
xmlget(b.value, 'ENAME'):"$"::varchar as ENAME,
xmlget(b.value, 'JOB'):"$"::varchar as JOB,
xmlget(b.value, 'MGR'):"$"::number as MGR,
xmlget(b.value, 'HIREDATE'):"$"::varchar as HIREDATE,
xmlget(b.value, 'SAL'):"$"::number as SAL,
xmlget(b.value, 'COMM'):"$"::number as COMM,
xmlget(b.value, 'DEPTNO'):"$"::number as DEPTNO,
from @stg_xml_stage/emp.xml a ,
lateral flatten(a.$1:"$") b ;


select * from t_Emp_info;

YYYY-MM-DD


17-DEC-80
DD-MON-YY
;

select * from table(information_schema.query_history());

-- 01c6ec75-3203-4f63-0018-21b6000d44de
select * from table(result_scan('01c6ec75-3203-4f63-0018-21b6000d44de'));

update t_cust_info set company='BOA' where company='HCL';

select * from t_emp_info;

update t_emp_info set comm = 5000;

delete from t_emp_info where deptno=10;

select * from table(result_scan('01c6ec8e-3203-4f46-0018-21b6000d6852'));

select "number of rows updated" as rows_updated from table(result_scan('01c6ec8e-3203-4f46-0018-21b6000d6852'));

select * from table(result_scan('01c6ec90-3203-4f63-0018-21b6000d4912'));

select "number of rows deleted" as rows_deleted from table(result_scan('01c6ec90-3203-4f63-0018-21b6000d4912'));


delete from t_emp;

select LAST_QUERY_ID(); -- 01c6ec95-3203-4f46-0018-21b6000d699a

select * from table(result_scan('01c6ec95-3203-4f46-0018-21b6000d699a'));

select "number of rows deleted" as rows_deleted from table(result_scan('01c6ec95-3203-4f46-0018-21b6000d699a'));




--to generate temp emails 
https://temp-mail.org/en/


https://aws.amazon.com/console/
futureplanof4458@gmail.com
Happybirthday1


aws_csv_stage
s3://bkt09092026/stg_csv_files/
This stage is used to access csv files from aws


--aws 
create storage integration <storage_integration_name>
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'iam_user_arn'
enabled = true
storage_allowed_locations = ( 's3://<location1>' ); 

--gcp 
create storage integration <storage_integration_name>
    type = external_stage
    storage_provider = gcs
    enabled = true
    storage_allowed_locations = ( 'gcs://<location1>', 'gcs://<location2>' );

--azure 
create storage integration <storage_integration_name>
    type = external_stage
    storage_provider = azure
    azure_tenant_id = '<azure_tenant_id>'
    enabled = true
    storage_allowed_locations = ( 'azure://<location1>', 'azure://<location2>' );


--internal stage 
CREATE STAGE csv_stage;

-----integration

show integrations;

create storage integration aws_integration
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::547960255593:role/role09092026'
enabled = true
storage_allowed_locations = ( 's3://bkt09092026/stg_csv_files/' ); 


desc storage integration aws_integration;

--from AWS 
STORAGE_AWS_ROLE_ARN	 	    arn:aws:iam::547960255593:role/role09092026
STORAGE_ALLOWED_LOCATIONS	 	s3://bkt09092026/stg_csv_files/
---from snowflake
STORAGE_AWS_IAM_USER_ARN	 	arn:aws:iam::782893932506:user/meu52000-s
STORAGE_AWS_EXTERNAL_ID	 	    ID06061_SFCRole=2_7OYEw4qpUnC2EouqHonmjZ2ZY9Y=

--external stage 
CREATE STAGE aws_csv_stage 
	URL = 's3://bkt09092026/stg_csv_files/' 
	STORAGE_INTEGRATION = AWS_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';


iam_role_arn:-
--------------
IAM 
ROLE 
ARN 

;

show stages;

CREATE STAGE aws_csv_stage 
	URL = 's3://bkt09092026/stg_csv_files/' 
	STORAGE_INTEGRATION = AWS_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';


list @aws_csv_stage;

select * from t_cust_info;

delete from t_cust_info;


copy into t_cust_info from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @aws_csv_stage  (file_format=>csv_format));
copy into t_cust_info from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv (file_format=>csv_format));





s3://bkt11092026/stg_csv_files/
s3://bkt11092026/stg_json_files/


iam_role_arn

iam 
role 
arn 



create storage integration S3_INTEGRATION
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::547960255593:role/role11092026'
enabled = true
storage_allowed_locations = ( 's3://bkt11092026/stg_csv_files/','s3://bkt11092026/stg_json_files/' ); 


desc storage integration S3_INTEGRATION;

--aws 
STORAGE_AWS_ROLE_ARN	 	    arn:aws:iam::547960255593:role/role11092026
STORAGE_ALLOWED_LOCATIONS	 	s3://bkt11092026/stg_csv_files/,s3://bkt11092026/stg_json_files/

--snowflake 
STORAGE_AWS_IAM_USER_ARN	arn:aws:iam::782893932506:user/meu52000-s
STORAGE_AWS_EXTERNAL_ID	 	ID06061_SFCRole=2_feUi4vGbVTYQS94x/V3IFvFy3nY=

CREATE STAGE s3_csv_stage 
	URL = 's3://bkt11092026/stg_csv_files/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';


s3://bkt11092026/stg_parquet_files/
s3://bkt11092026/stg_avro_files/

------------------------------11th Sep 

---11th
show integrations;


create storage integration S3_INTEGRATION
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::547960255593:role/role11092026'
enabled = true
storage_allowed_locations = ( 's3://bkt11092026/stg_csv_files/','s3://bkt11092026/stg_json_files/' ); 


desc storage integration S3_INTEGRATION;

--aws 
STORAGE_AWS_ROLE_ARN	 	    arn:aws:iam::547960255593:role/role11092026
STORAGE_ALLOWED_LOCATIONS	 	s3://bkt11092026/stg_csv_files/,s3://bkt11092026/stg_json_files/

--snowflake 
STORAGE_AWS_IAM_USER_ARN	arn:aws:iam::782893932506:user/meu52000-s
STORAGE_AWS_EXTERNAL_ID	 	ID06061_SFCRole=2_feUi4vGbVTYQS94x/V3IFvFy3nY=
;
CREATE STAGE s3_csv_stage 
	URL = 's3://bkt11092026/stg_csv_files/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';


CREATE STAGE s3_json_stage 
	URL = 's3://bkt11092026/stg_json_files/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access json files from aws';

desc integration S3_INTEGRATION; ---- 's3://bkt11092026/stg_csv_files/','s3://bkt11092026/stg_json_files/'

alter storage integration S3_INTEGRATION  set STORAGE_ALLOWED_LOCATIONS=('s3://bkt11092026/stg_csv_files/','s3://bkt11092026/stg_json_files/','s3://bkt11092026/stg_parquet_files/','s3://bkt11092026/stg_avro_files/');

CREATE STAGE s3_parquet_stage 
	URL = 's3://bkt11092026/stg_parquet_files/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access parquet files from aws';


CREATE STAGE s3_avro_stage 
	URL = 's3://bkt11092026/stg_avro_files/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access avro files from aws';

select $1 from @s3_avro_stage/Sample.avro (file_Format=>AVRO_FORMAT);

create table t_avro_info 
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@s3_avro_stage' , FILE_FORMAT => 'avro_format' , FILES => 'Sample.avro'))
);


select * from table(infer_schema(LOCATION => '@s3_avro_stage' , FILE_FORMAT => 'avro_format' , FILES => 'Sample.avro'));

select expression,' as ',column_name from table(infer_schema(LOCATION => '@s3_avro_stage' , FILE_FORMAT => 'avro_format' , FILES => 'Sample.avro'));

select concat(expression,' as ',column_name,',') from table(infer_schema(LOCATION => '@s3_avro_stage' , FILE_FORMAT => 'avro_format' , FILES => 'Sample.avro'));



copy into t_avro_info from (select 
$1:manifest_path::TEXT as manifest_path,
$1:manifest_length::NUMBER(38, 0) as manifest_length,
$1:partition_spec_id::NUMBER(38, 0) as partition_spec_id,
$1:content::NUMBER(38, 0) as content,
$1:sequence_number::NUMBER(38, 0) as sequence_number,
$1:min_sequence_number::NUMBER(38, 0) as min_sequence_number,
$1:added_snapshot_id::NUMBER(38, 0) as added_snapshot_id,
$1:added_files_count::NUMBER(38, 0) as added_files_count,
$1:existing_files_count::NUMBER(38, 0) as existing_files_count,
$1:deleted_files_count::NUMBER(38, 0) as deleted_files_count,
$1:added_rows_count::NUMBER(38, 0) as added_rows_count,
$1:existing_rows_count::NUMBER(38, 0) as existing_rows_count,
$1:deleted_rows_count::NUMBER(38, 0) as deleted_rows_count,
$1:partitions::ARRAY as partitions,
$1:key_metadata::BINARY as key_metadata
from @stg_Avro_stage (file_format=>avro_format)
);


list @s3_avro_stage;

show file formats;


list @s3_parquet_stage;

select $1 from @s3_parquet_stage/Users_Info.parquet (file_format=>parquet_format);



create table t_parquet_info 
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@s3_parquet_stage' , FILE_FORMAT => 'parquet_format' , FILES => 'Users_Info.parquet'))
);


select * from table(infer_schema(LOCATION => '@s3_parquet_stage' , FILE_FORMAT => 'parquet_format' , FILES => 'Users_Info.parquet'));

select expression,' as ',column_name from table(infer_schema(LOCATION => '@s3_parquet_stage' , FILE_FORMAT => 'parquet_format' , FILES => 'Users_Info.parquet'));

select concat(expression,' as ',column_name,',') from table(infer_schema(LOCATION => '@s3_parquet_stage' , FILE_FORMAT => 'parquet_format' , FILES => 'Users_Info.parquet'));

select * from t_parquet_info;

copy into t_parquet_info from (select 
$1:registration_dttm::TIMESTAMP_NTZ as registration_dttm,
$1:id::NUMBER(38, 0) as id,
$1:first_name::TEXT as first_name,
$1:last_name::TEXT as last_name,
$1:email::TEXT as email,
$1:gender::TEXT as gender,
$1:ip_address::TEXT as ip_address,
$1:cc::TEXT as cc,
$1:country::TEXT as country,
$1:birthdate::TEXT as birthdate,
$1:salary::REAL as salary,
$1:title::TEXT as title,
$1:comments::TEXT as comments,
from @stg_parquet_stage (file_format=>parquet_format)
);


select * from table(information_schema.copy_history(table_name=>'t_avro_info',start_time=>dateadd(hours,-1,current_timestamp())));


list @s3_csv_stage;

select * from table(infer_schema(LOCATION => '@s3_csv_stage' , FILE_FORMAT => 'csv_infer_format' , FILES => 'PD_58.csv'));

desc file format csv_format;

create file format csv_infer_format
type=csv 
skip_header=0 
parse_header=true;

select concat(expression,' as ',column_name,',') from table(infer_schema(LOCATION => '@s3_csv_stage' , FILE_FORMAT => 'csv_infer_format' , FILES => 'PD_58.csv'));


select 
$1::TEXT as product_line,
$2::TEXT as product_type,
$3::TEXT as product_desc,
from @s3_csv_stage (file_format=>csv_format);


create table t_product_info(product_line varchar,product_type varchar, product_desc varchar );

copy into t_product_info from (select 
$1::TEXT as product_line,
$2::TEXT as product_type,
$3::TEXT as product_desc,
from @s3_csv_stage (file_format=>csv_format)
);


select * from t_product_info;


select * from table(information_schema.copy_history(table_name=>'t_product_info',start_time=>dateadd(hours,-1,current_timestamp())));




s3 --> s3://bkt11092026/stg_csv_files/  s3_Csv_Stage --> PD_58.csv --> t_product_info   -->without any manual intervention
;

show pipes;

create pipe pipe_load_Data 
auto_ingest=true    --> it should automatically execute command without any manual intervention
as 
copy into t_product_info from (select 
$1::TEXT as product_line,
$2::TEXT as product_type,
$3::TEXT as product_desc,
from @s3_csv_stage (file_format=>csv_format)
);



-- arn:aws:sqs:eu-north-1:782893932506:sf-snowpipe-AIDA3MSA5L7NMNO4O54FZ-_cy-qqAag9CLA7zgUrQ-Gg


select system$pipe_status('PIPE_LOAD_DATA');
select parse_json(system$pipe_status('PIPE_LOAD_DATA'));

list @s3_csv_stage;

select * from t_product_info; --- 46 


select * from table(information_schema.copy_history(table_name=>'t_product_info',start_time=>dateadd(days,-1,current_timestamp())));


S3 => s3_csv_stage => PIPE_RAW_CUST_INFO=>RAW_CUST_INFO => STG_CUST_INFO


F => Full load 
I => Incremental 

;

select get_ddl('TABLE','T_CUST_INFO');

select  $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,metadata$filename, METADATA$START_SCAN_TIME
from @s3_cust_csv_stage (file_format=>csv_format);

ID,FirstName,LastName,Email,Company,Phone,Area,Locality,City,StateCode,Pincode,Country
;
create or replace TABLE RAW_CUST_INFO (
	ID NUMBER(2,0),
	FIRSTNAME VARCHAR(16777216),
	LASTNAME VARCHAR(16777216),  
	EMAIL VARCHAR(16777216),
	COMPANY VARCHAR(16777216),
	PHONE NUMBER(10,0),    
	AREA VARCHAR(16777216),
	LOCALITY VARCHAR(16777216),    
	CITY VARCHAR(16777216),
	STATECODE VARCHAR(16777216),
	PINCODE VARCHAR(16777216),    
	COUNTRY VARCHAR(16777216),
    filename    varchar , 
    d_load_time timestamp
);







s3://bkt11092026/stg_cust_csv_info/
;
 


alter storage integration S3_INTEGRATION
set 
storage_allowed_locations = ( 's3://bkt11092026/stg_csv_files/','s3://bkt11092026/stg_json_files/' ,
's3://bkt11092026/stg_parquet_files/','s3://bkt11092026/stg_avro_files/',
's3://bkt11092026/stg_cust_csv_info/'); 

 
CREATE STAGE s3_cust_csv_stage 
	URL = 's3://bkt11092026/stg_cust_csv_info/' 
	STORAGE_INTEGRATION = S3_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';


list @s3_cust_csv_stage;

S3 => s3_cust_csv_stage => PIPE_RAW_CUST_INFO=>RAW_CUST_INFO => STG_CUST_INFO

;

create pipe PIPE_RAW_CUST_INFO 
auto_ingest=true    --> it should automatically execute command without any manual intervention
as 
copy into RAW_CUST_INFO from
(
select  $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,metadata$filename, METADATA$START_SCAN_TIME
from @s3_cust_csv_stage (file_format=>csv_format)
);


select parse_json(system$pipe_Status('PIPE_RAW_CUST_INFO'));


{
  "executionState": "RUNNING",
  "lastForwardedFilePath": "bkt11092026/stg_cust_csv_info/Cust_Info_F_20260912.csv",
  "lastForwardedMessageTimestamp": "2026-09-12T02:23:49.076Z",
  "lastPulledFromChannelTimestamp": "2026-09-12T02:24:01.612Z",
  "lastReceivedMessageTimestamp": "2026-09-12T02:23:46.792Z",
  "notificationChannelName": "arn:aws:sqs:eu-north-1:782893932506:sf-snowpipe-AIDA3MSA5L7NMNO4O54FZ-_cy-qqAag9CLA7zgUrQ-Gg",
  "numOutstandingMessagesOnChannel": 0,
  "pendingFileCount": 0,
  "pendingHistoryRefreshJobsCount": 0
}


{
  "executionState": "RUNNING",
  "lastForwardedFilePath": "bkt11092026/stg_cust_csv_info/Cust_Info_F_20260912.csv",
  "lastForwardedMessageTimestamp": "2026-09-12T02:23:49.076Z",
  "lastIngestedFilePath": "Cust_Info_F_20260912.csv",
  "lastIngestedTimestamp": "2026-09-12T02:23:47.343Z",
  "lastPulledFromChannelTimestamp": "2026-09-12T02:24:16.606Z",
  "lastReceivedMessageTimestamp": "2026-09-12T02:23:46.792Z",
  "notificationChannelName": "arn:aws:sqs:eu-north-1:782893932506:sf-snowpipe-AIDA3MSA5L7NMNO4O54FZ-_cy-qqAag9CLA7zgUrQ-Gg",
  "numOutstandingMessagesOnChannel": 0,
  "pendingFileCount": 0,
  "pendingHistoryRefreshJobsCount": 0
}


;

select * from RAW_CUST_INFO;

select * from table(information_schema.copy_history(table_name=>'RAW_CUST_INFO',start_time=>dateadd(days,-1,current_timestamp())));

select * from table(information_schema.validate_pipe_load(pipe_name=>'pipe_RAW_CUST_INFO',start_time=>dateadd(days,-1,current_timestamp())));



copy into RAW_CUST_INFO from
(
select  $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,metadata$filename, METADATA$START_SCAN_TIME
from @s3_cust_csv_stage (file_format=>csv_format)
);


select * from RAW_CUST_INFO;

md5();


select md5('krishna'); -- 243bd1ce0387f18005abfc43b001646a
select md5('krishnA'); -- 6037634324125f96e4dcba92afe4f95d
select md5('krishna'); -- 243bd1ce0387f18005abfc43b001646a


S3 => s3_cust_csv_stage => PIPE_RAW_CUST_INFO=>RAW_CUST_INFO => STG_CUST_INFO
;

-- stream 

create table customer
as 
select * from snowflake_sample_data.tpcds_sf100tcl.customer;

select count(*)/1000000 from customer; -- 100M 
;

create table t_customer
as 
select * from customer where 1=2;

select count(*) from t_customer;

select * from customer limit 2 ;

select * from information_schema.columns where table_name='CUSTOMER';
select table_name,column_name,ordinal_position from information_schema.columns where table_name='CUSTOMER';

select table_name,listagg(column_name,',') within group(order by ordinal_position) as column_name from information_schema.columns where table_name='CUSTOMER'
group by table_name;


merge into t_customer t 
using customer  s 
on (t.c_customer_sk=s.c_customer_sk)
when not matched then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE);


select count(*) from t_customer;

select * from customer limit 1 ;

insert into customer values 
('31725357','AAAAAAAANCHBEOBA','184108','6598','45915488','2449228','2449198','Sir','Donald','Hass','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Donald.Hass@Cftfrklyms.edu','2452425');

select * from customer where C_CUSTOMER_SK=1;

update customer set c_first_name='Krishna',c_email_address='Krishna@gmail.com' where C_CUSTOMER_SK=1;

--- 1m 24 sec 
merge into t_customer t  -- 100M
using customer  s        -- 100M
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and t.c_first_name<>s.c_first_name then  
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address;


insert into customer values 
('100000001','Ravi','184108','6598','45915488','2449228','2449198','Sir','Donald','Hass','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Ravi@gmail.com','2452425');

update customer set c_first_name='Soumita',c_email_address='Soumita@gmail.com' where C_CUSTOMER_SK=2;

create table t_chages 
as 
select * from customer where c_customer_sk in (100000001,2);

select * from t_chages;

select * from customer where c_customer_sk in (100000001,2);
select * from t_customer where c_customer_sk in (100000001,2);

merge into t_customer t  -- 100M
using t_chages  s        -- 2
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and t.c_first_name<>s.c_first_name then  
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address;


show streams;  --- to capture the changes of the source object 
1) standard stream  --- mode=defalut --
2) append_only stream 
3) insert_only stream 

t_changes ---> customer 

;

create stream standard_stream
on table customer;

select * from standard_stream;

select system$stream_has_Data('standard_stream'); -- false  true 

insert into customer values 
('100000002','Ravali','184108','6598','45915488','2449228','2449198','Sir','Ravali','N','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Ravali.N@gmail.com','2452425');

delete from customer where C_CUSTOMER_SK=50;

update customer set c_first_name='Soumita',c_email_address='Soumita@gmail.com' where C_CUSTOMER_SK=25;

select * from customer where C_CUSTOMER_SK in (50,25,100000002);
select * from t_customer where C_CUSTOMER_SK in (50,25,100000002);


operation         metadata$action    metadata$isupdate  
insert            INSERT             FALSE 
delete            DELETE             FALSE 
update            INSERT             TRUE 
                  DELETE             TRUE 
;
merge into t_customer t  -- 100M
using standard_stream  s        -- 2
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;


select * from standard_stream;

select system$stream_has_data('standard_stream'); -- FALSE

insert into customer values 
('100000003','Jaya','184108','6598','45915488','2449228','2449198','Sir','Ravali','N','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Jaya.N@gmail.com','2452425');

delete from customer where C_CUSTOMER_SK=100;

update customer set C_CUSTOMER_ID='Abhijit25',c_first_name='Abhijit',c_email_address='Abhijit@gmail.com' where C_CUSTOMER_SK=25;


merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;

select * from table(result_scan('01c7196c-3203-60e5-0018-21b6001acebe'));

show parameters like 'autocommit';

alter session set autocommit=false;

commit;

alter session set autocommit=true;

select "number of rows deleted" as deleted ,
"number of rows inserted" as inserted ,
"number of rows updated" as updated ,
from table(result_scan('01c7196c-3203-60e5-0018-21b6001acebe'));


insert into customer values 
('100000004','Rahul','184108','6598','45915488','2449228','2449198','Sir','Ravali','N','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Rahul.N@gmail.com','2452425');

delete from customer where C_CUSTOMER_SK=120;

update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=125;


commit;

select * from standard_stream;

select system$stream_has_data('standard_stream');

merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;

show tasks;  --> suspended  --> started

alter task task1 resume;

create task task1
schedule='2 minutes'
when system$stream_has_data('standard_stream') ---- True 
as 
merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;

select * from t_customer;

alter table t_customer drop column c_birth_day;
alter table t_customer add column c_birth_day number ;

select * from standard_stream;

select * from table(information_schema.task_history(task_name=>'task1')); --> SCHEDULED  --> SKIPPED
                                                                          --> SCHEDULED  --> EXECUTING --> SUCCEEDED
                                                                          --> SCHEDULED  --> EXECUTING --> FAILED                                                                          

Conditional expression for task evaluated to false.
2026-09-15 19:18:11.968 -0700
2026-09-15 19:14:11.968 -0700
2026-09-15 19:12:11.968 -0700
2026-09-15 19:08:11.968 -0700
2026-09-15 19:07:09.115 -0700
2026-09-15 19:10:11.968 -0700

;
select current_timestamp();

select system$stream_has_data('standard_stream');

insert into customer values 
('100000005','Sirisha','184108','6598','45915488','2449228','2449198','Sir','Ravali','N','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Sirisha.N@gmail.com','2452425');

delete from customer where C_CUSTOMER_SK=220;

update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=445;

update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=550;

update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=660;



S3 => s3_cust_csv_stage => PIPE_RAW_CUST_INFO=>RAW_CUST_INFO => ST_CUST_INFO=>STG_CUST_INFO
S3 => s3_cust_csv_stage => PIPE_RAW_CUST_INFO=>RAW_CUST_INFO => VW_CUST_INFO=>STG_CUST_INFO


Airflow -->   


---18 


select system$stream_has_data('standard_stream');


create task task2
schedule='2 minutes'
as 
merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;


show tasks;

alter task task2 resume;
alter task task2 suspend;
alter task task1 suspend;


select * from table(information_schema.task_history(task_name=>'task2'));  -- scheduled --> EXECUTING -->SUCCEEDED
select * from table(information_schema.task_history(task_name=>'task1'));

2026-09-17 18:44:23.844 -0700
2026-09-17 18:46:23.844 -0700
2026-09-17 18:48:23.844 -0700
;

select current_timestamp();

alter warehouse hdfc_wh set auto_Resume=false;
alter warehouse hdfc_wh suspend;

show warehouses;


create task task3
schedule='2 minutes'
warehouse=hdfc_wh
as 
merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;


alter task task3 resume;

select * from table(information_schema.task_history(task_name=>'task3')); 

alter warehouse hdfc_wh resume;




--- serverless task 
select * from table(information_schema.serverless_task_history(task_name=>'task2'));
select * from table(information_schema.serverless_task_history(task_name=>'task1'));



alter task task3 suspend;

show pipes;

select * from table(information_schema.pipe_usage_history(pipe_name=>'PIPE_RAW_CUST_INFO'));

select * from snowflake.account_usage.pipe_usage_history;


show tasks;



select current_timestamp();


2026-09-17 19:01:12.056 -0700

1 minutes       13       (0-59)
2 hours         19       (0-23)
3 dayofmonth    17       (1-31 or L )
4 month_name    SEP or 9  (JAN-DEC) (1-12 )
5 dayofweek     THU or (0-6)(sun-sat)

;

show parameters like 'timezone';

13 19 * 9 4  --> every thursay in september 

create task task4
schedule='using cron 13 19 17 9 * America/Los_Angeles'
as 
merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;


show tasks;

alter task task4 resume;

select * from table(information_schema.task_history(task_name=>'task4')); 

alter warehouse hdfc_wh set auto_resume=true;


2026-09-17 19:13:00.000 -0700
2026-09-17 19:12:16.106 -0700

;

select current_timestamp();


update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=1250;

--schedule 
alter task task4 resume;
-- force start 
execute task task4;

-- Airflow 
vscode 
docker 
wsl 
astronomer 



show tasks;

create task task5
schedule='2 minutes'
as 
create or replace table  dept(deptno number , dname varchar,loc varchar);


select * from table(information_schema.task_dependents(task_name=>'task5')); --> 

create or replace task task6
after task5
as 
insert into dept values(10,'SALES','HYD'),(20,'ACCOUNTS','DELHI');


alter task task5 suspend;

show tasks;

select current_timestamp();

select system$task_Dependents_enable('task5');

select * from table(information_schema.task_history(task_name=>'task5'));
select * from table(information_schema.task_history(task_name=>'task6'));


execute task task6;
execute task task5;


select * from dept;


select * from table(information_schema.task_dependents(task_name=>'task6')); --> 


select * from standard_stream;



merge into t_customer t  -- 100M
using standard_stream  s        -- 4
on (t.c_customer_sk=s.c_customer_sk)  -- 
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;



insert into customer values 
('100000030','Bala','184108','6598','45915488','2449228','2449198','Sir','Ravali','N','N','16','5','1989','VIRGIN ISLANDS, U.S.','','Sirisha.N@gmail.com','2452425');

delete from customer where C_CUSTOMER_SK=320;

update customer set C_CUSTOMER_ID='Vijay25',c_first_name='Vijay',c_email_address='Vijay@gmail.com' where C_CUSTOMER_SK=778;


select * from t_customer where c_customer_sk in (100000030,320,778);


snowflake_merge_execution.py
dag_id="snowflake_merge_dag"
task_id="snowflake_merge_task"
conn_id="snowflake_dev"


---snowflake_merge_execution.py
from datetime import datetime
from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator

MERGE_SQL = """
merge into t_customer t   
using standard_stream  s         
on (t.c_customer_sk=s.c_customer_sk)   
when not matched and metadata$action='INSERT'  and    metadata$isupdate = 'FALSE' then 
insert (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE) values (C_CUSTOMER_SK,C_CUSTOMER_ID,C_CURRENT_CDEMO_SK,C_CURRENT_HDEMO_SK,C_CURRENT_ADDR_SK,C_FIRST_SHIPTO_DATE_SK,C_FIRST_SALES_DATE_SK,C_SALUTATION,C_FIRST_NAME,C_LAST_NAME,C_PREFERRED_CUST_FLAG,C_BIRTH_DAY,C_BIRTH_MONTH,C_BIRTH_YEAR,C_BIRTH_COUNTRY,C_LOGIN,C_EMAIL_ADDRESS,C_LAST_REVIEW_DATE)
when matched and metadata$action='INSERT'  and    metadata$isupdate = 'TRUE' then 
update  set t.c_first_name=s.c_first_name,t.c_email_address=s.c_email_address
when matched and metadata$action='DELETE'  and    metadata$isupdate = 'FALSE' then 
delete;
"""

with DAG(
    dag_id="snowflake_merge_dag",
    start_date=datetime(2026, 5, 27),
    schedule=None,
    catchup=False,
    tags=["snowflake", "merge"],
) as dag:

    run_snowflake_merge = SQLExecuteQueryOperator(
        task_id="snowflake_merge_task",
        conn_id="snowflake_dev",
        sql=MERGE_SQL,
    )




requirements.txt 
-------------------------------
# Astro Runtime includes the following pre-installed providers packages: https://www.astronomer.io/docs/astro/runtime-image-architecture#provider-packages
apache-airflow-providers-snowflake
snowflake-connector-python[pandas]
colorama>=0.4.6,<1
#dbt
dbt-core
dbt-snowflake
astronomer-cosmos
apache-airflow-providers-postgres
#oracle
apache-airflow-providers-oracle
oracledb
#dbt cloud 
apache-airflow-providers-dbt-cloud==4.9.3
apache-airflow-providers-amazon





----------------22 
-------------------------------------------------------------------

-- pre defined functions , 
--- pre defiend procedres 
show functions;   
show procedures;   
-- user defined functions  --> UDF's 
--- user defiend procedres --> UDP's 
show functions;   
show procedures;   



select * from t_cust_info;

list @~;

create or replace table t_cust_info
(
ID number,
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number,
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
); 


copy into t_cust_info from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @~/Cust_Info.csv (file_format=>csv_format));


select * from t_cust_info where company='TCS';

select * from t_cust_info where company='TCS' and city='Pune';

select  firstname from t_cust_info where company='TCS' and city='Pune';

select * from information_schema.procedures;

create or replace procedure pr_cust_info(p_comcany varchar,p_city varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	    
	BEGIN 
		select  firstname into v_firstname from t_cust_info where company='TCS' and city='Pune';
        return v_firstname;
	END;
$$;


select get_ddl('TABLE','T_CUST_INFO');

create or replace TABLE T_CUST_INFO (
	ID NUMBER(38,0),
	FIRSTNAME VARCHAR(16777216),
	LASTNAME VARCHAR(16777216),
	EMAIL VARCHAR(16777216),
	COMPANY VARCHAR(16777216),
	PHONE NUMBER(38,0),
	AREA VARCHAR(16777216),
	LOCALITY VARCHAR(16777216),
	CITY VARCHAR(16777216),
	STATECODE VARCHAR(16777216),
	PINCODE VARCHAR(16777216),
	COUNTRY VARCHAR(16777216)
);
select get_ddl('PROCEDURE','pr_cust_info(varchar,varchar)');

--- how to execute the procedre 

call procedure_name(parameter);

select  firstname from t_cust_info where company='TCS' and city='Pune';
select concat('Employee name is ', firstname) from t_cust_info where company='TCS' and city='Pune';

call pr_cust_info('TCS','Pune');

create or replace procedure pr_cust_info(p_comcany varchar,p_city varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	
        v_message varchar;
	BEGIN 
		select  firstname into v_firstname from t_cust_info where company='TCS' and city='Pune';

        v_message:=concat('Employee name is ', v_firstname);

        
        return v_message;
	END;
$$;


call pr_cust_info('TCS','Pune');  --- positional Notation

call pr_cust_info(p_comcany=>'TCS',p_city=>'Pune'); -- Named Notation 


call pr_cust_info(p_city=>'Pune',p_comcany=>'TCS'); 

call pr_cust_info('Pune','TCS');  




create or replace procedure pr_cust_info_new()
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	
        v_message varchar;
	BEGIN 
		select  firstname into v_firstname from t_cust_info where company='TCS' and city='Pune';

        v_message:=concat('Employee name is ', v_firstname);

        
        return v_message;
	END;
$$;

call pr_cust_info_new();

select  firstname from t_cust_info where company='TCS' and city='Hyderabad';

call pr_cust_info('TCS','Hyderabad');

v_firstname  Priya 
v_firstname  Rohan 


v_firstname  Priya
             Rohan

-- hardcoding 

-- use : when you are referring a input PARAMETER

create or replace procedure pr_cust_info(p_comcany varchar,p_city varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	
        v_message varchar;
	BEGIN 
		select  firstname into v_firstname from t_cust_info where company=:p_comcany and city=:p_city;

        v_message:=concat('Employee name is ', v_firstname);

        
        return v_message;
	END;
$$;



call pr_cust_info('TCS','Hyderabad');

A SELECT INTO statement expects exactly 1 returned row, but got 2.

---;
;

create or replace procedure pr_cust_info(p_comcany varchar,p_city varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	
        v_message varchar;
	BEGIN 
		select  firstname into v_firstname from t_cust_info where company=:p_comcany and city=:p_city;

        v_message:=concat('Employee name is ', v_firstname);
        
        return v_message;
        
   EXCEPTION 
    when STATEMENT_ERROR then 
       return 'we are getting more than one employee information into the variable';
	END;
$$;




-- variable 
variable_name data_type;

v_firstname varchar;
v_message varchar;
v_Sal number;
v_hiredate date;

-- assignment operator 
:=

---How to assign VALUE to a variable 
v_firstname:='Ravi';
v_firstname:='Krishna';
v_message:='Employee name is Pooja';
v_Sal:=50000;
v_hiredate:='2020-01-25';




--sql 
select  firstname from t_cust_info where company='TCS' and city='Pune';
--procedure
select  firstname into v_firstname from t_cust_info where company='TCS' and city='Pune';

create or replace procedure pr_cust_info(p_comcany varchar,p_city varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_firstname varchar;	    

	BEGIN 
		select  firstname into v_firstname from t_cust_info where company='TCS' and city='Pune';
        return v_firstname;
	END;
$$; -- end of the procedure 

create or replace procedure <pr_name>(prameter_1 <data_type>,prameter_2 <data_type>)
returns <data_type>
language sql/javascript/Python
[execute as owner/caller]
as 
$$ -- start of the procedure 
    <procedure_definition>
$$; -- end of the procedure 


procedure_definition:-
------------------------
[DECLARE]
--          Declaration section      
            variables ;
			cursors;

BEGIN 
         --  execution section;
		   DML,DDL,TCL,SELECT 
		   for loop,while loop , 
		   case, decode , 
		   functions 
    return <value>;
[EXCEPTION]
--           exception section
             STATEMENT_ERROR
END;



select * from emp;


update emp set hiredate='2020-09-23',sal=70000 where empno=7369;

select * from emp where empno=7369;


alter table emp add dor date;
alter table emp add gratuity number;

update emp set dor = current_date()  where empno=7369;



select empno,ename,sal,hiredate,dor,gratuity  from emp where empno=7369;
select empno,ename,sal,hiredate,dor,datediff('days',hiredate,dor) as experience , gratuity  from emp where empno=7369;
select empno,ename,sal,hiredate,dor,datediff('months',hiredate,dor) as experience , gratuity  from emp where empno=7369;
select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , gratuity  from emp where empno=7369;

select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , (sal*15*datediff('years',hiredate,dor))/26 as gratuity
from emp where empno=7369;

select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , round((sal*15*datediff('years',hiredate,dor))/26) as gratuity
from emp where empno=7369;


v_empno number;
v_ename varchar;
v_sal number;
v_hiredate date;
v_dor date;
v_experience number;
v_gratuity number;

select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , round((sal*15*datediff('years',hiredate,dor))/26) as gratuity
into v_empno,v_ename,v_sal,v_hiredate,v_dor,v_experience , v_gratuity
from emp where empno=7369;

Gratuity = (Last Drawn Salary × 15 × Years of Service) ÷ 26
Where:

Last Drawn Salary = Basic Salary + Dearness Allowance (DA)
15 = 15 days wages per year of service
26 = Average working days in a month (excluding Sundays)
Years of Service = Completed years ;


;

;

create or replace procedure pr_gratuity_update (p_empno number)
returns number
language sql
as 
$$ -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
        
        BEGIN 
            select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , round((sal*15*datediff('years',hiredate,dor))/26) as gratuity
            into v_empno,v_ename,v_sal,v_hiredate,v_dor,v_experience , v_gratuity
            from emp where empno=7369;
            
            return v_gratuity;
        END;
$$; -- end of the procedure 


 call pr_gratuity_update(7369);
 call pr_gratuity_update(p_empno=>7369);


 create or replace procedure pr_gratuity_update (p_empno number)
returns varchar
language sql
as 
$$ -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
        
        BEGIN 
            select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , round((sal*15*datediff('years',hiredate,dor))/26) as gratuity
            into v_empno,v_ename,v_sal,v_hiredate,v_dor,v_experience , v_gratuity
            from emp where empno=7369;

            v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);
            
            return v_message;
        END;
$$; -- end of the procedure 


call pr_gratuity_update(p_empno=>7369);


experience >=5 
dor is not null 
;


select * from emp;

select coalesce('2026-01-01',current_date());
select coalesce(null,current_date());

select empno,ename,sal,hiredate,coalesce(dor,current_date()),datediff('years',hiredate,coalesce(dor,current_date())) as experience ,
case when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is not null then round((sal*15*datediff('years',hiredate,dor))/26) 
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is not null then null 
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is  null then  null   
     when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is null then null 
     end as gratuity,
case when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is not null then 'Employee is eligible..'
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is not null then  'Employee is not eligible.. he experience is <5 years '
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is  null then  'Employee is not eligible.. he experience is <5 years and also he is not reisgned '     
     when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is null then  'Employee is not eligible.. he is not resigned'
     end as message     
from emp where empno=7499;


update emp set hiredate='2020-09-23',sal=70000 where empno=7369;
update emp set hiredate='2022-09-23',sal=50000 where empno=7499;
update emp set hiredate='2015-09-23',sal=100000 where empno=7521;


select get_ddl('TABLE','EMP');

create or replace TABLE EMP (
	EMPNO NUMBER(4,0) NOT NULL,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER,
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0),
	DOR DATE,
	GRATUITY NUMBER(38,0)
);


insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('17-DEC-1980', 'DD-MON-YYYY'),  800, NULL, 20);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600,  300, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250,  500, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('2-APR-1981', 'DD-MON-YYYY'),  2975, NULL, 20);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1-MAY-1981', 'DD-MON-YYYY'),  2850, NULL, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('9-JUN-1981', 'DD-MON-YYYY'),  2450, NULL, 10);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('8-SEP-1981', 'DD-MON-YYYY'),  1500,    0, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),   950, NULL, 30);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),  3000, NULL, 20);
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);


if (condition) then 
   <do this>;
end if;    

if (condition1) then 
   <do this>;
elseif (condition2)   then  
    <do this>;
end if; 

if (condition1) then 
   <do this>;
elseif (condition2)   then  
    <do this>;
else 
    <do this>;
end if; 


;


select object_construct('employee name is  ',ename , 'Salary',sal) from emp where empno=7521;


create or replace procedure pr_gratuity_update (p_empno number)
returns varchar
language sql
as 
$$ -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
        
        BEGIN 
            select empno,ename,sal,hiredate,dor,datediff('years',hiredate,dor) as experience , round((sal*15*datediff('years',hiredate,dor))/26) as gratuity
            into v_empno,v_ename,v_sal,v_hiredate,v_dor,v_experience , v_gratuity
            from emp where empno=:p_empno;

            if (v_experience>=5 and v_dor is not null) then 
                v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);
            elseif (v_experience<5 and v_dor is not null) then 
                  v_message:='Employee is not eligible.. he experience is <5 years ';  
            elseif (v_experience<5 and v_dor is null) then 
                  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;   
            elseif (v_experience>=5 and v_dor is null) then 
                  v_message:='Employee is not eligible.. he is not resigned';
            end if;
            
            return object_construct('input_paramter',:p_empno,'v_experience',v_experience,'v_dor',v_dor);
        END;
$$; -- end of the procedure 


select * from emp where empno=7521;

update emp set dor=current_date()  where empno=7369;

call pr_gratuity_update(7369);
call pr_gratuity_update(7521);

select empno,ename,sal,hiredate,coalesce(dor,current_date()),datediff('years',hiredate,coalesce(dor,current_date())) as experience ,
case when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is not null then round((sal*15*datediff('years',hiredate,dor))/26) 
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is not null then null 
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is  null then  null   
     when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is null then null 
     end as gratuity,
case when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is not null then 'Employee is eligible..'
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is not null then  'Employee is not eligible.. he experience is <5 years '
     when datediff('years',hiredate,coalesce(dor,current_date()))<5 and dor is  null then  'Employee is not eligible.. he experience is <5 years and also he is not reisgned '     
     when datediff('years',hiredate,coalesce(dor,current_date()))>=5 and dor is null then  'Employee is not eligible.. he is not resigned'
     end as message     
from emp where empno=7499;




----- Airflow steps 

--
Goto CMD 
echo %PROCESSOR_ARCHITECTURE%
AMD64
---- Airflow 
Downlaod docker 
download vscode 

1) Install Docker 
2) Install vs code 
3) create folder in local and open that using vs code 
4) intially the folder is empty 
5) open vs code --> goto terminal and run the below command 

PS C:\Users\Balakrishna\Desktop\2026\Jan_2026\dbt_info> wsl --install
Enter new UNIX username: krishna
New password:         krishna
Retype new password:  krishna

6) 

krishna@DESKTOP-GBCNUJK:~$ curl -SSL https://install.astronomer.io | sudo bash
password for krishna: krishna


krishna@DESKTOP-GBCNUJK:~$ astro version
--- next initialize astro 
astro dev init


--open requirements.txt
apache-airflow-providers-snowflake
snowflake-connector-python[pandas]
colorama>=0.4.6,<1
#dbt
dbt-core
dbt-snowflake
astronomer-cosmos
apache-airflow-providers-postgres
#oracle
apache-airflow-providers-oracle
oracledb
#dbt cloud 
apache-airflow-providers-dbt-cloud==4.9.3

---
sudo astro dev start


--airflow url 
http://airflow.localhost:6563




---28


create or replace procedure pr_emp_sal_upd(p_deptno number,p_job varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_empno number;	
        v_ename varchar;
        v_sal number;
	BEGIN 
		select  empno,ename,sal into v_empno,v_ename,v_sal from emp where deptno=:p_deptno and job=:p_job;

         update emp set sal=sal+(sal*0.1) where empno=v_empno;
        
        return 'success';

	END;
$$;


call pr_emp_sal_upd(30,'SALESMAN');


-- A SELECT INTO statement expects exactly 1 returned row, but got 4.


create or replace procedure pr_emp_sal_upd(p_deptno number,p_job varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE
		v_empno number;	
        v_ename varchar;
        v_sal number;
		c1 cursor for select  empno,ename,sal  from emp where  deptno=? and job=?;
	BEGIN 

         open c1 using(:p_deptno,:p_job);
		 
		 for i in c1 loop 
	     -- if you want to access the values of a cursor you need to use variables.
            v_empno:= i.empno;	 
            v_ename:= i.ename;			
            v_sal:= i.sal;			

            update emp set sal=:v_sal+(:v_sal*0.1) where empno=:v_empno;
			
        end loop; 


       close c1;
		 
       
        return 'success';

	END;
$$;



call pr_emp_sal_upd('30','SALESMAN');

select  empno,ename,sal  from emp where  deptno=30 and job='SALESMAN';

EMPNO	ENAME	SAL
7499	ALLEN	50000
7521	WARD	100000
7654	MARTIN	1250
7844	TURNER	1500

EMPNO	ENAME	SAL
7499	ALLEN	55000
7521	WARD	110000
7654	MARTIN	1375
7844	TURNER	1650

EMPNO	ENAME	SAL
7499	ALLEN	60500
7521	WARD	121000
7654	MARTIN	1513
7844	TURNER	1815


;


create or replace procedure pr_emp_sal_upd(p_deptno number,p_job varchar)
returns varchar
language sql
as 
$$ -- start of the procedure 
	DECLARE

		c1 cursor for select  empno,ename,sal  from emp where  deptno=? and job=?;
	BEGIN 
		let v_empno number;	
        let v_ename varchar;
        let v_sal number;

         open c1 using(:p_deptno,:p_job);
		 
		 for i in c1 loop 
	     -- if you want to access the values of a cursor you need to use variables.
            v_empno:= i.empno;	 
            v_ename:= i.ename;			
            v_sal:= i.sal;			

            update emp set sal=:v_sal+(:v_sal*0.1) where empno=:v_empno;
			
        end loop; 


       close c1;
		 
       
        return 'success';

	END;
$$;



CREATE OR REPLACE PROCEDURE "Sample_Procedure"("GROUP_ID" NUMBER(38,0))
RETURNS VARIANT
LANGUAGE SQL
EXECUTE AS CALLER
AS '
DECLARE
  Table_Database_Name VARCHAR;
  Table_Schema_Name VARCHAR;
  View_Database_Name VARCHAR;
  View_Schema_Name VARCHAR;
  Table_Name VARCHAR;
  View_Name VARCHAR;
  Query_table_name VARCHAR;
  Query_view_name VARCHAR;
  information_t VARCHAR;
  information_v VARCHAR;
  Table_Row_Count INT;
  View_Row_Count INT;
  Table_Column_Count INT;
  View_Column_Count INT;
  Hash_Table_Data_Compare_Status INT;
  Hash_View_Data_Compare_Status INT;
  unique_time timestamp;

  c1 CURSOR FOR 
  SELECT Table_Database_Name, Table_Schema_Name,View_Database_Name, View_Schema_Name, Table_Name, View_Name
    FROM sit_db.sit_schema.Validation_Config
    WHERE GROUP_ID = ?;

BEGIN
OPEN c1 using (:GROUP_ID);
  -- Fetch all information from config tables based on the group id
  FOR i IN c1 loop
    Table_Database_Name := i.Table_Database_Name;
    Table_Schema_Name := i.Table_Schema_Name;
    View_Database_Name := i.View_Database_Name;
    View_Schema_Name := i.View_Schema_Name;
    Table_Name := i.Table_Name;
    View_Name := i.View_Name;
    Query_table_name := :Table_Database_Name || ''.'' || :Table_Schema_Name || ''.'' || :Table_Name;
    Query_view_name := :View_Database_Name || ''.'' || :View_Schema_Name || ''.'' || :View_Name;
    information_t := :Table_Database_Name || ''.INFORMATION_SCHEMA.COLUMNS'';
    information_v := :View_Database_Name || ''.INFORMATION_SCHEMA.COLUMNS'';

    -- Count of rows & Column in the table
    -- Table_Row_Count := (SELECT COUNT(*) FROM :SNC_Database_Name.:Schema_Name.:Table_Name);
    -- Table_Column_Count := (SELECT COUNT(*) FROM :SNC_Database_Name.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_CATALOG = :SNC_Database_Name and TABLE_SCHEMA = :Schema_Name and TABLE_NAME = :Table_Name);
    SELECT COUNT(*) INTO :Table_Row_Count FROM TABLE(:Query_table_name);
    SELECT COUNT(*) INTO :Table_Column_Count FROM TABLE(:information_t) WHERE TABLE_CATALOG = :Table_Database_Name and TABLE_SCHEMA = :Table_Schema_Name and TABLE_NAME = upper(:Table_Name);

    -- Count of rows & Column in the view
    SELECT COUNT(*) INTO :View_Row_Count FROM TABLE(:Query_view_name);
    SELECT COUNT(*) INTO :View_Column_Count FROM TABLE(:information_t) WHERE TABLE_CATALOG = :View_Database_Name and TABLE_SCHEMA = :View_Schema_Name and TABLE_NAME = upper(:View_Name);

    -- Hash values for table in both the view and the table
    select count(*) into :Hash_View_Data_Compare_Status from 
    (SELECT hash_agg(*) FROM TABLE(:Query_view_name) 
    minus 
    SELECT hash_agg(*) FROM TABLE(:Query_table_name));

    -- Hash values for table in both the table and the view

    select count(*) into :Hash_Table_Data_Compare_Status from 
    (SELECT hash_agg(*) FROM TABLE(:Query_table_name) 
    minus 
    SELECT hash_agg(*) FROM TABLE(:Query_view_name));

    -- Fetch Current timestamp
    unique_time :=(select CURRENT_TIMESTAMP());

    -- Insert data into log tables with all the values
    INSERT INTO sit_db.sit_schema.Validation_Config_log (Table_Database_Name,Table_Schema_Name,Table_Name,View_Database_Name,View_Schema_Name, View_Name,Table_Row_Count,View_Row_Count, Row_Count_Status,Table_Column_Count,View_Column_Count,Column_Count_Status,Hash_Table_Data_Compare_Status,Hash_View_Data_Compare_Status,group_id,Validation_Time)
      VALUES (:Table_Database_Name,:Table_Schema_Name,:Table_Name,:View_Database_Name,:View_Schema_Name,:View_Name,:Table_Row_Count,:View_Row_Count,''NA'',:Table_Column_Count,:View_Column_Count,''NA'',''NA'',''NA'',:GROUP_ID,:unique_time);

    -- Updating all the columns based on the validation
    -- Please add your test case here. Declare the variable and add your query

    -- Comparing Rows Count and updating the status
    CASE
    When :Table_Row_Count = :View_Row_Count THEN

    update sit_db.sit_schema.Validation_Config_log
    set Row_Count_Status = ''Match''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    ELSE
    update sit_db.sit_schema.Validation_Config_log
    set Row_Count_Status = ''Mismatch''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    END;

    -- Comparing Column Count and Updating the Status

    CASE 
    When :Table_Column_Count = :View_Column_Count THEN

    update sit_db.sit_schema.Validation_Config_log
    set Column_Count_Status = ''Match''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    ELSE

    update sit_db.sit_schema.Validation_Config_log
    set Column_Count_Status = ''Mismatch''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    END;

    -- Hash table level Data comparing between table and view and updating the Status

    CASE 
    When :Hash_Table_Data_Compare_Status = 0 THEN

    update sit_db.sit_schema.Validation_Config_log
    set Hash_Table_Data_Compare_Status = ''Match''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    ELSE

    update sit_db.sit_schema.Validation_Config_log
    set Hash_Table_Data_Compare_Status = ''Mismatch''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    END;

    -- Hash view level data comparing between view and table and updating the Status

    CASE 
    When :Hash_View_Data_Compare_Status = 0 THEN

    update sit_db.sit_schema.Validation_Config_log
    set Hash_View_Data_Compare_Status = ''Match''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    ELSE

    update sit_db.sit_schema.Validation_Config_log
    set Hash_View_Data_Compare_Status = ''Mismatch''
    where VALIDATION_CONFIG_LOG_ID = (select VALIDATION_CONFIG_LOG_ID from sit_db.sit_schema.Validation_Config_log where GROUP_ID = :GROUP_ID and VALIDATION_TIME = :unique_time)
    AND Table_Database_Name = :Table_Database_Name
    AND Table_Schema_Name = :Table_Schema_Name
    AND Table_Name = :Table_Name
    AND View_Database_Name = :View_Database_Name
    AND View_Schema_Name = :View_Schema_Name
    AND View_Name = :View_Name
    AND GROUP_ID = :GROUP_ID
    AND Validation_Time = :unique_time;

    END;
  END FOR;
  close c1;

  RETURN NULL;
END;
';


select * from emp;

update emp set gratuity=null;

update emp set dor =current_date();

alter table emp add column description varchar;

show procedures;


select * from information_schema.procedures;


select get_ddl('PROCEDURE','PR_GRATUITY_UPDATE(NUMBER)');




call PR_GRATUITY_UPDATE(30);

select * from emp where deptno=30;

 select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity

            from emp where deptno=30;

CREATE OR REPLACE PROCEDURE "PR_GRATUITY_UPDATE"(p_deptno NUMBER(38,0))
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
        
        BEGIN 
        
            select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            into v_empno,v_ename,v_sal,v_hiredate,v_dor,v_experience , v_gratuity
            from emp where deptno=:p_deptno;

           

            if (v_experience>=5 and v_dor is not null) then 
                v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

                 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
                
            elseif (v_experience<5 and v_dor is not null) then 
                  v_message:='Employee is not eligible.. he experience is <5 years ';  
                 update emp set   description=:v_message where empno=:v_empno;                  
            elseif (v_experience<5 and v_dor is null) then 
                  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
                 update emp set   description=:v_message where empno=:v_empno;                      
            elseif (v_experience>=5 and v_dor is null) then 
                  v_message:='Employee is not eligible.. he is not resigned';
                 update emp set   description=:v_message where empno=:v_empno;                      
            end if;
            
            return object_construct('input_paramter',:p_deptno,'v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        END;
;


--  A SELECT INTO statement expects exactly 1 returned row, but got 6.

CREATE OR REPLACE PROCEDURE PR_GRATUITY_UPDATE_cursor(p_deptno NUMBER(38,0))
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
            c1 cursor for             select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp where deptno=?;
        
        BEGIN 
        
             open c1 using (:p_deptno);
			 for i in c1 loop 
					 v_empno:=i.empno;
					 v_ename:=i.ename;
					 v_sal:=i.sal;
					 v_hiredate:=i.hiredate;
					 v_dor:=i.dor;
					 v_experience:=i.experience;
					 v_gratuity:=i.gratuity;

				   

					if (v_experience>=5 and v_dor is not null) then 
						v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

						 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
						
					elseif (v_experience<5 and v_dor is not null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years ';  
						 update emp set   description=:v_message where empno=:v_empno;                  
					elseif (v_experience<5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
						 update emp set   description=:v_message where empno=:v_empno;                      
					elseif (v_experience>=5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he is not resigned';
						 update emp set   description=:v_message where empno=:v_empno;                      
					end if;
			
			end loop ;
			close c1; 
            
            return object_construct('input_paramter',:p_deptno,'v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        END;
;


call PR_GRATUITY_UPDATE_cursor(30);

select * from emp;

update emp set gratuity=null, description=null;

CREATE OR REPLACE PROCEDURE PR_GRATUITY_UPDATE_cursor()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
            c1 cursor for             select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp ;
        
        BEGIN 
        
             open c1;
			 for i in c1 loop 
					 v_empno:=i.empno;
					 v_ename:=i.ename;
					 v_sal:=i.sal;
					 v_hiredate:=i.hiredate;
					 v_dor:=i.dor;
					 v_experience:=i.experience;
					 v_gratuity:=i.gratuity;

				   

					if (v_experience>=5 and v_dor is not null) then 
						v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

						 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
						
					elseif (v_experience<5 and v_dor is not null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years ';  
						 update emp set   description=:v_message where empno=:v_empno;                  
					elseif (v_experience<5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
						 update emp set   description=:v_message where empno=:v_empno;                      
					elseif (v_experience>=5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he is not resigned';
						 update emp set   description=:v_message where empno=:v_empno;                      
					end if;
			
			end loop ;
			close c1; 
            
            return object_construct('v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        END;
;

call PR_GRATUITY_UPDATE_cursor();

select * from emp;


--29 

 select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
from emp  where deptno=30;


select concat('my name is ','Krishna');

select concat('select empno,ename,sal,hiredate,dor,datediff(''years'',hiredate,
             coalesce(dor,current_date())) as experience , 
             round((sal*15*datediff(''years'',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp  where deptno=',30)
;

select empno,ename,sal,hiredate,dor,datediff('years',hiredate,
             coalesce(dor,current_date())) as experience , 
             round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp  where deptno=30;


create or replace procedure pr_tab_result(p_deptno number)
returns table(empno number,ename varchar,sal number,hiredate date, dor date,experience number,gratuity number)
language sql 
as 
$$ -- start of the procedure 
        DECLARE
           v_result resultset;
           v_sql varchar;
        BEGIN 
             v_sql:= concat('select empno,ename,sal,hiredate,dor,datediff(''years'',hiredate,
             coalesce(dor,current_date())) as experience , 
             round((sal*15*datediff(''years'',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp  where deptno=',p_deptno);
            
             v_result:= (execute immediate :v_sql);
            
            return table(v_result);
        
        END;
$$; -- end of the procedure 

call pr_tab_result(30);



  DECLARE
           v_result resultset;
           v_sql varchar;
           p_deptno number:=30;
        BEGIN 
             v_sql:= concat('select empno,ename,sal,hiredate,dor,datediff(''years'',hiredate,
             coalesce(dor,current_date())) as experience , 
             round((sal*15*datediff(''years'',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp  where deptno=',p_deptno);
            
             v_result:= (execute immediate :v_sql);
            
            return table(v_result);
        
        END;

-- Scalar function 
select current_date();
select current_database();
select datediff('years','2020-09-29',current_date());
-- tabular functions 
select * from table(information_schema.query_history());

select * from table(information_schema.task_history(task_name=>'task5'));

show tasks;

alter task task5 suspend;
alter task task6 suspend;

-- udf's

-- number of days left to complete the current year

select dayofyear(current_date());
select 365-dayofyear(current_date());

select date_trunc('year',current_date()); -- 2026-01-01
select last_Day(add_months(date_trunc('year',current_date()),11)); -- 2026-12-31

select datediff('days', date_trunc('year',current_date()),last_Day(add_months(date_trunc('year',current_date()),11)))+1;

select datediff('days', date_trunc('year',current_date()),last_Day(add_months(date_trunc('year',current_date()),11)))+1-dayofyear(current_date()) as days_left ;



create or replace function fn_days_left(p_Date date)
returns number
language sql 
as 
$$  

            select datediff('days', date_trunc('year',p_Date),last_Day(add_months(date_trunc('year',p_Date),11)))+1-dayofyear(p_Date) as days_left        

$$;  



select fn_days_left(current_Date());


CREATE OR REPLACE FUNCTION normalize_email(email STRING)
RETURNS STRING
LANGUAGE SQL
AS
$$
    LOWER(TRIM(email))
$$;


select * from t_cust_info;

select id,firstname,normalize_email(email) from t_cust_info;


 CREATE OR REPLACE FUNCTION get_transaction_risk(
    amount NUMBER,
    country STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
    CASE
        WHEN amount IS NULL THEN 'UNKNOWN'
        WHEN amount >= 10000 THEN 'HIGH'
        WHEN amount >= 1000
             AND UPPER(country) NOT IN ('US', 'CA', 'UK') THEN 'MEDIUM'
        ELSE 'LOW'
    END
$$;


select  *  from t_cust_info;


 
CREATE OR REPLACE TEMPORARY TABLE transaction_risk_test (
    transaction_id NUMBER,
    amount NUMBER(12, 2),
    country STRING
);

-- DML: test each risk branch.
INSERT INTO transaction_risk_test (transaction_id, amount, country)
VALUES
    (1, NULL, 'US'),
    (2, 15000, 'US'),
    (3, 2500, 'DE'),
    (4, 2500, 'US'),
    (5, 100, 'CA'),
    (6, 1000, NULL);


SELECT
    transaction_id,
    amount,
    country,
    get_transaction_risk(amount, country) AS actual_risk,
    CASE transaction_id
        WHEN 1 THEN 'UNKNOWN'
        WHEN 2 THEN 'HIGH'
        WHEN 3 THEN 'MEDIUM'
        WHEN 4 THEN 'LOW'
        WHEN 5 THEN 'LOW'
        WHEN 6 THEN 'LOW'
    END AS expected_risk,
    IFF(
        get_transaction_risk(amount, country) = CASE transaction_id
            WHEN 1 THEN 'UNKNOWN'
            WHEN 2 THEN 'HIGH'
            WHEN 3 THEN 'MEDIUM'
            WHEN 4 THEN 'LOW'
            WHEN 5 THEN 'LOW'
            WHEN 6 THEN 'LOW'
        END,
        'PASS',
        'FAIL'
    ) AS test_result
FROM transaction_risk_test
ORDER BY transaction_id;



SELECT *
FROM transaction_risk_test
WHERE get_transaction_risk(amount, country) != CASE transaction_id
    WHEN 1 THEN 'UNKNOWN'
    WHEN 2 THEN 'HIGH'
    WHEN 3 THEN 'MEDIUM'
    WHEN 4 THEN 'LOW'
    WHEN 5 THEN 'LOW'
    WHEN 6 THEN 'LOW'
END;



;
number , varchar, date , VARIANT
;
--> 
CREATE OR REPLACE TEMPORARY TABLE event_value_test (
    event_id NUMBER,
    payload VARIANT
);


INSERT INTO event_value_test (event_id, payload)
SELECT column1, PARSE_JSON(column2)
FROM VALUES
    (1, '{"customer_id":"C001","event_type":"ORDER_CREATED","amount":125.50,"customer":{"email":"a@example.com"}}'),
    (2, '{"customer_id":"C002","event_type":"PAYMENT_RECEIVED","amount":999.99,"customer":{"email":"b@example.com"}}'),
    (3, '{"customer_id":"C003","event_type":"ORDER_CREATED","amount":null,"customer":{}}');

CREATE OR REPLACE FUNCTION get_event_value(
    event_data VARIANT,
    field_path STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
    GET_PATH(event_data, field_path)::STRING
$$;



SELECT
    event_id,
    get_event_value(payload, 'customer_id') AS customer_id,
    get_event_value(payload, 'event_type') AS event_type,
    get_event_value(payload, 'amount') AS amount,
    get_event_value(payload, 'customer.email') AS customer_email
FROM event_value_test
ORDER BY event_id;


select * from event_value_test;


create temporary table t_cust_json_info
(id number , cust_info variant);

insert into t_cust_json_info
SELECT column1, PARSE_JSON(column2)
FROM VALUES
( 1 , '{
  "AREA": "Hitech City",
  "CITY": "Hyderabad",
  "COMPANY": "TCS",
  "COUNTRY": "India",
  "EMAIL": "priya.rao@gmail.com",
  "FIRSTNAME": "Priya",
  "ID": 1,
  "LASTNAME": "Rao",
  "LOCALITY": "Kondapur",
  "PHONE": 2146202474,
  "PINCODE": "730912",
  "STATECODE": "MH"
}');


insert into t_cust_json_info
SELECT column1, PARSE_JSON(column2)
FROM VALUES
(2,'{
  "AREA": "Gachibowli",
  "CITY": "Pune",
  "COMPANY": "Cognizant",
  "COUNTRY": "India",
  "EMAIL": "kavya.verma@gmail.com",
  "FIRSTNAME": "Kavya",
  "ID": 2,
  "LASTNAME": "Verma",
  "LOCALITY": "Kondapur",
  "PHONE": 5327299222,
  "PINCODE": "743662",
  "STATECODE": "KA"
}');

insert into t_cust_json_info
SELECT column1, PARSE_JSON(column2)
FROM VALUES
(3,'{
  "AREA": "Kukatpally",
  "CITY": "Hyderabad",
  "COMPANY": "HCL",
  "COUNTRY": "India",
  "EMAIL": "suresh.gupta@gmail.com",
  "FIRSTNAME": "Suresh",
  "ID": 3,
  "LASTNAME": "Gupta",
  "LOCALITY": "Kondapur",
  "PHONE": 401795542,
  "PINCODE": "450158",
  "STATECODE": "TG"
}');


select id,get_event_value(cust_info,'AREA'),get_event_value(cust_info,'CITY') from t_cust_json_info;



--pre-defined exception --> 
statement_Error  --> select 
expression_Error  --> data types 
other 
---user-defined exception --> 
;

select * from emp where sal<1000;

call PR_GRATUITY_UPDATE_cursor();




CREATE OR REPLACE PROCEDURE PR_GRATUITY_UPDATE_cursor()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
            exp_Sal_check  exception;
            
            c1 cursor for             select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp ;
        
        BEGIN 
        
             open c1;
			 for i in c1 loop 
					 v_empno:=i.empno;
					 v_ename:=i.ename;
					 v_sal:=i.sal;
					 v_hiredate:=i.hiredate;
					 v_dor:=i.dor;
					 v_experience:=i.experience;
					 v_gratuity:=i.gratuity;


                     if (v_Sal <1000 ) then 
                        raise exp_Sal_check;
                     end if ;
				   

					if (v_experience>=5 and v_dor is not null) then 
						v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

						 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
						
					elseif (v_experience<5 and v_dor is not null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years ';  
						 update emp set   description=:v_message where empno=:v_empno;                  
					elseif (v_experience<5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
						 update emp set   description=:v_message where empno=:v_empno;                      
					elseif (v_experience>=5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he is not resigned';
						 update emp set   description=:v_message where empno=:v_empno;                      
					end if;
			
			end loop ;
			close c1; 
            
            return object_construct('v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        exception 
        when exp_Sal_check then   --- handling the exception
              let v_exp_message varchar;
                  v_exp_message:='salary is less than 500';
              return v_exp_message;
          
        END;
;


-20001 to -20999 --> 
;


CREATE OR REPLACE PROCEDURE PR_GRATUITY_UPDATE_cursor()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename varchar;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
            exp_Sal_check  exception(-20002,'Salary is less than 1000');
            
            c1 cursor for             select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp ;
        
        BEGIN 
        
             open c1;
			 for i in c1 loop 
					 v_empno:=i.empno;
					 v_ename:=i.ename;
					 v_sal:=i.sal;
					 v_hiredate:=i.hiredate;
					 v_dor:=i.dor;
					 v_experience:=i.experience;
					 v_gratuity:=i.gratuity;


                     if (v_Sal <1000 ) then 
                        raise exp_Sal_check;
                     end if ;
				   

					if (v_experience>=5 and v_dor is not null) then 
						v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

						 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
						
					elseif (v_experience<5 and v_dor is not null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years ';  
						 update emp set   description=:v_message where empno=:v_empno;                  
					elseif (v_experience<5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
						 update emp set   description=:v_message where empno=:v_empno;                      
					elseif (v_experience>=5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he is not resigned';
						 update emp set   description=:v_message where empno=:v_empno;                      
					end if;
			
			end loop ;
			close c1; 
            
            return object_construct('v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        exception 
        when exp_Sal_check then   --- handling the exception
              return concat(sqlcode,'-------',sqlerrm);          
        END;
;




call PR_GRATUITY_UPDATE_CURSOR();


 select empno,ename,salary,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity from emp ;


show stages;

list @STG_CSV_STAGE/emp.csv;

 select * from emp;

select table_name,listagg(column_name,',')within group(order by ordinal_position) as column_name from information_schema.columns where table_name='EMP'
group by table_name;


select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11 from @STG_CSV_STAGE/test_emp.csv (file_Format=>csv_Format);

delete from emp;

select * from emp;

truncate table emp;


call PR_GRATUITY_UPDATE_cursor();

          copy into emp from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11 from @STG_CSV_STAGE/test_emp.csv (file_Format=>csv_Format));

select * from table(information_schema.copy_history(table_name=>'emp',start_time=>dateadd('hours',-1,current_timestamp())));


copy into emp from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11 from @STG_CSV_STAGE/test_emp.csv (file_Format=>csv_Format)) force=true;
          


CREATE OR REPLACE PROCEDURE PR_GRATUITY_UPDATE_cursor()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS  -- start of the procedure 
        DECLARE
            v_empno number;
            v_ename number;
            v_sal number;
            v_hiredate date;
            v_dor date;
            v_experience number;
            v_gratuity number;
            v_message varchar;
            
            c1 cursor for             select empno,ename,sal,hiredate,dor,datediff('years',hiredate,coalesce(dor,current_date())) as experience , round((sal*15*datediff('years',hiredate,coalesce(dor,current_date())))/26) as gratuity
            from emp ;
        
        BEGIN 
  
          truncate table emp;
          copy into emp from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11 from @STG_CSV_STAGE/test_emp.csv (file_Format=>csv_Format));
        
             open c1;
			 for i in c1 loop 
					 v_empno:=i.empno;
					 v_ename:=i.ename;
					 v_sal:=i.sal;
					 v_hiredate:=i.hiredate;
					 v_dor:=i.dor;
					 v_experience:=i.experience;
					 v_gratuity:=i.gratuity;


					if (v_experience>=5 and v_dor is not null) then 
						v_message:=concat('The gratuity of the employee ',v_ename,' is ',v_gratuity);

						 update emp set gratuity=:v_gratuity, description=:v_message where empno=:v_empno;
						
					elseif (v_experience<5 and v_dor is not null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years ';  
						 update emp set   description=:v_message where empno=:v_empno;                  
					elseif (v_experience<5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he experience is <5 years and also he is not reisgned '  ;  
						 update emp set   description=:v_message where empno=:v_empno;                      
					elseif (v_experience>=5 and v_dor is null) then 
						  v_message:='Employee is not eligible.. he is not resigned';
						 update emp set   description=:v_message where empno=:v_empno;                      
					end if;
			
			end loop ;
			close c1; 
            
            return object_construct('v_experience',v_experience,'v_dor',v_dor,'v_message',v_message);
        exception   
        when statement_error then 
          return concat(sqlcode,'------',sqlerrm);
        when expression_Error then 
          return concat(sqlcode,'------',sqlerrm);     
        when other then 
          return concat(sqlcode,'------',sqlerrm);            
         
        END;
;


create database dev_db;
create schema dev_schema;
create warehouse dev_wh;

select * from information_schema.procedures;


CREATE OR REPLACE TABLE RAW_TEST_EMP (
    EMP_ID        VARCHAR,
    EMP_NAME      VARCHAR,
    DEPT          VARCHAR,
    SALARY        VARCHAR,
    type_of_load    VARCHAR, -- F I 
    D_CREATED_DATE TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FILENAME      VARCHAR
);
 


INSERT INTO RAW_TEST_EMP
(
    EMP_ID,
    EMP_NAME,
    DEPT,
    SALARY,
    type_of_load,
    FILENAME
)
VALUES
    ('101', 'Ravi Kumar',    'IT',         '65000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('102', 'Priya Sharma',  'HR',         '55000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('103', 'Arjun Reddy',   'FINANCE',    '72000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('104', 'Sneha Rao',     'MARKETING',  '60000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('105', 'Kiran Patel',   'IT',         '80000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('106', 'Anjali Singh',  'HR',         '58000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('107', 'Vijay Kumar',   'SALES',      '70000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('108', 'Megha Nair',    'FINANCE',    '75000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('109', 'Rahul Verma',   'SALES',      '68000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('110', 'Pooja Reddy',   'IT',         '85000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv');



  select * from RAW_TEST_EMP;


select md5('Bala');


create table emp(empno number, ename varchar,sal number, location varchar,designation varchar);

insert into emp values(10,'Krishna',20000,'Hyderabad','Team Lead');
insert into emp values(20,'Ravi',50000,'Hyderabad','Manager');
insert into emp values(null,'Ravali',50000,'Hyderabad','Manager');

delete from emp where empno is null;

create table target_Emp as 
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e 
where 1=2;


select * from target_Emp;

select * from emp;

create view vw_emp 
as 
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e ;

insert into target_emp
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e ;


select * from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey);

select * from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata=s.hashdata);

insert into target_emp
select * from vw_emp s where not exists ( select 1 from target_emp t where t.hashkey=s.hashkey);

select * from vw_emp s where not exists ( select 1 from target_emp t where t.hashkey=s.hashkey);


select * from target_emp;
                                         active_flag
10	Krishna	20000	Hyderabad	Manager   'Y'
10	Krishna	20000	Hyderabad	Team Lead 'N'


select * from emp;
select * from target_emp;

select * from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata<>s.hashdata);

update emp set designation='Manager' where empno=10;



select concat('Bala','_','Krishna');
select 'Bala'||'_'||'Krishna';

select 'Bala'||'|'||'Krishna';



-------5th 

select md5('Bala');


create table emp(empno number, ename varchar,sal number, location varchar,designation varchar);

insert into emp values(10,'Krishna',20000,'Hyderabad','Team Lead');


 

create table target_Emp as 
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e 
where 1=2;


select * from target_Emp;

select * from emp;

create view vw_emp 
as 
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e ;

select * from vw_emp;

insert into target_emp
select md5( coalesce(empno::varchar,'NULL')) as hashkey,
md5(coalesce(empno::varchar,'NULL')||'|'||coalesce(ename::varchar,'NULL')||'|'||coalesce(sal::varchar,'NULL')
||'|'||coalesce(location::varchar,'NULL')||'|'||coalesce(designation::varchar,'NULL')) as hashdata,
empno,ename,sal,location,designation
from emp e ;

select * from vw_emp;
select * from target_emp;

select * from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey);

select * from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata=s.hashdata);

insert into emp values(20,'Ravi',50000,'Hyderabad','Manager');

insert into target_emp
select * from vw_emp s where not exists ( select 1 from target_emp t where t.hashkey=s.hashkey);

select * from vw_emp s where not exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata=s.hashdata );

update target_emp set active_flag='Y';
update emp set sal=75000 where empno=10;

merge into target_emp t 
using (select * from vw_emp s where not exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata=s.hashdata )) s 
on (t.hashkey=s.hashkey  )
when matched then 
update set active_flag='N';

insert into target_emp
select HASHKEY,HASHDATA,EMPNO,ENAME,SAL,LOCATION,DESIGNATION,'Y' from vw_emp s where exists ( select 1 from target_emp t where t.hashkey=s.hashkey and t.hashdata <> s.hashdata );
 
 
CREATE OR REPLACE TABLE RAW_TEST_EMP (
    EMP_ID        VARCHAR,
    EMP_NAME      VARCHAR,
    DEPT          VARCHAR,
    SALARY        VARCHAR,
    type_of_load    VARCHAR, -- F I 
    D_CREATED_DATE TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FILENAME      VARCHAR
);
 


INSERT INTO RAW_TEST_EMP
(
    EMP_ID,
    EMP_NAME,
    DEPT,
    SALARY,
    type_of_load,
    FILENAME
)
VALUES
    ('101', 'Ravi Kumar',    'IT',         '65000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('102', 'Priya Sharma',  'HR',         '55000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('103', 'Arjun Reddy',   'FINANCE',    '72000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('104', 'Sneha Rao',     'MARKETING',  '60000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('105', 'Kiran Patel',   'IT',         '80000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('106', 'Anjali Singh',  'HR',         '58000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('107', 'Vijay Kumar',   'SALES',      '70000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('108', 'Megha Nair',    'FINANCE',    '75000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('109', 'Rahul Verma',   'SALES',      '68000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv'),
    ('110', 'Pooja Reddy',   'IT',         '85000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv');

select * from RAW_TEST_EMP;




CREATE OR REPLACE VIEW VW_RAW_TEST_EMP AS
SELECT 
    MD5(COALESCE(CAST(EMP_ID AS VARCHAR), 'NULL')) AS HASHKEY_PK, --> PK COLUMNN 
    MD5(
        COALESCE(CAST(EMP_ID AS VARCHAR), 'NULL') || '|' ||
        COALESCE(CAST(EMP_NAME AS VARCHAR), 'NULL') || '|' ||
        COALESCE(CAST(DEPT AS VARCHAR), 'NULL') || '|' ||
        COALESCE(CAST(SALARY AS VARCHAR), 'NULL') || '|' ||
        COALESCE(CAST(type_of_load AS VARCHAR), 'NULL')
    ) AS HASHKEY_DATA, -- COMBINATION OF ALL THE COLUMNS 
    CAST(EMP_ID AS VARCHAR) AS EMP_ID,
    CAST(EMP_NAME AS VARCHAR) AS EMP_NAME,
    CAST(DEPT AS VARCHAR) AS DEPT,
    CAST(SALARY AS VARCHAR) AS SALARY,
    CAST(type_of_load AS VARCHAR) AS type_of_load,
    FILENAME AS ETL_SOURCE_FILENAME,
    D_CREATED_DATE AS ETL_SOURCE_LOAD_DATE
FROM RAW_TEST_EMP;


select * from VW_RAW_TEST_EMP;

select * from TEST_EMP;


CREATE OR REPLACE TABLE TEST_EMP (
    SURROGATE_KEY       NUMBER AUTOINCREMENT,
    HASHKEY_PK          VARCHAR,
    HASHKEY_DATA        VARCHAR,
    EMP_ID              VARCHAR,
    EMP_NAME            VARCHAR,
    DEPT                VARCHAR,
    SALARY              VARCHAR,
    type_of_load          VARCHAR,
    ETL_EFFECTIVE_DATE  TIMESTAMP_NTZ, ---
    ETL_END_DATE        TIMESTAMP_NTZ, -- 
    ETL_IS_CURRENT      BOOLEAN,  -- 
    ETL_VERSION_NUMBER  NUMBER,
    ETL_IS_DELETE        BOOLEAN DEFAULT FALSE,
    ETL_DELETE_TYPE      VARCHAR,
    ETL_DELETE_SOURCE_FILENAME VARCHAR,
    ETL_SOURCE_FILENAME  VARCHAR,
    ETL_SOURCE_LOAD_DATE TIMESTAMP_NTZ
);


INSERT INTO RAW_TEST_EMP
(
    EMP_ID,
    EMP_NAME,
    DEPT,
    SALARY,
    type_of_load,
    FILENAME
)
select '101', 'Ravi Kumar',    'IT',         '65000', 'F', 'EMP_INFO/EMP_F_20261002_001.csv';


select * From RAW_TEST_EMP;
delete  From RAW_TEST_EMP;



delete from TEMP_EMP_DATA_RAW;
delete from TEMP_EMP_DATA;
select * from TEMP_EMP_DATA_RAW;


delete from TEST_EMP;


--source 
select * From RAW_TEST_EMP;
--target 
select * from TEST_EMP;


create or replace procedure pr_load_Data (p_file_name varchar)
returns varchar 
language sql 
as 
$$
declare 
     v_message varchar;
begin 

create or replace  temporary table TEMP_EMP_DATA_RAW
as 
SELECT * FROM VW_RAW_TEST_EMP
WHERE ETL_SOURCE_FILENAME = :p_file_name;

---removing the duplicates 
create or replace temporary table TEMP_EMP_DATA
as 
SELECT s.*
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY HASHKEY_PK 
            ORDER BY ETL_SOURCE_LOAD_DATE DESC, ETL_SOURCE_FILENAME DESC
        ) AS rn
    FROM TEMP_EMP_DATA_RAW
) s
WHERE s.rn = 1 AND s.EMP_ID IS NOT NULL;


INSERT INTO TEST_EMP (
    HASHKEY_PK, HASHKEY_DATA, EMP_ID, EMP_NAME, DEPT, SALARY, type_of_load,
    ETL_EFFECTIVE_DATE, ETL_END_DATE, ETL_IS_CURRENT, ETL_VERSION_NUMBER,
    ETL_SOURCE_FILENAME, ETL_SOURCE_LOAD_DATE)
SELECT s.HASHKEY_PK, s.HASHKEY_DATA, s.EMP_ID, s.EMP_NAME, s.DEPT, s.SALARY, s.type_of_load,
    CURRENT_TIMESTAMP(), NULL, TRUE,
    COALESCE((SELECT MAX(ETL_VERSION_NUMBER) + 1 FROM TEST_EMP t2
              WHERE t2.HASHKEY_PK = s.HASHKEY_PK), 1),
    s.ETL_SOURCE_FILENAME, s.ETL_SOURCE_LOAD_DATE
FROM TEMP_EMP_DATA s;

return 'success';

end;
$$;


call pr_load_Data('EMP_INFO/EMP_F_20261002_001.csv');

select * from raw_emp_data;
select * from TEST_EMP;


INSERT INTO RAW_TEST_EMP
(
    EMP_ID,
    EMP_NAME,
    DEPT,
    SALARY,
    type_of_load,
    FILENAME
)
select '101', 'Ravi Kumar',    'IT',         '250000', 'F', 'EMP_INFO/EMP_F_20261005_001.csv';


call PR_LOAD_DATA('EMP_INFO/EMP_F_20261005_001.csv');

select * from TEST_EMP;



CREATE OR REPLACE PROCEDURE PR_LOAD_DATA (P_FILE_NAME VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$

DECLARE
    V_MESSAGE VARCHAR;

BEGIN

    ------------------------------------------------------------
    -- STEP 1
    -- Read only the requested source file
    ------------------------------------------------------------

    CREATE OR REPLACE TEMPORARY TABLE TEMP_EMP_DATA_RAW AS
    SELECT *
    FROM VW_RAW_TEST_EMP
    WHERE ETL_SOURCE_FILENAME = :P_FILE_NAME;


    ------------------------------------------------------------
    -- STEP 2
    -- Deduplicate source
    -- Keep latest record for each employee
    ------------------------------------------------------------

    CREATE OR REPLACE TEMPORARY TABLE TEMP_EMP_DATA AS
    SELECT
        HASHKEY_PK,
        HASHKEY_DATA,
        EMP_ID,
        EMP_NAME,
        DEPT,
        SALARY,
        TYPE_OF_LOAD,
        ETL_SOURCE_FILENAME,
        ETL_SOURCE_LOAD_DATE
    FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER
            (
                PARTITION BY HASHKEY_PK
                ORDER BY
                    ETL_SOURCE_LOAD_DATE DESC,
                    ETL_SOURCE_FILENAME DESC
            ) AS RN
        FROM TEMP_EMP_DATA_RAW
    )
    WHERE RN = 1
      AND EMP_ID IS NOT NULL;


    ------------------------------------------------------------
    -- STEP 3
    -- SCD TYPE 2
    -- Expire existing current record when data changed
    ------------------------------------------------------------

    UPDATE TEST_EMP T
    SET
        T.ETL_END_DATE   = CURRENT_TIMESTAMP(),
        T.ETL_IS_CURRENT = FALSE
    FROM TEMP_EMP_DATA S
    WHERE T.HASHKEY_PK = S.HASHKEY_PK

      -- Only compare against current record
      AND T.ETL_IS_CURRENT = TRUE

      -- Business data changed
      AND T.HASHKEY_DATA <> S.HASHKEY_DATA;





    ------------------------------------------------------------
    -- STEP 4
    -- Insert:
    --
    -- 1. Completely new employees
    -- 2. New versions of changed employees
    --
    -- Do not insert if same version already exists
    ------------------------------------------------------------

    INSERT INTO TEST_EMP
    (
        HASHKEY_PK,
        HASHKEY_DATA,
        EMP_ID,
        EMP_NAME,
        DEPT,
        SALARY,
        TYPE_OF_LOAD,
        ETL_EFFECTIVE_DATE,
        ETL_END_DATE,
        ETL_IS_CURRENT,
        ETL_VERSION_NUMBER,
        ETL_SOURCE_FILENAME,
        ETL_SOURCE_LOAD_DATE
    )

    SELECT
        S.HASHKEY_PK,
        S.HASHKEY_DATA,
        S.EMP_ID,
        S.EMP_NAME,
        S.DEPT,
        S.SALARY,
        S.TYPE_OF_LOAD,

        CURRENT_TIMESTAMP() AS ETL_EFFECTIVE_DATE,

        NULL AS ETL_END_DATE,

        TRUE AS ETL_IS_CURRENT,

        COALESCE
        (
            (
                SELECT MAX(T2.ETL_VERSION_NUMBER) + 1
                FROM TEST_EMP T2
                WHERE T2.HASHKEY_PK = S.HASHKEY_PK
            ),
            1
        ) AS ETL_VERSION_NUMBER,

        S.ETL_SOURCE_FILENAME,
        S.ETL_SOURCE_LOAD_DATE

    FROM TEMP_EMP_DATA S

    WHERE NOT EXISTS
    (
        SELECT 1
        FROM TEST_EMP T
        WHERE T.HASHKEY_PK = S.HASHKEY_PK
          AND T.HASHKEY_DATA = S.HASHKEY_DATA
          AND T.ETL_IS_CURRENT = TRUE
    );


    ------------------------------------------------------------
    -- STEP 5
    -- Return status
    ------------------------------------------------------------

    V_MESSAGE := 'SCD TYPE 2 LOAD COMPLETED SUCCESSFULLY FOR FILE: '
                 || P_FILE_NAME;

    RETURN V_MESSAGE;

END;

$$;


--6th
select * from raw_test_emp where emp_id=102; --95000

insert into raw_test_emp values(102,'Priya Sharma','HR',95000,'F',current_timestamp(),'EMP_INFO/EMP_F_20261006_001.csv');

select * from test_emp where emp_id=102;
 
17	ec8956637a99787bd197eacd77acce5e	d9019ef6dbc2b7e536b61584cb87367b	102	Priya Sharma	HR	95000	F	2026-10-06 19:19:21.645	 null	TRUE	2	FALSE			EMP_INFO/EMP_F_20261002_001.csv	2026-10-04 19:17:35.949
 
17	ec8956637a99787bd197eacd77acce5e	d9019ef6dbc2b7e536b61584cb87367b	102	Priya Sharma	HR	55000	F	2026-10-04 19:19:21.645		2026-10-06 19:19:21.645 FALSE	1	FALSE			EMP_INFO/EMP_F_20261002_001.csv	2026-10-04 19:17:35.949
;

create table t_permanent_cust_info
(
ID number,
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number,
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
); 


create transient table t_trainsient_cust_info
(
ID number,
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number,
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
); 

;
-- permanent tables 
select * from information_schema.tables where table_type='BASE TABLE' and is_transient='NO';
--Transient tables 
select * from information_schema.tables where table_type='BASE TABLE' and is_transient='YES';
--temporary tables 
select * from information_schema.tables where table_type='LOCAL TEMPORARY' ;
--external table 
select * from information_schema.tables where table_type='EXTERNAL TABLE' ;
--iceberg table 
select * from information_schema.tables where is_iceberg='YES';
--dynamic tables 
select * from information_schema.tables where is_dynamic='YES';
--Hybdrid tables 
select * from information_schema.tables where is_hybrid='YES';


call PR_LOAD_DATA('EMP_INFO/EMP_F_20261006_001.csv');


select * from test_emp where emp_id=102;

-- retention_time=1 day 
select * from information_schema.tables where table_type='BASE TABLE' and is_transient='NO' and table_name ='TEST_EMP';

select * from test_emp;

update test_emp set salary=55000; -- 01c789f7-3203-7b0e-0018-769e000652ca    2026-10-05 18:59:20.274 -0700


select * from test_emp before (statement=>'01c789f7-3203-7b0e-0018-769e000652ca');

 select * from test_emp;

select current_timestamp();

select datediff('minutes','2026-10-05 18:59:20.274 -0700',current_timestamp()); -- 4 minites 

merge into test_emp t 
using (select * from test_emp before (statement=>'01c789f7-3203-7b0e-0018-769e000652ca')) s 
on (t.SURROGATE_KEY=s.SURROGATE_KEY)
when matched then  
update set t.salary=s.salary;

select * from table(information_schema.query_history());

select * from test_emp at (offset=>-60*4);
select * from test_emp at (offset=>-60*5);
select * from test_emp at (offset=>-60*6);
select * from test_emp at (offset=>-60*7);
select * from test_emp at (offset=>-60*19);

select get_ddl('TABLE','test_emp');

--- going back to the past is called "Time Travel"
select * from test_emp at (offset=>-60*8);
select * from test_emp at (offset=>-60*10);


select * from test_emp;

create or replace TABLE T_EMP (
	SURROGATE_KEY NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	HASHKEY_PK VARCHAR(16777216),
	HASHKEY_DATA VARCHAR(16777216),
	EMP_ID VARCHAR(16777216),
	EMP_NAME VARCHAR(16777216),
	DEPT VARCHAR(16777216),
	SALARY VARCHAR(16777216),
	TYPE_OF_LOAD VARCHAR(16777216),
	ETL_EFFECTIVE_DATE TIMESTAMP_NTZ(9),
	ETL_END_DATE TIMESTAMP_NTZ(9),
	ETL_IS_CURRENT BOOLEAN,
	ETL_VERSION_NUMBER NUMBER(38,0),
	ETL_IS_DELETE BOOLEAN DEFAULT FALSE,
	ETL_DELETE_TYPE VARCHAR(16777216),
	ETL_DELETE_SOURCE_FILENAME VARCHAR(16777216),
	ETL_SOURCE_FILENAME VARCHAR(16777216),
	ETL_SOURCE_LOAD_DATE TIMESTAMP_NTZ(9)
)data_retention_time_in_days=0;

insert into t_emp 
select * from test_emp at (offset=>-60*9);

select * from t_emp;

select * from information_schema.tables where table_name ='T_EMP';

select * from t_Emp;

update t_Emp set salary=70000;


select * from t_Emp at(offset=>-60*1);-- 1 minute 
select * from t_Emp before(statement=>'01c78a07-3203-7b0e-0018-769e000654ca');

select * from table(information_schema.query_history());



create or replace TABLE T_EMP_MAX (
	SURROGATE_KEY NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	HASHKEY_PK VARCHAR(16777216),
	HASHKEY_DATA VARCHAR(16777216),
	EMP_ID VARCHAR(16777216),
	EMP_NAME VARCHAR(16777216),
	DEPT VARCHAR(16777216),
	SALARY VARCHAR(16777216),
	TYPE_OF_LOAD VARCHAR(16777216),
	ETL_EFFECTIVE_DATE TIMESTAMP_NTZ(9),
	ETL_END_DATE TIMESTAMP_NTZ(9),
	ETL_IS_CURRENT BOOLEAN,
	ETL_VERSION_NUMBER NUMBER(38,0),
	ETL_IS_DELETE BOOLEAN DEFAULT FALSE,
	ETL_DELETE_TYPE VARCHAR(16777216),
	ETL_DELETE_SOURCE_FILENAME VARCHAR(16777216),
	ETL_SOURCE_FILENAME VARCHAR(16777216),
	ETL_SOURCE_LOAD_DATE TIMESTAMP_NTZ(9)
)data_retention_time_in_days=90; --- Exceeds maximum allowable retention time (90 day(s)).


permanent --> 90 time travel + 7 days fail safe (Clod provider)

;

select * from t_emp;

select * from information_schema.tables where table_name ='T_EMP';


drop table t_Emp;

undrop table t_emp;

select * from information_schema.tables where table_name ='TEST_EMP';


drop table test_emp;

undrop table test_emp;




select * from raw_test_emp;

select * from information_schema.tables where table_name ='RAW_TEST_EMP'; --- 8 columns , 13 rows 


drop table raw_test_emp;

create table raw_test_emp(id number);

select * from raw_test_emp;

undrop table raw_test_emp;


alter table raw_test_emp rename to raw_test_emp_old;

undrop table raw_test_emp;


---7th 

-- trainsient 
select * from information_schema.tables where table_type='BASE TABLE' and is_transient='YES';

alter table T_TRAINSIENT_CUST_INFO set data_retention_time_in_days=2;

select * from T_TRAINSIENT_CUST_INFO;

select * from T_PERMANENT_CUST_INFO;

select current_timestamp(); -- 2026-10-06 18:38:04.495 -0700


insert into T_TRAINSIENT_CUST_INFO
select * from t_Cust_info;

show tables;

AWS(files) --> stg_cust_info(trasient) --> 

;

Trainset --> max 1 --> day 
;


select * from information_schema.table_storage_metrics;


-->temporary 
no storage 
--permanent
active_bytes      --> emp --> 5 MB   --> 10$
time_travel_bytes --> emp --> 5 days --> 50$
fail_safe_bytes --> emp --> 7 days -->   70$

-->Transient
active_bytes      --> emp --> 5 MB   --> 10$
time_travel_bytes --> emp --> 1 days --> 20$



;

show stages;


select * from information_schema.tables where table_type='EXTERNAL TABLE' ;
;
;

create storage integration aws_integration
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::547960255593:role/role20261001'
enabled = true
storage_allowed_locations = ( 's3://bkt20261001/stg_parquet_files/' ); 

desc storage integration aws_integration;

CREATE STAGE aws_parquet_stage 
	URL = 's3://bkt20261001/stg_parquet_files/' 
	STORAGE_INTEGRATION = AWS_INTEGRATION 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access parquet files from aws';

create file format parquet_format
type=parquet;

create external table t_Ext_cust_info_new
location=@aws_parquet_stage
file_Format=parquet_format;


select * from information_schema.tables where table_type='EXTERNAL TABLE' ;

select * from t_Ext_cust_info_new;
select value:birthdate from t_Ext_cust_info_new;

create external table t_Ext_cust_info
(
registration_dttm TIMESTAMP_NTZ as (VALUE:registration_dttm::TIMESTAMP_NTZ),
id NUMBER(38, 0) as (VALUE:id::NUMBER(38, 0)),
first_name TEXT as (VALUE:first_name::TEXT),
last_name TEXT as (VALUE:last_name::TEXT),
email TEXT as (VALUE:email::TEXT),
gender TEXT as (VALUE:gender::TEXT),
ip_address TEXT as (VALUE:ip_address::TEXT),
cc TEXT as (VALUE:cc::TEXT),
country TEXT as (VALUE:country::TEXT),
birthdate TEXT as (VALUE:birthdate::TEXT),
salary REAL as (VALUE:salary::REAL),
title TEXT as (VALUE:title::TEXT),
comments TEXT as (VALUE:comments::TEXT)
)
location=@aws_parquet_stage
file_Format=parquet_format;

select * from t_Ext_cust_info;

select * exclude value from t_Ext_cust_info;

delete from t_Ext_cust_info;

value --> column_name:key_name

;
select concat(column_name,' ',type,' as ', '(',replace(expression,'$1','VALUE'),'),') from table(infer_schema(LOCATION => '@aws_parquet_stage' , FILE_FORMAT => 'parquet_format' , FILES => 'Users_Info.parquet'));

--metadata 
select * from table(information_schema.external_table_files(table_name=>'t_Ext_cust_info')); -- metadata 
select * from table(information_schema.external_table_file_registration_history(table_name=>'t_Ext_cust_info')); --- there is a file 
--data
select * from t_Ext_cust_info;

alter external table t_Ext_cust_info refresh;

create external table t_Ext_cust_info_1
(
registration_dttm TIMESTAMP_NTZ as (VALUE:registration_dttm::TIMESTAMP_NTZ),
id NUMBER(38, 0) as (VALUE:id::NUMBER(38, 0)),
first_name TEXT as (VALUE:first_name::TEXT),
last_name TEXT as (VALUE:last_name::TEXT),
email TEXT as (VALUE:email::TEXT),
gender TEXT as (VALUE:gender::TEXT),
ip_address TEXT as (VALUE:ip_address::TEXT),
cc TEXT as (VALUE:cc::TEXT),
country TEXT as (VALUE:country::TEXT),
birthdate TEXT as (VALUE:birthdate::TEXT),
salary REAL as (VALUE:salary::REAL),
title TEXT as (VALUE:title::TEXT),
comments TEXT as (VALUE:comments::TEXT)
)
location=@aws_parquet_stage
file_Format=parquet_format
auto_refresh=true;



create storage integration aws_integration
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::547960255593:role/role20261001'
enabled = true
storage_allowed_locations = ( 's3://bkt20261001/stg_parquet_files/' ); 



--------8th




External table -
DATA            --> AWS 
metadata data   --> Snowflake 


Iceberg table -
DATA            --> AWS 
metadata data   --> Snowflake 
;

show external volumes;

create external volume ext_volume
storage_locations=(
                     (
                       name='iceberg'
                       storage_provider = 's3'
                       storage_base_url='s3://bktjan202601/'
                       storage_aws_role_arn = 'arn:aws:iam::262250695931:role/rolejan202601'
                     )
                  );

SELECT SYSTEM$VERIFY_EXTERNAL_VOLUME('EXT_VOLUME');

{"success":false,"storageLocationSelectionResult":"PASSED","storageLocationName":"iceberg","servicePrincipalProperties":"STORAGE_AWS_IAM_USER_ARN: arn:aws:iam::798793718469:user/npja2000-s; STORAGE_AWS_EXTERNAL_ID: CH59716_SFCRole=4_XkS/YVwK+x/h9kh/7Jq1n6aH5c8=","location":"s3://bktjan202601/","storageAccount":null,"region":"ap-southeast-2","writeResult":"FAILED with exception message Error assuming AWS_ROLE:\nUser: arn:aws:iam::798793718469:user/npja2000-s is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::262250695931:role/rolejan202601","readResult":"FAILED with exception message Error assuming AWS_ROLE:\nUser: arn:aws:iam::798793718469:user/npja2000-s is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::262250695931:role/rolejan202601","listResult":"FAILED with exception message Error assuming AWS_ROLE:\nUser: arn:aws:iam::798793718469:user/npja2000-s is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::262250695931:role/rolejan202601","deleteResult":"FAILED with exception message Error assuming AWS_ROLE:\nUser: arn:aws:iam::798793718469:user/npja2000-s is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::262250695931:role/rolejan202601","awsRoleArnValidationResult":"PASSED","azureGetUserDelegationKeyResult":"SKIPPED"}

desc external volume ext_volume;

{"NAME":"iceberg","STORAGE_PROVIDER":"S3",
"STORAGE_BASE_URL":"s3://bktjan202601/",
"STORAGE_ALLOWED_LOCATIONS":["s3://bktjan202601/*"],
"STORAGE_AWS_ROLE_ARN":"arn:aws:iam::262250695931:role/rolejan202601",
"STORAGE_AWS_IAM_USER_ARN":"arn:aws:iam::798793718469:user/npja2000-s",
"STORAGE_AWS_EXTERNAL_ID":"CH59716_SFCRole=4_XkS/YVwK+x/h9kh/7Jq1n6aH5c8=",
"ENCRYPTION_TYPE":"NONE",
"ENCRYPTION_KMS_KEY_ID":""}

;
create iceberg table t_ib_permanent_cust_info
(
ID number(10,0),
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number(10,0),
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
)
catalog='SNOWFLAKE'
external_volume=ext_volume   --> like a  storage integration to establish connectin with aws
base_location='cust_info';  --> data+metadata 








create storage integration aws_integration_new
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::262250695931:role/role_jan202602'
enabled = true
storage_allowed_locations = ( 's3://bktjan202602/stg_csv_files/' ); 


desc storage integration aws_integration_new;




CREATE STAGE aws_csv_stage_new
	URL = 's3://bktjan202602/stg_csv_files/' 
	STORAGE_INTEGRATION = aws_integration_new 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';

    
    SELECT SYSTEM$VALIDATE_STORAGE_INTEGRATION(
    'AWS_INTEGRATION_NEW',
    's3://bktjan202602/stg_csv_files/',
    'snowflake_integration_test.txt',
    'all'
);


;
create iceberg table t_ib_permanent_cust_info
(
ID number(10,0),
FirstName varchar,
LastName varchar,
Email varchar,
Company varchar,
Phone number(10,0),
Area varchar,
Locality varchar,
City varchar,
StateCode varchar,
Pincode varchar,
Country varchar
)
catalog='SNOWFLAKE'
external_volume=ext_volume   --> like a  storage integration to establish connectin with aws
base_location='cust_info';  --> data+metadata 


select * from T_IB_PERMANENT_CUST_INFO;


show stages;

list @AWS_CSV_STAGE;

select * from T_EXT_CUST_INFO;

show tables;

create storage integration aws_integration_dev
type = external_stage
storage_provider = s3
storage_aws_role_arn = 'arn:aws:iam::481340754866:role/rolemarch202602'
enabled = true
storage_allowed_locations = ( 's3://bktmarch202602/stg_csv_files/' ); 


alter storage integration aws_integration_dev set storage_allowed_locations = ( 's3://bktmarch202602/stg_csv_files/','s3://bktmarch202602/stg_parquet_files/',
's3://bktmarch202602/stg_avro_files/','s3://bktmarch202602/stg_json_files/'); 

desc storage integration aws_integration_dev;

CREATE STAGE aws_csv_stage_new
	URL = 's3://bktmarch202602/stg_csv_files/' 
	STORAGE_INTEGRATION = aws_integration_dev
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access csv files from aws';

show file formats;

create file format csv_format 
type=csv 
skip_header=1;

create file format avro_format 
type=avro;

create file format json_format 
type=json;



CREATE STAGE aws_parquet_stage_new
	URL = 's3://bktmarch202602/stg_parquet_files/' 
	STORAGE_INTEGRATION = aws_integration_dev
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access parquet files from aws';



CREATE STAGE aws_json_stage_new
	URL = 's3://bktmarch202602/stg_json_files/' 
	STORAGE_INTEGRATION = aws_integration_dev
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access json files from aws';



CREATE STAGE aws_avro_stage_new
	URL = 's3://bktmarch202602/stg_avro_files/' 
	STORAGE_INTEGRATION = aws_integration_dev
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'This stage is used to access avro files from aws';    

copy into t_ib_permanent_cust_info from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @aws_csv_stage_new (file_format=>csv_format));

select * from t_ib_permanent_cust_info;
    
    SELECT SYSTEM$VALIDATE_STORAGE_INTEGRATION(
    'AWS_INTEGRATION_NEW',
    's3://bktjan202602/stg_csv_files/',
    'snowflake_integration_test.txt',
    'all'
);


update t_ib_permanent_cust_info set company='PEGA' where company='TCS';

select * from t_ib_permanent_cust_info where company='PEGA';

list @aws_json_stage_new;

select * from table(infer_schema(LOCATION => '@aws_json_stage_new' , FILE_FORMAT => 'json_format' , FILES => '1_metadata.json'));
select * from table(infer_schema(LOCATION => '@aws_json_stage_new' , FILE_FORMAT => 'json_format' , FILES => '2_metadata.json'));


list @aws_parquet_stage_new;

select * from table(infer_schema(LOCATION => '@aws_parquet_stage_new' , FILE_FORMAT => 'parquet_format' , FILES => '1_data.parquet'));
select * from table(infer_schema(LOCATION => '@aws_parquet_stage_new' , FILE_FORMAT => 'parquet_format' , FILES => '2_data_after_update.parquet'));


s3://bktmarch202602/stg_json_files/1_metadata.json.json
;

create table t_cust_info_data_1
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@aws_parquet_stage_new' , FILE_FORMAT => 'parquet_format' , FILES => '1_data.parquet'))
);


copy into t_cust_info_data_1 from (select $1:PHONE::NUMBER(10, 0),
$1:EMAIL::TEXT,
$1:LASTNAME::TEXT,
$1:FIRSTNAME::TEXT,
$1:COMPANY::TEXT,
$1:LOCALITY::TEXT,
$1:AREA::TEXT,
$1:PINCODE::TEXT,
$1:CITY::TEXT,
$1:ID::NUMBER(2, 0),
$1:STATECODE::TEXT,
$1:COUNTRY::TEXT,
$1:METADATA$RL_ROW_ID::NUMBER(38, 0),
$1:METADATA$RL_LAST_UPDATED_SEQUENCE_NUMBER::NUMBER(38, 0) from @aws_parquet_stage_new/1_data.parquet (file_format=>parquet_format)
);


select * from t_cust_info_data_1;


truncate table t_cust_info_data_1;


alter table t_cust_info_data_1 add file_name varchar;

copy into t_cust_info_data_1 from (select $1:PHONE::NUMBER(10, 0),
$1:EMAIL::TEXT,
$1:LASTNAME::TEXT,
$1:FIRSTNAME::TEXT,
$1:COMPANY::TEXT,
$1:LOCALITY::TEXT,
$1:AREA::TEXT,
$1:PINCODE::TEXT,
$1:CITY::TEXT,
$1:ID::NUMBER(2, 0),
$1:STATECODE::TEXT,
$1:COUNTRY::TEXT,
$1:METADATA$RL_ROW_ID::NUMBER(38, 0),
$1:METADATA$RL_LAST_UPDATED_SEQUENCE_NUMBER::NUMBER(38, 0),
$1:metadata$file_name
from @aws_parquet_stage_new/2_data_after_update.parquet (file_format=>parquet_format)
);



list @aws_avro_stage_new; -- s3://bktmarch202602/stg_avro_files/1_after_data.avro


select * from table(infer_schema(LOCATION => '@aws_avro_stage_new' , FILE_FORMAT => 'avro_format' , FILES => '1_after_data.avro'));
select * from table(infer_schema(LOCATION => '@aws_avro_stage_new' , FILE_FORMAT => 'avro_format' , FILES => '1_after_data_snap.avro'));

create table t_cust_info_avro_Data_1
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@aws_avro_stage_new' , FILE_FORMAT => 'avro_format' , FILES => '1_after_data.avro'))
);

create table t_cust_info_avro_Data_2
using template(
select array_agg(object_construct(*) )from table(infer_schema(LOCATION => '@aws_avro_stage_new' , FILE_FORMAT => 'avro_format' , FILES => '1_after_data_snap.avro'))
);



copy into t_cust_info_avro_Data_2  from (select $1:manifest_path::TEXT
,$1:manifest_length::NUMBER(38, 0)
,$1:partition_spec_id::NUMBER(38, 0)
,$1:content::NUMBER(38, 0)
,$1:sequence_number::NUMBER(38, 0)
,$1:min_sequence_number::NUMBER(38, 0)
,$1:added_snapshot_id::NUMBER(38, 0)
,$1:added_files_count::NUMBER(38, 0)
,$1:existing_files_count::NUMBER(38, 0)
,$1:deleted_files_count::NUMBER(38, 0)
,$1:added_rows_count::NUMBER(38, 0)
,$1:existing_rows_count::NUMBER(38, 0)
,$1:deleted_rows_count::NUMBER(38, 0)
,$1:partitions::ARRAY
,$1:key_metadata::BINARY
from @aws_avro_stage_new/1_after_data.avro (file_format=>avro_format)
);


copy into t_cust_info_avro_Data_1 from (select $1:status::NUMBER(38, 0),
$1:snapshot_id::NUMBER(38, 0),
$1:sequence_number::NUMBER(38, 0),
$1:file_sequence_number::NUMBER(38, 0),
$1:data_file::VARIANT
from @aws_avro_stage_new/1_after_data_snap.avro (file_format=>avro_format)
);







select * from t_cust_info_avro_Data_1;
select * from t_cust_info_avro_Data_2;




 ;

  create or replace ICEBERG TABLE T_IB_SFM_CUST_INFO (
	ID DECIMAL(10, 0),
	FIRSTNAME STRING,
	LASTNAME STRING,
	EMAIL STRING,
	COMPANY STRING,
	PHONE DECIMAL(10, 0),
	AREA STRING,
	LOCALITY STRING,
	CITY STRING,
	STATECODE STRING,
	PINCODE STRING,
	COUNTRY STRING
)
 EXTERNAL_VOLUME = 'SNOWFLAKE_MANAGED'
 CATALOG = 'SNOWFLAKE';


 select current_region();

---- hybrid tables 
--dynamic tables 
select * from information_schema.tables where is_dynamic='YES';
--Hybdrid tables 
select * from information_schema.tables where is_hybrid='YES';

create hybrid table t_hyb_cust_info
(
	ID DECIMAL(10, 0) primary key ,
	FIRSTNAME STRING,
	LASTNAME STRING,
	EMAIL STRING,
	COMPANY STRING,
	PHONE DECIMAL(10, 0),
	AREA STRING,
	LOCALITY STRING,
	CITY STRING,
	STATECODE STRING,
	PINCODE STRING,
	COUNTRY STRING
);



create table t_customer 
(
	ID DECIMAL(10, 0) ,
	FIRSTNAME STRING,
	LASTNAME STRING,
	EMAIL STRING,
	COMPANY STRING,
	PHONE DECIMAL(10, 0),
	AREA STRING,
	LOCALITY STRING,
	CITY STRING,
	STATECODE STRING,
	PINCODE STRING,
	COUNTRY STRING
);



copy into t_Customer  from (select $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12 from @aws_csv_stage_new (file_format=>csv_format));


select * from t_Customer;

select * from t_Customer limit 2 ;


alter table t_Customer add constraint pk_id primary key (id);

select * from information_schema.table_constraints;

insert into t_Customer values
(1,'Priya','Rao','priya.rao@gmail.com','TCS','2146202474','Hitech City','Kondapur','Hyderabad','MH','730912','India'),
(null,'Kavya','Verma','kavya.verma@gmail.com','Cognizant','5327299222','Gachibowli','Kondapur','Pune','KA','743662','India');

;
select * from information_schema.tables where is_dynamic='YES';



show views;


create table customer
as 
select * from snowflake_sample_data.tpch_sf1.customer;

create table nation
as 
select * from snowflake_sample_data.tpch_sf1.nation;


select * from customer;
select * from nation;

create view v_ind_customers 
as 
select c_custkey,c_name,n_name, c_phone from customer c 
inner join nation n 
on c.c_nationkey=n.n_nationkey
where n_nationkey=8;




show users;


create user ravi 
password='Happybirthday1';

create role manager;

grant role manager to user ravi;

grant usage on database   dev_Db to role MANAGER;
grant usage on schema   dev_Schema to role MANAGER;
grant usage on warehouse   dev_wh to role MANAGER;
grant select on view   v_ind_customers to role MANAGER;

create secure view sv_ind_customers 
as 
select c_custkey,c_name,n_name, c_phone from customer c 
inner join nation n 
on c.c_nationkey=n.n_nationkey
where n_nationkey=8;


grant select on view   sv_ind_customers to role MANAGER;



view ---> no storage cost 

100 --> v_ind_customers --> 
;

2 minutes --> 

;

create dynamic table t_dy_cust_info
target_lag='2 minutes'
warehouse='DEV_WH'
as 
select c_custkey,c_name,n_name, c_phone from customer c 
inner join nation n 
on c.c_nationkey=n.n_nationkey
where n_nationkey=8;


show dynamic tables;

select * from t_dy_cust_info;

select * from table(information_schema.dynamic_table_refresh_history(name=>'t_dy_cust_info'));

delete from nation where n_nationkey=8;
select * from nation where n_nationkey=7;

insert into nation values(8,'INDIA',3,'	l platelets. regular accounts x-ray: unusual, regular acco');

select * from t_dy_cust_info;

select c_custkey,c_name,n_name, c_phone from customer c 
inner join nation n 
on c.c_nationkey=n.n_nationkey
where n_nationkey=8;



--- 
cache  --> types of caches 
QAS 
SOS 
Clustering key 
Prunning 
;

select * from VW_RAW_TEST_EMP;

create or replace  temporary table TEMP_EMP_DATA_RAW
as 
SELECT * FROM VW_RAW_TEST_EMP
WHERE ETL_SOURCE_FILENAME = 'EMP_INFO/EMP_F_20261002_001.csv';


SELECT s.*
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY HASHKEY_PK 
            ORDER BY ETL_SOURCE_LOAD_DATE DESC, ETL_SOURCE_FILENAME DESC
        ) AS rn
    FROM TEMP_EMP_DATA_RAW
) s
WHERE s.rn = 1 AND s.EMP_ID IS NOT NULL;

 
    SELECT  * 
    FROM TEMP_EMP_DATA_RAW
WHERE EMP_ID IS NOT NULL
qualify 
        ROW_NUMBER() OVER (
            PARTITION BY HASHKEY_PK 
            ORDER BY ETL_SOURCE_LOAD_DATE DESC, ETL_SOURCE_FILENAME DESC
            )=1;




show warehouses;
alter warehouse dev_wh set enable_query_Acceleration=false;

USE SCHEMA snowflake_sample_data.tpcds_sf10tcl;


alter session set use_Cached_Result=false;
alter session set use_Cached_Result=true;

alter warehouse dev_wh suspend;

show warehouses;

alter warehouse dev_wh set auto_suspend=120;

--2m.42 sec 
-- 1 sec 
select store.s_store_id, item.i_item_id, sum(ss_sales_price) ss_sales_price
from store_sales
    ,item
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_item_sk = item.i_item_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and store.s_store_name = 'ese'
group by store.s_store_id, item.i_item_id;
;

show warehouses;

show parameters like 'use_cached_result';

alter session set use_cached_result=false;
alter session set use_cached_result=true;




result cache    13th Oct 2026  10AM    24 hours    14th Oct 2026  10AM 

result cache    13th Oct 2026  10AM      1st        --->  remote disk 
                13th Oct 2026  9PM       2nd time   --->  result cache    --> 14th Oct 2026  9PM
                14th Oct 2026  7PM       3rd time   --->  result cache    --> 15th Oct 2026  7PM     

These are results for Snowflake result caching extended up to how many days.
Search instead for snowflake result cache extentend upto how many days?

Snowflake maintains a global result cache that stores the results of every query executed on the platform for up to 24 hours (extendable to 31 days as long as the query keeps being reused)



;


USE SCHEMA snowflake_sample_data.tpcds_sf10tcl;


store_sales
    ,item
    ,time_dim, store

;
use schema dev_Db.dev_schema;

select count(*) from snowflake_sample_data.tpcds_sf10tcl.store_sales;

-- vertical scaling 
create table store_sales
as 
select * from snowflake_sample_data.tpcds_sf10tcl.store_sales;

create table item
as 
select * from snowflake_sample_data.tpcds_sf10tcl.item;

create table time_dim
as 
select * from snowflake_sample_data.tpcds_sf10tcl.time_dim;

create table store
as 
select * from snowflake_sample_data.tpcds_sf10tcl.store;

show parameters like 'use_cached_result';

use schema dev_db.dev_Schema;

alter session set use_cached_result=false;

select store.s_store_id, item.i_item_id, sum(ss_sales_price) ss_sales_price
from store_sales
    ,item
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_item_sk = item.i_item_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and store.s_store_name = 'ese'
group by store.s_store_id, item.i_item_id;
;


delete from store where s_store_id='AAAAAAAAEKFAAAAA';

select * from store where s_store_id in ('AAAAAAAAGNAAAAAA',
'AAAAAAAAKCCAAAAA',
'AAAAAAAAEMDAAAAA',
'AAAAAAAAIHEAAAAA',
'AAAAAAAAMNEAAAAA',
'AAAAAAAACODAAAAA',
'AAAAAAAAOEBAAAAA',
'AAAAAAAAGJEAAAAA');

alter warehouse qa_wh suspend;

select * from store where s_store_id in ('AAAAAAAAGNAAAAAA');


-- metadata cache 

select count(*) from store;


select * from information_schema.tables where table_type='BASE TABLE';




show parameters like 'use_cached_result';

use schema dev_db.dev_Schema;

alter session set use_cached_result=false;

select store.s_store_id, item.i_item_id, sum(ss_sales_price) ss_sales_price
from store_sales
    ,item
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_item_sk = item.i_item_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and store.s_store_name = 'ese'
group by store.s_store_id, item.i_item_id;
;


delete from store where s_store_id='AAAAAAAAEKFAAAAA';

select * from store where s_store_id in ('AAAAAAAAGNAAAAAA',
'AAAAAAAAKCCAAAAA',
'AAAAAAAAEMDAAAAA',
'AAAAAAAAIHEAAAAA',
'AAAAAAAAMNEAAAAA',
'AAAAAAAACODAAAAA',
'AAAAAAAAOEBAAAAA',
'AAAAAAAAGJEAAAAA');

alter warehouse qa_wh suspend;

select * from store where s_store_id in ('AAAAAAAAGNAAAAAA');


-- metadata cache 

select count(*) from store;


select * from information_schema.tables where table_type='BASE TABLE';

--

show warehouses;

alter warehouse dev_wh resume;


enable_query_acceleration =true
query_acceleration_max_scale_Factor=8

---  QAS
;

alter session set use_cached_Result=false;
alter warehouse dev_wh suspend;


select store.s_store_id, item.i_item_id, sum(ss_sales_price) ss_sales_price
from store_sales
    ,item
    ,time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_item_sk = item.i_item_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and store.s_store_name = 'ese'
group by store.s_store_id, item.i_item_id;
;

select system$estimate_query_acceleration('01c7c232-3203-9ec6-0018-769e0022151e');
select parse_json(system$estimate_query_acceleration('01c7c232-3203-9ec6-0018-769e0022151e'));


alter warehouse dev_wh set enable_query_acceleration =true;
alter warehouse dev_wh set query_acceleration_max_scale_Factor=11;

show warehouses like 'dev_Wh';

create warehouse prod_wh;

show warehouses like 'prod_wh';

show warehouses;

select * from emp;


select parse_json(system$estimate_query_acceleration('01c7c240-3203-9f86-0018-769e0023007e'));


select count(*) from store_sales; -- 28800239865  -- 28800 M    ---> partitions 38621

select 28800239865/1000000;

select * from store_sales limit 100;


parition prunning --> 100 --> 98

;
select * from store_sales where ss_addr_sk='2452125'; -- Partitions scanned   8739

alter warehouse dev_wh suspend;

select count(*) , ss_addr_sk from store_sales group by ss_addr_sk;
-- Invalid clustering keys or table STORE_SALES is not clustered
select system$clustering_information('store_sales','ss_addr_sk');

alter table store_sales cluster by (ss_addr_sk);

Partitions scanned   7138     8739
Partitions total    38621    38621
;

--SOS 












https://github.com/krishnaspark2005-ctrl/dbrepository/


emp.csv
--------------
id,fname,lname,sal,location
1,krishna,bala,20000,Hyderabd


id,name
1,bala_krishna


select current_Date()
select dateadd
select datediff


PI   --> Personal information 
PHI  --> 

                    admission_Date  discharge_Date
1,ravi,urology,UR01,2026-01-01,     2026-01-15
1,ravi,urology,UR01,2026-01-15,     2026-01-01



skey,id,fname,lname,sal,location,is_current,start_DAte,end_Date
10,1,krishna,bala,20000,Delhi,Y,2026-02-01,null
11,1,krishna,bala,20000,Hyderabd,N,2025-01-01,2026-01-31

select id,fname||'_'||lname from t_emp; ---> model 
functions    ----> macros  
csv-->table  ----> seed 
implement scd type 2 --> snapshot 
it will have queries which will help to understand the business needs --> Analysis 
constraints -->  Tests 
materializations --> Type of object that you are trying to create in the silver layer 
dbt Docs --> existing dbt objects 
Running Models -->  it create either table , view , table with scd type 2 logic 
dbt Build --> tests+models 


Snowflake :- 
-----------------
snowsight  --> UI 
snowsql    --> CLI 

DBT :- 
-----------------
dbtcloud   --> UI  --> licenced
dbtcore    --> CLI --> Free  

https://getdbt.com/


 repository  --->
 
 oracle 
 python 
 informatica  ------------> common place --> repository 
 snowflake 
 dbt 
 

Storage Integration
---------------------------
snowflake                             AWS 
----------------------------------------------------------
storage_allowed_locations            iam_user_arn
iam_role_Arn                         external_id 

dbt                                                         github 
-------------------------------------------------------------------------------
git@github.com:krishnaspark2005-ctrl/dbrepository.git      ssh



MAIN   -->  DBT_7AM 

Ravi    --> developer 
Krishna --> Architech 



model_name --> emp_info
select id,concat(first_name,'_',last_name) as ename from DEV_DB.BRONZE.EMPLOYEE

dbt run
dbt run --select emp_info.sql



create or replace   view dev_Db.silver.emp_info
  as (
    select id,concat(first_name,'_',last_name) as ename from DEV_DB.BRONZE.EMPLOYEE
  );




dbt seed 
dbt seed --select claims.csv









create file format my_csv_format 
type=csv 
field_delimiter=','
skip_header=1;

create or replace table orders ( order_id number,customer_id number,order_Date date ,status varchar);
;

copy into orders (order_id,customer_id,order_Date,status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv' file_format=(format_name=my_csv_format);

create or replace table customers ( customer_id number,first_name varchar,last_name varchar);

copy into customers (customer_id,first_name,last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv' file_format=(format_name=my_csv_format);


create table payment ( id number,orderid number,paymentmethod varchar,
status varchar,amount number,created date,_batched_at timestamp default current_timestamp);

copy into payment (id,orderid,paymentmethod,status,amount,created)
from 's3://dbt-tutorial-public/stripe_payments.csv' file_format=(format_name=my_csv_format);

-- CTE 
--Common Table Expression 

with customers as (
select
customer_id as customer_id,
first_name,
last_name
from marketing_db.marketing_schema.customers
),
orders as (
select
order_id as order_id,
customer_id as customer_id,
order_date,
status
from marketing_db.marketing_schema.orders
),
customer_orders as (
select
customer_id,
min(order_date) as first_order_date,
max(order_date) as most_recent_order_date,
count(*) as number_of_orders
from marketing_db.marketing_schema.orders
group by 1
),
final as (
select
customers.customer_id,
customers.first_name,
customers.last_name,
customer_orders.first_order_date, customer_orders.most_recent_order_date,
coalesce (customer_orders.number_of_orders, 0) as number_of_orders
from customers
left join customer_orders on customers.customer_id=customer_orders.customer_id
)
select * from final;

;


---21st Oct 

select * from bronze.employee;

select * from silver.int_claims_enriched;
select * from silver.int_member_claim_summary;



drop table customers;
drop table orders;
drop table payment;

create file format my_csv_format 
type=csv 
field_delimiter=','
skip_header=1;

create or replace table customers ( customer_id number,first_name varchar,last_name varchar);

create or replace table orders ( order_id number,customer_id number,order_Date date ,status varchar);
;

create table payment ( id number,orderid number,paymentmethod varchar,
status varchar,amount number,created date,_batched_at timestamp default current_timestamp);


copy into orders (order_id,customer_id,order_Date,status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv' file_format=(format_name=my_csv_format);

copy into customers (customer_id,first_name,last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv' file_format=(format_name=my_csv_format);

copy into payment (id,orderid,paymentmethod,status,amount,created)
from 's3://dbt-tutorial-public/stripe_payments.csv' file_format=(format_name=my_csv_format);


select * from customers;

update customers set first_name='Praful'  where customer_id=1;
update customers set first_name='Krishna'  where customer_id=54;

select * from customers where customer_id=54;

select * from orders  where customer_id=54;

select * from payment where orderid in (6,19,52,54,83);


select * from payment ;


select * from orders order by customer_id;




with customers as (
select
customer_id as customer_id,
first_name,
last_name
from dev_Db.bronze.customers
),
orders as (
select
order_id as order_id,
customer_id as customer_id,
order_date,
status
from dev_Db.bronze.orders
),
customer_orders as (
select
customer_id,
min(order_date) as first_order_date,
max(order_date) as most_recent_order_date,
count(*) as number_of_orders
from dev_Db.bronze.orders
group by 1
),
final as (
select
customers.customer_id,
customers.first_name,
customers.last_name,
customer_orders.first_order_date, customer_orders.most_recent_order_date,
coalesce (customer_orders.number_of_orders, 0) as number_of_orders
from customers
left join customer_orders on customers.customer_id=customer_orders.customer_id
)
select * from final
where customer_id=54;

;


select * from silver.cust_order_info;


---- 
create schema cust_Schema;


create file format my_csv_format 
type=csv 
field_delimiter=','
skip_header=1;

create or replace table customers ( customer_id number,first_name varchar,last_name varchar);

create or replace table orders ( order_id number,customer_id number,order_Date date ,status varchar);
;

create table payment ( id number,orderid number,paymentmethod varchar,
status varchar,amount number,created date,_batched_at timestamp default current_timestamp);


copy into orders (order_id,customer_id,order_Date,status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv' file_format=(format_name=my_csv_format);

copy into customers (customer_id,first_name,last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv' file_format=(format_name=my_csv_format);

copy into payment (id,orderid,paymentmethod,status,amount,created)
from 's3://dbt-tutorial-public/stripe_payments.csv' file_format=(format_name=my_csv_format);



drop schema cust_schema;


select * from silver.fct_claims;

select * from table(information_schema.query_history());

--22 

select * from payment;




create table customer_info 
as 
select * from snowflake_sample_data.tpch_sf1.customer;


select * from customer_info;
select distinct c_mktsegment from customer_info;


select c_custkey,c_name,c_phone,
case when c_mktsegment='MACHINERY' then 'Industrial'
     when c_mktsegment='BUILDING' then 'Construnction'
     when c_mktsegment='AUTOMOBILE' then 'Automotive'     
     when c_mktsegment='HOUSEHOLD' then 'Consumer Goods' 
     when c_mktsegment='FURNITURE' then 'Home Furnishing' 
     else 'other' end c_mktsegment 
from customer_info;

MACHINERY
HOUSEHOLD
BUILDING
AUTOMOBILE
FURNITURE

;


select * from silver.fct_claims_with_macros;

select * from silver.fct_claims_monthly;

---------------------------------------------------------------



--  Run in DB 
--step1 
create or replace table s_emp (
empno number,
ename varchar,
deptno number,
sal number,
d_upd_Date timestamp
);

insert into s_emp values(7782,'Arun',10,2000,current_date()-2);
insert into s_emp values(7369,'Krishna',20,3000,current_date()-2);

select * from s_emp;

--step2
create or replace  table incr_changes 
as select * from s_emp where 1=2;

select * from incr_changes;

-- full load 
insert into incr_changes
select * from s_emp;

--spep3 

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--step4 

update s_emp set sal=35000 ,d_upd_Date=current_date()-1 where empno=7782;

insert into s_emp values(7777,'Ramu',10,2000,current_date()-1);

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--stpe5 
create or replace temp view t_changes 
as 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

select * from t_changes;

select * from s_emp;
select * from incr_changes;

--step6 
merge into incr_changes t 
using t_changes s   ------------ s_emp 5 M 
on (t.empno=s.empno)
when not matched then 
insert(empno,ename,deptno,sal,d_upd_date) values(empno,ename,deptno,sal,d_upd_date)
when matched then 
update set t.sal=s.sal,t.d_upd_date=s.d_upd_date;

--step7 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--step8
update s_emp set sal=50000 ,d_upd_Date=current_date() where empno=7782;

insert into s_emp values(8888,'Sirisha',10,2000,current_date());
 

create or replace temp view t_changes 
as 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

-- step9
select * from t_changes;
--step10
merge into incr_changes t 
using t_changes s 
on (t.empno=s.empno)
when not matched then 
insert(empno,ename,deptno,sal,d_upd_date) values(empno,ename,deptno,sal,d_upd_date)
when matched then 
update set t.sal=s.sal,t.d_upd_date=s.d_upd_date;


-- step11
select * from t_changes;

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);



select * from dbt_schema.incr_changes;

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from dbt_Schema.incr_changes);



drop table silver.incr_changes;


--  Run in DB 
--step1 
create or replace table s_emp (
empno number,
ename varchar,
deptno number,
sal number,
d_upd_Date timestamp
);


alter table s_emp add mobile number;

alter table s_emp drop column ename;

insert into s_emp values(7782,'Arun',10,2000,current_date()-2);
insert into s_emp values(7369,'Krishna',20,3000,current_date()-2);

select * from s_emp;

--step2
create or replace  table incr_changes 
as select * from s_emp where 1=2;

select * from incr_changes;

-- full load 
insert into incr_changes
select * from s_emp;

--spep3 

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--step4 

update s_emp set sal=35000 ,d_upd_Date=current_date()-1 where empno=7782;

insert into s_emp values(7777,'Ramu',10,2000,current_date()-1);

select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--stpe5 
create or replace temp view t_changes 
as 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

select * from t_changes;

select * from s_emp;
select * from silver.incr_changes;

--step6 
merge into incr_changes t 
using t_changes s   ------------ s_emp 5 M 
on (t.empno=s.empno)
when not matched then 
insert(empno,ename,deptno,sal,d_upd_date) values(empno,ename,deptno,sal,d_upd_date)
when matched then 
update set t.sal=s.sal,t.d_upd_date=s.d_upd_date;

--step7 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

--step8
update s_emp set sal=50000 ,d_upd_Date=current_date() where empno=7782;

insert into s_emp values(8888,'Sirisha',10,2000,current_date());
insert into s_emp values(8800,'Soumitha',10,2000,current_date());
insert into s_emp values(8801,'Lavanya',10,2000,current_date());


insert into s_emp values(7678,10,2000,current_date(),9898989898);
 

create or replace temp view t_changes 
as 
select * from s_emp where d_upd_Date>( select max(d_upd_Date) from incr_changes);

-- step9
select * from t_changes;
--step10
merge into incr_changes t 
using t_changes s 
on (t.empno=s.empno)
when not matched then 
insert(empno,ename,deptno,sal,d_upd_date) values(empno,ename,deptno,sal,d_upd_date)
when matched then 
update set t.sal=s.sal,t.d_upd_date=s.d_upd_date;
 


select * from silver.fct_claims_incremental where claim_id='CLM001'; -- PAID   -- pending


select * from silver.int_claims_enriched; --> stg_claims,stg_memebers,stg_providers,stg_plans

select * from silver.stg_claims; -- raw_claims
select * from silver.raw_claims where claim_id='CLM001';


select  max(service_date)  from dev_Db.silver.int_claims_enriched; -- 2024-05-10
select max(service_date) from dev_Db.silver.fct_claims_incremental; -- 2024-05-10


select * from bronze.customers;
select * from bronze.customers where customer_id=1;
select * from bronze.customers where customer_id is null;

insert into bronze.customers values(1,'Krishna','K');
insert into bronze.customers values(null,'Ravi','K');


select * from silver.t_cust_info where customer_id=1;
select * from silver.t_cust_info where customer_id is null;