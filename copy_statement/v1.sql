create schema data;
create table data.items3 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);
