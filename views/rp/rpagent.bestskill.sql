-- View: agent_rp_best_skill

-- DROP VIEW agent_rp_best_skill;

CREATE OR REPLACE VIEW rpagent_bestskill AS 
SELECT m1.skillname, m1.sell_price, m1.buy_price, m1.agentid, m1.skillid, m1.itemid
	FROM rpagent_coreinfo m1
	LEFT JOIN rpagent_coreinfo m2 
		ON m1.agentid = m2.agentid 
		AND m1.buy_price < m2.buy_price
	WHERE m2.agentid IS NULL;

ALTER TABLE rpagent_bestskill OWNER TO eve_admin;


