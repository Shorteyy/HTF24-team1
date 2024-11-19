
view: percent_habit_planet_by_telescope {
  derived_table: {
    sql: with habitable as (
      SELECT
        dt.discovery_telescope, count(*) as habit
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_telescope as dt
        ON p.facility_id = dt.facility_id
      WHERE (0.1 < p.planet_mass_earth and p.planet_mass_earth < 10 and 0.5 < p.planet_radius_earth and p.planet_radius_earth < 2.5 and 175 < p.equilibrium_temperature_k and p.equilibrium_temperature_k < 274 and p.eccentricity < 0.2 and 0.7 < p.insolation_flux_earth and p.insolation_flux_earth < 13 and 1 < p.planet_density )
      GROUP BY dt.discovery_telescope
      ), 
      
      all_planets as (
      SELECT
        dt.discovery_telescope, count(*) as all_p
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.discovery_telescope as dt
        ON p.facility_id = dt.facility_id
      GROUP BY dt.discovery_telescope
      )
      
      SELECT h.discovery_telescope, h.habit/a.all_p*100 as Percentage
      FROM habitable as h 
      INNER JOIN all_planets as a
      ON h.discovery_telescope = a.discovery_telescope ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: discovery_telescope {
    type: string
    sql: ${TABLE}.discovery_telescope ;;
  }

  dimension: percentage {
    type: number
    sql: ${TABLE}.Percentage ;;
  }

  set: detail {
    fields: [
        discovery_telescope,
	percentage
    ]
  }
}
