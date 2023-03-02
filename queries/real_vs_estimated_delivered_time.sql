-- This query will return a table with the differences between the real
-- and estimated delivery times by month and year. It will have different
-- columns: month_no, with the month numbers going from 01 to 12; month, with
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with
-- the average delivery time per month of 2016 (NaN if it doesn't exist);
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if
-- it doesn't exist); Year2018_real_time, with the average delivery time per
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist);
-- Year2017_estimated_time, with the average estimated delivery time per month
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).
select 	strftime('%m', oo.order_purchase_timestamp) as month_no,
		(case strftime('%m', oo.order_purchase_timestamp)
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
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2016'
				then (julianday(strftime(oo.order_delivered_customer_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2016_real_time,
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2017'
				then (julianday(strftime(oo.order_delivered_customer_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2017_real_time,
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2018'
				then (julianday(strftime(oo.order_delivered_customer_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2018_real_time,
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2016'
				then (julianday(strftime(oo.order_estimated_delivery_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2016_estimated_time,
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2017'
				then (julianday(strftime(oo.order_estimated_delivery_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2017_estimated_time,
		avg(case strftime('%Y', oo.order_purchase_timestamp) when '2018'
				then (julianday(strftime(oo.order_estimated_delivery_date)) - julianday(strftime(oo.order_purchase_timestamp))) end) as Year2018_estimated_time
from olist_orders as oo
where 	oo.order_status = 'delivered'
		and oo.order_purchase_timestamp not null
		and oo.order_delivered_customer_date not null
		and oo.order_estimated_delivery_date not null
group by month_no;