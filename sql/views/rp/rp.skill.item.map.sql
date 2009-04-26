create or replace view rp_skill_item_map as
	select 
		skill.skillid, item.typeid as itemid, 
		skill.typename as skillname, item.typename as itemname
	from rp_skill_list as skill
	join invtypes as item 
		on strpos(item.typename,skill.typename) > 0 
		and strpos(item.typename, 'Datacore') > 0; 

ALTER TABLE rp_skill_item_map OWNER TO eve_admin;
