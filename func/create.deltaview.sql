-- Function: delta(text, text, text[], timestamp without time zone, text, boolean)

-- DROP FUNCTION delta(text, text, text[], timestamp without time zone, text, boolean);

CREATE OR REPLACE FUNCTION createDeltaView_mostRecent(
	viewName text,
	tableName text,
	columns text[],
	dtt_column text)
RETURNS void AS
$BODY$
declare

	columnsCriteria text;
	queryText text;
	i int;

begin
	
	columnsCriteria := '';
	for i in array_lower(columns,1) .. array_upper(columns,1) loop
		columnsCriteria := columnsCriteria || 'and t1.' || columns[i] || ' = t2.' || columns[i] || ' '; 
	end loop;
	columnsCriteria := overlay(columnsCriteria placing '   ' from 1); 
	
	queryText = 'create or replace view ' || viewName || ' as ' ||
		'select t1.* from ' || tableName || ' as t1 ' ||
		'left join ' || tableName || ' as t2 ' || 
		'on ' || columnsCriteria ||
		'and t1.' || dtt_column || ' < t2.' || dtt_column ||  ' ' ||
		'where t2.' || dtt_column || ' is null';
	--raise notice 'sample create query: %', queryText;
	execute queryText;
	
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
--ALTER FUNCTION delta(text, text, text[], timestamp without time zone, text, boolean) OWNER TO postgres;

