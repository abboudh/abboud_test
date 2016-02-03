- view: also_bought

  derived_table:
    sql: |

      SELECT
      pi1.product_id as product_id1
      , pi2.product_id as product_id2
      , pi1.order_id as order_id
      FROM (SELECT ii.product_id as product_id, oi.order_id as order_id
            FROM order_items oi
            LEFT JOIN orders o ON o.id = oi.order_id
            LEFT JOIN inventory_items ii ON ii.id = oi.inventory_item_id) as pi1
      JOIN  (SELECT ii.product_id as product_id, oi.order_id as order_id
            FROM order_items oi
            LEFT JOIN orders o ON o.id = oi.order_id
            LEFT JOIN inventory_items ii ON ii.id = oi.inventory_item_id) as pi2 
            ON pi1.order_id = pi2.order_id AND pi1.product_id <> pi2.product_id
      

  fields:
  - measure: count
    type: count

  - dimension: product_id1
  - dimension: product_id2
  - dimension: order_id