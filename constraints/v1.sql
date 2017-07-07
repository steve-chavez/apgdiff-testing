create schema data;
create table data.users (  
  firstname text not null,
  CONSTRAINT users_firstname_check CHECK (length(firstname) > 2)
);
