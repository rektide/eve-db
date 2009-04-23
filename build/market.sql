drop table if exists market;
create table market (
	id serial primary key,
	dtt timestamp default now(),
	typeid integer,
	buy_price integer,
	sell_price integer,
	volume integer
);

grant select, insert on table market to eve;
grant select on table market to eve_readonly;

ALTER TABLE market OWNER TO eve_admin;