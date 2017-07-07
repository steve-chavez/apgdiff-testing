create schema data;
create table data.items2 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

alter table data.items2 enable row level security;
