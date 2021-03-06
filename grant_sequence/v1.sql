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
