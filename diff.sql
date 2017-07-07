--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: data; Type: SCHEMA; Schema: -; Owner: stevebash
--

CREATE SCHEMA data;


ALTER SCHEMA data OWNER TO stevebash;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = data, pg_catalog;

--
-- Name: private_items(); Type: FUNCTION; Schema: data; Owner: stevebash
--

CREATE FUNCTION private_items() RETURNS SETOF integer
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  select id from data.items where private = true
$$;


ALTER FUNCTION data.private_items() OWNER TO stevebash;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE activities (
    id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE activities OWNER TO stevebash;

--
-- Name: items; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE items (
    id integer NOT NULL,
    name text NOT NULL,
    private boolean DEFAULT true
);


ALTER TABLE items OWNER TO stevebash;

--
-- Name: items2; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE items2 (
    id integer NOT NULL,
    name text NOT NULL,
    private boolean DEFAULT true
);


ALTER TABLE items2 OWNER TO stevebash;

--
-- Name: items2_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE items2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items2_id_seq OWNER TO stevebash;

--
-- Name: items2_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE items2_id_seq OWNED BY items2.id;


--
-- Name: items3; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE items3 (
    id integer NOT NULL,
    name text NOT NULL,
    private boolean DEFAULT true
);


ALTER TABLE items3 OWNER TO stevebash;

--
-- Name: items3_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE items3_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items3_id_seq OWNER TO stevebash;

--
-- Name: items3_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE items3_id_seq OWNED BY items3.id;


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items_id_seq OWNER TO stevebash;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: projects; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE projects (
    id integer NOT NULL
);


ALTER TABLE projects OWNER TO stevebash;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO stevebash;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: sub_items; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE sub_items (
    id integer NOT NULL
);


ALTER TABLE sub_items OWNER TO stevebash;

--
-- Name: sub_items_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE sub_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sub_items_id_seq OWNER TO stevebash;

--
-- Name: sub_items_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE sub_items_id_seq OWNED BY sub_items.id;


--
-- Name: tasks; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE tasks (
    id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE tasks OWNER TO stevebash;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: data; Owner: stevebash
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tasks_id_seq OWNER TO stevebash;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: stevebash
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: data; Owner: stevebash
--

CREATE TABLE users (
    firstname text NOT NULL,
    lastname text NOT NULL,
    CONSTRAINT users_firstname_check CHECK ((length(firstname) > 2)),
    CONSTRAINT users_lastname_check CHECK ((length(lastname) > 2))
);


ALTER TABLE users OWNER TO stevebash;

--
-- Name: items id; Type: DEFAULT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: items2 id; Type: DEFAULT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items2 ALTER COLUMN id SET DEFAULT nextval('items2_id_seq'::regclass);


--
-- Name: items3 id; Type: DEFAULT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items3 ALTER COLUMN id SET DEFAULT nextval('items3_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY activities (id, project_id) FROM stdin;
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY items (id, name, private) FROM stdin;
\.


--
-- Data for Name: items2; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY items2 (id, name, private) FROM stdin;
\.


--
-- Name: items2_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('items2_id_seq', 1, false);


--
-- Data for Name: items3; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY items3 (id, name, private) FROM stdin;
\.


--
-- Name: items3_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('items3_id_seq', 1, false);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('items_id_seq', 1, false);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY projects (id) FROM stdin;
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('projects_id_seq', 1, false);


--
-- Data for Name: sub_items; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY sub_items (id) FROM stdin;
\.


--
-- Name: sub_items_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('sub_items_id_seq', 1, false);


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY tasks (id, project_id) FROM stdin;
\.


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: data; Owner: stevebash
--

SELECT pg_catalog.setval('tasks_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: data; Owner: stevebash
--

COPY users (firstname, lastname) FROM stdin;
\.


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id, project_id);


--
-- Name: items2 items2_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items2
    ADD CONSTRAINT items2_pkey PRIMARY KEY (id);


--
-- Name: items3 items3_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items3
    ADD CONSTRAINT items3_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: stevebash
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: items2; Type: ROW SECURITY; Schema: data; Owner: stevebash
--

ALTER TABLE items2 ENABLE ROW LEVEL SECURITY;

--
-- Name: private_items(); Type: ACL; Schema: data; Owner: stevebash
--

GRANT ALL ON FUNCTION private_items() TO webuser;


--
-- PostgreSQL database dump complete
--

