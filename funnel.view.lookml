- view: funnel

  derived_table:
    sql: |
      SELECT 
        u.created_at as event_time
        , 'SIGNUP' as event_type
        , u.id as user_id
        , NULL as order_id
      FROM users u
      WHERE
      {% condition event_time %} u.created_at {% endcondition %}
      UNION
      SELECT
       o.created_at as event_time
       , 'ORDER' as event_type
       , o.user_id as user_id
       , o.id as order_id
      FROM orders o
      WHERE
      {% condition event_time %} o.created_at {% endcondition %}
        

  fields:
  - dimension_group: event
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.event_time
      
  - dimension: user_id 
    type: number
      
  - dimension: order_id
    type: number
      
  - dimension: event_type  
  - measure: count_signups
    type: count
    filters:
      event_type: SIGNUP
    drill_fields: [users.id, users.name, users.created_time]


  - measure: count_orders
    type: count
    filters:
      event_type: ORDER
    drill_fields: [users.id, users.name, users.created_time]
    
  - measure: count
    type: count
    drill_fields: [users.id, users.name, users.created_time]
      
