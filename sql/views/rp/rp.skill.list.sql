create or replace view rp_skill_list as
	select ar.typeid as skillid, iv.typename from agtresearchagents ar
	join invtypes iv on ar.typeid = iv.typeid
	group by ar.typeid, iv.typename;

ALTER TABLE rp_skill_list OWNER TO eve_admin;