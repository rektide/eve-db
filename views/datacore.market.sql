-- View: datacore_market

-- DROP VIEW datacore_market;

CREATE OR REPLACE VIEW datacore_market AS 
 SELECT list.name, market.buy_price, market.sell_price, list.coreid, list.skillid
   FROM datacore_skill_map list
   JOIN market ON list.coreid = market.typeid;

ALTER TABLE datacore_market OWNER TO eve;


