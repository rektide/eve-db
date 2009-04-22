-- Function: delta(text, text, text[], timestamp without time zone, text, boolean)

-- DROP FUNCTION delta(text, text, text[], timestamp without time zone, text, boolean);

CREATE OR REPLACE FUNCTION delta(freshdata text, existingdata text, columns text[], dtt timestamp without time zone, dtt_column text, marktombstones boolean)
  RETURNS SETOF record AS
$BODY$
declare

	primary_key text;
	vanila_column_list text;
	fresh_column_list text;
	existing_column_list text;
	null_value_list text;
	where_query_list text;
	tt text;
	
	loop_enum int;
	
	queryText text;

	
	bonusQuery text;
	fresh_count int;
	fresh_count2 int;
	fresh_count3 int;
	

begin

	drop table if exists tempDeltaInsertTable;
	execute 'create local temp table tempDeltaInsertTable as select * from '|| existingData || ' limit 0';
	
	primary_key := columns[1];
	
	vanila_column_list := array_to_string(columns, ',');
	fresh_column_list := 'fresh.' || array_to_string(columns, ',fresh.');
	existing_column_list := 'existing.' || array_to_string(columns, ',existing.');
	
	loop_enum := array_upper( columns,1 );
	null_value_list := 'existing.' || primary_key;
	where_query_list := '';
	while loop_enum > 1 
	loop
		null_value_list := null_value_list || ', null';
		where_query_list := where_query_list || 'fresh.' || columns[loop_enum] || ' <> existing.' || columns[loop_enum] || ' or ';
		loop_enum := loop_enum - 1;
	end loop;
	where_query_list := substring(where_query_list from 0 for char_length(where_query_list)-3);
	
	if markTombstones
	then	
		-- mark tombstones
		queryText := 'insert into tempDeltaInsertTable ' ||
			'(' || vanila_column_list || ', ' || dtt_column || ') ' ||
			'select ' || null_value_list || ', ' || quote_literal(dtt::text) || ' ' ||
			'from ' || existingData || ' as existing ' ||
			'left join ' || freshData || ' as fresh ' ||
			'on fresh.' || primary_key || ' = existing.' || primary_key || ' ' ||
			'where fresh.' || primary_key || ' is null';

		raise notice 'TOMBSTONE %', queryText;
		execute queryText;
	end if;	
	
	
	-- load changed elements
	queryText := 'insert into tempDeltaInsertTable ' || 
		'(' || vanila_column_list || ', ' || dtt_column || ') ' ||
		'select ' || fresh_column_list || ', ' || quote_literal(dtt) || ' ' ||
		'from ' || freshData || ' as fresh ' ||
		'left join ' || existingData || ' as existing ' ||
		'on fresh.' || primary_key || ' = existing.' || primary_key || ' ' ||
		'where ' || where_query_list;

	execute queryText;


	bonusQuery := 'select count(*) ' ||
		'from ' || freshData || ' as fresh ' ||
		'left join ' || existingData || ' as existing ' ||
		'on fresh.' || primary_key || ' = existing.' || primary_key || ' ' ||
		'where ' || where_query_list;

	execute bonusQuery into fresh_count2;

	execute 'select count(*) from ' || freshData into fresh_count;
	--execute 'select count(*) from tempDeltaInsertTable' into fresh_count;
	raise notice 'DELTA % % % %', fresh_count2, (select count(*) from tempSovFresh), (select count(*) from tempDeltaInsertTable), queryText;

	return query select * from tempDeltaInsertTable;
	
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION delta(text, text, text[], timestamp without time zone, text, boolean) OWNER TO postgres;

