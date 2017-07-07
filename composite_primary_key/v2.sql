create schema data;
create table data.activities (
  id           int not null,
  project_id   int not null
);

ALTER TABLE ONLY data.activities ADD CONSTRAINT activities_pkey PRIMARY KEY (id, project_id);

