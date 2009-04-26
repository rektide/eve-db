create table api_sov
(
	id bigserial primary key,
	solarsystemid integer not null,
	allianceid integer,
	const_sov integer,
	sov_level smallint,
	factionid integer,
	entrydate timestamp not null default now()
);

select createDeltaView_mostRecent('api_sov_recent','api_sov',ARRAY['solarsystemid'],'entryDate');

