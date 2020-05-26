select
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" payment_method,
    amount,
    created as created_at
from raw.stripe.payment
