-- View: stastations_services

-- DROP VIEW stastations_services;

CREATE OR REPLACE VIEW stastations_services AS 
 SELECT stations.stationid, stations.security, stations.dockingcostpervolume, stations.maxshipvolumedockable, stations.officerentalcost, stations.operationid, stations.stationtypeid, stations.corporationid, stations.solarsystemid, stations.constellationid, stations.regionid, stations.stationname, stations.x, stations.y, stations.z, stations.reprocessingefficiency, stations.reprocessingstationstake, stations.reprocessinghangarflag, array_to_string(ARRAY( SELECT ops.servicename::character varying(128) AS servicename
           FROM names_staoperationservices ops
          WHERE stations.operationid = ops.operationid), ', '::text) AS services
   FROM stastations stations;

ALTER TABLE stastations_services OWNER TO eve_admin;


