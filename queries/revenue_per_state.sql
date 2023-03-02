-- This query will return a table with two columns; customer_state, and
-- Revenue. The first one will have the letters that identify the top 10 states
-- with most revenue and the second one the total revenue of each.
select 	oc.customer_state,
		sum(oop.payment_value) as Revenue
from olist_orders as oo
inner join olist_customers as oc
	on oo.customer_id = oc.customer_id
inner join olist_order_payments as oop
	on oo.order_id = oop.order_id
where	oo.customer_id not null
		and oo.order_delivered_customer_date not null
		and oo.order_status = 'delivered'
group by customer_state
order by Revenue desc
limit 10;