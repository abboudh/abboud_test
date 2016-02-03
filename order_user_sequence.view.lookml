- view: order_user_sequence

  derived_table:
    sql: |
      SELECT
        id as order_id
        , (SELECT COUNT(*) FROM orders o2 WHERE o2.id <= o1.id AND o2.user_id = o1.user_id) as user_order_sequence_number
        FROM orders o1  
      

  fields:
  
  - dimension: order_id
    primary_key: true
    sql: ${TABLE}.order_id
  
  - dimension: user_order_sequence_number
    type: number
    sql: ${TABLE}.user_order_sequence_number
  
  