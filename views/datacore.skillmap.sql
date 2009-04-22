-- View: datacore_skill_map

-- DROP VIEW datacore_skill_map;

CREATE OR REPLACE VIEW datacore_skill_map AS 
 SELECT core.core_name AS name, core.typeid AS coreid, skill.typeid AS skillid
   FROM datacore_extract core
   JOIN invtypes skill ON core.core_name = skill.typename::text;

ALTER TABLE datacore_skill_map OWNER TO eve;


