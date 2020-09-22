SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: email; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.email AS public.citext NOT NULL
	CONSTRAINT email_check CHECK ((VALUE OPERATOR(public.~*) '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::public.citext));


--
-- Name: iso2; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.iso2 AS public.citext NOT NULL
	CONSTRAINT iso2_check CHECK ((VALUE OPERATOR(public.~*) '^[a-zA-Z]{2}$'::public.citext));


--
-- Name: iso3; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.iso3 AS public.citext NOT NULL
	CONSTRAINT iso3_check CHECK ((VALUE OPERATOR(public.~*) '^[a-zA-Z]{3}$'::public.citext));


--
-- Name: lang_code; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.lang_code AS public.citext NOT NULL
	CONSTRAINT lang_code_check CHECK ((VALUE OPERATOR(public.~*) '^[a-zA-Z]{2,5}$'::public.citext));


--
-- Name: login_attempt_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.login_attempt_status AS ENUM (
    'success',
    'failure'
);


--
-- Name: token_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.token_type AS ENUM (
    'PasswordResetToken',
    'EmailVerificationToken',
    'AccountRecoveryToken',
    'JwtRefreshToken'
);


--
-- Name: pg_search_dmetaphone(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.pg_search_dmetaphone(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ') $_$;


SET default_tablespace = '';

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id uuid NOT NULL,
    blob_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    iso2 public.iso2 NOT NULL,
    iso3 public.iso3,
    code smallint,
    name character varying NOT NULL,
    native character varying NOT NULL,
    phonecode smallint
);


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currencies (
    iso3 public.iso3 NOT NULL,
    name character varying(30),
    symbol character varying(10),
    active boolean DEFAULT false NOT NULL
);


--
-- Name: data_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_migrations (
    version character varying NOT NULL
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    code public.lang_code NOT NULL,
    name character varying NOT NULL,
    native character varying NOT NULL,
    rtl boolean DEFAULT false NOT NULL,
    active boolean DEFAULT false NOT NULL
);


--
-- Name: login_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_attempts (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    status public.login_attempt_status NOT NULL,
    ip inet NOT NULL,
    metadata jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    slug character varying NOT NULL,
    name character varying NOT NULL
);


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pg_search_documents (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    content text,
    searchable_type character varying,
    searchable_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: time_zones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_zones (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    country_iso2 public.iso2 NOT NULL,
    abbreviation character varying(6) NOT NULL,
    name character varying NOT NULL,
    time_start numeric(11,0) NOT NULL,
    gmt_offset integer NOT NULL
);


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tokens (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    type public.token_type NOT NULL,
    creation_ip inet,
    usage_ip inet,
    issued_at timestamp without time zone NOT NULL,
    expired_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    email public.email NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_permissions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    permission_id uuid NOT NULL
);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (iso2);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (iso3);


--
-- Name: data_migrations data_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_migrations
    ADD CONSTRAINT data_migrations_pkey PRIMARY KEY (version);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (code);


--
-- Name: login_attempts login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: time_zones time_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_zones
    ADD CONSTRAINT time_zones_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: users_permissions users_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_permissions
    ADD CONSTRAINT users_permissions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_countries_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_countries_on_name ON public.countries USING btree (name);


--
-- Name: index_countries_on_native; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_countries_on_native ON public.countries USING btree (native);


--
-- Name: index_languages_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_name ON public.languages USING btree (name);


--
-- Name: index_languages_on_native; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_native ON public.languages USING btree (native);


--
-- Name: index_login_attempts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_login_attempts_on_user_id ON public.login_attempts USING btree (user_id);


--
-- Name: index_permissions_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_name ON public.permissions USING btree (name);


--
-- Name: index_permissions_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_slug ON public.permissions USING btree (slug);


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON public.pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_time_zones_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_time_zones_on_name ON public.time_zones USING btree (name);


--
-- Name: index_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tokens_on_user_id ON public.tokens USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_permissions_on_permission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_permissions_on_permission_id ON public.users_permissions USING btree (permission_id);


--
-- Name: index_users_permissions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_permissions_on_user_id ON public.users_permissions USING btree (user_id);


--
-- Name: active_storage_attachments active_storage_attachments_active_storage_blobs_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_active_storage_blobs_id FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: login_attempts login_attempts_users_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_users_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tokens tokens_users_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_users_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users_permissions users_permissions_permissions_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_permissions
    ADD CONSTRAINT users_permissions_permissions_id FOREIGN KEY (permission_id) REFERENCES public.permissions(id);


--
-- Name: users_permissions users_permissions_users_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_permissions
    ADD CONSTRAINT users_permissions_users_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200922215403'),
('20200922215404'),
('20200922215405'),
('20200922215406'),
('20200922215407'),
('20200922215408'),
('20200922215409'),
('20200922215410'),
('20200922215411'),
('20200922220636'),
('20200922220637'),
('20200922220638'),
('20200922220639'),
('20200922220640'),
('20200922220641'),
('20200922220642'),
('20200922220643'),
('20200922220644'),
('20200922220645'),
('20200922220646'),
('20200922220647'),
('20200922220648'),
('20200922220649'),
('20200922220650');


