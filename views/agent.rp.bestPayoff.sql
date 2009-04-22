-- View: agent_rp_payoffs

-- DROP VIEW agent_rp_payoffs;

CREATE OR REPLACE VIEW agent_rp_payoffs AS 
 SELECT agent.agentid, field.typeid, market.name, (market.buy_price::numeric * agent.rp_daily_level4 / 50::numeric)::integer AS daily, market.buy_price::numeric * agent.rp_daily_level4 / 50::numeric * 30.5 / 1000000::numeric AS monthly_m
   FROM agent_rp agent
   JOIN agtresearchagents field ON agent.agentid = field.agentid
   JOIN datacore_market market ON field.typeid = market.skillid;

ALTER TABLE agent_rp_payoffs OWNER TO eve;


