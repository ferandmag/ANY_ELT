-- This query will return a table with two columns; State, and
-- Delivery_Difference. The first one will have the letters that identify the
-- states, and the second one the average difference between the estimate
-- delivery date and the date when the items were actually delivered to the
-- customer.
select  oc.customer_state as State,
		cast((avg(julianday(strftime('%Y-%m-%d', oo.order_estimated_delivery_date))
				-
				julianday(strftime('%Y-%m-%d', oo.order_delivered_customer_date))))
			as int) as Delivery_Difference
from olist_orders as oo
inner join olist_customers as oc
	on oo.customer_id = oc.customer_id
where	oo.order_status not null
		and oc.customer_id not null
		and oo.order_status = 'delivered'
group by State
order by Delivery_Difference asc;