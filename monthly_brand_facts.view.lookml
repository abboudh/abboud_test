- view: monthly_brand_facts

  derived_table:
      sql: |
         SELECT products.brand
          ,DATE_FORMAT(CONVERT_TZ(orders.created_at,'UTC','America/Los_Angeles'), '%Y-%m-01') AS order_month
          , SUM(inventory_items.cost) AS producer_revenue  
          FROM order_items 
                  LEFT JOIN orders
                ON order_items.order_id = orders.id
              LEFT JOIN inventory_items
            ON order_items.inventory_item_id = inventory_items.id
          LEFT JOIN products
          ON inventory_items.product_id = products.id
          GROUP BY 1,2  
      sql_trigger_value: SELECT CURDATE()
      indexes: [order_month, brand]
    
  
  fields:
   
# FILTER-ONLY FIELDS #   

  - filter: is_peer_of
    label: '--Filter-- Is Peer Of'
    sql: |
        NOT {% condition is_peer_of %} ${brand} {% endcondition %}
  
  - dimension: brand
    sql: ${TABLE}.brand
  
  - dimension_group: order
    type: time
    timeframes: [month]
    convert_tz: false
    sql: ${TABLE}.order_month
  
  - dimension: producer_revenue
    type: number
    sql: ${TABLE}.producer_revenue
    value_format: '$#,##0.00'
  
  - measure: total_producer_revenue
    type: sum
    sql: ${producer_revenue}
    value_format: '$#,##0.00'
    
  - measure: average_producer_revenue
    type: avg
    sql: ${producer_revenue}
    value_format: '$#,##0.00'