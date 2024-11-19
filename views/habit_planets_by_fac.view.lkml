
view: habit_planets_by_fac {
  derived_table: {
    sql: SELECT
        d.discovery_facility, p.planet_name 
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as d
        ON p.facility_id =  d.facility_id
      WHERE (0.1 < p.planet_mass_earth and p.planet_mass_earth < 10 and 0.5 < p.planet_radius_earth and p.planet_radius_earth < 2.5 and 175 < p.equilibrium_temperature_k and p.equilibrium_temperature_k < 274 and p.eccentricity < 0.2 and 0.7 < p.insolation_flux_earth and p.insolation_flux_earth < 13 and 1 < p.planet_density ) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_facility {
    type: string
    sql: ${TABLE}.discovery_facility ;;
  }

  dimension: planet_name {
    type: string
    sql: ${TABLE}.planet_name ;;
  }

  set: detail {
    fields: [
        discovery_facility,
	planet_name
    ]
  }
}
