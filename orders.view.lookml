- view: orders
  fields: 

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, day_of_week, week, month,year]
    sql: ${TABLE}.created_at

  - dimension: status
    type: string
    sql: ${TABLE}.status

  - dimension: user_id
    type: number
    value_format_name: id
    # hidden: true
    sql: ${TABLE}.user_id

  - dimension : is_a_weekday
    type: yesno
    sql: ${created_day_of_week} IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')

  - dimension: multiple_product_order
    type: yesno
    sql: ${orders_facts.order_items_per_order} > 1

  - measure: count
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  
  
  
  
  