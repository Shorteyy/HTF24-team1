
view: percent_habit_planet_by_fac {
  derived_table: {
    sql: with habitable as (
      SELECT
        df.discovery_facility, count(*) as habit
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as df
        ON p.facility_id = df.facility_id
      WHERE (0.1 < p.planet_mass_earth and p.planet_mass_earth < 10 and 0.5 < p.planet_radius_earth and p.planet_radius_earth < 2.5 and 175 < p.equilibrium_temperature_k and p.equilibrium_temperature_k < 274 and p.eccentricity < 0.2 and 0.7 < p.insolation_flux_earth and p.insolation_flux_earth < 13 and 1 < p.planet_density )
      GROUP BY df.discovery_facility
      ), 
      
      all_planets as (
      SELECT
        df.discovery_facility, count(*) as all_p
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_facility as df 
        ON p.facility_id = df.facility_id
      GROUP BY df.discovery_facility
      )
      
      SELECT h.discovery_facility, h.habit/a.all_p*100 as Percentage
      FROM habitable as h 
      INNER JOIN all_planets as a
      ON h.discovery_facility = a.discovery_facility ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_facility {
    type: string
    sql: ${TABLE}.discovery_facility ;;
  }

  dimension: percentage {
    type: number
    sql: ${TABLE}.Percentage ;;
  }

  set: detail {
    fields: [
        discovery_facility,
	percentage
    ]
  }
}
