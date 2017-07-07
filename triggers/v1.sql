create schema data;
create table data.items ( -- df: mult=3.0
	id    serial primary key,
	name  text not null,
	private boolean default true,  
	owner_id int references data.users(id) default request.user_id()
);

create or replace function data.send_message(
	channel text,
	routing_key text,
	message text) returns void as $$
     
	select	pg_notify(
		channel,	
    routing_key || '|' || message
	);
$$ stable language sql;

create or replace function data.on_row_change() returns trigger as $$
  declare
    routing_key text;
    row record;
  begin
    routing_key := 'row_change'
                   '.table-'::text || TG_TABLE_NAME::text || 
                   '.event-'::text || TG_OP::text;
    if (TG_OP = 'DELETE') then
        row := old;
    elsif (TG_OP = 'UPDATE') then
        row := new;
    elsif (TG_OP = 'INSERT') then
        row := new;
    end if;
    perform data.send_message('app_events', routing_key, row_to_json(row)::text);
    return null;
  end;
$$ stable language plpgsql;

create trigger send_change_event
after insert or update on data.items
for each row execute procedure rabbitmq.on_row_change();
