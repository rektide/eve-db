-- View: agent_coreprices

-- DROP VIEW agent_coreprices;

CREATE OR REPLACE VIEW agent_coreprices AS 
 SELECT core.name, market.sell_price, market.buy_price, agent.agentid, agent.typeid AS skillid, core.coreid
   FROM agtresearchagents agent
   JOIN datacore_skill_map core ON agent.typeid = core.skillid
   JOIN market ON core.coreid = market.typeid;

ALTER TABLE agent_coreprices OWNER TO eve;


