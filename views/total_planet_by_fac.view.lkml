
view: total_planet_by_fac {
  derived_table: {
    sql: SELECT
        d.discovery_facility, count(*) as Total
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as d
        ON p.facility_id =  d.facility_id
      GROUP BY d.discovery_facility ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_facility {
    type: string
    sql: ${TABLE}.discovery_facility ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.Total ;;
  }

  set: detail {
    fields: [
        discovery_facility,
	total
    ]
  }
}
