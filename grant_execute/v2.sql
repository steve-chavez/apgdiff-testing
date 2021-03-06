create schema data;
create table data.items (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

grant select, insert, update, delete on api.subitems to webuser;
