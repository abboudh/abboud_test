- view: user_order_facts

  derived_table:
    sql: |
      SELECT
        orders.user_id as user_id
        , COUNT(*) as lifetime_items
        , COUNT(DISTINCT order_items.order_id) as lifetime_orders
        , MIN(NULLIF(orders.created_at,0)) as first_order
        , MAX(NULLIF(orders.created_at,0)) as latest_order
        , COUNT(DISTINCT EXTRACT(MONTH FROM NULLIF(orders.created_at,0))) as number_of_distinct_months_with_orders
        , SUM(order_items.sale_price) as lifetime_revenue
        FROM order_items
        LEFT JOIN orders on order_items.order_id = orders.id
        GROUP BY user_id
    indexes: [user_id]
    sql_trigger_value: SELECT MAX(id) FROM orders


  fields: 

  - dimension: user_id
    primary_key: true
    hidden: true
  
  - dimension: lifetime_items
    type: number
    sql: COALESCE(${TABLE}.lifetime_items,0)
  
  - dimension: lifetime_orders
    type: number
    sql: COALESCE(${TABLE}.lifetime_orders,0)

  - dimension: lifetime_orders_tiered
    type: tier
    style: integer
    tiers: [0,1,2,3,5,10]
    sql: ${lifetime_orders}
    
  - dimension: lifetime_revenue
    type: number
    sql: COALESCE(${TABLE}.lifetime_revenue, 0)
    
  - dimension: lifetime_revenue_tiered
    type: tier
    style: integer
    sql: ${lifetime_revenue}
    tiers: [0,1,20,50,100,500,1000,10000]
    
  - dimension: repeat_customer
    type: yesno
    sql: ${lifetime_orders} > 1
  
  - dimension_group: first_order
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order

  - dimension: latest_order
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_order

  - dimension: days_as_customer
    type: number
    sql: DATEDIFF('day', ${TABLE}.first_order, ${TABLE}.latest_order)+1
    
  - dimension: number_of_distinct_months_with_orders
    type: number