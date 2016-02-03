- dashboard: side_by_side
  title: Side By Side
  layout: tile
  tile_size: 100

  filters:
  - name: producer
    type: select_filter
    explore: monthly_brand_facts
    dimension: monthly_brand_facts.brand    

  elements:

  - name: first
    title: 'Your Producer Revenue This Month'
    type: single_value
    model: abboud_test
    explore: monthly_brand_facts
    measures: [monthly_brand_facts.total_producer_revenue]
    listen:
    ## highlight
      producer: monthly_brand_facts.brand
    ## endhighlight  
    filters:
      monthly_brand_facts.order_month: last month
    sorts: [monthly_brand_facts.total_producer_revenue desc]
    height: 2
    width: 6
  
  - name: second
    title: "How You Compare to Your Competitors This Month (On Average)"
    type: single_value
    model: abboud_test
    explore: monthly_brand_facts
    measures: [monthly_brand_facts.average_producer_revenue]
    listen:
    ## highlight
      producer: monthly_brand_facts.is_peer_of
    ## endhighlight    
    filters:
      monthly_brand_facts.order_month: last month
    sorts: [monthly_brand_facts.average_producer_revenue desc]
    height: 2
    width: 6

