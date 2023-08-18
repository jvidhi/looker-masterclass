view: eav_source {
  sql_table_name:
  ( SELECT 1 as entity, 1 as object_id, 'foo' as attribute, 'bar' as val UNION ALL
    SELECT 1 as entity, 1 as object_id, 'contribution' as attribute, '3' as val UNION ALL
    SELECT 1 as entity, 1 as object_id, 'foo_2' as attribute, 'bar' as val UNION ALL
    SELECT 2 as entity, 2 as object_id, 'first_name' as attribute, 'bob' as val UNION ALL
    SELECT 2 as entity, 2 as object_id, 'last_name' as attribute, 'dole' as val UNION ALL
    SELECT 3 as entity, 4 as object_id, 'amount_c' as attribute, '10' as val UNION ALL
    SELECT 3 as entity, 5 as object_id, 'amount_c' as attribute, '20' as val UNION ALL
    SELECT 3 as entity, 6 as object_id, 'amount_c' as attribute, '20' as val
    )
  ;;
  dimension: object_id {}
  dimension: entity { type: number }
  dimension: attribute {}
  dimension: val {}
  filter: picker { type: string }
  measure: picked_attribute {
    type: max
    sql: CASE WHEN {% condition picker %} ${attribute} {% endcondition %} THEN ${val} ELSE NULL END ;;
  }
}
explore: eav_source { hidden: yes }
view: eav_flattened {
  derived_table: {
    explore_source: eav_source {
      column: object_id {}
      column: picked_attribute {}
      bind_filters: {
        from_field: eav_flattened.picker
        to_field: eav_source.picker
      }
      bind_filters: {
        from_field: eav_flattened.entity
        to_field: eav_source.entity
      }
      filters: [ eav_source.attribute: "-NULL" ]
    }
  }
  filter: entity { type: number }
  dimension: object_id {}
  filter: picker { type: string }
  parameter: is_number { type: yesno }
  dimension: picked_attribute {
    sql:
        {% if is_number._parameter_value == 'true' %}
          CAST(${TABLE}.picked_attribute AS INT64)
          {% else %}
          ${TABLE}.picked_attribute
          {% endif %};;
  }
  measure: attribute_sum {
    label: "Sum"
    type: sum
    sql: ${picked_attribute} ;;
  }
}
explore: eav_flattened {
  #NOTE: this would be be replaced by an access_filter for entity, i.e. I am always querying the table as an entity and want
  #to measure the custom attributes of my objects
  always_filter: {
    filters: [eav_flattened.entity: "3"]
  }
}
