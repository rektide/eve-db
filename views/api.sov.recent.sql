-- View: api_sov_recent

-- DROP VIEW api_sov_recent;

CREATE OR REPLACE VIEW api_sov_recent AS 
 SELECT s1.id, s1.solarsystemid, s1.allianceid, s1.constellationsovereignty, s1.sovereigntylevel, s1.factionid, s1.entrydate
   FROM api_sov s1
   LEFT JOIN api_sov s2 ON s1.solarsystemid = s2.solarsystemid AND s1.entrydate < s2.entrydate
  WHERE s2.entrydate IS NULL;

ALTER TABLE api_sov_recent OWNER TO eve;


