-- View: agent_coreprices

DROP VIEW if exists rpagent_coreinfo;
CREATE OR REPLACE VIEW rpagent_coreinfo AS 
 SELECT agent.agentid, core.skillname, market.sell_price, market.buy_price, core.itemid, core.skillid 
   FROM agtresearchagents agent
   JOIN rp_skill_item_map core ON agent.typeid = core.skillid
   JOIN market ON core.itemid = market.typeid;

ALTER TABLE rpagent_coreinfo OWNER TO eve_admin;
