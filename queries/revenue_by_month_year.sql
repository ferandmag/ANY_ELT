-- This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
select 	strftime('%m', aux.order_delivered_customer_date) as month_no,
		(case strftime('%m', aux.order_delivered_customer_date) 
			when '01' then 'Jan'
			when '02' then 'Feb'
			when '03' then 'Mar'
			when '04' then 'Apr'
			when '05' then 'May'
			when '06' then 'Jun'
			when '07' then 'Jul'
			when '08' then 'Aug'
			when '09' then 'Sep'
			when '10' then 'Oct'
			when '11' then 'Nov'
			when '12' then 'Dec'
			end) as month,
		sum(case strftime('%Y', aux.order_delivered_customer_date) when '2016'
				then (aux.payment_value) else 0.00 end) as Year2016,
		sum(case strftime('%Y', aux.order_delivered_customer_date) when '2017'
				then (aux.payment_value) else 0.00 end) as Year2017,
		sum(case strftime('%Y', aux.order_delivered_customer_date) when '2018'
				then (aux.payment_value) else 0.00 end) as Year2018
from	(select 	oo.order_id,
					oo.order_delivered_customer_date,
					oop.payment_value
		from olist_orders as oo
		inner join olist_order_payments as oop
			on oo.order_id = oop.order_id
		where 	oo.order_status = 'delivered'
				and oo.order_delivered_customer_date not null
				and oop.payment_value not null
		group by 1) as aux -- grupy by a number is used to drop duplicates records
group by month_no;