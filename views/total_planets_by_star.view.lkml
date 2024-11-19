
view: total_planets_by_star {
  derived_table: {
    sql: SELECT
        s.host_name, count(*) as Total
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.star as s 
        ON p.host_id = s.host_id
      GROUP BY s.host_name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: host_name {
    type: string
    sql: ${TABLE}.host_name ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.Total ;;
  }

  set: detail {
    fields: [
        host_name,
	total
    ]
  }
}
