-- View: map_solar_distance

-- DROP VIEW map_solar_distance;

CREATE OR REPLACE VIEW map_solar_distance AS 
 SELECT sqrt(power(solar.x - const.x, 2::double precision) + power(solar.y - const.y, 2::double precision) + power(solar.z - const.z, 2::double precision)) AS m
   FROM mapsolarsystems solar
   JOIN mapconstellations const ON solar.constellationid = const.constellationid;

ALTER TABLE map_solar_distance OWNER TO eve;


