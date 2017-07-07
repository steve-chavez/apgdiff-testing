
# Pgdiff testing

Some apgdiff tests

## Constraints

Can only handle typical constraint syntax:

Success:
```sql
-- v1.sql
create table data.users (  
  firstname text not null,
  CONSTRAINT users_firstname_check CHECK (length(firstname) > 2)
);
-- v2.sql
CREATE TABLE data.users (
  firstname text NOT NULL,
  lastname text NOT NULL,
  CONSTRAINT users_firstname_check CHECK (length(firstname) > 2),
  CONSTRAINT users_lastname_check CHECK (length(lastname) > 2)
);
```

Fail: 
```sql
-- v1.sql
create table data.users (  
  firstname            text not null,
  check (length(firstname)>2)
);
-- v2.sql
create table data.users (
  firstname            text not null,
  lastname             text not null,
  check (length(firstname)>2),
  check (length(lastname)>2)
);
-- diff.sql
SET search_path = data, pg_catalog;

ALTER TABLE users
  ADD COLUMN lastname text NOT NULL,
  ALTER COLUMN "check" TYPE (length(lastname)>2)
```

## Foreign key constraints

Can handle explicit fk constraints, cannot handle inline references foreign key

Success:
```sql
-- v1.sql
create schema data;
create table data.tasks (
  id           serial primary key,
  project_id   int not null
);
-- v2.sql
create schema data;

create table data.projects( id serial primary key );

create table data.tasks (
  id           serial primary key,
  project_id   int not null
);

ALTER TABLE data.tasks ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES data.projects(id);
-- diff.sql
SET search_path = data, pg_catalog;

CREATE TABLE projects (
        id serial primary key
);
ALTER TABLE tasks
        ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES data.projects(id);
```

Fail:
```sql
-- v1.sql
create schema data;
create table data.tasks (
  id           serial primary key,
  project_id   int
);
-- v2.sql
create schema data;
create table data.projects( id serial primary key );
create table data.tasks (
  id           serial primary key,
  project_id   int references data.projects(id)
);
-- diff.sql
SET search_path = data, pg_catalog;
CREATE TABLE projects (
  id serial primary key
);
ALTER TABLE tasks
        ALTER COLUMN project_id TYPE int references data.projects(id)
-- ERROR:  42601: syntax error at or near "references"
```

## Composite primary key

Cannot handle in table ```primary key(key1, key2)```, the ```CONSTRAINT``` must be explicit.

Success:
```sql
-- v1.sql
create schema data;
create table data.activities (
  id           int not null,
  project_id   int not null
);
-- v2.sql
create schema data;
create table data.activities (
  id           int not null,
  project_id   int not null
);

ALTER TABLE ONLY data.activities ADD CONSTRAINT activities_pkey PRIMARY KEY (id, project_id);
-- diff.sql
SET search_path = data, pg_catalog;

ALTER TABLE activities
        ADD CONSTRAINT activities_pkey PRIMARY KEY (id, project_id);
```

Fail:
```sql
-- v1.sql
create schema data;
create table data.activities (
  id           int not null,
  project_id   int not null
);
-- v2.sql
create schema data;
create table data.activities (
  id           int not null,
  project_id   int not null,
  primary key(id, project_id)
);
-- diff.sql
Expected KEY at position 100 'key(id, project_id)
```

## RLS

Enabling RLS doesn't work

Fail:
```sql
-- v1.sql
create schema data;
create table data.items2 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);
-- v2.sql
create schema data;
create table data.items2 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);

alter table data.items2 enable row level security;
-- diff.sql
Exception in thread "main" cz.startnet.utils.pgdiff.parsers.ParserException: Cannot parse string: alter table data.items2 enable row level security;
Expected , at position 32 'row level security'
```

## Grant sequence

It works with explicit ```CREATE SEQUENCE```.

Success:
```sql
-- v1.sql
create schema data;
create table data.sub_items (
  id           integer not null
);

CREATE SEQUENCE data.sub_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE data.sub_items_id_seq OWNED BY data.sub_items.id;
-- v2.sql
create schema data;
create table data.sub_items (
  id           integer not null
);

CREATE SEQUENCE data.sub_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE data.sub_items_id_seq OWNED BY data.sub_items.id;

create role webuser;
grant usage on sequence data.sub_items_id_seq to webuser;
-- diff.sql
REVOKE ALL ON SEQUENCE sub_items_id_seq FROM webuser;
GRANT USAGE ON SEQUENCE sub_items_id_seq TO webuser;
```

Fail:
```sql
-- v1.sql
create schema data;
create table data.sub_items (
  id           serial primary key,
);
-- v2.sql
create schema data;
create table data.sub_items (
  id           serial primary key,
);
create role webuser;
grant usage on sequence data.sub_items_id_seq to webuser;
-- diff.sql
Exception in thread "main" java.lang.RuntimeException: Cannot find sequence 'data.sub_items_id_seq' for statement 'grant usage on sequence data.sub_items_id_se
q to webuser;'. Missing CREATE SEQUENCE?
```

## Copy statement

Doesn't work.

Fail:
```sql
-- v1.sql
create schema data;
create table data.items3 (
	id    serial primary key,
	name  text not null,
	private boolean default true
);
-- v2.sql
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
-- diff.sql
Exception in thread "main" java.lang.RuntimeException: Cannot find ending semicolon of statement: 1     item_1  FALSE   1
2       item_2  TRUE    1
3       item_3  FALSE   1
4       item_4  TRUE    2
5       item_5  TRUE    2
6       item_6  FALSE   2
\.
```

## Triggers

Works ok.

## Functions

Works ok.

## Slash commands

Every slash command must be ended with a ```;``` to be successfully ignored, otherwise it'll err

Fail
```sql
-- v1.sql
\echo # Loading roles
\set authenticator `echo $DB_USER`
-- v2.sql
\echo # Loading roles;
\set authenticator `echo $DB_USER`
\set authenticator_pass `echo $DB_PASS`
-- diff.sql
Exception in thread "main" java.lang.RuntimeException: Cannot find ending semicolon of statement: \echo # Loading roles
```
