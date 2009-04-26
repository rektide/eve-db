-- Function: apiloadsov(text)

-- DROP FUNCTION apiloadsov(text);

CREATE OR REPLACE FUNCTION apiloadsov(text)
  RETURNS SETOF record AS
$BODY$
declare
	
	sov ALIAS FOR $1;
	sovXml xml;
	dtt timestamp;

begin
	
	-- load document
	sovXml := xmlparse(DOCUMENT sov);
	
	-- parse time
	dtt := (( xpath('//eveapi/currentTime/text()', sovXml) )[1])::text::timestamp;
	
	-- create temp table
	drop table if exists tempSovXml;
	create local temp table tempSovXml (id int, doc xml);
	drop table if exists tempSovFresh;
	create local temp table tempSovFresh (like api_sov);
	alter table tempSovFresh drop column id;
	drop table if exists tempSovNew;
	create local temp table tempSovNew (like api_sov);

	drop sequence if exists tempSovNew_id_seq;
	create temp sequence tempSovNew_id_seq;
	alter table tempSovNew alter column id set default nextval('tempSovNew_id_seq');

	-- populate doc table
	insert into tempSovXml values (1, sovXml);
	
	-- load data into table
	insert into tempSovFresh (solarsystemid, allianceid, const_sov, sov_level, factionid, entryDate)
	select solarsystemid::int, allianceid::int, const_sov::int, sov_level::int, factionid::int, dtt
	from xpath_table2
	(
		'id', 'doc', 'tempSovXml',
		'//eveapi/result/rowset/row/@solarSystemID|//eveapi/result/rowset/row/@allianceID|//eveapi/result/rowset/row/@constellationSovereignty|//eveapi/result/rowset/row/@sovereigntyLevel|//eveapi/result/rowset/row/@factionID',
		'1=1'
	)
	as t(id int, solarsystemid text, allianceid text, const_sov text, sov_level text, factionid text);
	
	-- retrieve diffs
	insert into api_sov (solarsystemid, allianceid, const_sov, sov_level, factionid, entryDate)
	select solarsystemid, allianceid, const_sov, sov_level, factionid, entryDate
	from delta(
		'tempSovFresh', 'api_sov_recent', 
		ARRAY['allianceid','const_sov','sov_level','factionid'],
		dtt, 'entryDate', true) 
	as t(id bigint, solarsystemid int, allianceid int, const_sov int, sov_level int, factionid int, entrydate timestamp);

	-- clean up
	drop table tempSovXml;
	drop table tempSovFresh;

	return query select * from api_sov where entryDate = dtt;
	
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION apiloadsov(text) OWNER TO postgres;

