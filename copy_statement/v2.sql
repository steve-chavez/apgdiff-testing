create schema data;
create table data.items3 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

COPY data.items3 (id,name,private) FROM STDIN (FREEZE ON);
1	item_1	FALSE	1
2	item_2	TRUE	1
3	item_3	FALSE	1
4	item_4	TRUE	2
5	item_5	TRUE	2
6	item_6	FALSE	2
\.
