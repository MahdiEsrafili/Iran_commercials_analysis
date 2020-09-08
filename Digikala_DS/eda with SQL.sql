-- execute shortcut: ctrl+Enter
select * from patent.digikala8 limit 5;

SELECT * FROM patent.digikala8 where Amount_Gross_Order between 100000 and 200000;

select avg(Amount_Gross_Order) average from patent.digikala8;

select city_name_fa,count(ID_Order) order_counts, sum(Amount_Gross_Order) amount_sum from patent.digikala8 group by city_name_fa order by order_counts desc;

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
select city_customer.city_name_fa, city_customer.ID_Customer, max(city_customer.customer_order_count) order_counts
 from (select city_name_fa, ID_Customer, count(ID_Customer) customer_order_count
 		from patent.digikala8
 		group by ID_Customer)city_customer 
 group by city_customer.city_name_fa
 order by city_customer.city_name_fa;
 
 select count(distinct city_name_fa) from patent.digikala8; 