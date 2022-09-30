select * from shark_tank_project..sheet1

-- total episode
select count(distinct ep_no) total_ep from shark_tank_project..sheet1
select max(ep_no) total_ep from shark_tank_project..sheet1


-- pitches
select count(distinct brand) total_brand from shark_tank_project..sheet1


-- no. of pitches converted
select sum(a.converted_nonconverted) convetred_pitches, count(*) total_pitches from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_nonconverted from shark_tank_project..sheet1)a


-- conversion ratio
select cast((b.converted_pitches) as float)/cast((b.total_pitches) as float) conversion_ratio from(
select sum(a.converted_nonconverted) converted_pitches, count(*) total_pitches from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_nonconverted from shark_tank_project..sheet1)a)b


-- total male
select sum(male) total_male from shark_tank_project..sheet1

-- total female
select sum(female) total_female from shark_tank_project..sheet1

-- gender ratio
select sum(female)/sum(male) gender_ratio from shark_tank_project..sheet1

-- total amount invested
select sum(amount_invested_lakhs) total_amount_invested from shark_tank_project..sheet1

-- avg equity taken by sharks
select avg(a.Equity_Taken_per) avg_equity_taken from(
select * from shark_tank_project..sheet1 where Equity_Taken_per>0)a


-- highest deal taken
select max(amount_invested_lakhs) highest_deal from shark_tank_project..sheet1

-- highest equity taken by the shark
select max(equity_taken_per) highest_equity_taken from shark_tank_project..sheet1

-- pitches that has atleast one women
select count(a.female) pitches_with_atleast_1_women from(
select female from shark_tank_project..sheet1 where female>0)a


-- pitches converted that has atleast one women
select count(a.amount_invested_lakhs) pitches_converted_with_atleast_1_women from (
select female, amount_invested_lakhs from shark_tank_project..sheet1 where female>0)a
where a.amount_invested_lakhs>0


-- avg teammember number
select * from shark_tank_project..sheet1
select round(avg(team_members),0) avg_team_members from shark_tank_project..sheet1


-- avg ammount invested per deal
select avg(a.amount_invested_lakhs) avg_ammount_invested_per_deal_lakhs from (
select amount_invested_lakhs from shark_tank_project..sheet1 where amount_invested_lakhs>0)a


-- highest avg age of participants
select avg_age, count(avg_age) count_age from shark_tank_project..sheet1 group by avg_age order by count_age desc


-- location from where most no. of. contestant came
select location, count(location) count_loc from shark_tank_project..sheet1 group by location order by count_loc desc


-- sector from which most no. of. deal came
select sector, count(sector) count_sec from shark_tank_project..sheet1 group by sector order by count_sec desc


-- partner deals
select partners, count(partners) count_pa from shark_tank_project..sheet1 where partners!='-' group by partners order by count_pa desc



-- making the matrix
-- total deals
select 'ashneer' as keyy, count(ashneer_amount_invested) total_deals_present from shark_tank_project..sheet1 where ashneer_amount_invested is not null and ashneer_amount_invested>0

-- total amount invested by ashneer
select 'ashneer' as keyy, sum(ashneer_amount_invested) total_deals from shark_tank_project..sheet1 where ashneer_amount_invested is not null and ashneer_amount_invested>0

-- avg equity taken by ashneer
select 'ashneer' as keyy, avg(Ashneer_Equity_Taken_per) from shark_tank_project..sheet1 where Ashneer_Equity_Taken_per is not null and Ashneer_Equity_Taken_per>0



-- joining all the column    #(1st join two table then join it with 3rd)
select m.keyy, m.total_deals_present, m.total_deals, n.average_equity_taken from 
(select a.keyy, a.total_deals_present, b.total_deals from(
select 'ashneer' as keyy, count(ashneer_amount_invested) total_deals_present from shark_tank_project..sheet1 
where ashneer_amount_invested is not null and ashneer_amount_invested>0)a
inner join(

select 'ashneer' as keyy, sum(ashneer_amount_invested) total_deals from shark_tank_project..sheet1 
where ashneer_amount_invested is not null and ashneer_amount_invested>0)b
on a.keyy=b.keyy)m
inner join(

select 'ashneer' as keyy, avg(Ashneer_Equity_Taken_per) average_equity_taken from shark_tank_project..sheet1 
where Ashneer_Equity_Taken_per is not null and Ashneer_Equity_Taken_per>0)n
on m.keyy=n.keyy



-- which startup got the highest amount in each sector
select * from shark_tank_project..sheet1

select a.* from(
select brand, sector, amount_invested_lakhs, rank() over (partition by sector order by amount_invested_lakhs desc) rnk
from shark_tank_project..sheet1) a
where a.rnk=1