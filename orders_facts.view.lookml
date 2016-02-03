- view: orders_facts
  derived_table:
    sql: |
       SELECT
         orders.id as order_id
         , COUNT(*) as order_items_per_order
       FROM order_items
       LEFT JOIN orders ON order_items.order_id = orders.id
       GROUP BY 1 
       ORDER BY orders.id
  fields:
  - dimension: order_id
    primary_key: true
    type: number
    sql: ${TABLE}.order_id
    
  - dimension: order_items_per_order
    type: number
    sql: ${TABLE}.order_items_per_order
    
  - measure: average_order_items_per_order
    type: average
    sql: ${order_items_per_order}
    value_format_name : decimal_2


# # # Specify the table name if it's different from the view name:
# #   sql_table_name: my_schema_name.orders_facts
# #
# # # Or, you could make this view a derived table, like this:
#   derived_table:
#     sql: |
#       SELECT
#         users.id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.date) as most_recent_purchase_date
#       FROM orders
#       GROUP BY user.id

#   fields:
# #     Define your dimensions and measures here, like this:
#     - dimension: profit
#       type: number
#       sql: ${TABLE}.profit
#
#     - measure: total_profit
#       type: sum
#       sql: ${profit}
