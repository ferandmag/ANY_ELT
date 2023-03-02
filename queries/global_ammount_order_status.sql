-- This query will return a table with two columns; order_status, and
-- Ammount. The first one will have the different order status classes and the
-- second one the total ammount of each.
select 	oo.order_status,
		count(oo.order_status) as Ammount
from olist_orders as oo
where oo.order_status not null
group by oo.order_status;