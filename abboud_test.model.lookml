- connection: thelook

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards



- explore: events
  joins:
    - join: users
      type: left_outer 
      sql_on: ${events.user_id} = ${users.id}
      relationship: many_to_one



- explore: inventory_items
  joins:
    - join: products
      type: left_outer 
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one

- explore: also_bought
  joins:
  
    - join: orders
      relationship: many_to_one
      sql_on: also_bought.order_id = orders.id
      
    - join: orders_facts
      type: inner
      sql_on: ${orders.id} = ${orders_facts.order_id}
      relationship: one_to_one
      
    - join: product1
      from: products 
      relationship: many_to_one
      sql_on: also_bought.product_id1 = product1.id

    - join: product2
      from: products
      relationship: many_to_one
      sql_on: also_bought.product_id2 = product2.id

    - join: users
      relationship: many_to_one
      sql_on: orders.user_id = users.id

- explore: order_items
  joins:
    - join: inventory_items
      type: left_outer 
      sql_on: ${order_items.inventory_item_id} = ${inventory_items.id}
      relationship: many_to_one

    - join: orders
      type: left_outer 
      sql_on: ${order_items.order_id} = ${orders.id}
      relationship: many_to_one

    - join: products
      type: left_outer 
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one

    - join: users
      type: left_outer 
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one
    
    - join: user_data
      type: inner
      sql_on: ${users.id} = ${user_data.user_id}
      relationship: one_to_one
      
    - join: user_order_facts
      relationship: many_to_one
      sql_on: ${orders.user_id} = ${user_order_facts.user_id}      
      
    - join: orders_facts
      type: inner
      sql_on: ${orders.id} = ${orders_facts.order_id}
      relationship: one_to_one
      
    - join: order_items_facts
      type: left_outer
      sql_on: ${order_items_facts.user_id} = ${users.id}
      relationship: many_to_one
  
- explore: orders
  joins:
    - join: users
      type: left_outer 
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one
    
    - join: orders_facts
      type: inner
      sql_on: ${orders.id} = ${orders_facts.order_id}
      relationship: one_to_one
      
    - join: order_user_sequence
      relationship: one_to_one
      sql_on: ${orders.id} = ${order_user_sequence.order_id}
- explore: products

- explore: schema_migrations

- explore: user_data
  joins:
    - join: users
      type: left_outer 
      sql_on: ${user_data.user_id} = ${users.id}
      relationship: many_to_one


- explore: users
  joins:
    - join: user_order_facts
      relationship: one_to_one
      sql_on: users.id = user_order_facts.user_id

- explore: users_nn

- explore: monthly_brand_facts

