-- Function: xpath_table2(text, text, text, text, text)

-- DROP FUNCTION xpath_table2(text, text, text, text, text);

CREATE OR REPLACE FUNCTION xpath_table2("key" text, "document" text, relation text, xpaths text, criterea text)
  RETURNS SETOF record AS
$BODY$
declare
	paths text[];
	matchSet xml[];
	matches xml[][];
	max_match int;
	cols text;
	vals text;

begin
	-- decompose xpaths list
	paths := regexp_split_to_array(xpaths, E'\\|');

	-- craft table
	drop table if exists datum;
	create local temp table datum (key_column serial);
	execute 'alter table datum rename column key_column to ' || key;

	-- query all xpaths
	max_match := 0;
	cols := '';
	matches = '{}';
	for i in array_lower(paths,1)..array_upper(paths,1) loop
		-- load matches
		execute 'select xpath(''' || paths[i] || ''',' || document || ') from ' || relation INTO matchSet;
		matches := matches || ARRAY[matchSet];
		-- grow table
		execute 'alter table datum add column d' || i::text || ' text';
		-- account column
		cols := cols || 'd' || i::text || ',';
		-- identify largest results
		if max_match < array_upper(matchSet,1) then
			max_match := array_upper(matchSet,1);
		end if;
	end loop;
	cols := substring(cols from 0 for char_length(cols));

	-- collate results
	for i in 1..max_match loop

		-- build insert values
		vals := '';
		for j in 1..array_upper(paths,1) loop
			vals := vals || quote_literal(matches[j][i]) || ',';
		end loop;
		vals := substring(vals from 0 for char_length(vals));

		-- load in values
		execute 'insert into datum (' || cols || ') values(' || vals || ')';
		
	end loop;

	vals := 'select * from datum';
	if char_length(criterea) > 0 then
		vals := vals || ' where ' || criterea;
	end if;
	--return query execute vals; -- requires return query execute from 8.4 ???
	RETURN QUERY select * from datum;
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION xpath_table2(text, text, text, text, text) OWNER TO postgres;

