
view: planet_by_telescope {
  derived_table: {
    sql: SELECT 
        dt.discovery_telescope, count(p.planet_name) as Total
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as df ON p.facility_id = df.facility_id
        FULL OUTER JOIN planets_dataset.discovery_telescope as dt ON df.facility_id = dt.facility_id
      WHERE (0.1 < p.planet_mass_earth and p.planet_mass_earth < 10 and 0.5 < p.planet_radius_earth and p.planet_radius_earth < 2.5 and 175 < p.equilibrium_temperature_k and p.equilibrium_temperature_k < 274 and p.eccentricity < 0.2 and 0.7 < p.insolation_flux_earth and p.insolation_flux_earth < 13 and 1 < p.planet_density )
      GROUP BY dt.discovery_telescope ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_telescope {
    type: string
    sql: ${TABLE}.discovery_telescope ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.Total ;;
  }

  set: detail {
    fields: [
        discovery_telescope,
	total
    ]
  }
}
