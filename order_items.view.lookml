- view: order_items
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: inventory_item_id
    type: number
    value_format_name: id
    # hidden: true
    sql: ${TABLE}.inventory_item_id

  - dimension: order_id
    type: number
    value_format_name: id
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension_group: returned
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.returned_at

  - dimension: sale_price
    type: number
    sql: ${TABLE}.sale_price
    
  - dimension: gross_margin
    type: number
    sql: ${sale_price} - ${inventory_items.cost}

  - measure: count
    type: count
    drill_fields: [id, inventory_items.id, orders.id]


   
  - measure: count_in_california
    type: count
    filters: 
     users.state : 'California'
     
  - measure: percent_of_california_in_total
    type: number 
    sql: 100.0 * ${count_in_california}/NULLIF(${count},0)
    value_format: '0.00\%'
  
  - measure: count_in_texas
    type: count
    filters: 
      users.state: 'Texas'
      
  - measure: percent_of_texas_in_total
    type: number
    sql: 100.0 * ${count_in_texas}/NULLIF(${count}, 0)
    value_format: '0.00\%'
  
  - measure: count_ordered_with_other_prods
    type: count
    filter:
      orders.multiple_product_order : 'Yes'

  - measure: percent_ordered_with_other_prods
    type: number
    sql: 100.0 * ${count_ordered_with_other_prods} / NULLIF(${count}, 0)
    value_format: '0.00\$'
    
  - measure: total_sale_price
    type: sum
    sql: ${sale_price}
    decimals: 2 
#    value_format: '$#,##0.00'
    
  - measure: total_gross_margin
    type: sum
    sql: ${gross_margin}
    value_format: '$#,##0.00'
