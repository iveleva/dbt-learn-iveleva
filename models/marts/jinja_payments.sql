{% set payment_methods = dbt_utils.get_column_values(table=ref('stg_stripe_payments'), column='payment_method') %}
with payments as (
    select * 
    from {{ ref('stg_stripe_payments') }}
), final as (
    select
        order_id, 
        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount
        {{ "," if not loop.last }}
        {%- endfor %}
    from payments
    group by order_id
)
select *
from final