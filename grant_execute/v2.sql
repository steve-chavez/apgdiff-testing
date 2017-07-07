create schema data;
create table data.items (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

create or replace function data.private_items() returns setof int as $$
  select id from data.items where private = true
$$ stable security definer language sql;

create role webuser;
-- grant execute on function data.private_items() to webuser;
GRANT ALL ON FUNCTION data.private_items() TO webuser;