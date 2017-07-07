create schema data;
create table data.items (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

create role webuser;
grant select on data.items to webuser;
