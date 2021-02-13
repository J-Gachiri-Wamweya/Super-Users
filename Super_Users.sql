-- SUPER USERS

-- A company defines its super users as those who have made at least two transactions. 
-- From the following table, write a query to return, for each user, the date when they become a super user, 
-- ordered by oldest super users first. Users who are not super users should also be present in the table

create database if not exists practicedb;
use practicedb;

create table if not exists users_t(
user_id integer not null,
product_id integer not null,
transaction_date date
);
/*
insert into users_t (user_id, product_id, transaction_date) 
VALUES 
(1, 101, CAST('20-2-12' AS date)), 
(2, 105, CAST('20-2-13' AS date)), 
(1, 111, CAST('20-2-14' AS date)), 
(3, 121, CAST('20-2-15' AS date)), 
(1, 101, CAST('20-2-16' AS date)), 
(2, 105, CAST('20-2-17' AS date)),
(4, 101, CAST('20-2-16' AS date)), 
(3, 105, CAST('20-2-15' AS date));
*/
with t1 as ( select * , row_number() over ( partition by user_id order by transaction_date) num 
from users_t
),
t2 as (select distinct user_id 
from users_t
), 
t3 as (select user_id, transaction_date 
from t1 
where num = 2
)
select t2.user_id, t3.transaction_date as super_user_date 
from t2 
left join t3 
on t2.user_id=t3.user_id 
order by super_user_date;
