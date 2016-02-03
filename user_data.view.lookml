- view: user_data
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: max_num_orders
    type: number
    sql: ${TABLE}.max_num_orders

  - dimension: total_num_orders
    type: number
    sql: ${TABLE}.total_num_orders

  - dimension: user_id
    type: number
    value_format_name: id
    # hidden: true
    sql: ${TABLE}.user_id
  
  - dimension: has_multiple_orders
    type: yesno
    sql: ${total_num_orders} > 1
    
  - dimension: is_repeat_customer
    type: number
    sql: CASE WHEN ${has_multiple_orders} THEN 1 ELSE 0 END

  - measure: count
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id]

