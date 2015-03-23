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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: legacy_artists; Type: TABLE; Schema: public; Owner: necromancer; Tablespace: 
--

CREATE TABLE legacy_artists (
    id integer NOT NULL,
    name character varying(255),
    description text,
    members text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cover_image character varying(255),
    photo_image character varying(255)
);


ALTER TABLE legacy_artists OWNER TO necromancer;

--
-- Name: legacy_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: necromancer
--

CREATE SEQUENCE legacy_artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE legacy_artists_id_seq OWNER TO necromancer;

--
-- Name: legacy_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: necromancer
--

ALTER SEQUENCE legacy_artists_id_seq OWNED BY artists.id;


--
-- Name: legacy_releases; Type: TABLE; Schema: public; Owner: necromancer; Tablespace: 
--

CREATE TABLE legacy_releases (
    id integer NOT NULL,
    name character varying(255),
    released_on date,
    catalog_number character varying(255),
    artist_id integer,
    description text,
    tracks text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cover_image character varying(255),
    notes text
);


ALTER TABLE legacy_releases OWNER TO necromancer;

--
-- Name: legacy_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: necromancer
--

CREATE SEQUENCE legacy_releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE legacy_releases_id_seq OWNER TO necromancer;

--
-- Name: legacy_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: necromancer
--

ALTER SEQUENCE legacy_releases_id_seq OWNED BY legacy_releases.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: necromancer
--

ALTER TABLE ONLY legacy_artists ALTER COLUMN id SET DEFAULT nextval('artists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: necromancer
--

ALTER TABLE ONLY legacy_releases ALTER COLUMN id SET DEFAULT nextval('legacy_releases_id_seq'::regclass);


--
-- Data for Name: legacy_artists; Type: TABLE DATA; Schema: public; Owner: necromancer
--

COPY legacy_artists (id, name, description, members, created_at, updated_at, cover_image, photo_image) FROM stdin;
1	The Wonder Bars	The Wonder Bars are a live House music project from Philadelphia. Their eclectic and danceable blend of funk, soul, samba, jazz, rock and electro styles transcend classification and permeates that invisible vibe through anyone who listens.	- Tom Phoolery, vocals/controllers\r\n- Jules Victor, bass/controllers\r\n- Rob Green, saxophones	2013-08-12 01:40:30.123	2013-09-22 06:03:00.223109	just-text.png	\N
2	Research and Development	Two years ago, longtime friends [The Architech](http://soundcloud.com/iamthearchitech) and [Tom Phoolery](http://thewonderbars.com) made a pact to begin producing tracks together. Sharing common interests in sound engineering and musical taste, they began making "experiments", tracks that touched both on Architech's experiences as a hardcore/jungle DJ as well as Tom's experience fronting a live house band. Together, their influences touch both on the more "classic" styles of dance music as well as new developments in the scene. The music they create is reminiscent of a time when electronic music was more melodic, but retains the raw energy that recent technology has empowered us to use in modern music production.	- **The Architech:** programming, drum machines\r\n- **Tom Phoolery:** programming, vocals	2013-08-31 20:35:38.734703	2013-12-17 01:34:51.991129	\N	\N
\.


--
-- Name: legacy_artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: necromancer
--

SELECT pg_catalog.setval('legacy_artists_id_seq', 2, true);


--
-- Data for Name: legacy_releases; Type: TABLE DATA; Schema: public; Owner: necromancer
--

COPY legacy_releases (id, name, released_on, catalog_number, artist_id, description, tracks, created_at, updated_at, cover_image, notes) FROM stdin;
1	Just The Start EP	2012-07-31	WXP001	1	\N	1. Just The Start\r\n2. After Hours	2013-08-12 03:06:34.109748	2013-08-31 20:49:40.732557	Just-The-Start-EP.png	The debut EP from Philadelphia's premiere live house band! Performing a combination of house, jazz and garage music live (with improvisation), The Wonder Bars have firmly planted themselves into the roots of Philly's diverse electronic music scene. With this debut offering, the world can now experience a taste of what it's like to see this incredible band perform live.\r\n\r\n#### Personnel\r\n\r\n- **Tom Phoolery** vocals, keyboards, programming\r\n- **Aaron Fraint** guitar\r\n- **Jules Victor** bass\r\n- **Rob Green** saxophones\r\n\r\n#### Listen to it\r\n\r\n- **On Beatport:** <http://www.beatport.com/release/just-the-start-ep/949170>\r\n- **On Spotify:** <https://play.spotify.com/artist/2nrkwnQWEqM20n92QC7Cdy>
2	Shuffle Not	2013-08-26	WXP002F	2	\N	1. Shuffle Not	2013-08-31 20:39:50.949314	2013-08-31 20:43:09.883335	artworks-000056460803-mvl60c-t500x500.jpg	A free download from Research and Development to promote...something...stay tuned!\r\n\r\n#### This is Shuffle Not, our remix of [Suffer Not](https://www.youtube.com/watch?v=5dblnSABZp0) by Submotion Orchestra\r\n\r\nA truly beautiful piece, we never intended to release this version but after much deliberation, tweaking, and secret live performances...we noticed that almost everyone who listened to it really enjoyed the work. The only sample from Suffer Not is the open vocals, everything else has either been re-produced or edited by one of us. After even more deliberation, we decided that all great things in life should be free and gave it to YOU, to download FOR FREE!\r\n\r\nYou can find the download link on this release's **Soundcloud page**: <http://soundcloud.com/resndev/shuffle-not/> \r\n\r\n#### Enjoy!!
\.


--
-- Name: legacy_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: necromancer
--

SELECT pg_catalog.setval('legacy_releases_id_seq', 2, true);


--
-- Name: legacy_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: necromancer; Tablespace: 
--

ALTER TABLE ONLY legacy_artists
    ADD CONSTRAINT legacy_artists_pkey PRIMARY KEY (id);


--
-- Name: legacy_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: necromancer; Tablespace: 
--

ALTER TABLE ONLY legacy_releases
    ADD CONSTRAINT legacy_releases_pkey PRIMARY KEY (id);


--
-- Name: index_legacy_releases_on_artist_id; Type: INDEX; Schema: public; Owner: necromancer; Tablespace: 
--

CREATE INDEX index_legacy_releases_on_artist_id ON legacy_releases USING btree (artist_id);


--
-- PostgreSQL database dump complete
--

