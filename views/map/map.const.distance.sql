-- View: map_constellation_distance

-- DROP VIEW map_constellation_distance;

CREATE OR REPLACE VIEW map_constellation_distance AS 
 SELECT sqrt(power(constellation.x - region.x, 2::double precision) + power(constellation.y - region.y, 2::double precision) + power(constellation.z - region.z, 2::double precision)) AS m
   FROM mapconstellations constellation
   JOIN mapregions region ON constellation.regionid = region.regionid;

ALTER TABLE map_constellation_distance OWNER TO eve_admin;


