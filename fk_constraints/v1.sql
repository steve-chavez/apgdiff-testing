create schema data;
create table data.tasks (
  id           serial primary key,
  project_id   int not null
);
