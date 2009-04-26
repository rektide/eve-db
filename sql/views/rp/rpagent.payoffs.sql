-- View: agent_rp_payoffs

-- DROP VIEW agent_rp_payoffs;

CREATE OR REPLACE VIEW rpagent_payoffs AS 
	SELECT agent.agentid, agent.itemid, agent.skillid, agent.skillname, 
		(market.buy_price::numeric * rps.rp_daily_level4 / 50::numeric)::integer AS daily, 
		(market.buy_price::numeric * rps.rp_daily_level4 / 50::numeric * 30.5 / 1000000::numeric) AS monthly_m
	FROM rpagent_bestskill agent
	JOIN rpagent_rptally rps ON agent.agentid = rps.agentid
	JOIN rp_skill_item_map map ON agent.skillid = map.skillid
	JOIN market ON map.itemid = market.typeid;
	
ALTER TABLE rpagent_payoffs OWNER TO eve_admin;


