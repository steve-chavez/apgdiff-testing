
CREATE SEQUENCE task_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;
REVOKE ALL ON TABLE task_id_seq FROM webuser;
GRANT USAGE ON TABLE task_id_seq TO webuser;
