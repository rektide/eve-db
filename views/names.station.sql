-- View: station_names

-- DROP VIEW station_names;

CREATE OR REPLACE VIEW station_names AS 
 SELECT station.stationid, station.security, station.dockingcostpervolume, station.maxshipvolumedockable, station.officerentalcost, station.operationid, station.stationtypeid, station.corporationid, station.solarsystemid, station.constellationid, station.regionid, station.stationname, station.x, station.y, station.z, station.reprocessingefficiency, station.reprocessingstationstake, station.reprocessinghangarflag, corp.itemname AS corp, solar.itemname AS solar, constellation.itemname AS constellation, region.itemname AS region
   FROM stastations station
   JOIN evenames corp ON station.corporationid = corp.itemid
   JOIN evenames solar ON station.solarsystemid = solar.itemid
   JOIN evenames constellation ON station.constellationid = constellation.itemid
   JOIN evenames region ON station.regionid = region.itemid;

ALTER TABLE station_names OWNER TO eve;


