### Query the database - explore each table

use pricehub ;


# Section 1

select * from line_item ;

select * from line_item limit 10 ;

select sku, unit_price, "date" from line_item limit 10 ;

select count(*) from line_item;

select count(distinct sku) from line_item ;

select sku, avg(unit_price) from line_item group by sku;

select sku, avg(unit_price) as avg_price 
from line_item 
group by sku order by avg_price ;

select sku, product_quantity 
from line_item 
group by sku, product_quantity order by product_quantity ;

select sku, max(product_quantity) as max_qu 
from line_item group by sku order by max_qu desc  
limit 100 ;

select sku, id, max(product_quantity) as max_qu 
from line_item group by sku, id order by max_qu desc  
limit 100 ;


# Section 2

select * from orders limit 50;

select count(id_order) from orders;

select state, count(id_order) from orders group by state;

select id_order, created_date from orders where created_date like "2017-01-%" ;

select count(*) from orders where created_date like "2017-01-%" ;

select count(id_order) from orders 
where created_date like "2017-01-04%" and state = "cancelled";

select count(id_order), extract(month from created_date) as monthly 
from orders group by monthly ;

select sum(total_paid) from orders;

select id_order, avg(total_paid) from orders group by id_order;

select id_order, truncate(avg(total_paid) , 2) as avg_paid 
from orders group by id_order ;

select id_order, created_date from orders order by created_date desc;

select id_order, created_date from orders order by created_date asc;

select state, created_date, count(id_order) as counts 
from orders group by created_date, state having state = "completed" 
order by counts desc;

select created_date, max(total_paid) 
from orders group by created_date 
order by max(total_paid) desc;


# Section 3

select * from products limit 100 ;

select count(distinct ProductID) from products ;

select count(distinct brand) from products ;

select count(distinct manual_categories) from products ;

select brand, count(distinct ProductID) as number_of_products 
from products group by brand ;

select manual_categories, count(distinct ProductID) as number_of_products 
from products group by manual_categories ;

select brand, avg(price) as avg_price from products group by brand;

select manual_categories, avg(price) as avg_price 
from products group by manual_categories;

select name_en, short_desc_en, products.manual_categories, price
from (select manual_categories, max(price) as most_expensive 
from products group by manual_categories) as store
inner join products 
on products.price = store.most_expensive
order by store.most_expensive desc;

select name_en, short_desc_en, products.brand, price
from (select brand, max(price) as most_expensive from products group by brand) as store
inner join products 
on products.price = store.most_expensive
order by store.most_expensive desc;


### Query the database - join tables

#Query 1
select products.sku, product_quantity, price, unit_price, date, name_en 
from line_item inner join products
on line_item.sku = products.sku
limit 10 ;

#Query 2
select products.sku, product_quantity, price, unit_price, date, name_en,
(price-unit_price) as price_difference
from line_item inner join products
on line_item.sku = products.sku
order by price_difference desc
limit 10 ;

#Query 3
select manual_categories,
round(avg(price-unit_price)) as price_difference
from line_item inner join products
on line_item.sku = products.sku
group by manual_categories
limit 10 ;

#Query 4
select brand,
round(avg(price-unit_price)) as price_difference
from line_item inner join products
on line_item.sku = products.sku
group by brand
limit 10 ;

#Query 5
select brand,
truncate(avg((price-unit_price)), 2) as avg_price_dif
from line_item inner join products
on line_item.sku = products.sku
group by brand having avg_price_dif > 50000
order by avg_price_dif desc
limit 10 ;

#Query 6
select products.sku, unit_price, state
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
limit 10 ;

#Query 7 - with brand and category
select products.sku, brand, manual_categories 
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
limit 10 ;

#Query 8 - grouped by brand
select brand, count(orders.id_order) as number_of_orders, state
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
group by brand, state having state = "cancelled"
order by number_of_orders desc
limit 10 ;

#Query 8 - grouped by category
select manual_categories, count(orders.id_order) as number_of_orders, state
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
group by manual_categories, state having state = "cancelled"
order by number_of_orders desc
limit 10 ;