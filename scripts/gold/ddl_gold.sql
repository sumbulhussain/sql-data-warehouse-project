=========================
----------GOLDEN LAYER : CUSTOMER
=========================
select cst_id, count(*) from
(select 
ci.cst_id,
ci.cst_key,
ci.cst_firstname,
ci.cst_lastname,
ci.cst_material_status,
ci.cst_gndr,
ci.cst_create_date,
ca.bdate,
ca.gen,
la.cntry
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid
)
t group by cst_id having count(*) > 1

-----data integration
select 
ci.cst_gndr,
ca.gen,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
else coalesce(ca.gen, 'n/a')
end as new_gen
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on    ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on    ci.cst_key = la.cid
order by 1, 2


----create view
create view gold.dim_customers as 
---cleaned data: colmuns name
select 
-----surrogate key - system generated unique 
row_number() over (order by cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_name,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
la.cntry as country,
ci.cst_material_status as marital_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
else coalesce(ca.gen, 'n/a')
end as gender,
ca.bdate as birth_date,
ci.cst_create_date as create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid

select *from gold.dim_customers

=========================
----------GOLDEN LAYER : PRODUCT
=========================
select prd_key, count(*) from(
select
pn.prd_id,
pn.cat_id,
pn.prd_key,
pn.prd_nm,
pn.prd_cost,
pn.prd_line,
pn.prd_start_dt,
pc.cat,
pc.subcat,
pc.maintenance
from silver.crm_prd_info pn
left join silver.erp_px_cat_glv2 pc
on pn.cat_id = pc.id
where prd_end_dt is null) t
group by prd_key
having count(*) > 1

---------------
create view gold.dim_products as
select
----surrogate key
row_number() over(order by pn.prd_start_dt, pn.prd_key) as product_key,
pn.prd_id as product_id,
pn.prd_key as product_number,
pn.prd_nm as product_name,
pn.cat_id as category_id,
pc.cat as category,
pc.subcat as subcategory,
pc.maintenance,
pn.prd_cost as cost,
pn.prd_line as product_line,
pn.prd_start_dt as start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_glv2 pc
on pn.cat_id = pc.id
where prd_end_dt is null


=========================
----------GOLDEN LAYER : SALES
=========================
create view gold.fact_sales as
select
sls_ord_num as order_number,
 pr.product_key,
cu.customer_key,
    sls_order_dt as order_date,
    sales_ship_dt as ship_date,
    sales_due_dt as due_date,
    sls_sales as sales_amt,
    sals_quantity as quantity,
    sls_price 
    from silver.crm_sales_details sd
    left join gold.dim_products pr
    on sd.sls_prd_key = pr.product_number
    left join gold.dim_customers cu
    on sls_cust_id = cu.customer_id

    ---foreign key integrity
    select *from gold.fact_sales f
    left join gold.dim_customers c
    on c.customer_key = f.customer_key
    where c.customer_key is null

     select *from gold.fact_sales f
    left join gold.dim_products p
    on p.product_key = f.product_key
        where p.product_key is null
