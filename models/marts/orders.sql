with stg_orders as (
    select * from {{ ref('stg_orders') }}
),

stg_payments as (
    select * from {{ ref('stg_stripe_payments') }}
)

select
    stg_orders.order_id,
    stg_orders.order_date,
    stg_orders.customer_id,
    sum(stg_payments.amount) as amount
from stg_orders
left join stg_payments
on stg_orders.order_id = stg_payments.order_id
group by 1,2,3