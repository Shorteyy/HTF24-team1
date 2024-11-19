
view: total_planets_by_telescope {
  derived_table: {
    sql: SELECT
        df.discovery_facility, dt.discovery_telescope, count(p.planet_name) as total
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as df ON p.facility_id = df.facility_id
        FULL OUTER JOIN planets_dataset.discovery_telescope as dt ON df.facility_id = dt.facility_id
      GROUP BY df.discovery_facility, dt.discovery_telescope ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_facility {
    type: string
    sql: ${TABLE}.discovery_facility ;;
  }

  dimension: discovery_telescope {
    type: string
    sql: ${TABLE}.discovery_telescope ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  set: detail {
    fields: [
        discovery_facility,
	discovery_telescope,
	total
    ]
  }
}
