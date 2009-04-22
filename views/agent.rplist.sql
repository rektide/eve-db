-- View: agent_rplist

-- DROP VIEW agent_rplist;

CREATE OR REPLACE VIEW agent_rplist AS 
 SELECT agent.agentid, array_to_string(ARRAY( SELECT research_name.typename
           FROM agtresearchagents research
      JOIN invtypes research_name ON research.typeid = research_name.typeid
     WHERE agent.agentid = research.agentid), ', '::text) AS fs
   FROM agtagents agent
  WHERE (agent.agentid IN ( SELECT agtresearchagents.agentid
           FROM agtresearchagents));

ALTER TABLE agent_rplist OWNER TO eve;


