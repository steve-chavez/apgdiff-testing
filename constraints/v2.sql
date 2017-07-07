create schema data;
CREATE TABLE data.users (
  firstname text NOT NULL,
  lastname text NOT NULL,
  CONSTRAINT users_firstname_check CHECK (length(firstname) > 2),
  CONSTRAINT users_lastname_check CHECK (length(lastname) > 2)
);
