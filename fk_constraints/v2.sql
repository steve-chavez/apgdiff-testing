create schema data;

create table data.projects( id serial primary key );

create table data.tasks (
  id           serial primary key,
  project_id   int not null
);

ALTER TABLE data.tasks ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES data.projects(id);
