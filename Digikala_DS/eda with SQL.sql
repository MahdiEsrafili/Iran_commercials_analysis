-- execute shortcut: ctrl+Enter
select * from patent.digikala8 limit 5;

SELECT * FROM patent.digikala8 where Amount_Gross_Order between 100000 and 200000;

select avg(Amount_Gross_Order) average from patent.digikala8;

select
 city_name_fa,count(ID_Order) order_counts, sum(Amount_Gross_Order) amount_sum
 from
	patent.digikala8
	group by
		city_name_fa
	order by
	order_counts desc;

select ID_Item, count(ID_Order) order_count from patent.digikala8 group by ID_Item order by order_count desc;

-- which item is most selled in each city
select city_item.city_name_fa, city_item.ID_Item, max(city_item.item_count) sold_count
 from
	(select city_name_fa, ID_Item, count(ID_Item) item_count
		from
			patent.digikala8 group by city_name_fa, ID_Item)city_item group by city_item.city_name_fa order by city_item.city_name_fa ;

select city_name_fa, ID_Item, count(ID_Item) item_count from patent.digikala8 group by city_name_fa, ID_Item order by city_name_fa, item_count desc;

select ID_Customer, city_name_fa, count(ID_Order) from patent.digikala8 group by ID_Customer;

-- who is the most buyer in each city
select 
city_customer.city_name_fa, city_customer.ID_Customer, max(city_customer.customer_order_count) order_counts
 from (select city_name_fa, ID_Customer, count(ID_Customer) customer_order_count
 		from patent.digikala8
 		group by ID_Customer)city_customer 
 group by city_customer.city_name_fa
 order by city_customer.city_name_fa;
 
 
 select count(distinct city_name_fa) from patent.digikala8; 
 
 select count(*) from patent.digikala8;
 
 select max(Amount_Gross_Order) from digikala8;
 
 -- create min, max, avg of amount gross for each city
 select city_name_fa, min(Amount_Gross_Order), round(avg(Amount_Gross_Order),2), max(Amount_Gross_Order)
 from
 digikala8
 group by
 city_name_fa
 order by city_name_fa;
 
 select concat(ID_Item,'-', Quantity_item) from digikala8;
 
 select substring("hello there" from 4) str;
select round(2.1284,2);

create view max_order_per_ctmax_order_per_ct as
  select city_name_fa, ID_Customer, max(Amount_Gross_Order) max_amount 
  from
  digikala8
  group by 
  city_name_fa
  order by
  max_amount desc;

-- how many from each item each city bought
create view city_item as 
select 
city_name_fa, ID_Item, count(ID_Item) item_count 
from
 digikala8
 group by
 city_name_fa, ID_Item
 order by
 city_name_fa, item_count desc;

select * from city_item order by city_item.item_count desc limit 10  ;

-- share of each order in city
select 
	*, d1.Amount_Gross_Order/d1.total_gross_city 
    from 
		(select
			city_name_fa, ID_Order, Amount_Gross_Order,
            sum(Amount_Gross_Order)  over (partition by city_name_fa) total_gross_city
            from digikala8)d1; 
 
 --   compare amount gross of order due to total amount gross of a city
select
	city_name_fa, ID_Order, Amount_Gross_Order,
	first_value(Amount_Gross_Order)  over (partition by city_name_fa order by Amount_Gross_Order desc) total_gross_city
	from digikala8;

-- create rank for each order in city 
select
	city_name_fa, ID_Order, Amount_Gross_Order,
    rank() over (partition by city_name_fa order by Amount_Gross_Order) rank_of_order_amount
    from digikala8;

-- create laged difference of amount gross of orders in each city     
select *, (d1.Amount_Gross_Order - d1.laged_amount) diff
 from 
	(select 
		city_name_fa, ID_Order, Amount_Gross_Order,
		lag(Amount_Gross_Order, 1) over (partition by city_name_fa order by Amount_Gross_Order desc) laged_amount
		from digikala8) d1;
        
--  create histogram of amount gross
select *, ntile(10) over (partition by city_name_fa order by Amount_Gross_Order desc) hist_number
 from digikala8 where city_name_fa='تهران';