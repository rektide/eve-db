-- View: datacore_extract

-- DROP VIEW datacore_extract;

CREATE OR REPLACE VIEW datacore_extract AS 
 SELECT invtypes.typeid, invtypes.typename, array_to_string(regexp_matches(invtypes.typename::text, 'Datacore - (.*)'::text), ''::text) AS core_name
   FROM invtypes;

ALTER TABLE datacore_extract OWNER TO eve;


