-- Function: delta(text, text, text[], timestamp without time zone, text, boolean)

-- DROP FUNCTION delta(text, text, text[], timestamp without time zone, text, boolean);

CREATE OR REPLACE FUNCTION delta(freshTable text, existingTable text, columns text[], dtt timestamp, dtt_column text, marktombstones boolean)
  RETURNS SETOF record AS
$BODY$
declare

	primary_key text;
	
	vanila_column_list text;
	fresh_column_list text;
	existing_column_list text;
	
	null_value_list text;
	not_null_list text;
	where_query_list text;
	
	loop_enum int;
	
	queryText text;

begin

	drop table if exists tempDeltaInsertTable;
	execute 'create local temp table tempDeltaInsertTable as select * from '|| existingTable || ' limit 0';
	
	primary_key := columns[1];
	
	vanila_column_list := array_to_string(columns, ',');
	fresh_column_list := 'fresh.' || array_to_string(columns, ',fresh.');
	existing_column_list := 'existing.' || array_to_string(columns, ',existing.');
	
	null_value_list := 'existing.' || primary_key;
	where_query_list := '';
	not_null_list := ''; 
	
	for loop_enum in 2 .. array_upper( columns,1 ) loop
		null_value_list := null_value_list || ', null';
		where_query_list := where_query_list || 'fresh.' || columns[loop_enum] || ' is distinct from existing.' || columns[loop_enum] || ' or ';
		not_null_list := not_null_list || 'and existing.' || columns[loop_enum] || ' is not null ';
	end loop;
	where_query_list := substring(where_query_list from 0 for char_length(where_query_list)-3) || ' or existing.' || primary_key || ' is null';
	
	if markTombstones
	then	
		-- mark tombstones
		queryText := 'insert into tempDeltaInsertTable ' ||
			'(' || vanila_column_list || ', ' || dtt_column || ') ' ||
			'select ' || null_value_list || ', ' || quote_literal(dtt::text) || ' ' ||
			'from ' || existingTable || ' as existing ' ||
			'left join ' || freshTable || ' as fresh ' ||
			'on fresh.' || primary_key || ' = existing.' || primary_key || ' ' ||
			'where fresh.' || primary_key || ' is null ' || not_null_list;
		execute queryText;		
	end if;	
	
	-- load changed elements
	queryText := 'insert into tempDeltaInsertTable ' || 
		'(' || vanila_column_list || ', ' || dtt_column || ') ' ||
		'select ' || fresh_column_list || ', ' || quote_literal(dtt) || ' ' ||
		'from ' || freshTable || ' as fresh ' ||
		'left join ' || existingTable || ' as existing ' ||
		'on fresh.' || primary_key || ' = existing.' || primary_key || ' ' ||
		'where ' || where_query_list;
	execute queryText;

	return query select * from tempDeltaInsertTable;
	
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION delta(text, text, text[], timestamp, text, boolean) OWNER TO postgres;

