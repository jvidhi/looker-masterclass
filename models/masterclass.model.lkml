connection: "looker-private-demo"

# include: "/queries/queries*.view" # includes all queries refinements
# include: "/views/**/*.view" # include all the views
# include: "/retail_views/**/*.view" # include all the views
# include: "/dashboards/*.dashboard.lookml" # include all the views


# datagroup: order_items_once_day_mc {
#   sql_trigger: SELECT CURRENT_DATE() ;;
#   max_cache_age: "24 hours"
# }

# access_grant: can_see_email_mc {
#   user_attribute: can_see_email
#   allowed_values: ["yes"]
# }

# access_grant: can_see_gross_margin_mc {
#   user_attribute: can_see_gross_margin
#   allowed_values: ["yes"]
# }


# explore: transactions_mc {
#   view_name: transactions
#   label: "MC Transaction Detail 🏷"
#   # always_filter: {
#   #   filters: {
#   #     field: transaction_date
#   #     value: "last 30 days"
#   #   }
#   # }

#   # access_filter: {
#   #   field: stores.name
#   #   user_attribute: store
#   # }

#   join: transactions__line_items {
#     view_label: "mc transaction line items"
#     relationship: one_to_many
#     sql: LEFT JOIN UNNEST(${transactions.line_items}) transactions__line_items ;;
#   }

#   join: customers {
#     view_label: "mc customers"
#     relationship: many_to_one
#     sql_on: ${transactions.customer_id} = ${customers.id} ;;
#   }

#   join: customer_facts {
#     relationship: many_to_one
#     view_label: "mc Customers facts"
#     sql_on: ${transactions.customer_id} = ${customer_facts.customer_id} ;;
#   }

#   # join: products {
#   #   relationship: many_to_one
#   #   sql_on: ${products.id} = ${transactions__line_items.product_id} ;;
#   # }

#   # join: stores {
#   #   type: left_outer
#   #   sql_on: ${stores.id} = ${transactions.store_id} ;;
#   #   relationship: many_to_one
#   # }

#   # join: channels {
#   #   type: left_outer
#   #   view_label: "Transactions"
#   #   sql_on: ${channels.id} = ${transactions.channel_id} ;;
#   #   relationship: many_to_one
#   # }

#   # join: customer_transaction_sequence {
#   #   relationship: many_to_one
#   #   sql_on: ${transactions.customer_id} = ${customer_transaction_sequence.customer_id}
#   #     AND ${transactions.transaction_raw} = ${customer_transaction_sequence.transaction_raw} ;;
#   # }

#   # join: store_weather {
#   #   relationship: many_to_one
#   #   sql_on: ${transactions.transaction_date} = ${store_weather.weather_date}
#   #     AND ${transactions.store_id} = ${store_weather.store_id};;
#   # }

#   # join: customer_clustering_prediction {
#   #   fields: [customer_clustering_prediction.centroid_id,customer_clustering_prediction.customer_segment]
#   #   view_label: "Customers"
#   #   relationship: many_to_one
#   #   sql_on: ${transactions.customer_id} = ${customer_clustering_prediction.customer_id} ;;
#   # }

# }


# explore: order_items_mc {
#   label: "Masterclass: Orders, Items and Users"
#   view_name: order_items
#   view_label: "mc order items"
#   always_filter: {
#     filters: {
#       field: order_items.created_date
#       value: "last 30 days"
#     }
#   }
#   persist_with: order_items_once_day_mc

#   join: order_facts {
#     type: left_outer
#     view_label: "mc Orders facts"
#     relationship: many_to_one
#     sql_on: ${order_facts.order_id} = ${order_items.order_id} ;;
#   }

#   join: inventory_items {
#     view_label: "mc Inventory Items"
#     #Left Join only brings in items that have been sold as order_item
#     type: full_outer
#     relationship: one_to_one
#     sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
#   }
#   join: users {
#     view_label: "mc Users"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#   }

#   join: user_order_facts {
#     view_label: "mc Users Facts"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${user_order_facts.user_id} = ${order_items.user_id} ;;
#   }

#   join: products {
#     view_label: "mc Products"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${products.id} = ${inventory_items.product_id} ;;
#   }

#   join: repeat_purchase_facts {
#     view_label: "mc Repeat Purchase Facts"
#     relationship: many_to_one
#     type: full_outer
#     sql_on: ${order_items.order_id} = ${repeat_purchase_facts.order_id} ;;
#   }

#   join: discounts {
#     view_label: "mc Discounts"
#     type: inner
#     relationship: many_to_one
#     sql_on: ${products.id} = ${discounts.product_id} ;;
#   }

#   join: distribution_centers {
#     view_label: "mc Distribution Center"
#     type: left_outer
#     sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
#     relationship: many_to_one
#   }


# }
