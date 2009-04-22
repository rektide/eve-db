-- View: staoperationservices_named

-- DROP VIEW staoperationservices_named;

CREATE OR REPLACE VIEW staoperationservices_named AS 
 SELECT operation.operationid, operation.serviceid, service.servicename
   FROM staoperationservices operation
   JOIN staservices service ON operation.serviceid = service.serviceid;

ALTER TABLE staoperationservices_named OWNER TO eve;


