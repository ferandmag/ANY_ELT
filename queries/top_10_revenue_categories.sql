-- This query will return a table with the top 10 revenue categories in
-- English, the number of orders and their total revenue. The first column will
-- be Category, that will contain the top 10 revenue categories; the second one
-- will be Num_order, with the total amount of orders of each category; and the
-- last one will be Revenue, with the total revenue of each catgory. OK but 1 less in health_beauty
select 	pcnt.product_category_name_english as Category,
		count(distinct oo.order_id) as Num_order,
		sum(oop.payment_value) as Revenue
from olist_orders as oo
left join olist_order_items as ooi
	on oo.order_id = ooi.order_id
left join olist_products as op
	on ooi.product_id = op.product_id
left join olist_order_payments as oop
	on oo.order_id = oop.order_id
left join product_category_name_translation as pcnt
	on op.product_category_name = pcnt.product_category_name
where 	oo.order_status = 'delivered'
		and oo.order_id not null
		and ooi.product_id not null
		and oo.order_delivered_customer_date not null
group by op.product_category_name
order by Revenue desc
limit 10;