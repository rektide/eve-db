-- View: agent_rp_best_skill

-- DROP VIEW agent_rp_best_skill;

CREATE OR REPLACE VIEW agent_rp_best_skill AS 
 SELECT m1.name, m1.sell_price, m1.buy_price, m1.agentid, m1.skillid, m1.coreid
   FROM agent_coreprices m1
   LEFT JOIN agent_coreprices m2 ON m1.agentid = m2.agentid AND m1.buy_price < m2.buy_price
  WHERE m2.agentid IS NULL;

ALTER TABLE agent_rp_best_skill OWNER TO eve;


