connection: "htf2024"

# include all the views
include: "/views/**/*.view.lkml"



explore: raw_planets {}

explore: star {}

explore: discovery_facility {}

explore: planet {
  sql_always_where: 0.1 < ${planet_mass_earth} and ${planet_mass_earth} < 10 and 0.5 < ${planet_radius_earth} and ${planet_radius_earth} < 2.5 and 175 < ${equilibrium_temperature_k} and ${equilibrium_temperature_k} < 274 and ${eccentricity} < 0.2 and 0.7 < ${insolation_flux_earth} and ${insolation_flux_earth} < 13 and 1 < ${planet_density} ;;
}

explore: discovery_telescope {}

explore: all_planets {}

explore: planets_and_stars {
  label: "Join between all planets and all stars"
  from: all_planets
  join: star {
    type: inner
    relationship: one_to_many
    sql_on: ${planets_and_stars.host_id} = ${star.host_id};;
  }
}

explore: planet_count_by_star {}
