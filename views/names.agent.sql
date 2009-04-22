-- View: agent_names

-- DROP VIEW agent_names;

CREATE OR REPLACE VIEW agent_names AS 
 SELECT agent_name.itemname AS agent, corp_name.itemname AS corp, division.divisionname AS division, faction.factionname AS faction, station_names.solar, station_names.region, station_names.constellation, station_names.corp AS station_owner, corp.stationcount AS corp_stations, agent.agentid, agent.divisionid, agent.corporationid, agent.stationid, agent.level, agent.quality, agent.agenttypeid
   FROM agtagents agent
   LEFT JOIN evenames agent_name ON agent.agentid = agent_name.itemid
   LEFT JOIN evenames corp_name ON agent.corporationid = corp_name.itemid
   LEFT JOIN station_names station_names ON agent.stationid = station_names.stationid
   LEFT JOIN crpnpcdivisions division ON agent.divisionid = division.divisionid
   LEFT JOIN crpnpccorporations corp ON agent.corporationid = corp.corporationid
   LEFT JOIN chrfactions faction ON corp.factionid = faction.factionid;

ALTER TABLE agent_names OWNER TO eve;


