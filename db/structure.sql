SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: test-organization; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "test-organization";


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: board_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.board_lists (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ordinal_number integer,
    project_id bigint
);


--
-- Name: board_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.board_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: board_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.board_lists_id_seq OWNED BY public.board_lists.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    issue_id bigint,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    name character varying NOT NULL,
    file character varying NOT NULL,
    folder_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    title character varying NOT NULL,
    all_day boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    description text
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.folders (
    id bigint NOT NULL,
    name character varying NOT NULL,
    folder_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: folders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.folders_id_seq OWNED BY public.folders.id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issues (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying NOT NULL,
    description text,
    user_id bigint,
    complexity numeric(4,1),
    board_list_id integer NOT NULL,
    ordinal_number integer
);


--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issues_id_seq OWNED BY public.issues.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    time_zone character varying NOT NULL,
    time_zone_seconds integer
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.records (
    id bigint NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    user_id bigint,
    issue_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_record_days; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.project_record_days AS
 SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date AS day,
    board_lists.project_id
   FROM (((public.records
     JOIN public.issues ON ((issues.id = records.issue_id)))
     JOIN public.board_lists ON ((board_lists.id = issues.board_list_id)))
     JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
  GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date), board_lists.project_id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: record_days; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.record_days AS
 SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date AS day,
    records.user_id
   FROM (public.records
     JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
  GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date), records.user_id;


--
-- Name: records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.records_id_seq OWNED BY public.records.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    firstname character varying,
    lastname character varying,
    gender integer,
    avatar character varying,
    selected_project_id integer,
    telephone_number character varying,
    type character varying NOT NULL
);


--
-- Name: user_issues; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.user_issues AS
 SELECT users.id AS user_id,
    issues.id AS issue_id,
    sum((records.end_time - records.start_time)) AS spent_time,
    min(records.start_time) AS start_time
   FROM ((public.users
     JOIN public.records ON ((records.user_id = users.id)))
     JOIN public.issues ON ((issues.id = records.issue_id)))
  GROUP BY users.id, issues.id;


--
-- Name: user_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_projects (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_projects_id_seq OWNED BY public.user_projects.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wiki_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_categories (
    id bigint NOT NULL,
    title character varying,
    wiki_category_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_categories_id_seq OWNED BY public.wiki_categories.id;


--
-- Name: wiki_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wiki_pages (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    wiki_category_id bigint NOT NULL,
    content text
);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wiki_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wiki_pages_id_seq OWNED BY public.wiki_pages.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: board_lists; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".board_lists (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ordinal_number integer,
    project_id bigint
);


--
-- Name: board_lists_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".board_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: board_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".board_lists_id_seq OWNED BY "test-organization".board_lists.id;


--
-- Name: comments; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".comments (
    id bigint NOT NULL,
    issue_id bigint,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".comments_id_seq OWNED BY "test-organization".comments.id;


--
-- Name: documents; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".documents (
    id bigint NOT NULL,
    name character varying NOT NULL,
    file character varying NOT NULL,
    folder_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".documents_id_seq OWNED BY "test-organization".documents.id;


--
-- Name: events; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".events (
    id bigint NOT NULL,
    title character varying NOT NULL,
    all_day boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    description text
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".events_id_seq OWNED BY "test-organization".events.id;


--
-- Name: folders; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".folders (
    id bigint NOT NULL,
    name character varying NOT NULL,
    folder_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: folders_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: folders_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".folders_id_seq OWNED BY "test-organization".folders.id;


--
-- Name: issues; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".issues (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying NOT NULL,
    description text,
    user_id bigint,
    complexity numeric(4,1),
    board_list_id integer NOT NULL,
    ordinal_number integer
);


--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".issues_id_seq OWNED BY "test-organization".issues.id;


--
-- Name: organizations; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".organizations (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    time_zone character varying NOT NULL,
    time_zone_seconds integer
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".organizations_id_seq OWNED BY "test-organization".organizations.id;


--
-- Name: records; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".records (
    id bigint NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    user_id bigint,
    issue_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_record_days; Type: VIEW; Schema: test-organization; Owner: -
--

CREATE VIEW "test-organization".project_record_days AS
 SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date AS day,
    board_lists.project_id
   FROM ((("test-organization".records
     JOIN "test-organization".issues ON ((issues.id = records.issue_id)))
     JOIN "test-organization".board_lists ON ((board_lists.id = issues.board_list_id)))
     JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
  GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date), board_lists.project_id;


--
-- Name: projects; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".projects (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".projects_id_seq OWNED BY "test-organization".projects.id;


--
-- Name: record_days; Type: VIEW; Schema: test-organization; Owner: -
--

CREATE VIEW "test-organization".record_days AS
 SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date AS day,
    records.user_id
   FROM ("test-organization".records
     JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
  GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * '00:00:01'::interval)))::date), records.user_id;


--
-- Name: records_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".records_id_seq OWNED BY "test-organization".records.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    firstname character varying,
    lastname character varying,
    gender integer,
    avatar character varying,
    selected_project_id integer,
    telephone_number character varying,
    type character varying NOT NULL
);


--
-- Name: user_issues; Type: VIEW; Schema: test-organization; Owner: -
--

CREATE VIEW "test-organization".user_issues AS
 SELECT users.id AS user_id,
    issues.id AS issue_id,
    sum((records.end_time - records.start_time)) AS spent_time,
    min(records.start_time) AS start_time
   FROM (("test-organization".users
     JOIN "test-organization".records ON ((records.user_id = users.id)))
     JOIN "test-organization".issues ON ((issues.id = records.issue_id)))
  GROUP BY users.id, issues.id;


--
-- Name: user_projects; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".user_projects (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_projects_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".user_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".user_projects_id_seq OWNED BY "test-organization".user_projects.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".users_id_seq OWNED BY "test-organization".users.id;


--
-- Name: wiki_categories; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".wiki_categories (
    id bigint NOT NULL,
    title character varying,
    wiki_category_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_categories_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".wiki_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".wiki_categories_id_seq OWNED BY "test-organization".wiki_categories.id;


--
-- Name: wiki_pages; Type: TABLE; Schema: test-organization; Owner: -
--

CREATE TABLE "test-organization".wiki_pages (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    wiki_category_id bigint NOT NULL,
    content text
);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE; Schema: test-organization; Owner: -
--

CREATE SEQUENCE "test-organization".wiki_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: test-organization; Owner: -
--

ALTER SEQUENCE "test-organization".wiki_pages_id_seq OWNED BY "test-organization".wiki_pages.id;


--
-- Name: board_lists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_lists ALTER COLUMN id SET DEFAULT nextval('public.board_lists_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folders_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues ALTER COLUMN id SET DEFAULT nextval('public.issues_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.records ALTER COLUMN id SET DEFAULT nextval('public.records_id_seq'::regclass);


--
-- Name: user_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_projects ALTER COLUMN id SET DEFAULT nextval('public.user_projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wiki_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_categories ALTER COLUMN id SET DEFAULT nextval('public.wiki_categories_id_seq'::regclass);


--
-- Name: wiki_pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_pages ALTER COLUMN id SET DEFAULT nextval('public.wiki_pages_id_seq'::regclass);


--
-- Name: board_lists id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".board_lists ALTER COLUMN id SET DEFAULT nextval('"test-organization".board_lists_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".comments ALTER COLUMN id SET DEFAULT nextval('"test-organization".comments_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".documents ALTER COLUMN id SET DEFAULT nextval('"test-organization".documents_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".events ALTER COLUMN id SET DEFAULT nextval('"test-organization".events_id_seq'::regclass);


--
-- Name: folders id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".folders ALTER COLUMN id SET DEFAULT nextval('"test-organization".folders_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".issues ALTER COLUMN id SET DEFAULT nextval('"test-organization".issues_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".organizations ALTER COLUMN id SET DEFAULT nextval('"test-organization".organizations_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".projects ALTER COLUMN id SET DEFAULT nextval('"test-organization".projects_id_seq'::regclass);


--
-- Name: records id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".records ALTER COLUMN id SET DEFAULT nextval('"test-organization".records_id_seq'::regclass);


--
-- Name: user_projects id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".user_projects ALTER COLUMN id SET DEFAULT nextval('"test-organization".user_projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".users ALTER COLUMN id SET DEFAULT nextval('"test-organization".users_id_seq'::regclass);


--
-- Name: wiki_categories id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".wiki_categories ALTER COLUMN id SET DEFAULT nextval('"test-organization".wiki_categories_id_seq'::regclass);


--
-- Name: wiki_pages id; Type: DEFAULT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".wiki_pages ALTER COLUMN id SET DEFAULT nextval('"test-organization".wiki_pages_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: board_lists board_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_lists
    ADD CONSTRAINT board_lists_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_projects user_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_projects
    ADD CONSTRAINT user_projects_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wiki_categories wiki_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_categories
    ADD CONSTRAINT wiki_categories_pkey PRIMARY KEY (id);


--
-- Name: wiki_pages wiki_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wiki_pages
    ADD CONSTRAINT wiki_pages_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: board_lists board_lists_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".board_lists
    ADD CONSTRAINT board_lists_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_projects user_projects_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".user_projects
    ADD CONSTRAINT user_projects_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wiki_categories wiki_categories_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".wiki_categories
    ADD CONSTRAINT wiki_categories_pkey PRIMARY KEY (id);


--
-- Name: wiki_pages wiki_pages_pkey; Type: CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".wiki_pages
    ADD CONSTRAINT wiki_pages_pkey PRIMARY KEY (id);


--
-- Name: index_board_lists_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_board_lists_on_project_id ON public.board_lists USING btree (project_id);


--
-- Name: index_comments_on_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_issue_id ON public.comments USING btree (issue_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_documents_on_folder_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_folder_id ON public.documents USING btree (folder_id);


--
-- Name: index_folders_on_folder_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_folders_on_folder_id ON public.folders USING btree (folder_id);


--
-- Name: index_issues_on_board_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_issues_on_board_list_id ON public.issues USING btree (board_list_id);


--
-- Name: index_issues_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_issues_on_user_id ON public.issues USING btree (user_id);


--
-- Name: index_organizations_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_organizations_on_name ON public.organizations USING btree (name);


--
-- Name: index_records_on_issue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_records_on_issue_id ON public.records USING btree (issue_id);


--
-- Name: index_records_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_records_on_user_id ON public.records USING btree (user_id);


--
-- Name: index_user_projects_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_projects_on_project_id ON public.user_projects USING btree (project_id);


--
-- Name: index_user_projects_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_projects_on_user_id ON public.user_projects USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_selected_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_selected_project_id ON public.users USING btree (selected_project_id);


--
-- Name: index_wiki_categories_on_wiki_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_categories_on_wiki_category_id ON public.wiki_categories USING btree (wiki_category_id);


--
-- Name: index_wiki_pages_on_wiki_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wiki_pages_on_wiki_category_id ON public.wiki_pages USING btree (wiki_category_id);


--
-- Name: unique_active_record_per_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_active_record_per_user ON public.records USING btree (user_id) WHERE (end_time IS NULL);


--
-- Name: index_board_lists_on_project_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_board_lists_on_project_id ON "test-organization".board_lists USING btree (project_id);


--
-- Name: index_comments_on_issue_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_comments_on_issue_id ON "test-organization".comments USING btree (issue_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_comments_on_user_id ON "test-organization".comments USING btree (user_id);


--
-- Name: index_documents_on_folder_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_documents_on_folder_id ON "test-organization".documents USING btree (folder_id);


--
-- Name: index_folders_on_folder_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_folders_on_folder_id ON "test-organization".folders USING btree (folder_id);


--
-- Name: index_issues_on_board_list_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_issues_on_board_list_id ON "test-organization".issues USING btree (board_list_id);


--
-- Name: index_issues_on_user_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_issues_on_user_id ON "test-organization".issues USING btree (user_id);


--
-- Name: index_organizations_on_name; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE UNIQUE INDEX index_organizations_on_name ON "test-organization".organizations USING btree (name);


--
-- Name: index_records_on_issue_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_records_on_issue_id ON "test-organization".records USING btree (issue_id);


--
-- Name: index_records_on_user_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_records_on_user_id ON "test-organization".records USING btree (user_id);


--
-- Name: index_user_projects_on_project_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_user_projects_on_project_id ON "test-organization".user_projects USING btree (project_id);


--
-- Name: index_user_projects_on_user_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_user_projects_on_user_id ON "test-organization".user_projects USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON "test-organization".users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON "test-organization".users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON "test-organization".users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON "test-organization".users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON "test-organization".users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON "test-organization".users USING btree (reset_password_token);


--
-- Name: index_users_on_selected_project_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_users_on_selected_project_id ON "test-organization".users USING btree (selected_project_id);


--
-- Name: index_wiki_categories_on_wiki_category_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_wiki_categories_on_wiki_category_id ON "test-organization".wiki_categories USING btree (wiki_category_id);


--
-- Name: index_wiki_pages_on_wiki_category_id; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE INDEX index_wiki_pages_on_wiki_category_id ON "test-organization".wiki_pages USING btree (wiki_category_id);


--
-- Name: unique_active_record_per_user; Type: INDEX; Schema: test-organization; Owner: -
--

CREATE UNIQUE INDEX unique_active_record_per_user ON "test-organization".records USING btree (user_id) WHERE (end_time IS NULL);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: issues fk_rails_14989b278a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT fk_rails_14989b278a FOREIGN KEY (board_list_id) REFERENCES public.board_lists(id);


--
-- Name: documents fk_rails_404da7ca3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_404da7ca3d FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- Name: records fk_rails_6f771fa596; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_rails_6f771fa596 FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: records fk_rails_9ba3ba9afc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_rails_9ba3ba9afc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: board_lists fk_rails_c76f6a3cd9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_lists
    ADD CONSTRAINT fk_rails_c76f6a3cd9 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: users fk_rails_cbf756aaae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_cbf756aaae FOREIGN KEY (selected_project_id) REFERENCES public.projects(id);


--
-- Name: folders fk_rails_f5f7a22451; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT fk_rails_f5f7a22451 FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES "test-organization".users(id);


--
-- Name: issues fk_rails_14989b278a; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".issues
    ADD CONSTRAINT fk_rails_14989b278a FOREIGN KEY (board_list_id) REFERENCES "test-organization".board_lists(id);


--
-- Name: documents fk_rails_404da7ca3d; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".documents
    ADD CONSTRAINT fk_rails_404da7ca3d FOREIGN KEY (folder_id) REFERENCES "test-organization".folders(id);


--
-- Name: records fk_rails_6f771fa596; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".records
    ADD CONSTRAINT fk_rails_6f771fa596 FOREIGN KEY (issue_id) REFERENCES "test-organization".issues(id) ON DELETE SET NULL;


--
-- Name: records fk_rails_9ba3ba9afc; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".records
    ADD CONSTRAINT fk_rails_9ba3ba9afc FOREIGN KEY (user_id) REFERENCES "test-organization".users(id);


--
-- Name: board_lists fk_rails_c76f6a3cd9; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".board_lists
    ADD CONSTRAINT fk_rails_c76f6a3cd9 FOREIGN KEY (project_id) REFERENCES "test-organization".projects(id);


--
-- Name: users fk_rails_cbf756aaae; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".users
    ADD CONSTRAINT fk_rails_cbf756aaae FOREIGN KEY (selected_project_id) REFERENCES "test-organization".projects(id);


--
-- Name: folders fk_rails_f5f7a22451; Type: FK CONSTRAINT; Schema: test-organization; Owner: -
--

ALTER TABLE ONLY "test-organization".folders
    ADD CONSTRAINT fk_rails_f5f7a22451 FOREIGN KEY (folder_id) REFERENCES "test-organization".folders(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20171119171745'),
('20171125155017'),
('20171126130309'),
('20171126132245'),
('20171202104524'),
('20171202173355'),
('20171202181601'),
('20171203000209'),
('20171208220639'),
('20171209113515'),
('20171209115742'),
('20171224182744'),
('20171225005147'),
('20171225015530'),
('20180106231149'),
('20180109225641'),
('20180129200937'),
('20180216175602'),
('20180325135819'),
('20180429133109'),
('20180503232032'),
('20180508010259'),
('20180510222857'),
('20180512104724'),
('20180512173350'),
('20180512173936'),
('20180512174745'),
('20180513040723'),
('20180513040925'),
('20180519220707'),
('20180520123954'),
('20180524223242'),
('20180524232615'),
('20180607014617'),
('20180608134221'),
('20180608142000'),
('20180708115054'),
('20180801003653'),
('20180804230316'),
('20180811165408'),
('20180812122047'),
('20180814165717'),
('20180817170637'),
('20180828211000'),
('20180902121451'),
('20180902132847'),
('20180902142751'),
('20180925204755'),
('20181020171506'),
('20181029193456'),
('20181030184844');


