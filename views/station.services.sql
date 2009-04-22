-- View: station_services

-- DROP VIEW station_services;

CREATE OR REPLACE VIEW station_services AS 
 SELECT station.stationid, service.serviceid, service.servicename
   FROM stastations station
   JOIN staoperationservices_named service ON station.operationid = service.operationid;

ALTER TABLE station_services OWNER TO eve;


