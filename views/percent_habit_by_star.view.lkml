
view: percent_habit_by_star {
  derived_table: {
    sql: with habitable as (
      SELECT
        s.host_name, count(*) as habit
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.star as s 
        ON p.host_id = s.host_id
      WHERE (0.1 < p.planet_mass_earth and p.planet_mass_earth < 10 and 0.5 < p.planet_radius_earth and p.planet_radius_earth < 2.5 and 175 < p.equilibrium_temperature_k and p.equilibrium_temperature_k < 274 and p.eccentricity < 0.2 and 0.7 < p.insolation_flux_earth and p.insolation_flux_earth < 13 and 1 < p.planet_density )
      GROUP BY s.host_name
      ), 
      
      all_planets as (
      SELECT
        s.host_name, count(*) as all_p
      FROM planets_dataset.planet  AS p
        FULL OUTER JOIN planets_dataset.star as s 
        ON p.host_id = s.host_id
      GROUP BY s.host_name
      )
      
      SELECT h.host_name, h.habit/a.all_p*100 as Percentage
      FROM habitable as h 
      INNER JOIN all_planets as a
      ON h.host_name = a.host_name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: host_name {
    type: string
    sql: ${TABLE}.host_name ;;
  }

  dimension: percentage {
    type: number
    sql: ${TABLE}.Percentage ;;
  }

  set: detail {
    fields: [
        host_name,
	percentage
    ]
  }
}
