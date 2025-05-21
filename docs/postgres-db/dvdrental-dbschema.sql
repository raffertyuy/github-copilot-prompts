--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-12 22:20:21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4270 (class 1262 OID 24761)
-- Name: dvdrental; Type: DATABASE; Schema: -; Owner: razadmin
--

CREATE DATABASE dvdrental WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE dvdrental OWNER TO razadmin;

\connect dvdrental

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 215 (class 1259 OID 24784)
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_customer_id_seq OWNER TO razadmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 24785)
-- Name: customer; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.customer (
    customer_id integer DEFAULT nextval('public.customer_customer_id_seq'::regclass) NOT NULL,
    store_id smallint NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT ('now'::text)::date NOT NULL,
    last_update timestamp without time zone DEFAULT now(),
    active integer
);


ALTER TABLE public.customer OWNER TO razadmin;

--
-- TOC entry 217 (class 1259 OID 24794)
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actor_actor_id_seq OWNER TO razadmin;

--
-- TOC entry 218 (class 1259 OID 24795)
-- Name: actor; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.actor (
    actor_id integer DEFAULT nextval('public.actor_actor_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.actor OWNER TO razadmin;

--
-- TOC entry 219 (class 1259 OID 24800)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO razadmin;

--
-- TOC entry 220 (class 1259 OID 24801)
-- Name: category; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.category (
    category_id integer DEFAULT nextval('public.category_category_id_seq'::regclass) NOT NULL,
    name character varying(25) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.category OWNER TO razadmin;

--
-- TOC entry 221 (class 1259 OID 24806)
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.film_film_id_seq OWNER TO razadmin;

--
-- TOC entry 222 (class 1259 OID 24807)
-- Name: film; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.film (
    film_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    release_year public.year,
    language_id smallint NOT NULL,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);


ALTER TABLE public.film OWNER TO razadmin;

--
-- TOC entry 223 (class 1259 OID 24818)
-- Name: film_actor; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.film_actor (
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.film_actor OWNER TO razadmin;

--
-- TOC entry 224 (class 1259 OID 24822)
-- Name: film_category; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.film_category (
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.film_category OWNER TO razadmin;

--
-- TOC entry 225 (class 1259 OID 24826)
-- Name: actor_info; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.actor_info AS
 SELECT a.actor_id,
    a.first_name,
    a.last_name,
    public.group_concat(DISTINCT (((c.name)::text || ': '::text) || ( SELECT public.group_concat((f.title)::text) AS group_concat
           FROM ((public.film f
             JOIN public.film_category fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN public.film_actor fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((public.actor a
     LEFT JOIN public.film_actor fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN public.film_category fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;


ALTER VIEW public.actor_info OWNER TO razadmin;

--
-- TOC entry 226 (class 1259 OID 24831)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.address_address_id_seq OWNER TO razadmin;

--
-- TOC entry 227 (class 1259 OID 24832)
-- Name: address; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.address (
    address_id integer DEFAULT nextval('public.address_address_id_seq'::regclass) NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.address OWNER TO razadmin;

--
-- TOC entry 228 (class 1259 OID 24837)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_city_id_seq OWNER TO razadmin;

--
-- TOC entry 229 (class 1259 OID 24838)
-- Name: city; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.city (
    city_id integer DEFAULT nextval('public.city_city_id_seq'::regclass) NOT NULL,
    city character varying(50) NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.city OWNER TO razadmin;

--
-- TOC entry 230 (class 1259 OID 24843)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.country_country_id_seq OWNER TO razadmin;

--
-- TOC entry 231 (class 1259 OID 24844)
-- Name: country; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.country (
    country_id integer DEFAULT nextval('public.country_country_id_seq'::regclass) NOT NULL,
    country character varying(50) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.country OWNER TO razadmin;

--
-- TOC entry 232 (class 1259 OID 24849)
-- Name: customer_list; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.customer_list AS
 SELECT cu.customer_id AS id,
    (((cu.first_name)::text || ' '::text) || (cu.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customer cu
     JOIN public.address a ON ((cu.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));


ALTER VIEW public.customer_list OWNER TO razadmin;

--
-- TOC entry 233 (class 1259 OID 24854)
-- Name: film_list; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat((((actor.first_name)::text || ' '::text) || (actor.last_name)::text)) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


ALTER VIEW public.film_list OWNER TO razadmin;

--
-- TOC entry 234 (class 1259 OID 24859)
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_inventory_id_seq OWNER TO razadmin;

--
-- TOC entry 235 (class 1259 OID 24860)
-- Name: inventory; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.inventory (
    inventory_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.inventory OWNER TO razadmin;

--
-- TOC entry 236 (class 1259 OID 24865)
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.language_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.language_language_id_seq OWNER TO razadmin;

--
-- TOC entry 237 (class 1259 OID 24866)
-- Name: language; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.language (
    language_id integer DEFAULT nextval('public.language_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.language OWNER TO razadmin;

--
-- TOC entry 238 (class 1259 OID 24871)
-- Name: nicer_but_slower_film_list; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.nicer_but_slower_film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat((((upper("substring"((actor.first_name)::text, 1, 1)) || lower("substring"((actor.first_name)::text, 2))) || upper("substring"((actor.last_name)::text, 1, 1))) || lower("substring"((actor.last_name)::text, 2)))) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


ALTER VIEW public.nicer_but_slower_film_list OWNER TO razadmin;

--
-- TOC entry 239 (class 1259 OID 24876)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO razadmin;

--
-- TOC entry 240 (class 1259 OID 24877)
-- Name: payment; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.payment (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL
);


ALTER TABLE public.payment OWNER TO razadmin;

--
-- TOC entry 241 (class 1259 OID 24881)
-- Name: rental_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rental_rental_id_seq OWNER TO razadmin;

--
-- TOC entry 242 (class 1259 OID 24882)
-- Name: rental; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.rental (
    rental_id integer DEFAULT nextval('public.rental_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp without time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date timestamp without time zone,
    staff_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.rental OWNER TO razadmin;

--
-- TOC entry 243 (class 1259 OID 24887)
-- Name: sales_by_film_category; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.sales_by_film_category AS
 SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.film f ON ((i.film_id = f.film_id)))
     JOIN public.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;


ALTER VIEW public.sales_by_film_category OWNER TO razadmin;

--
-- TOC entry 244 (class 1259 OID 24892)
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.staff_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_staff_id_seq OWNER TO razadmin;

--
-- TOC entry 245 (class 1259 OID 24893)
-- Name: staff; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.staff (
    staff_id integer DEFAULT nextval('public.staff_staff_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id smallint NOT NULL,
    email character varying(50),
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    picture bytea
);


ALTER TABLE public.staff OWNER TO razadmin;

--
-- TOC entry 246 (class 1259 OID 24901)
-- Name: store_store_id_seq; Type: SEQUENCE; Schema: public; Owner: razadmin
--

CREATE SEQUENCE public.store_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_store_id_seq OWNER TO razadmin;

--
-- TOC entry 247 (class 1259 OID 24902)
-- Name: store; Type: TABLE; Schema: public; Owner: razadmin
--

CREATE TABLE public.store (
    store_id integer DEFAULT nextval('public.store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.store OWNER TO razadmin;

--
-- TOC entry 248 (class 1259 OID 24907)
-- Name: sales_by_store; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.sales_by_store AS
 SELECT (((c.city)::text || ','::text) || (cy.country)::text) AS store,
    (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.store s ON ((i.store_id = s.store_id)))
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
     JOIN public.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;


ALTER VIEW public.sales_by_store OWNER TO razadmin;

--
-- TOC entry 249 (class 1259 OID 24912)
-- Name: staff_list; Type: VIEW; Schema: public; Owner: razadmin
--

CREATE VIEW public.staff_list AS
 SELECT s.staff_id AS id,
    (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((public.staff s
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));


ALTER VIEW public.staff_list OWNER TO razadmin;

--
-- TOC entry 4041 (class 2606 OID 24918)
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- TOC entry 4056 (class 2606 OID 24920)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 4044 (class 2606 OID 24922)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4059 (class 2606 OID 24924)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4062 (class 2606 OID 24926)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 4036 (class 2606 OID 24928)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 4051 (class 2606 OID 24930)
-- Name: film_actor film_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);


--
-- TOC entry 4054 (class 2606 OID 24932)
-- Name: film_category film_category_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);


--
-- TOC entry 4047 (class 2606 OID 24934)
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


--
-- TOC entry 4065 (class 2606 OID 24936)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- TOC entry 4067 (class 2606 OID 24938)
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 4072 (class 2606 OID 24940)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4076 (class 2606 OID 24942)
-- Name: rental rental_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);


--
-- TOC entry 4078 (class 2606 OID 24944)
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- TOC entry 4081 (class 2606 OID 24946)
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- TOC entry 4045 (class 1259 OID 24947)
-- Name: film_fulltext_idx; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX film_fulltext_idx ON public.film USING gist (fulltext);


--
-- TOC entry 4042 (class 1259 OID 24948)
-- Name: idx_actor_last_name; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_actor_last_name ON public.actor USING btree (last_name);


--
-- TOC entry 4037 (class 1259 OID 24949)
-- Name: idx_fk_address_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_address_id ON public.customer USING btree (address_id);


--
-- TOC entry 4057 (class 1259 OID 24950)
-- Name: idx_fk_city_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id);


--
-- TOC entry 4060 (class 1259 OID 24951)
-- Name: idx_fk_country_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_country_id ON public.city USING btree (country_id);


--
-- TOC entry 4068 (class 1259 OID 24952)
-- Name: idx_fk_customer_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_customer_id ON public.payment USING btree (customer_id);


--
-- TOC entry 4052 (class 1259 OID 24953)
-- Name: idx_fk_film_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_film_id ON public.film_actor USING btree (film_id);


--
-- TOC entry 4073 (class 1259 OID 24954)
-- Name: idx_fk_inventory_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);


--
-- TOC entry 4048 (class 1259 OID 24955)
-- Name: idx_fk_language_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_language_id ON public.film USING btree (language_id);


--
-- TOC entry 4069 (class 1259 OID 24956)
-- Name: idx_fk_rental_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_rental_id ON public.payment USING btree (rental_id);


--
-- TOC entry 4070 (class 1259 OID 24957)
-- Name: idx_fk_staff_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_staff_id ON public.payment USING btree (staff_id);


--
-- TOC entry 4038 (class 1259 OID 24961)
-- Name: idx_fk_store_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_fk_store_id ON public.customer USING btree (store_id);


--
-- TOC entry 4039 (class 1259 OID 24963)
-- Name: idx_last_name; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_last_name ON public.customer USING btree (last_name);


--
-- TOC entry 4063 (class 1259 OID 24965)
-- Name: idx_store_id_film_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);


--
-- TOC entry 4049 (class 1259 OID 24966)
-- Name: idx_title; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE INDEX idx_title ON public.film USING btree (title);


--
-- TOC entry 4079 (class 1259 OID 24967)
-- Name: idx_unq_manager_staff_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.store USING btree (manager_staff_id);


--
-- TOC entry 4074 (class 1259 OID 24968)
-- Name: idx_unq_rental_rental_date_inventory_id_customer_id; Type: INDEX; Schema: public; Owner: razadmin
--

CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON public.rental USING btree (rental_date, inventory_id, customer_id);


--
-- TOC entry 4103 (class 2620 OID 24969)
-- Name: film film_fulltext_trigger; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER film_fulltext_trigger BEFORE INSERT OR UPDATE ON public.film FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');


--
-- TOC entry 4101 (class 2620 OID 24970)
-- Name: actor last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.actor FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4107 (class 2620 OID 24971)
-- Name: address last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.address FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4102 (class 2620 OID 24972)
-- Name: category last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.category FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4108 (class 2620 OID 24973)
-- Name: city last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4109 (class 2620 OID 24974)
-- Name: country last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.country FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4100 (class 2620 OID 24975)
-- Name: customer last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.customer FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4104 (class 2620 OID 24976)
-- Name: film last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4105 (class 2620 OID 24977)
-- Name: film_actor last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_actor FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4106 (class 2620 OID 24978)
-- Name: film_category last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_category FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4110 (class 2620 OID 24979)
-- Name: inventory last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.inventory FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4111 (class 2620 OID 24980)
-- Name: language last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.language FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4112 (class 2620 OID 24981)
-- Name: rental last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.rental FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4113 (class 2620 OID 24982)
-- Name: staff last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4114 (class 2620 OID 24983)
-- Name: store last_updated; Type: TRIGGER; Schema: public; Owner: razadmin
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.store FOR EACH ROW EXECUTE FUNCTION public.last_updated();


--
-- TOC entry 4082 (class 2606 OID 24984)
-- Name: customer customer_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4084 (class 2606 OID 24989)
-- Name: film_actor film_actor_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4085 (class 2606 OID 24994)
-- Name: film_actor film_actor_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4086 (class 2606 OID 24999)
-- Name: film_category film_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4087 (class 2606 OID 25004)
-- Name: film_category film_category_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4083 (class 2606 OID 25009)
-- Name: film film_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4088 (class 2606 OID 25014)
-- Name: address fk_address_city; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES public.city(city_id);


--
-- TOC entry 4089 (class 2606 OID 25019)
-- Name: city fk_city; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT fk_city FOREIGN KEY (country_id) REFERENCES public.country(country_id);


--
-- TOC entry 4090 (class 2606 OID 25024)
-- Name: inventory inventory_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4091 (class 2606 OID 25029)
-- Name: payment payment_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4092 (class 2606 OID 25034)
-- Name: payment payment_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4093 (class 2606 OID 25039)
-- Name: payment payment_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4094 (class 2606 OID 25044)
-- Name: rental rental_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4095 (class 2606 OID 25049)
-- Name: rental rental_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4096 (class 2606 OID 25054)
-- Name: rental rental_staff_id_key; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- TOC entry 4097 (class 2606 OID 25059)
-- Name: staff staff_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4098 (class 2606 OID 25064)
-- Name: store store_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4099 (class 2606 OID 25069)
-- Name: store store_manager_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: razadmin
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (manager_staff_id) REFERENCES public.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-02-12 22:20:45

--
-- PostgreSQL database dump complete
--

