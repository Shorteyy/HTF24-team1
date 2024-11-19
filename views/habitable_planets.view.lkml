view: habitable_planets {
  sql_table_name: `planets_dataset.planet` ;;
  drill_fields: [planet_id]

  dimension: planet_id {
    primary_key: yes
    type:  number
    sql:  ${TABLE}.planet_id ;;
  }

  dimension: planet_name {
    type:  string
    sql: ${TABLE}.planet_name ;;
  }

  dimension: mass {
    type:  number
    sql: 0.1 < ${TABLE}.planet_mass_earth AND ${TABLE}.planet_mass_earth < 10;;
  }

  dimension: radius {
    type:  number
    sql:  0.5 < ${TABLE}.planet_radius_earth AND ${TABLE}.planet_radius_earth < 2.5 ;;
  }

  dimension: temperature {
    type:  number
    sql: 175 < ${TABLE}.equilibrium_temperature_k AND ${TABLE}.equilibrium_temperature_k < 274 ;;
  }

  dimension: eccentricity {
    type: number
    sql: ${TABLE}.eccentricity < 0.2 ;;
  }

  dimension: flux {
    type:  number
    sql: ${TABLE}.insolation_flux_earth > 0.7 and ${TABLE}.insolation_flux_earth < 1.3;;
  }

  dimension: density {
    type:  number
    sql:  1 < ${TABLE}.planet_density ;;
  }


}




