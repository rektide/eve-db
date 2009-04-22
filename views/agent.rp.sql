-- View: agent_rp

-- DROP VIEW agent_rp;

CREATE OR REPLACE VIEW agent_rp AS 
 SELECT agent.agentid, (1::numeric + agent.quality::numeric / 100.0) * ((3.0 + agent.level::numeric) ^ 2::numeric) AS rp_daily_level3, (1::numeric + agent.quality::numeric / 100.0) * ((4.0 + agent.level::numeric) ^ 2::numeric) AS rp_daily_level4, (1::numeric + agent.quality::numeric / 100.0) * ((5.0 + agent.level::numeric) ^ 2::numeric) AS rp_daily_level5
   FROM agtagents agent
  WHERE (agent.agentid IN ( SELECT agtresearchagents.agentid
           FROM agtresearchagents));

ALTER TABLE agent_rp OWNER TO eve;


