- view: order_items_facts

  derived_table:
    sql: |
       SELECT 
        products.brand AS brand,
        users.id AS user_id ,
        COUNT(*) AS number_orders_same_brand
       FROM order_items
       LEFT JOIN inventory_items ON order_items.inventory_item_id = inventory_items.id
       LEFT JOIN orders ON order_items.order_id = orders.id
       LEFT JOIN products ON inventory_items.product_id = products.id
       LEFT JOIN users ON orders.user_id = users.id
       GROUP BY brand, user_id


  fields:
  
  - dimension: brand
    type: string
    sql: ${TABLE}.brand
    
  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id
    
  - dimension: number_orders_same_brand
    type: number
    sql: ${TABLE}.number_orders_same_brand
    
    