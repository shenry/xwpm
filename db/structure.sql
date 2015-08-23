--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachments (
    id integer NOT NULL,
    asset character varying,
    parent_id integer,
    parent_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying DEFAULT ''::character varying,
    description text DEFAULT ''::text
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: back_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE back_labels (
    id integer NOT NULL,
    vendor_id integer,
    item_number character varying,
    height character varying,
    width character varying,
    units character varying,
    material character varying,
    alc character varying,
    upc character varying,
    rewind character varying,
    cut character varying,
    "position" character varying,
    treatment character varying,
    artwork_source character varying,
    image character varying,
    artwork character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 0,
    aasm_state character varying
);


--
-- Name: back_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE back_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: back_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE back_labels_id_seq OWNED BY back_labels.id;


--
-- Name: bottles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bottles (
    id integer NOT NULL,
    item_number character varying,
    mould character varying,
    shape character varying,
    color character varying,
    height character varying,
    width character varying,
    neck_diameter character varying,
    units character varying,
    finish character varying,
    fill_point character varying,
    capacity integer,
    capacity_units character varying,
    bottles_per_case character varying,
    case_dimensions character varying,
    pallet_config character varying,
    case_weight character varying,
    image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 0,
    aasm_state character varying
);


--
-- Name: bottles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bottles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bottles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bottles_id_seq OWNED BY bottles.id;


--
-- Name: capsules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE capsules (
    id integer NOT NULL,
    item_number character varying,
    height character varying,
    width character varying,
    units character varying,
    material character varying,
    color character varying,
    has_artwork boolean DEFAULT false NOT NULL,
    image character varying,
    artwork character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 0,
    aasm_state character varying
);


--
-- Name: capsules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE capsules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: capsules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE capsules_id_seq OWNED BY capsules.id;


--
-- Name: closures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE closures (
    id integer NOT NULL,
    type character varying,
    item_number character varying,
    material character varying,
    color character varying,
    height character varying,
    width character varying,
    units character varying,
    has_artwork boolean DEFAULT false NOT NULL,
    artwork character varying,
    image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 0,
    aasm_state character varying
);


--
-- Name: closures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE closures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: closures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE closures_id_seq OWNED BY closures.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    project_id integer,
    author_id integer,
    body text DEFAULT ''::text NOT NULL,
    actionable boolean DEFAULT false NOT NULL,
    resolved boolean DEFAULT false NOT NULL,
    resolver_id integer,
    resolved_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: component_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE component_events (
    id integer NOT NULL,
    packageable_id integer,
    packageable_type character varying,
    actionable_id integer,
    actionable_type character varying,
    delta double precision,
    user_id integer,
    type character varying
);


--
-- Name: component_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE component_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: component_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE component_events_id_seq OWNED BY component_events.id;


--
-- Name: component_requirements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE component_requirements (
    id integer NOT NULL,
    project_id integer,
    packageable_id integer,
    packageable_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying
);


--
-- Name: component_requirements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE component_requirements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: component_requirements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE component_requirements_id_seq OWNED BY component_requirements.id;


--
-- Name: components; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE components (
    id integer NOT NULL,
    wine_id integer,
    lot_number character varying,
    volume integer,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cogs double precision,
    appellation_percent double precision DEFAULT 100.0,
    vintage_percent double precision DEFAULT 100.0,
    variety_percent double precision DEFAULT 100.0
);


--
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE components_id_seq OWNED BY components.id;


--
-- Name: firms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    type character varying,
    name character varying DEFAULT ''::character varying NOT NULL,
    description character varying DEFAULT ''::character varying NOT NULL,
    contact_name character varying,
    contact_email character varying,
    contact_phone character varying,
    address_line_1 character varying,
    address_line_2 character varying,
    city character varying,
    state character varying,
    zip character varying,
    bond character varying,
    account_number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    projects_count integer
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(50),
    scope character varying,
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: front_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE front_labels (
    id integer NOT NULL,
    item_number character varying,
    height character varying,
    width character varying,
    units character varying,
    material character varying,
    alc character varying,
    upc character varying,
    rewind character varying,
    cut character varying,
    "position" character varying,
    treatment character varying,
    artwork_source character varying,
    image character varying,
    artwork character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 0,
    aasm_state character varying
);


--
-- Name: front_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE front_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: front_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE front_labels_id_seq OWNED BY front_labels.id;


--
-- Name: packaging_component_orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE packaging_component_orders (
    id integer NOT NULL,
    purchase_order_id integer,
    quantity double precision DEFAULT 0.0,
    price double precision DEFAULT 0.0,
    aasm_state character varying,
    packageable_id integer,
    packageable_type character varying
);


--
-- Name: packaging_component_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE packaging_component_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: packaging_component_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE packaging_component_orders_id_seq OWNED BY packaging_component_orders.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    wine_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    customer_id integer,
    qb_code character varying,
    project_number character varying,
    target_cases integer,
    brand character varying DEFAULT ''::character varying NOT NULL,
    description character varying DEFAULT ''::character varying NOT NULL,
    bottling_date timestamp without time zone,
    variety character varying,
    winemaker character varying,
    no_capsule boolean DEFAULT false NOT NULL,
    vintage character varying,
    appellation character varying,
    closure_type character varying,
    trucker character varying,
    cases_to_customer integer DEFAULT 0 NOT NULL,
    comments_count integer,
    fob double precision,
    taxes character varying,
    fso2_target character varying,
    max_do character varying,
    notes text DEFAULT ''::text,
    aasm_state character varying,
    bottled_at_id integer,
    bottler_id integer
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE purchase_orders (
    id integer NOT NULL,
    vendor_id integer,
    number character varying DEFAULT ''::character varying NOT NULL,
    po_image character varying,
    bol_image character varying,
    total double precision,
    receive_date timestamp without time zone,
    order_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    line_items_count integer,
    overhead double precision DEFAULT 0.0
);


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE purchase_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE purchase_orders_id_seq OWNED BY purchase_orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying DEFAULT ''::character varying NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: vendor_products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vendor_products (
    id integer NOT NULL,
    vendable_id integer,
    vendable_type character varying,
    vendor_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: vendor_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vendor_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vendor_products_id_seq OWNED BY vendor_products.id;


--
-- Name: wine_shipments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wine_shipments (
    id integer NOT NULL,
    customer_id integer,
    wine_id integer,
    tracking_number character varying,
    ship_date timestamp without time zone,
    feedback character varying,
    carrier character varying,
    approved boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying,
    accepted boolean DEFAULT false,
    message character varying
);


--
-- Name: wine_shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wine_shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wine_shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wine_shipments_id_seq OWNED BY wine_shipments.id;


--
-- Name: wines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wines (
    id integer NOT NULL,
    appellation character varying,
    variety character varying,
    vintage character varying,
    alc character varying,
    sample_number character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    treatments text,
    description text,
    vinx2_reference character varying,
    aasm_state character varying
);


--
-- Name: wines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wines_id_seq OWNED BY wines.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY back_labels ALTER COLUMN id SET DEFAULT nextval('back_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bottles ALTER COLUMN id SET DEFAULT nextval('bottles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY capsules ALTER COLUMN id SET DEFAULT nextval('capsules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY closures ALTER COLUMN id SET DEFAULT nextval('closures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY component_events ALTER COLUMN id SET DEFAULT nextval('component_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY component_requirements ALTER COLUMN id SET DEFAULT nextval('component_requirements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY components ALTER COLUMN id SET DEFAULT nextval('components_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY front_labels ALTER COLUMN id SET DEFAULT nextval('front_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY packaging_component_orders ALTER COLUMN id SET DEFAULT nextval('packaging_component_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY purchase_orders ALTER COLUMN id SET DEFAULT nextval('purchase_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vendor_products ALTER COLUMN id SET DEFAULT nextval('vendor_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wine_shipments ALTER COLUMN id SET DEFAULT nextval('wine_shipments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wines ALTER COLUMN id SET DEFAULT nextval('wines_id_seq'::regclass);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: back_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY back_labels
    ADD CONSTRAINT back_labels_pkey PRIMARY KEY (id);


--
-- Name: bottles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bottles
    ADD CONSTRAINT bottles_pkey PRIMARY KEY (id);


--
-- Name: capsules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY capsules
    ADD CONSTRAINT capsules_pkey PRIMARY KEY (id);


--
-- Name: closures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY closures
    ADD CONSTRAINT closures_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: component_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY component_events
    ADD CONSTRAINT component_events_pkey PRIMARY KEY (id);


--
-- Name: component_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY component_requirements
    ADD CONSTRAINT component_requirements_pkey PRIMARY KEY (id);


--
-- Name: components_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: front_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY front_labels
    ADD CONSTRAINT front_labels_pkey PRIMARY KEY (id);


--
-- Name: packaging_component_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY packaging_component_orders
    ADD CONSTRAINT packaging_component_orders_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendor_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vendor_products
    ADD CONSTRAINT vendor_products_pkey PRIMARY KEY (id);


--
-- Name: wine_shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wine_shipments
    ADD CONSTRAINT wine_shipments_pkey PRIMARY KEY (id);


--
-- Name: wines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wines
    ADD CONSTRAINT wines_pkey PRIMARY KEY (id);


--
-- Name: index_attachments_on_parent_type_and_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attachments_on_parent_type_and_parent_id ON attachments USING btree (parent_type, parent_id);


--
-- Name: index_back_labels_on_item_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_back_labels_on_item_number ON back_labels USING btree (item_number);


--
-- Name: index_back_labels_on_vendor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_back_labels_on_vendor_id ON back_labels USING btree (vendor_id);


--
-- Name: index_bottles_on_item_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bottles_on_item_number ON bottles USING btree (item_number);


--
-- Name: index_capsules_on_item_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_capsules_on_item_number ON capsules USING btree (item_number);


--
-- Name: index_closures_on_item_number_and_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_closures_on_item_number_and_type ON closures USING btree (item_number, type);


--
-- Name: index_comments_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_author_id ON comments USING btree (author_id);


--
-- Name: index_comments_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_project_id ON comments USING btree (project_id);


--
-- Name: index_comments_on_resolver_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_resolver_id ON comments USING btree (resolver_id);


--
-- Name: index_component_events_on_actionable_id_and_actionable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_events_on_actionable_id_and_actionable_type ON component_events USING btree (actionable_id, actionable_type);


--
-- Name: index_component_events_on_id_and_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_events_on_id_and_type ON component_events USING btree (id, type);


--
-- Name: index_component_events_on_packageable_id_and_packageable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_events_on_packageable_id_and_packageable_type ON component_events USING btree (packageable_id, packageable_type);


--
-- Name: index_component_events_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_events_on_user_id ON component_events USING btree (user_id);


--
-- Name: index_component_requirements_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_requirements_on_ancestry ON component_requirements USING btree (ancestry);


--
-- Name: index_component_requirements_on_packageable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_requirements_on_packageable_id ON component_requirements USING btree (packageable_id);


--
-- Name: index_component_requirements_on_packageable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_requirements_on_packageable_type ON component_requirements USING btree (packageable_type);


--
-- Name: index_component_requirements_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_component_requirements_on_project_id ON component_requirements USING btree (project_id);


--
-- Name: index_components_on_lot_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_components_on_lot_number ON components USING btree (lot_number);


--
-- Name: index_components_on_wine_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_components_on_wine_id ON components USING btree (wine_id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_front_labels_on_item_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_front_labels_on_item_number ON front_labels USING btree (item_number);


--
-- Name: index_packaging_component_orders_on_purchase_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_packaging_component_orders_on_purchase_order_id ON packaging_component_orders USING btree (purchase_order_id);


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_projects_on_aasm_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_aasm_state ON projects USING btree (aasm_state);


--
-- Name: index_projects_on_brand; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_brand ON projects USING btree (brand);


--
-- Name: index_projects_on_customer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_customer_id ON projects USING btree (customer_id);


--
-- Name: index_projects_on_project_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_projects_on_project_number ON projects USING btree (project_number);


--
-- Name: index_projects_on_wine_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_wine_id ON projects USING btree (wine_id);


--
-- Name: index_purchase_orders_on_vendor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_purchase_orders_on_vendor_id ON purchase_orders USING btree (vendor_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_vendor_products_on_vendable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vendor_products_on_vendable_id ON vendor_products USING btree (vendable_id);


--
-- Name: index_vendor_products_on_vendable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vendor_products_on_vendable_type ON vendor_products USING btree (vendable_type);


--
-- Name: index_vendor_products_on_vendor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_vendor_products_on_vendor_id ON vendor_products USING btree (vendor_id);


--
-- Name: index_wine_shipments_on_customer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wine_shipments_on_customer_id ON wine_shipments USING btree (customer_id);


--
-- Name: index_wine_shipments_on_tracking_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wine_shipments_on_tracking_number ON wine_shipments USING btree (tracking_number);


--
-- Name: index_wine_shipments_on_wine_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wine_shipments_on_wine_id ON wine_shipments USING btree (wine_id);


--
-- Name: index_wines_on_appellation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wines_on_appellation ON wines USING btree (appellation);


--
-- Name: index_wines_on_sample_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_wines_on_sample_number ON wines USING btree (sample_number);


--
-- Name: index_wines_on_variety; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wines_on_variety ON wines USING btree (variety);


--
-- Name: packaging_component_orders_on_packageable; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX packaging_component_orders_on_packageable ON packaging_component_orders USING btree (packageable_id, packageable_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131103142222');

INSERT INTO schema_migrations (version) VALUES ('20141010133701');

INSERT INTO schema_migrations (version) VALUES ('20150509230334');

INSERT INTO schema_migrations (version) VALUES ('20150509230409');

INSERT INTO schema_migrations (version) VALUES ('20150509230418');

INSERT INTO schema_migrations (version) VALUES ('20150509231852');

INSERT INTO schema_migrations (version) VALUES ('20150509232959');

INSERT INTO schema_migrations (version) VALUES ('20150510050314');

INSERT INTO schema_migrations (version) VALUES ('20150510050937');

INSERT INTO schema_migrations (version) VALUES ('20150510051421');

INSERT INTO schema_migrations (version) VALUES ('20150510051819');

INSERT INTO schema_migrations (version) VALUES ('20150511035640');

INSERT INTO schema_migrations (version) VALUES ('20150511040012');

INSERT INTO schema_migrations (version) VALUES ('20150511043120');

INSERT INTO schema_migrations (version) VALUES ('20150511162215');

INSERT INTO schema_migrations (version) VALUES ('20150511162221');

INSERT INTO schema_migrations (version) VALUES ('20150511162234');

INSERT INTO schema_migrations (version) VALUES ('20150511165022');

INSERT INTO schema_migrations (version) VALUES ('20150511165405');

INSERT INTO schema_migrations (version) VALUES ('20150511171540');

INSERT INTO schema_migrations (version) VALUES ('20150511200055');

INSERT INTO schema_migrations (version) VALUES ('20150511201616');

INSERT INTO schema_migrations (version) VALUES ('20150511202805');

INSERT INTO schema_migrations (version) VALUES ('20150511222507');

INSERT INTO schema_migrations (version) VALUES ('20150511223519');

INSERT INTO schema_migrations (version) VALUES ('20150512160330');

INSERT INTO schema_migrations (version) VALUES ('20150513042954');

INSERT INTO schema_migrations (version) VALUES ('20150513174652');

INSERT INTO schema_migrations (version) VALUES ('20150513210430');

INSERT INTO schema_migrations (version) VALUES ('20150518174541');

INSERT INTO schema_migrations (version) VALUES ('20150519043418');

INSERT INTO schema_migrations (version) VALUES ('20150519161001');

INSERT INTO schema_migrations (version) VALUES ('20150526233824');

INSERT INTO schema_migrations (version) VALUES ('20150527002604');

INSERT INTO schema_migrations (version) VALUES ('20150527022922');

INSERT INTO schema_migrations (version) VALUES ('20150527025845');

INSERT INTO schema_migrations (version) VALUES ('20150527033905');

INSERT INTO schema_migrations (version) VALUES ('20150527034259');

INSERT INTO schema_migrations (version) VALUES ('20150527182057');

INSERT INTO schema_migrations (version) VALUES ('20150527220733');

INSERT INTO schema_migrations (version) VALUES ('20150531200816');

INSERT INTO schema_migrations (version) VALUES ('20150612185914');

INSERT INTO schema_migrations (version) VALUES ('20150614182303');

INSERT INTO schema_migrations (version) VALUES ('20150615170722');

INSERT INTO schema_migrations (version) VALUES ('20150619171544');

INSERT INTO schema_migrations (version) VALUES ('20150619202519');

INSERT INTO schema_migrations (version) VALUES ('20150619223300');

INSERT INTO schema_migrations (version) VALUES ('20150622234152');

INSERT INTO schema_migrations (version) VALUES ('20150623033151');

INSERT INTO schema_migrations (version) VALUES ('20150624152346');

INSERT INTO schema_migrations (version) VALUES ('20150625222049');

INSERT INTO schema_migrations (version) VALUES ('20150626000233');

INSERT INTO schema_migrations (version) VALUES ('20150626154048');

INSERT INTO schema_migrations (version) VALUES ('20150626162058');

INSERT INTO schema_migrations (version) VALUES ('20150627042508');

INSERT INTO schema_migrations (version) VALUES ('20150701143307');

INSERT INTO schema_migrations (version) VALUES ('20150701212743');

INSERT INTO schema_migrations (version) VALUES ('20150702165538');

INSERT INTO schema_migrations (version) VALUES ('20150702172223');

INSERT INTO schema_migrations (version) VALUES ('20150702190508');

INSERT INTO schema_migrations (version) VALUES ('20150702221040');

INSERT INTO schema_migrations (version) VALUES ('20150703175824');

INSERT INTO schema_migrations (version) VALUES ('20150703180104');

INSERT INTO schema_migrations (version) VALUES ('20150703202211');

INSERT INTO schema_migrations (version) VALUES ('20150704234651');

INSERT INTO schema_migrations (version) VALUES ('20150707164249');

INSERT INTO schema_migrations (version) VALUES ('20150707165048');

INSERT INTO schema_migrations (version) VALUES ('20150708040750');

INSERT INTO schema_migrations (version) VALUES ('20150708043126');

INSERT INTO schema_migrations (version) VALUES ('20150709235751');

INSERT INTO schema_migrations (version) VALUES ('20150710233747');

INSERT INTO schema_migrations (version) VALUES ('20150711044841');

INSERT INTO schema_migrations (version) VALUES ('20150711200755');

INSERT INTO schema_migrations (version) VALUES ('20150711201202');

INSERT INTO schema_migrations (version) VALUES ('20150713183652');

INSERT INTO schema_migrations (version) VALUES ('20150713184208');

INSERT INTO schema_migrations (version) VALUES ('20150713224352');

INSERT INTO schema_migrations (version) VALUES ('20150714161947');

INSERT INTO schema_migrations (version) VALUES ('20150716173717');

INSERT INTO schema_migrations (version) VALUES ('20150720132800');

INSERT INTO schema_migrations (version) VALUES ('20150720134324');

INSERT INTO schema_migrations (version) VALUES ('20150721174046');

INSERT INTO schema_migrations (version) VALUES ('20150723035915');

INSERT INTO schema_migrations (version) VALUES ('20150723211517');

INSERT INTO schema_migrations (version) VALUES ('20150725215245');

INSERT INTO schema_migrations (version) VALUES ('20150804052554');

INSERT INTO schema_migrations (version) VALUES ('20150806210751');

INSERT INTO schema_migrations (version) VALUES ('20150811022805');

INSERT INTO schema_migrations (version) VALUES ('20150815032146');

INSERT INTO schema_migrations (version) VALUES ('20150815204048');

INSERT INTO schema_migrations (version) VALUES ('20150815214644');

INSERT INTO schema_migrations (version) VALUES ('20150816025146');

INSERT INTO schema_migrations (version) VALUES ('20150816234512');

INSERT INTO schema_migrations (version) VALUES ('20150817054449');

INSERT INTO schema_migrations (version) VALUES ('20150818212832');

INSERT INTO schema_migrations (version) VALUES ('20150821034302');

INSERT INTO schema_migrations (version) VALUES ('20150823211104');

