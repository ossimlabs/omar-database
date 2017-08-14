--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: avro_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE avro_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone,
    filename text NOT NULL,
    process_id character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    status_message text
);


ALTER TABLE avro_file OWNER TO postgres;

--
-- Name: avro_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE avro_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE avro_file_id_seq OWNER TO postgres;

--
-- Name: avro_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE avro_file_id_seq OWNED BY avro_file.id;


--
-- Name: avro_payload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE avro_payload (
    id bigint NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone,
    message text NOT NULL,
    message_id text NOT NULL,
    status character varying(255) NOT NULL,
    status_message text
);


ALTER TABLE avro_payload OWNER TO postgres;

--
-- Name: avro_payload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE avro_payload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE avro_payload_id_seq OWNER TO postgres;

--
-- Name: avro_payload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE avro_payload_id_seq OWNED BY avro_payload.id;


--
-- Name: batch_job_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone,
    job_configuration_location character varying(2500)
);


ALTER TABLE batch_job_execution OWNER TO postgres;

--
-- Name: batch_job_execution_context; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_job_execution_context OWNER TO postgres;

--
-- Name: batch_job_execution_params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    type_cd character varying(6) NOT NULL,
    key_name character varying(100) NOT NULL,
    string_val character varying(250),
    date_val timestamp without time zone,
    long_val bigint,
    double_val double precision,
    identifying character(1) NOT NULL
);


ALTER TABLE batch_job_execution_params OWNER TO postgres;

--
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_execution_seq OWNER TO postgres;

--
-- Name: batch_job_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE batch_job_instance OWNER TO postgres;

--
-- Name: batch_job_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE batch_job_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_job_seq OWNER TO postgres;

--
-- Name: batch_step_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE batch_step_execution OWNER TO postgres;

--
-- Name: batch_step_execution_context; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE batch_step_execution_context OWNER TO postgres;

--
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_step_execution_seq OWNER TO postgres;

--
-- Name: dem_generation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dem_generation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    bbox character varying(255),
    finish timestamp without time zone,
    name character varying(255) NOT NULL,
    start timestamp without time zone,
    submitted timestamp without time zone NOT NULL
);


ALTER TABLE dem_generation OWNER TO postgres;

--
-- Name: deployment_ids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE deployment_ids (
    deployment_key character varying(255) NOT NULL,
    deployment_id character varying(255) NOT NULL
);


ALTER TABLE deployment_ids OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO postgres;

--
-- Name: ht_layer_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ht_layer_info (
    id numeric NOT NULL,
    hib_sess_id character(36)
);


ALTER TABLE ht_layer_info OWNER TO postgres;

--
-- Name: ht_namespace_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ht_namespace_info (
    id numeric NOT NULL,
    hib_sess_id character(36)
);


ALTER TABLE ht_namespace_info OWNER TO postgres;

--
-- Name: ht_repository; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ht_repository (
    id numeric NOT NULL,
    hib_sess_id character(36)
);


ALTER TABLE ht_repository OWNER TO postgres;

--
-- Name: ht_workspace_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ht_workspace_info (
    id numeric NOT NULL,
    hib_sess_id character(36)
);


ALTER TABLE ht_workspace_info OWNER TO postgres;

--
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE image (
    id bigint NOT NULL,
    version bigint NOT NULL,
    filename character varying(255) NOT NULL,
    image_id character varying(255) NOT NULL,
    sensor_model character varying(255) NOT NULL
);


ALTER TABLE image OWNER TO postgres;

--
-- Name: image_tie_point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE image_tie_point (
    image_tie_points_id bigint NOT NULL,
    tie_point_id bigint
);


ALTER TABLE image_tie_point OWNER TO postgres;

--
-- Name: ingest_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ingest_metrics (
    id bigint NOT NULL,
    version bigint NOT NULL,
    description text,
    end_copy timestamp without time zone,
    end_date timestamp without time zone,
    end_staging timestamp without time zone,
    ingest_id text,
    start_copy timestamp without time zone,
    start_date timestamp without time zone,
    start_staging timestamp without time zone,
    status character varying(255),
    status_message text
);


ALTER TABLE ingest_metrics OWNER TO postgres;

--
-- Name: ingest_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ingest_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ingest_metrics_id_seq OWNER TO postgres;

--
-- Name: ingest_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ingest_metrics_id_seq OWNED BY ingest_metrics.id;


--
-- Name: layer_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE layer_info (
    id bigint NOT NULL,
    version bigint NOT NULL,
    description character varying(255) NOT NULL,
    keywords bytea NOT NULL,
    name character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    workspace_info_id bigint NOT NULL,
    layer_info_list_idx integer
);


ALTER TABLE layer_info OWNER TO postgres;

--
-- Name: layer_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE layer_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE layer_info_id_seq OWNER TO postgres;

--
-- Name: layer_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE layer_info_id_seq OWNED BY layer_info.id;


--
-- Name: namespace_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE namespace_info (
    id bigint NOT NULL,
    version bigint NOT NULL,
    prefix character varying(255) NOT NULL,
    uri character varying(255) NOT NULL
);


ALTER TABLE namespace_info OWNER TO postgres;

--
-- Name: namespace_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE namespace_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE namespace_info_id_seq OWNER TO postgres;

--
-- Name: namespace_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE namespace_info_id_seq OWNED BY namespace_info.id;


--
-- Name: omar_stage_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE omar_stage_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    build_histograms boolean,
    build_histograms_withr0 boolean,
    build_overviews boolean,
    date_created timestamp without time zone,
    filename text NOT NULL,
    overview_compression_type character varying(255),
    overview_type character varying(255),
    process_id character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    status_message text,
    use_fast_histogram_staging boolean
);


ALTER TABLE omar_stage_file OWNER TO postgres;

--
-- Name: omar_stage_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE omar_stage_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE omar_stage_file_id_seq OWNER TO postgres;

--
-- Name: omar_stage_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE omar_stage_file_id_seq OWNED BY omar_stage_file.id;


--
-- Name: opir_raster_data_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opir_raster_data_set (
    id bigint NOT NULL,
    version bigint NOT NULL
);


ALTER TABLE opir_raster_data_set OWNER TO postgres;

--
-- Name: opir_raster_data_set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE opir_raster_data_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE opir_raster_data_set_id_seq OWNER TO postgres;

--
-- Name: opir_raster_data_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE opir_raster_data_set_id_seq OWNED BY opir_raster_data_set.id;


--
-- Name: opir_raster_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opir_raster_entry (
    id bigint NOT NULL,
    version bigint NOT NULL,
    access_date timestamp without time zone NOT NULL,
    acquisition_end timestamp without time zone,
    acquisition_start timestamp without time zone,
    bit_depth integer NOT NULL,
    data_type character varying(255) NOT NULL,
    entry_id character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    filter1 integer,
    filter2 integer,
    focal_plane_id integer,
    frame_rate double precision,
    gain_setting integer,
    ground_geom geometry(MultiPolygon,4326) NOT NULL,
    gsd_unit character varying(255),
    gsdx double precision,
    gsdy double precision,
    hdf_location character varying(255),
    height integer,
    index_id character varying(255) NOT NULL,
    ingest_date timestamp without time zone NOT NULL,
    integration_index integer,
    mission character varying(255),
    number_of_bands integer NOT NULL,
    number_of_res_levels integer,
    raster_data_set_id bigint NOT NULL,
    receive_date timestamp without time zone NOT NULL,
    scan_rate double precision,
    snapshot_size integer,
    spatial_summation integer,
    summed_scans integer,
    task_name character varying(255),
    tie_point_set character varying(255) NOT NULL,
    width integer
);


ALTER TABLE opir_raster_entry OWNER TO postgres;

--
-- Name: opir_raster_entry_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opir_raster_entry_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    file_size integer NOT NULL,
    name character varying(255) NOT NULL,
    opir_raster_entry_id bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE opir_raster_entry_file OWNER TO postgres;

--
-- Name: opir_raster_entry_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE opir_raster_entry_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE opir_raster_entry_file_id_seq OWNER TO postgres;

--
-- Name: opir_raster_entry_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE opir_raster_entry_file_id_seq OWNED BY opir_raster_entry_file.id;


--
-- Name: opir_raster_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE opir_raster_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE opir_raster_entry_id_seq OWNER TO postgres;

--
-- Name: opir_raster_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE opir_raster_entry_id_seq OWNED BY opir_raster_entry.id;


--
-- Name: opir_raster_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE opir_raster_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    file_size integer NOT NULL,
    name character varying(255) NOT NULL,
    opir_raster_data_set_id bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE opir_raster_file OWNER TO postgres;

--
-- Name: opir_raster_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE opir_raster_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE opir_raster_file_id_seq OWNER TO postgres;

--
-- Name: opir_raster_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE opir_raster_file_id_seq OWNED BY opir_raster_file.id;


--
-- Name: photo_block; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE photo_block (
    id bigint NOT NULL,
    version bigint NOT NULL,
    photo_block jsonb NOT NULL
);


ALTER TABLE photo_block OWNER TO postgres;

--
-- Name: raster_data_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raster_data_set (
    id bigint NOT NULL,
    version bigint NOT NULL,
    repository_id bigint
);


ALTER TABLE raster_data_set OWNER TO postgres;

--
-- Name: raster_data_set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raster_data_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raster_data_set_id_seq OWNER TO postgres;

--
-- Name: raster_data_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raster_data_set_id_seq OWNED BY raster_data_set.id;


--
-- Name: raster_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raster_entry (
    id bigint NOT NULL,
    version bigint NOT NULL,
    access_date timestamp with time zone,
    acquisition_date timestamp with time zone,
    azimuth_angle double precision,
    be_number character varying(255),
    bit_depth integer NOT NULL,
    class_name character varying(255),
    cloud_cover double precision,
    country_code character varying(255),
    crosses_dateline boolean,
    data_type character varying(255) NOT NULL,
    description character varying(255),
    entry_id character varying(255) NOT NULL,
    exclude_policy character varying(255),
    file_type character varying(255),
    filename character varying(255),
    grazing_angle double precision,
    ground_geom geometry(MultiPolygon,4326) NOT NULL,
    gsd_unit character varying(255),
    gsdx double precision,
    gsdy double precision,
    height bigint NOT NULL,
    image_category character varying(255),
    image_id character varying(255),
    image_representation character varying(255),
    index_id character varying(255) NOT NULL,
    ingest_date timestamp with time zone,
    isorce character varying(255),
    keep_forever boolean,
    mission_id character varying(255),
    niirs double precision,
    number_of_bands integer NOT NULL,
    number_of_res_levels integer,
    organization character varying(255),
    other_tags_xml text,
    product_id character varying(255),
    raster_data_set_id bigint NOT NULL,
    receive_date timestamp with time zone,
    release_id numeric(19,2),
    security_classification character varying(255),
    security_code character varying(255),
    sensor_id character varying(255),
    style_id numeric(19,2),
    sun_azimuth double precision,
    sun_elevation double precision,
    target_id character varying(255),
    tie_point_set text,
    title character varying(255),
    valid_model integer,
    wac_code character varying(255),
    width bigint NOT NULL
);


ALTER TABLE raster_entry OWNER TO postgres;

--
-- Name: raster_entry_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raster_entry_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    name character varying(255) NOT NULL,
    raster_entry_id bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE raster_entry_file OWNER TO postgres;

--
-- Name: raster_entry_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raster_entry_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raster_entry_file_id_seq OWNER TO postgres;

--
-- Name: raster_entry_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raster_entry_file_id_seq OWNED BY raster_entry_file.id;


--
-- Name: raster_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raster_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raster_entry_id_seq OWNER TO postgres;

--
-- Name: raster_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raster_entry_id_seq OWNED BY raster_entry.id;


--
-- Name: raster_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raster_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    format character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    raster_data_set_id bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE raster_file OWNER TO postgres;

--
-- Name: raster_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raster_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raster_file_id_seq OWNER TO postgres;

--
-- Name: raster_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raster_file_id_seq OWNED BY raster_file.id;


--
-- Name: repository; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repository (
    id bigint NOT NULL,
    version bigint NOT NULL,
    repository_base_dir character varying(255) NOT NULL,
    scan_end_date timestamp without time zone,
    scan_start_date timestamp without time zone
);


ALTER TABLE repository OWNER TO postgres;

--
-- Name: repository_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repository_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repository_id_seq OWNER TO postgres;

--
-- Name: repository_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repository_id_seq OWNED BY repository.id;


--
-- Name: stream_definitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE stream_definitions (
    definition_name character varying(255) NOT NULL,
    definition text
);


ALTER TABLE stream_definitions OWNER TO postgres;

--
-- Name: task_definitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task_definitions (
    definition_name character varying(255) NOT NULL,
    definition text
);


ALTER TABLE task_definitions OWNER TO postgres;

--
-- Name: task_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task_execution (
    task_execution_id bigint NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    task_name character varying(100),
    exit_code integer,
    exit_message character varying(2500),
    error_message character varying(2500),
    last_updated timestamp without time zone,
    external_execution_id character varying(255)
);


ALTER TABLE task_execution OWNER TO postgres;

--
-- Name: task_execution_params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task_execution_params (
    task_execution_id bigint NOT NULL,
    task_param character varying(2500)
);


ALTER TABLE task_execution_params OWNER TO postgres;

--
-- Name: task_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE task_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE task_seq OWNER TO postgres;

--
-- Name: task_task_batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task_task_batch (
    task_execution_id bigint NOT NULL,
    job_execution_id bigint NOT NULL
);


ALTER TABLE task_task_batch OWNER TO postgres;

--
-- Name: tie_point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tie_point (
    id bigint NOT NULL,
    version bigint NOT NULL,
    col double precision NOT NULL,
    covariance character varying(255),
    dx double precision,
    dy double precision,
    lat double precision,
    lon double precision,
    point_id character varying(255) NOT NULL,
    rho double precision,
    "row" double precision NOT NULL,
    sigma_column double precision,
    sigma_row double precision,
    x double precision,
    y double precision,
    z double precision
);


ALTER TABLE tie_point OWNER TO postgres;

--
-- Name: tie_point_generation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tie_point_generation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    finish timestamp without time zone,
    name character varying(255) NOT NULL,
    photo_block_id bigint,
    start timestamp without time zone,
    submitted timestamp without time zone NOT NULL
);


ALTER TABLE tie_point_generation OWNER TO postgres;

--
-- Name: tie_point_generation_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tie_point_generation_image (
    tie_point_generation_images_id bigint NOT NULL,
    image_id bigint
);


ALTER TABLE tie_point_generation_image OWNER TO postgres;

--
-- Name: triangulation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE triangulation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    finish timestamp without time zone,
    name character varying(255) NOT NULL,
    photo_block_id bigint,
    report text,
    start timestamp without time zone,
    submitted timestamp without time zone NOT NULL
);


ALTER TABLE triangulation OWNER TO postgres;

--
-- Name: triangulation_dem_generation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE triangulation_dem_generation (
    triangulation_dem_generations_id bigint NOT NULL,
    dem_generation_id bigint
);


ALTER TABLE triangulation_dem_generation OWNER TO postgres;

--
-- Name: triangulation_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE triangulation_image (
    triangulation_images_id bigint NOT NULL,
    image_id bigint
);


ALTER TABLE triangulation_image OWNER TO postgres;

--
-- Name: uri_registry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE uri_registry (
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL
);


ALTER TABLE uri_registry OWNER TO postgres;

--
-- Name: video_data_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE video_data_set (
    id bigint NOT NULL,
    version bigint NOT NULL,
    end_date timestamp with time zone,
    filename character varying(255),
    ground_geom geometry(MultiPolygon,4326),
    height bigint NOT NULL,
    index_id character varying(255) NOT NULL,
    other_tags_xml text,
    repository_id bigint,
    start_date timestamp with time zone,
    style_id numeric(19,2),
    width bigint NOT NULL
);


ALTER TABLE video_data_set OWNER TO postgres;

--
-- Name: video_data_set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE video_data_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE video_data_set_id_seq OWNER TO postgres;

--
-- Name: video_data_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE video_data_set_id_seq OWNED BY video_data_set.id;


--
-- Name: video_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE video_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    format character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    video_data_set_id bigint NOT NULL
);


ALTER TABLE video_file OWNER TO postgres;

--
-- Name: video_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE video_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE video_file_id_seq OWNER TO postgres;

--
-- Name: video_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE video_file_id_seq OWNED BY video_file.id;


--
-- Name: wms_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE wms_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wms_log_id_seq OWNER TO postgres;

--
-- Name: wmts_layer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wmts_layer (
    id bigint NOT NULL,
    version bigint NOT NULL,
    description text,
    filter character varying(255),
    name character varying(255) NOT NULL,
    sort_by character varying(255),
    title character varying(255),
    wmts_tile_matrix_set_id bigint NOT NULL
);


ALTER TABLE wmts_layer OWNER TO postgres;

--
-- Name: wmts_layer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE wmts_layer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wmts_layer_id_seq OWNER TO postgres;

--
-- Name: wmts_layer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE wmts_layer_id_seq OWNED BY wmts_layer.id;


--
-- Name: wmts_tile_matrix_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wmts_tile_matrix_set (
    id bigint NOT NULL,
    version bigint NOT NULL,
    epsg_code character varying(255) NOT NULL,
    max_level integer NOT NULL,
    maxx double precision NOT NULL,
    maxy double precision NOT NULL,
    min_level integer NOT NULL,
    minx double precision NOT NULL,
    miny double precision NOT NULL,
    name character varying(255) NOT NULL,
    tile_height integer NOT NULL,
    tile_width integer NOT NULL
);


ALTER TABLE wmts_tile_matrix_set OWNER TO postgres;

--
-- Name: wmts_tile_matrix_set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE wmts_tile_matrix_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wmts_tile_matrix_set_id_seq OWNER TO postgres;

--
-- Name: wmts_tile_matrix_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE wmts_tile_matrix_set_id_seq OWNED BY wmts_tile_matrix_set.id;


--
-- Name: workspace_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workspace_info (
    id bigint NOT NULL,
    version bigint NOT NULL,
    name character varying(255) NOT NULL,
    namespace_info_id bigint NOT NULL
);


ALTER TABLE workspace_info OWNER TO postgres;

--
-- Name: workspace_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE workspace_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workspace_info_id_seq OWNER TO postgres;

--
-- Name: workspace_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE workspace_info_id_seq OWNED BY workspace_info.id;


--
-- Name: workspace_info_workspace_params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workspace_info_workspace_params (
    workspace_info_id bigint NOT NULL,
    workspace_params_string character varying(255),
    workspace_params_idx character varying(255),
    workspace_params_elt character varying(255) NOT NULL
);


ALTER TABLE workspace_info_workspace_params OWNER TO postgres;

--
-- Name: avro_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_file ALTER COLUMN id SET DEFAULT nextval('avro_file_id_seq'::regclass);


--
-- Name: avro_payload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_payload ALTER COLUMN id SET DEFAULT nextval('avro_payload_id_seq'::regclass);


--
-- Name: ingest_metrics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingest_metrics ALTER COLUMN id SET DEFAULT nextval('ingest_metrics_id_seq'::regclass);


--
-- Name: layer_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY layer_info ALTER COLUMN id SET DEFAULT nextval('layer_info_id_seq'::regclass);


--
-- Name: namespace_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY namespace_info ALTER COLUMN id SET DEFAULT nextval('namespace_info_id_seq'::regclass);


--
-- Name: omar_stage_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY omar_stage_file ALTER COLUMN id SET DEFAULT nextval('omar_stage_file_id_seq'::regclass);


--
-- Name: opir_raster_data_set id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_data_set ALTER COLUMN id SET DEFAULT nextval('opir_raster_data_set_id_seq'::regclass);


--
-- Name: opir_raster_entry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry ALTER COLUMN id SET DEFAULT nextval('opir_raster_entry_id_seq'::regclass);


--
-- Name: opir_raster_entry_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry_file ALTER COLUMN id SET DEFAULT nextval('opir_raster_entry_file_id_seq'::regclass);


--
-- Name: opir_raster_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_file ALTER COLUMN id SET DEFAULT nextval('opir_raster_file_id_seq'::regclass);


--
-- Name: raster_data_set id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_data_set ALTER COLUMN id SET DEFAULT nextval('raster_data_set_id_seq'::regclass);


--
-- Name: raster_entry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry ALTER COLUMN id SET DEFAULT nextval('raster_entry_id_seq'::regclass);


--
-- Name: raster_entry_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry_file ALTER COLUMN id SET DEFAULT nextval('raster_entry_file_id_seq'::regclass);


--
-- Name: raster_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_file ALTER COLUMN id SET DEFAULT nextval('raster_file_id_seq'::regclass);


--
-- Name: repository id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repository ALTER COLUMN id SET DEFAULT nextval('repository_id_seq'::regclass);


--
-- Name: video_data_set id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_data_set ALTER COLUMN id SET DEFAULT nextval('video_data_set_id_seq'::regclass);


--
-- Name: video_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_file ALTER COLUMN id SET DEFAULT nextval('video_file_id_seq'::regclass);


--
-- Name: wmts_layer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_layer ALTER COLUMN id SET DEFAULT nextval('wmts_layer_id_seq'::regclass);


--
-- Name: wmts_tile_matrix_set id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_tile_matrix_set ALTER COLUMN id SET DEFAULT nextval('wmts_tile_matrix_set_id_seq'::regclass);


--
-- Name: workspace_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workspace_info ALTER COLUMN id SET DEFAULT nextval('workspace_info_id_seq'::regclass);


--
-- Data for Name: avro_file; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: avro_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('avro_file_id_seq', 3585, true);


--
-- Data for Name: avro_payload; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: avro_payload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('avro_payload_id_seq', 3587, true);


--
-- Data for Name: batch_job_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: batch_job_execution_context; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: batch_job_execution_params; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: batch_job_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('batch_job_execution_seq', 1, false);


--
-- Data for Name: batch_job_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: batch_job_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('batch_job_seq', 1, false);


--
-- Data for Name: batch_step_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: batch_step_execution_context; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: batch_step_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('batch_step_execution_seq', 1, false);


--
-- Data for Name: dem_generation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: deployment_ids; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deployment_ids (deployment_key, deployment_id) VALUES ('omar-dropbox.log', 'omar-dropbox.log');
INSERT INTO deployment_ids (deployment_key, deployment_id) VALUES ('omar-dropbox.omar-scdf-aggregator', 'omar-dropbox.omar-scdf-aggregator');
INSERT INTO deployment_ids (deployment_key, deployment_id) VALUES ('omar-dropbox.omar-scdf-sqs', 'omar-dropbox.omar-scdf-sqs');


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 140, true);


--
-- Data for Name: ht_layer_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ht_namespace_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ht_repository; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ht_workspace_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO image (id, version, filename, image_id, sensor_model) VALUES (102, 0, '/data/s3/msp/Stereo/test/B.NTF', '19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001', 'WV03_EO_BASIC_DG_5.1.0');
INSERT INTO image (id, version, filename, image_id, sensor_model) VALUES (105, 0, '/data/s3/msp/Stereo/test/A.NTF', '19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001', 'WV03_EO_BASIC_DG_5.1.0');


--
-- Data for Name: image_tie_point; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO image_tie_point (image_tie_points_id, tie_point_id) VALUES (102, 103);
INSERT INTO image_tie_point (image_tie_points_id, tie_point_id) VALUES (102, 104);
INSERT INTO image_tie_point (image_tie_points_id, tie_point_id) VALUES (105, 106);
INSERT INTO image_tie_point (image_tie_points_id, tie_point_id) VALUES (105, 107);


--
-- Data for Name: ingest_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (100, 592, '', '2017-08-13 06:58:52.558', NULL, '2017-08-13 06:59:02.154', '/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.ntf', '2017-08-13 06:58:50.487', '2017-08-13 06:58:46.118', '2017-08-13 06:59:00.559', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (101, 567, '', '2017-08-13 06:59:10.944', NULL, '2017-08-13 06:59:40.56', '/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.TIF', '2017-08-13 06:59:05.497', '2017-08-13 06:59:03.127', '2017-08-13 06:59:35.59', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (102, 571, '', '2017-08-13 07:00:17.653', NULL, '2017-08-13 07:01:27.783', '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.TIF', '2017-08-13 06:59:50.487', '2017-08-13 06:59:46.108', '2017-08-13 07:00:20.56', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (107, 3, NULL, NULL, NULL, '2017-07-12 20:59:52.859', 's3://o2-test-data/brevard/q3305nw.tif', NULL, '2017-07-12 20:06:17.023', '2017-07-12 20:59:45.913', NULL, NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (92, 737, '', '2017-08-13 06:51:01.565', NULL, '2017-08-13 06:51:17.601', '/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.TIF', '2017-08-13 06:50:50.492', '2017-08-13 06:50:46.239', '2017-08-13 06:51:05.582', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (103, 603, '', '2017-08-13 07:02:21.394', NULL, '2017-08-13 07:03:31.798', '/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.TIF', '2017-08-13 07:01:50.487', '2017-08-13 07:01:46.211', '2017-08-13 07:02:25.559', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (93, 675, '', '2017-08-13 06:51:53.624', NULL, '2017-08-13 06:51:57.606', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.ntf', '2017-08-13 06:51:50.488', '2017-08-13 06:51:46.29', '2017-08-13 06:51:55.564', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (104, 558, '', '2017-08-13 07:04:02.434', NULL, '2017-08-13 07:04:08.44', '/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.ntf', '2017-08-13 07:03:50.487', '2017-08-13 07:03:46.108', '2017-08-13 07:04:05.564', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (94, 664, '', '2017-08-13 06:52:39.821', NULL, '2017-08-13 06:54:17.843', '/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.TIF', '2017-08-13 06:52:05.488', '2017-08-13 06:52:02.561', '2017-08-13 06:52:40.568', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (105, 14, NULL, NULL, '2017-08-13 11:41:04.039', '2017-08-13 11:41:04.024', '/data/s3/msp/Stereo/test/A.NTF', NULL, '2017-05-22 15:55:49.794', '2017-08-13 11:41:03.972', 'FINISHED', 'Added dataset');
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (106, 6, NULL, NULL, '2017-08-13 11:41:09.005', '2017-08-13 11:41:08.999', '/data/s3/msp/Stereo/test/B.NTF', NULL, '2017-05-22 16:00:22.502', '2017-08-13 11:41:08.955', 'FINISHED', 'Added dataset');
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (95, 610, '', '2017-08-13 06:55:02.382', NULL, '2017-08-13 06:55:08.324', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.ntf', '2017-08-13 06:54:50.488', '2017-08-13 06:54:46.103', '2017-08-13 06:55:05.563', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (96, 607, '', '2017-08-13 06:55:55.471', NULL, '2017-08-13 06:55:57.782', '/data/s3/2009/02/05/00/po_106005_pan_0000000.ntf', '2017-08-13 06:55:50.487', '2017-08-13 06:55:46.132', '2017-08-13 06:55:55.557', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (97, 630, '', '2017-08-13 06:56:07.703', NULL, '2017-08-13 06:56:31.861', '/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.TIF', '2017-08-13 06:56:05.491', '2017-08-13 06:56:00.727', '2017-08-13 06:56:30.584', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (98, 601, '', '2017-08-13 06:57:04.18', NULL, '2017-08-13 06:57:48.985', '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.TIF', '2017-08-13 06:56:50.487', '2017-08-13 06:56:46.106', '2017-08-13 06:57:05.562', 'RUNNING', NULL);
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (108, 3, NULL, NULL, '2017-08-07 14:20:34.596', '2017-08-07 14:20:34.581', '/s3/o2-test-data/geoint_demo/strips/056599178010_01/056599178010_01_P001_PAN/16OCT22190744-P1BS-056599178010_01_P001.TIF', NULL, '2017-08-07 14:11:34.032', '2017-08-07 14:11:34.032', 'FINISHED', 'Added dataset');
INSERT INTO ingest_metrics (id, version, description, end_copy, end_date, end_staging, ingest_id, start_copy, start_date, start_staging, status, status_message) VALUES (99, 615, '', '2017-08-13 06:57:55.554', NULL, '2017-08-13 06:58:23.3', '/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.tif', '2017-08-13 06:57:50.49', '2017-08-13 06:57:49.921', '2017-08-13 06:58:20.584', 'RUNNING', NULL);


--
-- Name: ingest_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ingest_metrics_id_seq', 108, true);


--
-- Data for Name: layer_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO layer_info (id, version, description, keywords, name, title, workspace_info_id, layer_info_list_idx) VALUES (22, 0, '', '\xaced0005757200135b4c6a6176612e6c616e672e537472696e673badd256e7e91d7b470200007870000000037400046f6d617274000c7261737465725f656e7472797400086665617475726573', 'raster_entry', 'raster_entry', 12, 0);
INSERT INTO layer_info (id, version, description, keywords, name, title, workspace_info_id, layer_info_list_idx) VALUES (23, 0, '', '\xaced0005757200135b4c6a6176612e6c616e672e537472696e673badd256e7e91d7b470200007870000000037400046f6d617274000e766964656f5f646174615f7365747400086665617475726573', 'video_data_set', 'video_data_set', 12, 1);


--
-- Name: layer_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('layer_info_id_seq', 23, true);


--
-- Data for Name: namespace_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO namespace_info (id, version, prefix, uri) VALUES (12, 0, 'omar', 'http://omar.ossim.org');


--
-- Name: namespace_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('namespace_info_id_seq', 12, true);


--
-- Data for Name: omar_stage_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO omar_stage_file (id, version, build_histograms, build_histograms_withr0, build_overviews, date_created, filename, overview_compression_type, overview_type, process_id, status, status_message, use_fast_histogram_staging) VALUES (2407, 1, true, false, true, '2017-06-22 04:21:06.554', '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.TIF', 'NONE', 'ossim_tiff_box', '9f645c60-95e3-4163-80a7-f12bea6ed825', 'RUNNING', '', false);
INSERT INTO omar_stage_file (id, version, build_histograms, build_histograms_withr0, build_overviews, date_created, filename, overview_compression_type, overview_type, process_id, status, status_message, use_fast_histogram_staging) VALUES (2410, 1, true, false, true, '2017-06-22 04:33:11.51', '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.TIF', 'NONE', 'ossim_tiff_box', 'ee27ddce-627b-4fe6-b5ce-342f7cd2b620', 'RUNNING', '', false);


--
-- Name: omar_stage_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('omar_stage_file_id_seq', 2482, true);


--
-- Data for Name: opir_raster_data_set; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: opir_raster_data_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('opir_raster_data_set_id_seq', 1, false);


--
-- Data for Name: opir_raster_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: opir_raster_entry_file; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: opir_raster_entry_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('opir_raster_entry_file_id_seq', 1, false);


--
-- Name: opir_raster_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('opir_raster_entry_id_seq', 1, false);


--
-- Data for Name: opir_raster_file; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: opir_raster_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('opir_raster_file_id_seq', 1, false);


--
-- Data for Name: photo_block; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO photo_block (id, version, photo_block) VALUES (108, 0, '{"images": [{"imageId": "19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                    ", "filename": "/data/s3/msp/Stereo/test/B.NTF", "entryIndex": 0, "modelState": "WV03_EO_BASIC_DG_5.1.0 BEGIN\nmodelVersion = 5.1.0\nsensorModelName = WV03_EO_BASIC_DG_5.1.0\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 0 3.7 20\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 4 5\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationGroup::2 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 6 7 10 11 14 15\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::2 END\nCorrelationGroup::3 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 8 12\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::3 END\nCorrelationGroup::4 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 9 13\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::4 END\nCorrelationGroup::5 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 16 17 18\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::5 END\nCorrelationGroup::6 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103630Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 19\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::6 END\nCorrelationModel::CorrelationModel END\nCovarianceModel::1B BEGIN\ncurrentCovariance = 0.5945394019691393 -0.1234362819226396 0.5484146384539952 0 0 0 0.001717460102033255 -3.601371772511502e-07 0 0 0.0004309623407945463 -9.0339393077255e-08 0 0 3.750666065329076e-06 -9.627734282878455e-10 0 0 0 0 0.6055820975020297 -0.6933111405353359 0 0 0 -0.227594595613939 2.347492115948331e-05 0 0 -0.05711604575589848 5.886403647028971e-06 0 0 -0.0004530218120107812 7.489954216011829e-08 0 0 0 0 3.517743885163133 0 0 0 -0.054723417279942 4.338581135748867e-06 0 0 -0.01373343391048386 1.087669258096867e-06 0 0 -0.0001065559102523203 1.517206257349913e-08 0 0 0 0 5.458337080083767e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.547495164604733e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.835595869127076e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.811336640293292 0.000120940061998147 0 0 -0.2975634553402253 3.03132691708736e-05 0 0 -0.002356981767855047 1.283292322342272e-06 0 0 0 0 0.003610202965894607 0 0 3.01680972745322e-05 -1.73518351616071e-07 0 0 1.543328175571649e-06 -2.070281038296958e-09 0 0 0 0 5.880364597055165e-13 0 0 0 0 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 0 0 0 0 3.922383672237822 7.660974750574782e-06 0 0 -0.0005911850706080191 -3.157483761257914e-06 0 0 0 0 0.003610951771258602 0 0 3.482308812131574e-07 1.852220981546136e-09 0 0 0 0 5.890797876695161e-13 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 15.98822863650602 4.730118994443306e-07 0 0 0 0 0.01444401003084583 0 0 0 0 0.02150787511459009 0 0 0 1.508765764438954e-16 0 0 1.511442703066091e-16 0 8.696538449011793e-13\ngridSize = 4 4 4\nheightRange = -1000 4000\noriginalCovariance = 0.5945419375557768 -0.1237660281712724 0.548335690776579 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6492681272332057 -0.6828077714669443 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3.520271569360592 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.458337080083767e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.547495164604733e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.835595869127076e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3.997058620594215 3.87776627970316e-07 0 0 4.585717134971833e-08 8.476302323023005e-08 0 0 -5.259680132234588e-10 8.968770582023395e-07 0 0 0 0 0.003610933350702486 0 0 8.430040204855421e-08 9.76099180969973e-09 0 0 4.072701708045495e-10 -4.70779487041361e-10 0 0 0 0 5.880364597055165e-13 0 0 0 0 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 0 0 0 0 3.997058921736611 1.174894536140818e-07 0 0 4.87725867974602e-09 -3.254088626577435e-06 0 0 0 0 0.003610997762519207 0 0 -3.890221655954662e-08 2.25359006707423e-09 0 0 0 0 5.890797876695161e-13 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 15.98823568697435 4.694122445444175e-07 0 0 0 0 0.0144440100343615 0 0 0 0 0.02150787511459009 0 0 0 1.508765764438954e-16 0 0 1.511442703066091e-16 0 8.696538449011793e-13\nunmodeledError = 0.5 0 0.5\nunmodeledErrorCorrelation = 0.05\nCovarianceModel::1B END\nIsdModel::1B BEGIN\nIsdBase::Attitude BEGIN\nattCov = 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16\nattData = 0.8822326188027296 0.05440124274766062 -0.4631486704127584 -0.06480293359780738 0.8822244644973914 0.05438963733958284 -0.463161899737311 -0.06482913098356874 0.8822163098858076 0.05437803121056685 -0.4631751275618541 -0.06485532746961899 0.8822081549765515 0.05436642430831035 -0.4631883538791408 -0.06488152303645102 0.8821999997662799 0.05435481665430543 -0.4632015786921086 -0.06490771769205037 0.8821918442580562 0.05434320823039219 -0.4632148019982182 -0.06493391142961684 0.882183688445379 0.05433159907758526 -0.4632280238031092 -0.06496010426442696 0.8821755323341568 0.05431998916008797 -0.4632412441018101 -0.06498629618313582 0.8821673759259692 0.05430837846894059 -0.4632544628930498 -0.06501248718235755 0.8821592192123872 0.05429676705706937 -0.4632676801841171 -0.06503867728181797 0.8821510622014582 0.05428515487545705 -0.4632808959682108 -0.06506486646323402 0.8821429048907664 0.05427354193985082 -0.4632941102474767 -0.06509105473244714 0.8821347472834581 0.05426192823158702 -0.4633073230193032 -0.0651172420824679 0.882126589370944 0.05425031380456385 -0.4633205342911192 -0.06514342853338653 0.882118431161713 0.0542386986070509 -0.463333744055743 -0.06516961406590549 0.8821102726533748 0.0542270826546313 -0.4633469523152995 -0.06519579868580518 0.8821021138479617 0.05421546593553389 -0.4633601590681299 -0.06522198238867019 0.8820939547388477 0.05420384849150363 -0.463373364319985 -0.06524816519005294 0.8820857953326539 0.05419223028237329 -0.4633865680652794 -0.06527434707497345 0.8820776356312451 0.05418061129743059 -0.463399770302496 -0.06530052803939047 0.8820694756244525 0.05416899160029796 -0.4634129710404203 -0.06532670810702929 0.882061315322311 0.05415737112972754 -0.4634261702705431 -0.06535288725503466 0.8820531547216255 0.05414574990626422 -0.4634393679956793 -0.06537906549104124 0.8820449938247384 0.05413412791622591 -0.4634525642139036 -0.06540524280991922 0.88203683262485 0.05412250520240705 -0.4634657589311189 -0.06543141922761501 0.8820286711285993 0.05411088172455124 -0.4634789521417213 -0.06545759472911353 0.8820205093375998 0.05409925747350883 -0.4634921438444083 -0.06548376931095685 0.8820123472428355 0.05408763250573874 -0.4635053340469826 -0.06550994299419714 0.8820041848529824 0.0540760067684279 -0.4635185227420943 -0.06553611575912724 0.8819960221647788 0.05406438028251271 -0.4635317099326171 -0.06556228761352922 0.8819878591820967 0.05405275302488097 -0.463544895615314 -0.06558845854874951 0.8819796958964401 0.05404112504876607 -0.4635580797975448 -0.06561462858463672 0.8819715323156015 0.05402949630682411 -0.4635712624727139 -0.06564079770352575 0.8819633684402542 0.05401786679570318 -0.4635844436403238 -0.06566696590412448 0.8819552042624866 0.05400623656502273 -0.4635976233072354 -0.06569313320493242 0.8819470397897194 0.05399460556974034 -0.46361080146717 -0.06571929958914324 0.8819388750202787 0.05398297382098469 -0.4636239781216426 -0.06574546506087549 0.8819307099563809 0.05397134130587176 -0.463637153268833 -0.0657716296152963 0.8819225445902035 0.05395970807344847 -0.463650326915528 -0.06579779327069248 0.8819143789301429 0.053948074072671 -0.4636634990546107 -0.06582395600801426 0.8819062129732519 0.05393643932251842 -0.463676669688688 -0.06585011783431372 0.8818980467227686 0.0539248038038096 -0.463689838815063 -0.06587627874240459 0.8818898801701596 0.05391316756995852 -0.4637030064411344 -0.06590243875220693 0.8818817133241965 0.05390153056762451 -0.4637161725594615 -0.06592859784381136 0.8818735461843924 0.0538898928006175 -0.4637293371705407 -0.06595475601860178 0.8818653787435273 0.05387825431423877 -0.4637425002806465 -0.06598091329346779 0.8818572110089026 0.05386661506422617 -0.4637556618835965 -0.06600706965189133 0.8818490429786161 0.05385497506310757 -0.463768821981103 -0.06603322509851467 0.8818408746552082 0.05384333429601098 -0.463781980571066 -0.06605937962776108 0.8818327060304531 0.0538316928144202 -0.4637951376606252 -0.06608553325883186 0.8818245371136375 0.05382005056185828 -0.4638082932418924 -0.06611168597064278 0.8818163679028415 0.05380840755095618 -0.4638214473165951 -0.06613783776787489 0.8818081983922603 0.05379676381827117 -0.4638345998897964 -0.06616398866415189 0.8818000285890745 0.05378511932031364 -0.4638477509554138 -0.06619013864324239 0.8817918584903166 0.05377347407616148 -0.4638609005160753 -0.06621628771223738 0.8817836880994238 0.0537618280654306 -0.4638740485689101 -0.06624243586349914 0.8817755174076546 0.05375018134274935 -0.463887195121504 -0.0662685831174069 0.8817673464249112 0.05373853384788055 -0.4639003401654365 -0.06629472945146822 0.8817591751490814 0.05372688559463527 -0.463913483702601 -0.06632087487080592 0.881751003573692 0.05371523662366343 -0.4639266257386371 -0.06634701939057532 0.8817428317066203 0.05370358688721071 -0.4639397662668616 -0.06637316299294863 0.8817346595448573 0.0536919364045983 -0.4639529052899385 -0.06639930568510892 0.8817264870916265 0.05368028515677242 -0.4639660428051795 -0.06642544745991479 0.8817183143390277 0.0536686331931456 -0.4639791788194516 -0.06645158833579824 0.8817101412942697 0.05365698047009647 -0.4639923133266443 -0.06647772829647548 0.8817019679568264 0.05364532699166219 -0.4640054463272887 -0.06650386734341622 0.8816937943270373 0.05363367275653822 -0.4640185778211739 -0.0665300054761141 0.8816856203987731 0.05362201780322669 -0.4640317078136476 -0.06655614270892354 0.8816774461792456 0.05361036208810129 -0.4640448362985941 -0.06658227902555784 0.8816692716689478 0.05359870560893257 -0.4640579632756692 -0.06660841442514372 0.8816610968599567 0.0535870484152473 -0.4640710887517639 -0.06663454892615847 0.8816529217603498 0.05357539045810496 -0.4640842127200163 -0.06666068251032739 0.8816447463668733 0.05356373175831745 -0.4640973351833041 -0.0666868151853923 0.8816365706839674 0.05355207228936201 -0.46411045613789 -0.06671294694141768 0.8816283947023363 0.05354041210918579 -0.4641235755918475 -0.06673907780003059 0.8816202184298272 0.05352875117028557 -0.4641366935385112 -0.06676520774349254 0.8816120418680048 0.05351708946384363 -0.4641498099766148 -0.06679133676846671 0.8816038650076211 0.0535054270474991 -0.4641629249141926 -0.06681746489646623 0.8815956878577516 0.05349376386620834 -0.4641760383435216 -0.06684359210693197 0.8815875104152484 0.05348209994011855 -0.4641891502673884 -0.06686971840735803 0.8815793326831097 0.05347043525158597 -0.4642022606832951 -0.06689584379112806 0.8815711546532626 0.05345876985100734 -0.4642153695982676 -0.06692196827704851 0.8815629763334638 0.05344710369146041 -0.4642284770057141 -0.06694809184759569 0.8815547977251318 0.05343543676503566 -0.4642415829044942 -0.06697421449977213 0.8815466188191851 0.05342376912831185 -0.464254687302503 -0.06700033625469722 0.8815384396240522 0.05341210073025325 -0.4642677901925693 -0.0670264570933079 0.8815302601368741 0.05340043158921856 -0.464280891577234 -0.06705257702243071 0.8815220803612385 0.05338876168395566 -0.4642939914534895 -0.06707869603409869 0.8815139002887843 0.0533770910665995 -0.4643070898286137 -0.06710481414777096 0.8815057199268928 0.05336541969256341 -0.4643201866963347 -0.06713093134679501 0.8814975392746204 0.05335374756843688 -0.4643332820575449 -0.06715704763359599 0.8814893583330551 0.05334207468832367 -0.4643463759113881 -0.06718316300594995 0.8814811770953279 0.05333040109517835 -0.4643594682638599 -0.06720927747988358 0.881472995569919 0.05331872673768664 -0.4643725591077397 -0.06723539103622696 0.8814648137551023 0.05330705162724196 -0.4643856484445939 -0.06726150367920215 0.8814566316453138 0.05329537579878318 -0.4643987362792957 -0.06728761542183848 0.8814484492465803 0.05328369921606038 -0.464411822606736 -0.06731372625059984 0.8814402665577967 0.05327202188665381 -0.4644249074279471 -0.06733983616828222 0.8814320835813561 0.05326034379665908 -0.4644379907409479 -0.06736594516966594 0.8814239003090787 0.05324866499704712 -0.4644510725528664 -0.06739205327377827 0.8814157167494026 0.05323698543679389 -0.4644641528565145 -0.06741816046155563 0.8814075329016912 0.05322530512060157 -0.4644772316525208 -0.06744426673471744 0.8813993487591157 0.05321362409114197 -0.4644903089468509 -0.06747037210918773 0.8813911643291511 0.05320194230331184 -0.4645033847331452 -0.06749647656811641 0.8813829796094563 0.05319025977226206 -0.4645164590135012 -0.06752258011713223 0.8813747946026897 0.05317857648246897 -0.4645295317857081 -0.06754868275040894 0.8813666093009919 0.05316689248291135 -0.4645426030566226 -0.06757478448623129 0.8813584237124131 0.05315520772496925 -0.464555672819386 -0.06760088530643237 0.8813502378375992 0.05314352220548361 -0.4645687410735223 -0.06762698520979087 0.8813420516669569 0.05313183598404582 -0.4645818078273833 -0.06765308421856302 0.8813338652110984 0.05312014899634585 -0.4645948730719011 -0.06767918230871067 0.8813256784657912 0.05310846126912196 -0.4646079368108053 -0.06770527949019862 0.8813174914338409 0.05309677278595702 -0.4646209990417572 -0.06773137575686566 0.8813093041079901 0.05308508359210768 -0.4646340597710978 -0.06775747112560615 0.8813011164958641 0.05307339364158897 -0.4646471189923314 -0.067783565579237 0.8812929285958347 0.05306170294517167 -0.464660176706943 -0.0678096591217488 0.881284740408671 0.05305001149892221 -0.4646732329143503 -0.06783575175165132 0.8812765519289565 0.05303831933680275 -0.4646862876193072 -0.06786184348161384 0.8812683631625975 0.05302662642337583 -0.4646993408167999 -0.06788793429839872 0.8812601741114598 0.05301493274801216 -0.4647123925052981 -0.06791402419798889 0.8812519847667041 0.0530032383656274 -0.4647254426925115 -0.06794011320089557 0.8812437951364706 0.05299154322711154 -0.4647384913714968 -0.06796620128876388 0.8812356052181339 0.05297984734933227 -0.4647515385446004 -0.06799228846786692 0.8812274150152268 0.05296815071144003 -0.4647645842088535 -0.06801837473038332 0.881219224518982 0.05295645336788933 -0.4647776283719061 -0.06804446009665334 0.8812110337375434 0.05294475526956372 -0.4647906710268092 -0.06807054454831825 0.8812028426718964 0.05293305641123208 -0.4648037121727923 -0.06809662808338085 0.8811946513134836 0.05292135684604939 -0.4648167518173255 -0.06812271072169616 0.8811864596701132 0.05290965652696842 -0.4648297899537486 -0.0681487924456787 0.8811782677396482 0.05289795546785597 -0.4648428265839876 -0.06817487326047944 0.8811700755249413 0.05288625365203769 -0.4648558617056593 -0.06820095315983878 0.8811618830179213 0.05287455112967351 -0.4648688953258166 -0.06822703216249215 0.8811536902269292 0.0528628478504743 -0.4648819274373366 -0.06825311024963951 0.8811454971516814 0.05285114381697135 -0.4648949580405444 -0.0682791874221889 0.8811373037845668 0.05283943907649991 -0.4649079871420972 -0.06830526369781971 0.8811291101335424 0.05282773358112793 -0.4649210147352019 -0.06833133905861291 0.8811209161961507 0.05281602734668085 -0.4649340408220627 -0.06835741351045325 0.8811127219747878 0.05280432035927907 -0.4649470654006903 -0.06838348704812658 0.8811045274625123 0.05279261266214756 -0.4649600884771639 -0.06840955968777473 0.8810963326669238 0.05278090420955959 -0.4649731100449986 -0.06843563141230322 0.8810881375846127 0.05276919502314784 -0.4649861301072214 -0.06846170222977113 0.8810799422192988 0.05275748508095294 -0.464999148660698 -0.06848777213193906 0.8810717465630585 0.05274577443218078 -0.4650121657123596 -0.06851384113718928 0.8810635506239878 0.05273406302809339 -0.4650251812552894 -0.06853990922729865 0.8810553544019341 0.0527223508704149 -0.4650381952896989 -0.06856597640287321 0.8810471578888978 0.05271063800880749 -0.465051207822587 -0.06859204268246716 0.8810389610934499 0.0526989243916357 -0.4650642188466241 -0.06861810804677136 0.881030764012339 0.05268721003955865 -0.4650772283647028 -0.0686441725034815 0.8810225666495904 0.05267549492875902 -0.4650902363734227 -0.06867023604366153 0.8810143689954529 0.05266377911957764 -0.4651032428812994 -0.06869629868986542 0.8810061710597046 0.0526520625530295 -0.4651162478799572 -0.06872236042003074 0.8809979728416586 0.05264034523410322 -0.4651292513700704 -0.06874842123598603 0.8809897743336871 0.05262862721015781 -0.4651422533583199 -0.0687744811554255 0.880981575543749 0.05261690843333113 -0.4651552538379014 -0.06880054016045045 0.8809733764688622 0.05260518892261799 -0.4651682528114763 -0.06882659825813438 0.8809651771133378 0.05259346865247561 -0.4651812502753948 -0.06885265543889409 0.88095697746709 0.05258174768524816 -0.4651942462384671 -0.06887871172603653 0.880948777539357 0.05257002596528137 -0.4652072406927799 -0.0689047670987438 0.8809405773311499 0.05255830348719773 -0.4652202336375383 -0.06893082155496272 0.8809323768332609 0.05254658030797317 -0.4652332250807942 -0.06895687511599131 0.8809241760535615 0.05253485638030068 -0.465246215015816 -0.06898292776413655 0.8809159749911093 0.05252313171072318 -0.4652592034435001 -0.06900897950180943 0.8809077736471147 0.05251140629262781 -0.4652721903628794 -0.06903503032651505 0.8808995720143523 0.05249968017087332 -0.4652851757802922 -0.06906108025501488 0.8808913701005273 0.05248795329918773 -0.4652981596891482 -0.06908712927000216 0.8808831679036306 0.05247622569061523 -0.4653111420912686 -0.06911317737632312 0.8808749654265259 0.05246449732846372 -0.4653241229842535 -0.06913922456770751 0.8808667626604596 0.05245276826689264 -0.4653371023757671 -0.06916527086440168 0.8808585596145111 0.05244103845127072 -0.4653500802580268 -0.06919131624596654 0.8808503562876003 0.0524293078889734 -0.4653630566320485 -0.06921736071512537 0.8808421526732861 0.05241757662005232 -0.4653760315034943 -0.06924340428684132 0.8808339487786339 0.05240584460216345 -0.4653890048663253 -0.06926944694527666 0.8808257446015247 0.05239411184901206 -0.4654019767224579 -0.06929548869552589 0.8808175401444164 0.05238237834638843 -0.4654149470698433 -0.06932152953224797 0.8808093353998984 0.05237064414023617 -0.4654279159149858 -0.06934756947261418 0.8808011303754747 0.05235890918555469 -0.4654408832514638 -0.06937360849979048 0.8807929250714677 0.05234717348117265 -0.4654538490790782 -0.06939964661329888 0.8807847194806901 0.0523354370716563 -0.4654668134041416 -0.06942568382979565 0.88077651360999 0.05232369991601878 -0.465479776220799 -0.06945172013394957 0.8807683074577023 0.05231196202518777 -0.4654927375305752 -0.06947775552981528 0.8807601010264932 0.05230022338369414 -0.4655056973312395 -0.06950379001157903 0.8807518943082722 0.05228848404159291 -0.4655186556298893 -0.06952982359795497 0.8807436873109805 0.05227674395124979 -0.4655316124197203 -0.06955585627111993 0.8807354800351317 0.0522650031103269 -0.4655445677003675 -0.0695818880301589 0.8807272724724533 0.05225326156997402 -0.4655575214790882 -0.06960791889419719 0.880719064631301 0.05224151928004775 -0.4655704737487165 -0.06963394884447048 0.880710856509378 0.05222977625531551 -0.4655834245113262 -0.06965997788647299 0.8807026481084665 0.05221803248569738 -0.4655963737654518 -0.06968600601640935 0.8806944394220799 0.05220628801145664 -0.4656093215168037 -0.06971203324932726 0.8806862304570813 0.0521945427915468 -0.4656222677595087 -0.06973805956986978 0.880678021211433 0.05218279683915612 -0.4656352124954163 -0.06976408498293969 0.8806698116884188 0.05217105013507065 -0.4656481557217578 -0.06979010948131871 0.8806616018786453 0.05215930273722566 -0.4656610974467678 -0.06981613308667793 0.8806533917920196 0.05214755458606965 -0.4656740376619297 -0.06984215577672469 0.8806451814273726 0.05213580568950538 -0.4656869763683387 -0.06986817755438136 0.8806369707777175 0.05212405609081217 -0.4656999135721421 -0.06989419843582789 0.8806287598501348 0.05211230574764612 -0.4657128492672754 -0.06992021840521907 0.8806205486427428 0.05210055467223965 -0.4657257834554532 -0.0699462374671001 0.8806123371585052 0.05208880284733647 -0.4657387161341837 -0.06997225561498557 0.8806041253888653 0.05207705032574755 -0.4657516473109786 -0.06999827286862881 0.8805959133421041 0.05206529705784428 -0.4657645769787294 -0.07002428920945343 0.8805877010192029 0.05205354303845192 -0.4657775051366642 -0.07005030463548069 0.8805794884108264 0.05204178832509854 -0.4657904317929736 -0.07007631916823309 0.8805712755264795 0.0520300328607314 -0.4658033569394836 -0.0701023327863505 0.880563062362416 0.05201827666890469 -0.4658162805795297 -0.07012834549862225 0.880554848922245 0.05200651972845231 -0.4658292027100576 -0.07015435729709661 0.880546635197424 0.05199476209206311 -0.4658421233385712 -0.07018036820148375 0.880538421196871 0.05198300370627169 -0.4658550424574047 -0.07020637819176673 0.8805302069199484 0.05197124457573939 -0.4658679600671922 -0.07023238726965356 0.8805219923586445 0.05195948474991873 -0.4658808761749788 -0.07025839545364249 0.8805137775220206 0.05194772417448449 -0.4658937907729713 -0.07028440272339301 0.8805055624069464 0.05193596286923888 -0.4659067038639719 -0.07031040908628913 0.8804973470159158 0.05192420081979957 -0.4659196154458938 -0.07033641453692116 0.8804891313412611 0.05191243807350921 -0.4659325255254852 -0.07036241909299779 0.8804809153913599 0.05190067458021709 -0.4659454340955451 -0.07038842273574199 0.8804726991631447 0.05188891035933309 -0.4659583411588214 -0.0704144254723911 0.8804644826599837 0.05187714539117409 -0.4659712467124673 -0.07044042729554792 0.8804562658734988 0.05186537972737865 -0.4659841507638501 -0.0704664282245331 0.8804480488121575 0.05185361331726683 -0.4659970533056882 -0.07049242824036958 0.8804398314754431 0.05184184616476321 -0.4660099543385123 -0.07051842734448971 0.8804316138563021 0.05183007831345476 -0.4660228538685396 -0.07054442555319651 0.8804233959623224 0.0518183097180101 -0.4660357518892518 -0.07057042284951724 0.8804151777910001 0.05180654039441165 -0.466048648402909 -0.07059641923940545 0.8804069593452698 0.05179477032561208 -0.4660615434070388 -0.07062241471645105 0.8803987406168841 0.05178299956243278 -0.4660744369088997 -0.07064840929967084 0.8803905216142082 0.05177122805484009 -0.4660873289012951 -0.07067440297032768 0.8803823023375521 0.05175945580174124 -0.4661002193840362 -0.07070039572797285 0.8803740827790955 0.05174768285134964 -0.466113108364011 -0.07072638759064614 0.8803658629461032 0.05173590916032068 -0.4661259958349791 -0.07075237854211784 0.880357642836307 0.05172413474319399 -0.4661388817989962 -0.07077836858780118 0.8803494224534129 0.05171235957826025 -0.4661517662529179 -0.07080435771953694 0.8803412017886574 0.05170058371943249 -0.4661646492044551 -0.07083034595750394 0.8803329808498742 0.05168880711993514 -0.4661775306468706 -0.07085633328418431 0.8803247596387187 0.05167702977051608 -0.4661904105788037 -0.07088231969606951 0.8803165381448932 0.05166525173437747 -0.4662032890093035 -0.07090830521682295 0.8803083163783668 0.05165347295181025 -0.4662161659297715 -0.07093428982407542 0.8803000943361713 0.05164169344158559 -0.4662290413428736 -0.0709602735248278 0.8802918720210008 0.0516299131881413 -0.4662419152463455 -0.07098625631322561 0.8802836494243339 0.05161813224388758 -0.4662547876476909 -0.0710122382088865 0.8802754265555328 0.0516063505528176 -0.4662676585388379 -0.07103821919082813 0.8802672034111907 0.05159456813635344 -0.4662805279228355 -0.07106419926704637 0.8802589799938642 0.05158278497976829 -0.4662933957975379 -0.07109017843199926 0.8802507562958751 0.05157100113034932 -0.4663062621697172 -0.07111615670338468 0.8802425323260148 0.05155921653556302 -0.4663191270317958 -0.07114213406152153 0.880234308083907 0.05154743119847475 -0.4663319903841825 -0.07116811050752057 0.8802260835612776 0.05153564516996709 -0.4663448522341703 -0.07119408606042922 0.88021785876614 0.05152385840223005 -0.4663577125748582 -0.07122006070233701 0.8802096336973655 0.05151207090288111 -0.4663705714073109 -0.07124603443606255 0.8802014083559372 0.05150028266673026 -0.4663834287307533 -0.07127200725964083 0.8801931827349925 0.05148849373609458 -0.4663962845512499 -0.0712979791889075 0.8801849568422797 0.05147670406478846 -0.4664091388621287 -0.07132395020656018 0.8801767306784497 0.05146491364965852 -0.4664219916629032 -0.07134992031137692 0.8801685042343811 0.05145312254668141 -0.4664348429616088 -0.07137588952431882 0.8801602775193291 0.05144133070056376 -0.466447692750258 -0.07140185782466556 0.8801520505305205 0.05142953812886791 -0.4664605410313507 -0.07142782521896712 0.8801438232703782 0.05141774481769289 -0.4664733878028547 -0.07145379170199005 0.8801355957313243 0.05140595081366287 -0.4664862330714631 -0.0714797572911882 0.8801273679212306 0.0513941560698691 -0.466499076830391 -0.0715057219689855 0.8801191398402275 0.05138236058630583 -0.4665119190796067 -0.07153168573534091 0.8801109114806311 0.05137056441022547 -0.4665247598258956 -0.07155764860794493 0.8801026828500793 0.05135876749614723 -0.4665375990626768 -0.07158361056975629 0.8800944539472525 0.05134696985283211 -0.4665504367911831 -0.07160957162402348 0.8800862247729659 0.05133517147610986 -0.4665632730107849 -0.07163553176916358 0.8800779953210908 0.05132337240381066 -0.466576107726913 -0.07166149101933299 0.8800697655981515 0.05131157259720211 -0.4665889409339563 -0.07168744936002147 0.8800615356038396 0.05129977205893253 -0.4666017726322653 -0.07171340679218383 0.8800533053384516 0.05128797078796547 -0.4666146028216628 -0.07173936331541318 0.8800450747955554 0.05127616882395171 -0.4666274315078465 -0.07176531894455029 0.8800368439829338 0.05126436612056808 -0.4666402586841044 -0.07179127366223501 0.8800286129000294 0.05125256268196521 -0.4666530843510044 -0.07181722746998613 0.8800203815400628 0.05124075854988252 -0.4666659085145488 -0.07184318038342911 0.8800121499108796 0.0512289536776263 -0.4666787311679688 -0.07186913238506382 0.8800039180092625 0.05121714808541689 -0.4666915523141561 -0.07189508348244013 0.8799956858388515 0.05120534175202011 -0.4667043719500135 -0.07192103366757079 0.879987453390777 0.05119353473178814 -0.4667171900833699 -0.07194698296081588 0.8799792206737636 0.05118172697273503 -0.4667300067066881 -0.07197293134268808 0.8799709876880076 0.05116991847445545 -0.4667428218198769 -0.07199887881299624 0.8799627544252493 0.05115810928760571 -0.4667556354302356 -0.07202482539071456 0.8799545208938099 0.05114629936264832 -0.4667684475305763 -0.0720507710572735 0.8799462870912647 0.05113448871500244 -0.4667812581230996 -0.0720767158184217 0.8799380530198343 0.05112267733201688 -0.4667940672059465 -0.07210265966939246 0.8799298186723357 0.05111086525782894 -0.4668068747854771 -0.07212860262671456 0.8799215840564647 0.05109905244669563 -0.4668196808550483 -0.07215454467324126 0.879913349172428 0.05108723889814899 -0.4668324854145606 -0.07218048580875797 0.8799051140121547 0.0510754246616716 -0.4668452884711517 -0.07220642605180111 0.8798968785837356 0.05106360968914937 -0.4668580900178315 -0.07223236538433261 0.8798886428850192 0.05105179399433861 -0.4668708900565627 -0.07225830381147795 0.8798804069185171 0.05103997756284605 -0.4668836885852313 -0.07228424132781572 0.879872170676355 0.05102816044294778 -0.4668964856108049 -0.0723101779514308 0.8798639341661803 0.05101634258922419 -0.4669092811266789 -0.07233611366529531 0.8798556973867615 0.05100452400987504 -0.4669220751340127 -0.07236204847244918 0.8798474603392128 0.05099270469894131 -0.4669348676319132 -0.07238798237063696 0.8798392230167256 0.05098088469825324 -0.4669476586264186 -0.07241391537552506 0.8798309854270728 0.05096906396165046 -0.466960448110812 -0.07243984746980611 0.8798227475701801 0.05095724249035665 -0.4669732360852407 -0.07246577865390091 0.8798145094387909 0.05094542032889872 -0.4669860225561351 -0.07249170894448892 0.8798062710397599 0.05093359743665802 -0.4669988075175813 -0.07251763832634286 0.8797980323723736 0.05092177381871273 -0.4670115909702849 -0.07254356680133071 0.8797897934377298 0.05090994946920019 -0.4670243729133676 -0.07256949436723326 0.8797815542286508 0.05089812443215527 -0.4670371533531934 -0.07259542104054649 0.8797733147531788 0.05088629865981655 -0.4670499322828067 -0.07262134680335984 0.8797650750110042 0.05087447215482938 -0.4670627097025601 -0.07264727165662785 0.8797568349955065 0.05086264495785597 -0.467075485618331 -0.07267319561558119 0.8797485947129824 0.05085081703166849 -0.4670882600246905 -0.07269911866626372 0.8797403541628493 0.0508389883805509 -0.4671010329222307 -0.07272504081024549 0.8797321133459149 0.05082715900039186 -0.4671138043103263 -0.07275096204596458 0.8797238722552924 0.05081532893344731 -0.4671265741950899 -0.0727768823892514 0.879715630899172 0.05080349813109082 -0.4671393425694327 -0.07280280182186799 0.8797073892776565 0.05079166659348412 -0.4671521094333467 -0.07282872034383636 0.8796991473825457 0.05077983437077775 -0.4671648747940953 -0.07285463797395259 0.879690905221878 0.05076800141527776 -0.4671776386447217 -0.0728805546943281 0.8796826627932457 0.0507561677422538 -0.467190400987417 -0.07290647051065914 0.8796744200997708 0.05074433333366377 -0.467203161819528 -0.07293238541615135 0.8796661771332824 0.05073249823946609 -0.4672159211482954 -0.07295829942953017 0.8796579339014657 0.05072066241410841 -0.4672286789670695 -0.07298421253371004 0.8796496904025822 0.05070882586882872 -0.4672414352774552 -0.07301012473287327 0.879641446638495 0.05069698859316676 -0.4672541900779024 -0.07303603602307303 0.8796332026020385 0.05068515063101281 -0.4672669433747727 -0.07306194642075675 0.8796249583011047 0.05067331193558725 -0.4672796951612332 -0.07308785590837652 0.8796167137360955 0.05066147250524506 -0.4672924454370131 -0.07311376448527569 0.8796084688977205 0.05064963239665075 -0.4673051942103381 -0.07313967217270148 0.8796002237956635 0.05063779155225412 -0.4673179414728031 -0.07316557894905866 0.8795919784269879 0.05062594999049456 -0.4673306872270644 -0.07319148482123575 0.8795837327945435 0.05061410769498291 -0.4673434314707052 -0.0732173897830579 0.879575486889591 0.05060226471904781 -0.467356174211471 -0.07324329385452064 0.8795672407213505 0.05059042100794824 -0.4673689154413603 -0.07326919701508275 0.8795589942893601 0.05057857656523708 -0.4673816551608601 -0.07329509926604034 0.8795507475856116 0.05056673143983464 -0.4673943933770757 -0.07332100062573377 0.8795425006180219 0.05055488558484751 -0.4674071300831471 -0.07334690107656923 0.8795342533848372 0.05054303901159061 -0.4674198652806948 -0.07337280062275904 0.879526005888416 0.05053119170664054 -0.4674325989677316 -0.07339869925924192 0.8795177581206934 0.05051934371923785 -0.4674453311514156 -0.07342459700448027 0.8795095100902619 0.0505074949984492 -0.4674580618242916 -0.07345049383936066 0.8795012617963048 0.05049564554995593 -0.4674707909871579 -0.07347638976597912 0.8794930132320274 0.05048379541535356 -0.4674835186460589 -0.07350228479992646 0.8794847644042559 0.05047194455433349 -0.4674962447950883 -0.07352817892608048 0.879476515311876 0.05046009297436185 -0.4675089694353059 -0.07355407214720795 0.8794682659568149 0.05044824066461067 -0.4675216925651024 -0.07357996445922237 0.8794600163312672 0.05043638767273629 -0.4675344141914116 -0.07360585587999327 0.8794517664432342 0.0504245339513826 -0.4675471343072933 -0.0736317463917489 0.8794435162902089 0.05041267951637675 -0.4675598529150306 -0.07365763600039826 0.87943526587559 0.05040082434806067 -0.4675725700117219 -0.07368352469853622 0.8794270151904261 0.05038896850095185 -0.4675852856053089 -0.07370941250661217 0.879418764243784 0.0503771119213147 -0.4675979996879142 -0.07373529940445545 0.8794105130350951 0.05036525461333689 -0.4676107122601186 -0.07376118539360131 0.8794022615565481 0.0503533966246772 -0.4676234233288648 -0.07378707049192269 0.8793940098165897 0.0503415379053358 -0.467636132886818 -0.07381295468065174 0.8793857578126995 0.05032967847121032 -0.4676488409362737 -0.07383883796572499 0.879377505547111 0.0503178183096487 -0.4676615474753526 -0.07386472034236935 0.8793692530120519 0.05030595746805815 -0.467674252510965 -0.07389060182836461 0.8793610002163879 0.05029409589394195 -0.4676869560354058 -0.07391648240400309 0.8793527471593404 0.05028223359274538 -0.4676996580494405 -0.07394236207129286 0.8793444938333747 0.0502703706104381 -0.4677123585597728 -0.07396824084747454 0.8793362402464088 0.0502585069002218 -0.467725057559528 -0.07399411871498114 0.87932798639575 0.05024664247901975 -0.4677377550511547 -0.0740199956801354 0.8793197322853872 0.05023477732365553 -0.4677504510312299 -0.07404587173420767 0.8793114779051917 0.05022291149564104 -0.4677631455087385 -0.07407174690028211 0.879303223265933 0.05021104493109223 -0.4677758384742978 -0.0740976211543679 0.8792949683652144 0.05019917764515792 -0.4677885299300963 -0.07412349450212105 0.87928671319714 0.05018730967394955 -0.4678012198814002 -0.07414936695707848 0.879278457767705 0.05017544098222729 -0.4678139083230222 -0.07417523850601614 0.8792702020766699 0.05016357157219425 -0.4678265952552549 -0.07420110914972396 0.8792619461257033 0.0501517014345991 -0.4678392806767139 -0.07422697888470597 0.8792536899062046 0.05013983062175695 -0.4678519645950445 -0.07425284773059192 0.8792454334270863 0.05012795908095231 -0.4678646470024931 -0.07427871566758684 0.8792371766866064 0.05011608682339329 -0.4678773279006735 -0.0743045826998659 0.8792289196856827 0.05010421384432791 -0.4678900072888609 -0.07433044882562492 0.8792206624177389 0.05009234018392771 -0.4679026851729229 -0.07435631405992915 0.8792124048900321 0.0500804657994088 -0.4679153615465593 -0.07438217838671643 0.8792041471041984 0.05006859068174436 -0.4679280364084124 -0.07440804180255382 0.8791958890504429 0.05005671489037074 -0.4679407097671828 -0.07443390432975161 0.8791876307373123 0.05004483837479722 -0.4679533816154341 -0.07445976594934843 0.8791793721633493 0.05003296114451718 -0.4679660519545311 -0.07448562666487547 0.8791711133307856 0.0500210831869158 -0.4679787207825924 -0.07451148647157158 0.8791628542309221 0.0500092045548477 -0.4679913881073562 -0.07453734538927353 0.8791545948726353 0.04999732519586155 -0.4680040539210942 -0.07456320339828129 0.879146335256314 0.04998544510840214 -0.4680167182235458 -0.07458906049797154 0.8791380753732881 0.04997356434513475 -0.468029381022426 -0.07461491670811113 0.879129815231852 0.04996168285711217 -0.4680420423105166 -0.07464077201031659 0.879121554829808 0.04994980065825034 -0.4680547020898347 -0.07466662640978287 0.8791132941697376 0.04993791773384917 -0.4680673603581902 -0.07469247990096395 0.8791050332436645 0.04992603413240553 -0.4680800171226893 -0.07471833250206041 0.8790967720597925 0.04991414980552644 -0.4680926723761912 -0.07474418419489587 0.8790885106185786 0.04990226475124609 -0.4681053261183756 -0.07477003497869267 0.8790802489106984 0.04989037902611666 -0.468117978357538 -0.07479588487468208 0.8790719869458552 0.049878492572784 -0.4681306290852151 -0.07482173386131626 0.8790637247213814 0.0498666054079759 -0.4681432783038393 -0.07484758194484847 0.8790554622391015 0.04985471752152261 -0.4681559260118859 -0.07487342912143605 0.8790471994916438 0.04984282895827603 -0.4681685722159319 -0.07489927540791087 0.8790389364872855 0.04983093966943383 -0.4681812169087688 -0.07492512078594037 0.8790306732228362 0.04981904967484066 -0.4681938600932899 -0.07495096526295068 0.8790224097018743 0.04980715895384508 -0.4682065017664249 -0.07497680883115584 0.8790141459162443 0.0497952675559695 -0.4682191419354431 -0.07500265150914633 0.8790058818733898 0.04978337543740995 -0.468231780593869 -0.07502849328046811 0.8789976175744298 0.04977148259224705 -0.4682444177407976 -0.07505433414285599 0.878989353010414 0.04975958907474023 -0.468257053384202 -0.07508017411668355 0.8789810881906381 0.04974769483002896 -0.4682696875159709 -0.07510601318133631 0.8789728231118368 0.04973579987839286 -0.4682823201390656 -0.0751318513444051 0.8789645577763228 0.0497239042067565 -0.4682949512515299 -0.07515768860095329 0.8789562921774045 0.04971200785586368 -0.468307580859347 -0.07518352496627113 0.8789480263222793 0.04970011078341102 -0.4683202089562541 -0.07520936042446695 0.8789397602112011 0.04968821298864596 -0.4683328355421089 -0.0752351949752192 0.8789314938364828 0.04967631451825226 -0.4683454606237747 -0.07526102863605395 0.878923227205881 0.04966441532659423 -0.4683580841944935 -0.07528686138982478 0.8789149603169591 0.04965251542898921 -0.4683707062564972 -0.07531269324225658 0.8789066931735391 0.04964061480335618 -0.4683833268064972 -0.07533852418502356 0.8788984257657837 0.04962871350920044 -0.4683959458532544 -0.07536435424047734 0.8788901581030121 0.04961681149157022 -0.4684085633886314 -0.07539018338796494 0.8788818901854069 0.04960490875014446 -0.4684211794125488 -0.07541601162732703 0.8788736220043661 0.04959300533703465 -0.4684337939326801 -0.07544183897813463 0.8788653535688874 0.04958110119922673 -0.4684464069411694 -0.07546766542046253 0.878857084875487 0.04956919635828105 -0.4684590184411735 -0.07549349096238572 0.8788488159274805 0.04955729079514618 -0.4684716284298486 -0.07551931559671715 0.8788405467171432 0.04954538455668796 -0.4684842369140965 -0.07554513934105536 0.8788322772521062 0.0495334775980623 -0.4684968438872648 -0.07557096217854811 0.8788240075298096 0.04952156993530486 -0.4685094493516955 -0.07559678411519193 0.878815737553892 0.04950966154745177 -0.4685220533042598 -0.07562260514307964 0.878807467314725 0.04949775249270177 -0.4685346557535412 -0.07564842528407607 0.8787991968218875 0.04948584271461019 -0.4685472566911661 -0.07567424451696199 0.8787909260756882 0.04947393221209832 -0.4685598561169441 -0.07570006284129288 0.878782655067011 0.04946202104030074 -0.4685724540390085 -0.07572588027778167 0.8787743838041978 0.04945010915015956 -0.4685850504500761 -0.07575169680798814 0.8787661122859313 0.04943819655029305 -0.4685976453513933 -0.07577751243511764 0.8787578405137642 0.04942628323218518 -0.4686102387416712 -0.0758033271559472 0.8787495684796459 0.04941436924459589 -0.4686228306281044 -0.07582914098879211 0.878741296192956 0.04940245453229573 -0.4686354210024908 -0.07585495391288744 0.8787330236524207 0.04939053910364797 -0.4686480098660381 -0.07588076593134285 0.8787247508508064 0.04937862300252618 -0.4686605972252209 -0.07590657706063519 0.8787164777963659 0.04936670618043442 -0.4686731830728306 -0.07593238728253329 0.878708204486178 0.04935478865554591 -0.4686857674115312 -0.07595819660383986 0.8786999309234267 0.04934287040962827 -0.468698350238592 -0.07598400501767381 0.8786916570992532 0.04933095149622519 -0.4687109315619256 -0.07600981254415373 0.8786833830227541 0.04931903186183003 -0.468723511373576 -0.07603561916316048 0.878675108694392 0.0493071115044507 -0.468736089673216 -0.07606142487390578 0.8786668341044991 0.04929519048244017 -0.468748666469476 -0.07608722969831998 0.8786585592630178 0.04928326873726264 -0.4687612417536496 -0.07611303361438933 0.8786502841664545 0.04927134629049275 -0.4687738155289085 -0.07613883663019824 0.8786420088177888 0.04925942312512452 -0.4687863877927012 -0.07616463873932651 0.8786337332090665 0.04924749928928145 -0.4687989585521444 -0.07619043995985467 0.8786254573486427 0.04923557473390566 -0.4688115277999333 -0.07621624027333586 0.8786171812333032 0.0492236494788951 -0.4688240955389936 -0.0762420396872239 0.8786089048664654 0.04921172350464576 -0.4688366617663857 -0.07626783819411978 0.8786006282403771 0.04919979685806064 -0.4688492264890498 -0.07629363581164599 0.8785923513624982 0.04918786949542894 -0.4688617897004705 -0.07631943252336763 0.8785840742330285 0.04917594141632407 -0.4688743514005542 -0.07634522832908565 0.878575796844574 0.0491640126655055 -0.4688869115959257 -0.07637102324561656 0.8785675192050757 0.04915208319641066 -0.4688994702796425 -0.07639681725545065 0.8785592413111675 0.04914015302982915 -0.4689120274547663 -0.07642261036637847 0.8785509631667741 0.04912822214314693 -0.468924583117907 -0.07644840256986639 0.8785426847638579 0.04911629058494002 -0.468937137276261 -0.07647419388416954 0.8785344061094498 0.04910435831407423 -0.4689496899236896 -0.07649998429382111 0.878526127204967 0.04909242532287984 -0.4689622410590211 -0.07652577379589423 0.8785178480412499 0.04908049166659471 -0.4689747906904463 -0.07655156241115404 0.8785095686276222 0.04906855729045688 -0.4689873388097963 -0.07657735011900044 0.87850128896098 0.04905662221368321 -0.4689998854199011 -0.07660313692663252 0.878493009044053 0.04904468642078347 -0.4690124305184272 -0.0766289228281989 0.8784847288685518 0.04903274996179789 -0.4690249741127977 -0.07665470784250841 0.8784764484435148 0.04902081278368133 -0.4690375161950934 -0.07668049194960606 0.8784681677683995 0.04900887489041924 -0.469050056765877 -0.07670627515095466 0.8784598868356339 0.04899693632777912 -0.469062595831938 -0.07673205746375493 0.8784516056523248 0.04898499705420808 -0.4690751333870659 -0.0767578388723794 0.87844332421775 0.04897305707475712 -0.4690876694319834 -0.07678361937869245 0.8784350425329635 0.04896111638390081 -0.46910020396584 -0.07680939898059522 0.8784267605912549 0.04894917502226794 -0.4691127369946635 -0.07683517769335427 0.8784184783994802 0.04893723294981149 -0.4691252685124641 -0.07686095550190794 0.8784101959567422 0.04892529017261946 -0.4691377985201199 -0.07688673240851157 0.8784019132644713 0.04891334668293446 -0.4691503270164462 -0.07691250841022523 0.8783936303149247 0.04890140252750159 -0.4691628540083878 -0.07693828352462088 0.8783853471168851 0.04888945765484397 -0.4691753794882457 -0.07696405773232978 0.8783770636698085 0.04887751206895284 -0.4691879034565842 -0.07698983103481744 0.8783687799664048 0.04886556581387559 -0.4692004259199485 -0.07701560344864024 0.8783604960141688 0.04885361884579715 -0.4692129468717797 -0.07704137495731503 0.8783522118105336 0.04884167118071469 -0.4692254663144357 -0.07706714556683067 0.8783439273586011 0.04882972280094811 -0.4692379842452499 -0.0770929152705086 0.8783356426508016 0.04881777375219015 -0.4692505006710171 -0.07711868408552648 0.8783273576942601 0.04880582399283469 -0.469263015585504 -0.07714445199623209 0.8783190724900332 0.04879387351736771 -0.4692755289878563 -0.07717021900050969 0.8783107870299703 0.04878192237491858 -0.4692880408853855 -0.07719598511683286 0.8783025013217426 0.04876997052065073 -0.4693005512713725 -0.07722175032833137 0.8782942153627804 0.04875801797056847 -0.4693130601481793 -0.07724751464099751 0.8782859291567738 0.04874606470351055 -0.4693255675126164 -0.07727327804684002 0.8782776426948531 0.04873411077285737 -0.4693380733726347 -0.07729904056593603 0.878269355985517 0.04872215612887613 -0.4693505777207794 -0.07732480217956869 0.8782610690290124 0.04871020077085921 -0.4693630805569142 -0.07735056288743317 0.8782527818175742 0.04869824474562195 -0.4693755818880117 -0.07737632270713368 0.8782444943578441 0.04868628801445546 -0.4693880817082632 -0.07740208162410676 0.8782362066493815 0.04867433058073065 -0.4694005800181432 -0.07742783963958476 0.8782279186936138 0.04866237243671816 -0.4694130768164678 -0.0774535967506374 0.8782196304835636 0.04865041362454153 -0.469425572109513 -0.07747935297310185 0.8782113420255148 0.04863845410763273 -0.4694380658917855 -0.07750510829322058 0.8782030533197485 0.04862649388507734 -0.4694505581631193 -0.07753086271061072 0.8781947643667201 0.04861453295491286 -0.4694630489231927 -0.07755661622451518 0.8781864751589818 0.04860257136203568 -0.4694755381787017 -0.07758236885181798 0.878178185705225 0.04859060905562086 -0.4694880259220142 -0.07760812057338645 0.8781698960051679 0.04857864603809304 -0.4695005121534631 -0.07763387139009646 0.878161606051421 0.04856668235399658 -0.4695129968796934 -0.07765962131870005 0.8781533158510894 0.04855471796191585 -0.46952548009448 -0.07768537034361048 0.8781450254022187 0.04854275287418326 -0.4695379617996414 -0.07771111846943808 0.878136734708154 0.04853078707171692 -0.469550441992291 -0.07773686568897274 0.8781284437597967 0.04851882060916546 -0.4695629206805923 -0.07776261202277671 0.8781201525659962 0.04850685343479852 -0.4695753978567703 -0.07778835745137368 0.8781118611266858 0.04849488554976364 -0.4695878735209663 -0.07781410197515798 0.8781035694344236 0.04848291699888984 -0.4696003476798757 -0.07783984561099154 0.8780952774961346 0.04847094774185194 -0.4696128203274303 -0.07786558834369627 0.8780869853108683 0.04845897778503065 -0.4696252914645574 -0.07789133017563971 0.8780786928794579 0.04844700712422687 -0.4696377610906002 -0.07791707110522145 0.8780704001956734 0.04843503579707525 -0.469650229211179 -0.07794281114659225 0.8780621072672232 0.04842306375862573 -0.469662695819527 -0.07796855028282927 0.8780538140938269 0.04841109101129764 -0.4696751609159765 -0.07799428851480655 0.878045520667471 0.04839911760326804 -0.469687624507734 -0.07802002586065074 0.8780372269970134 0.04838714348280041 -0.4697000865870102 -0.07804576230087897 0.878028933079218 0.04837516866979859 -0.4697125471567647 -0.07807149784295812 0.8780206389170695 0.04836319314732908 -0.4697250062144276 -0.07809723248048603 0.8780123445028447 0.04835121696184484 -0.4697374637669492 -0.07812296623094031 0.878004049844098 0.04833924006933192 -0.4697499198076969 -0.07814869907774903 0.8779957549389173 0.0483272624818537 -0.4697623743384542 -0.07817443102542293 0.8779874597893879 0.04831528418781022 -0.4697748273574504 -0.07820016206957048 0.8779791643887266 0.04830330522806875 -0.4697872788708011 -0.07822589222556459 0.8779708687437017 0.04829132556328456 -0.4697997288725717 -0.07825162147859267 0.877962572855587 0.04827934518668002 -0.4698121773617114 -0.07827734982606056 0.8779542767153561 0.04826736415237791 -0.4698246243463339 -0.07830307728834114 0.8779459803320209 0.04825538240777796 -0.4698370698185066 -0.07832880384562176 0.8779376837029853 0.04824339996898071 -0.4698495137806218 -0.0783545295039365 0.8779293868304973 0.04823141682342831 -0.4698619562307633 -0.07838025425853189 0.8779210897066001 0.04821943301890273 -0.4698743971760948 -0.07840597812739099 0.8779127923396891 0.04820744850646391 -0.46988683660923 -0.07843170109208009 0.8779044947304022 0.04819546328309418 -0.4698992745296844 -0.07845742315142307 0.877896196869871 0.04818347740195598 -0.469911710945434 -0.07848314432543313 0.8778878987666506 0.04817149081317382 -0.4699241458489493 -0.07850886459532276 0.8778796004188251 0.04815950352882328 -0.469936579242019 -0.07853458396560868 0.8778713018274209 0.04814751554356494 -0.4699490111238123 -0.07856030243425975 0.8778630029863591 0.04813552689406407 -0.4699614414998253 -0.07858602001506815 0.8778547039023423 0.04812353754140709 -0.469973870364175 -0.07861173669337961 0.8778464045772723 0.04811154747511423 -0.4699862977152514 -0.07863745246520312 0.8778381050012961 0.04809955675412658 -0.4699987235619111 -0.07866316735273471 0.8778298051833637 0.04808756532626978 -0.470011147896269 -0.07868888133631681 0.8778215051209013 0.04807557320749525 -0.4700235707207007 -0.07871459442192912 0.8778132048170858 0.04806358037977054 -0.4700359920324604 -0.07874030660275161 0.8778049042626557 0.04805158689852655 -0.4700484118398806 -0.07876601789965797 0.8777966034677996 0.04803959270429368 -0.4700608301339707 -0.07879172829023694 0.8777883024280181 0.04802759782438465 -0.4700732469188221 -0.0788174377847549 0.8777800011474899 0.04801560223485998 -0.4700856621907956 -0.07884314637416273 0.8777716996171326 0.0480036059900745 -0.4700980759580669 -0.07886885407892967 0.8777633978457339 0.04799160903884679 -0.4701104882128909 -0.07889456087977008 0.8777550958334497 0.04797961138100766 -0.4701228989552118 -0.07892026677658183 0.8777467935724315 0.0479676130636176 -0.4701353081921071 -0.07894597178708339 0.8777384910697427 0.04795561404567937 -0.4701477159173669 -0.07897167589583026 0.8777301883245022 0.04794361433314116 -0.4701601221318599 -0.07899737910502898 0.8777218853384707 0.04793161391634452 -0.4701725268341002 -0.07902308141101796 0.8777135821036015 0.04791961284350223 -0.4701849300313444 -0.07904878283195163 0.8777052786280607 0.04790761106712796 -0.4701973317163974 -0.07907448334993575 0.877696974912926 0.0478956085816156 -0.4702097318883821 -0.07910018296281703 0.8776886709491998 0.04788360544077431 -0.4702221305554037 -0.07912588169086271 0.8776803667451136 0.04787160159674301 -0.4702345277102077 -0.07915157951603624 0.8776720622984914 0.04785959706310289 -0.470246923354818 -0.07917727644342484 0.8776637576121182 0.04784759182415944 -0.4702593174868342 -0.07920297246708848 0.8776554526777 0.04783558592955566 -0.4702717101137379 -0.07922866760572413 0.8776471475034031 0.04782357933182966 -0.4702841012283293 -0.07925436184144409 0.8776388420902228 0.04781157202586754 -0.4702964908298046 -0.07928005517228054 0.8776305364289357 0.04779956406677398 -0.4703088789264749 -0.07930574761899276 0.8776222305283971 0.04778755540304376 -0.4703212655105251 -0.07933143916216609 0.8776139243857213 0.04777554605242788 -0.470333650584613 -0.07935712980846228 0.8776056180038959 0.04776353599804747 -0.4703460341461573 -0.07938281955149366 0.8775973113751631 0.04775152528635828 -0.4703584162021637 -0.07940850840875652 0.8775890045072999 0.04773951387222067 -0.4703707967457773 -0.07943419636323759 0.8775806973978542 0.04772750177082644 -0.4703831757792695 -0.07945988342063309 0.8775723900498185 0.04771548896527634 -0.4703955533000538 -0.07948556957454715 0.8775640824545726 0.04770347550708487 -0.4704079293159077 -0.07951125484438713 0.8775557746214568 0.04769146134192231 -0.4704203038185789 -0.07953693920966903 0.8775474665492928 0.04767944647748004 -0.4704326768092027 -0.07956262267325849 0.8775391582311246 0.0476674309554564 -0.4704450482940725 -0.07958830525085862 0.8775308496742222 0.04765541473372762 -0.4704574182667826 -0.07961398692659197 0.8775225408767079 0.04764339782409705 -0.4704697867290933 -0.07963966770487646 0.8775142318417062 0.04763138020889277 -0.470482153678298 -0.07966534757902372 0.8775059225595472 0.04761936194578049 -0.4704945191231161 -0.07969102657076603 0.8774976130406286 0.0476073429742385 -0.4705068830543466 -0.07971670465727899 0.8774893032832072 0.04759532330527597 -0.4705192454736301 -0.07974238184268115 0.877480993280313 0.04758330298065046 -0.4705316063872752 -0.07976805814270004 0.8774726830401144 0.04757128195297701 -0.4705439657880711 -0.07979373353946996 0.8774643725596901 0.04755926024018887 -0.4705563236787106 -0.07981940803972373 0.8774560618417395 0.04754723782713033 -0.4705686800568661 -0.07984508163772208 0.8774477508785119 0.04753521476013776 -0.4705810349295463 -0.07987075435092265 0.8774394396784502 0.04752319099022661 -0.4705933882892926 -0.07989642616085423 0.8774311282409346 0.04751116652178953 -0.4706057401367422 -0.07992209706913753 0.8774228165590264 0.0474991413963767 -0.470618090478179 -0.07994776709142412 0.8774145046394771 0.04748711557496225 -0.4706304393076547 -0.079973436213002 0.8774061920183051 0.0474750917862994 -0.4706427870399569 -0.07999910546425741 0.877397880086453 0.04746306185677007 -0.4706551324313712 -0.08002477175841881 0.8773895674468678 0.04745103399359319 -0.4706674767318239 -0.08005043819514758 0.877381254571261 0.04743900542778417 -0.4706798195192036 -0.08007610372859521 0.8773729414558024 0.04742697618260572 -0.470692160797018 -0.08010176836750885 0.8773646281042899 0.04741494623645366 -0.4707045005619558 -0.08012743210371276 0.8773563145091442 0.04740291563461763 -0.4707168388208778 -0.08015309495427311 0.8773480006777277 0.04739088433450824 -0.4707291755672854 -0.08017875690312973 0.8773396866101419 0.04737885233627206 -0.4707415108011713 -0.08020441795030031 0.877331372298918 0.04736681968453733 -0.4707538445292992 -0.08023007811260234 0.8773230577072294 0.0473547865963151 -0.4707661767846928 -0.08025573747202404 0.8773147408258964 0.04734276487429143 -0.4707785093646353 -0.08028140048641204 0.8773064258054338 0.04733073013952625 -0.4707908385565389 -0.0803070579475124 0.8772981105415152 0.04731869475306529 -0.4708031662428597 -0.08033271452435811 0.8772897950420441 0.04730665866916517 -0.4708154924166114 -0.08035837019969537 0.8772814300141111 0.0472947541370543 -0.4708278640916525 -0.08038420975791429 0.8772731175292231 0.0472826937814023 -0.470840188459094 -0.08040983186860251 0.8772648050892181 0.04727063630677125 -0.4708525098651782 -0.0804354564143913 0.8772564930099053 0.04725858269625607 -0.4708648274822066 -0.08046108421873843 0.8772481814279053 0.04724653307171164 -0.4708771410070601 -0.08048671549488044 0.8772398702776826 0.0472344866072683 -0.4708894507273915 -0.08051234975951148 0.8772315534519088 0.04722247615021726 -0.4709017626874425 -0.08053799893499196 0.8772232423811945 0.04721043074333183 -0.4709140674144603 -0.08056363550897011 0.8772149308948489 0.0471983829893721 -0.4709263711603334 -0.08058927102346768 0.8772066188041051 0.04718633170530711 -0.4709386745884309 -0.08061490434999134 0.8771983060553364 0.04717427670557358 -0.4709509779054528 -0.08064053497374625 0.8771899927023264 0.04716221876499176 -0.4709632809071427 -0.08066616305016262 0.8771816788426697 0.0471501592723266 -0.4709755831551377 -0.08069178926649101 0.8771733645419849 0.04713809974314936 -0.4709878842082535 -0.08071741460014621 0.8771650497665708 0.04712604138944087 -0.4710001838331304 -0.08074304007236467 0.8771567343534133 0.04711398487185468 -0.4710124821164947 -0.08076866656327068 0.8771484144860195 0.04710195108264385 -0.471024782617572 -0.08079430257721935 0.8771400969756916 0.04708989797661263 -0.471037079492794 -0.08081993274512006 0.877131778064258 0.04707784561388017 -0.4710493763711168 -0.08084556501485382 0.8771234577181044 0.04706579303280795 -0.4710616734430977 -0.08087119919859004 0.8771151361136883 0.04705373919929612 -0.4710739705552063 -0.08089683487617591 0.8771068136074631 0.04704168314719211 -0.4710862672387767 -0.08092247147163817 0.8770984906484568 0.04702962415604926 -0.4710985628366479 -0.08094810836075635 0.8770901676642159 0.04701756197298857 -0.4711108566730295 -0.08097374498983084 0.8770818449548539 0.04700549702312604 -0.471123148212053 -0.08099938097888505 0.8770735226306433 0.0469934305118141 -0.4711354371541935 -0.08102501617730667 0.8770651971040045 0.04698138487007739 -0.4711477265917234 -0.08105065843072506 0.8770568752008032 0.04696932104372523 -0.4711600103509587 -0.08107629240276619 0.8770485531700085 0.04695726136016175 -0.4711722918047472 -0.08110192613872022 0.8770402307975362 0.04694520665658267 -0.4711845712287843 -0.08112755987037995 0.8770319079206617 0.04693315655211964 -0.4711968489395231 -0.08115319374222157 0.8770235844250371 0.04692110955678707 -0.4712091252913477 -0.0811788277963089 0.877015260233827 0.04690906355831221 -0.4712214006490983 -0.08120446196716506 0.8770069353077091 0.04689701647945345 -0.4712336753245093 -0.08123009607073303 0.8769986096569498 0.04688496685426252 -0.4712459495003182 -0.08125572978193815 0.8769902833485274 0.04687291413377671 -0.4712582231867272 -0.081281362634777 0.8769819514787827 0.04686088803117116 -0.4712705007334589 -0.0813070051830171 0.8769736242324857 0.04684883066857295 -0.4712827728675263 -0.08133263467896504 0.8769652967351801 0.04683677248342157 -0.4712950437800351 -0.08135826186619588 0.8769569691047674 0.04682471437291282 -0.4713073131740837 -0.08138388667974364 0.8769486414152751 0.04681265691617483 -0.4713195808028084 -0.08140950942129953 0.8769403137041771 0.04680060034768436 -0.4713318464655665 -0.08143513071688009 0.8769319859913492 0.04678854459960637 -0.4713441099931485 -0.08146075137319495 0.8769236582964921 0.04677648935710475 -0.471356371245032 -0.08148637217374162 0.8769153306454305 0.04676443408407617 -0.4713686301290187 -0.08151199368254916 0.8769070030689539 0.04675237804877742 -0.4713808866230071 -0.08153761611622914 0.8768986734223793 0.04674033314104736 -0.4713931427284812 -0.08156324415140188 0.8768903461057457 0.04672827300845336 -0.4714053946130927 -0.0815888677324751 0.8768820189865336 0.04671620975725874 -0.4714176443024359 -0.0816144911419438 0.8768736921111769 0.0467041431552451 -0.4714298918249135 -0.0816401138497342 0.8768653655100646 0.04669207351106468 -0.4714421371713489 -0.08166573540628584 0.8768570391826973 0.04668000164135658 -0.4714543803265518 -0.08169135543877087 0.8768487130808177 0.04666792867100367 -0.4714666213290398 -0.08171697360188861 0.8768403870860901 0.04665585574170036 -0.4714788603500916 -0.08174258952776156 0.8768320609843894 0.04664378372471365 -0.4714910977742034 -0.08176820280149823 0.8768237344523288 0.04663171304103695 -0.4715033342401907 -0.08179381297086921 0.8768154017522981 0.0466196747471343 -0.4715155753824566 -0.08181943136063975 0.8768070731069941 0.04660760614120263 -0.4715278125368452 -0.08184503407996568 0.8767987428609673 0.04659553759498126 -0.4715400512017152 -0.08187063274670671 0.8767904109070898 0.04658346822963847 -0.4715522916308725 -0.08189622754893908 0.8767820774304256 0.04657139717406356 -0.4715645334593118 -0.08192181910422147 0.8767737428895266 0.0465593236782955 -0.471576775732903 -0.08194740842436278 0.8767654079076369 0.04654724721614419 -0.4715890171330512 -0.08197299672841619 0.8767570731088244 0.04653516759760611 -0.4716012563162541 -0.0819985851782878 0.8767487389580566 0.04652308506857889 -0.4716134922444855 -0.08202417463236175 0.8767404056594359 0.04651100034925876 -0.4716257243946894 -0.08204976550742672 0.8767320688420102 0.04649893969323941 -0.4716379566512047 -0.08207536729914511 0.8767237368662677 0.04648685399033038 -0.4716501816864686 -0.08210096063049681 0.8767154050761705 0.04647476932597239 -0.4716624040219985 -0.08212655447790859 0.876707073124219 0.046462686006485 -0.4716746243842631 -0.08215214820680211 0.8766987407177543 0.04645060354727464 -0.4716868434835182 -0.08217774113805355 0.8766904076469113 0.04643852077138962 -0.4716990619475322 -0.08220333257402668 0.8766820737957278 0.04642643615979573 -0.4717112802569857 -0.08222892185258207 0.8766737391527443 0.04641434833638881 -0.471723498659241 -0.0822545084547925 0.8766654038246214 0.04640225650888431 -0.471735717078642 -0.08228009212559596 0.8766570680434926 0.04639016070685809 -0.4717479350675051 -0.0823056729425386 0.876648728478626 0.0463780831378189 -0.4717601551516197 -0.0823312593890656 0.8766403928645888 0.04636598223692528 -0.4717723697715173 -0.08235683584008831 0.8766320578988575 0.04635388074468635 -0.471784581306099 -0.08238241102171308 0.8766237238457171 0.04634177973956392 -0.471796789060755 -0.08240798549533514 0.8766153908169131 0.04632967989868929 -0.4718089926832548 -0.08243355971088653 0.8766070587749402 0.04631758150933421 -0.4718211921559464 -0.08245913400962049 0.8765987275780246 0.04630548456312036 -0.4718333877006367 -0.08248470863683491 0.8765903970310126 0.04629338883594913 -0.4718455796758615 -0.08251028374357658 0.8765820669203221 0.04628129391059554 -0.4718577685125777 -0.08253585937026195 0.8765737370276792 0.04626919917190198 -0.4718699546933525 -0.08256143542243916 0.8765654022766042 0.04625713217461048 -0.4718821431105729 -0.08258702239461382 0.8765570721968353 0.04624503536578754 -0.4718943255124372 -0.08261259852402056 0.8765487417782475 0.04623293627619038 -0.4719065066838202 -0.08263817422793607 0.8765404109397408 0.04622083432924776 -0.4719186868639344 -0.08266374932289519 0.8765320796683614 0.04620872931381647 -0.4719308660897462 -0.08268932385285123 0.8765237480016783 0.04619662141502042 -0.4719430442196763 -0.08271489812356894 0.876515416002283 0.04618451113993553 -0.4719552210010476 -0.08274047262955601 0.8765070837350949 0.04617239919388692 -0.4719673961526947 -0.08276604789238709 0.8764987512566301 0.04616028636960978 -0.4719795694293389 -0.08279162426924273 0.8764904186185741 0.04614817347580736 -0.4719917406462051 -0.08281720181489396 0.8764820837454079 0.04613607376369237 -0.4720039115789985 -0.08284278499123544 0.876473751018196 0.0461239630011067 -0.4720160781956438 -0.08286836391512654 0.8764654184470513 0.04611185418435567 -0.4720282421707014 -0.08289394286287632 0.8764570862371373 0.04609974757147974 -0.4720404031413648 -0.08291952158985912 0.876448754639799 0.04608764310880518 -0.4720525606350724 -0.08294510016204762 0.8764404239314834 0.04607554048150391 -0.4720647141052973 -0.08297067894637977 0.8764320943732429 0.04606343924923113 -0.4720768630158971 -0.08299625848273806 0.8764237661541995 0.04605133900056179 -0.4720890069644074 -0.08302183929367149 0.8764154393291853 0.04603923945614627 -0.4721011458214543 -0.08304742169267366 0.8764071137765923 0.0460271404855714 -0.4721132798283222 -0.08307300566519196 0.8763987837579043 0.0460150737322548 -0.4721254145026532 -0.08309860286298028 0.8763904597621718 0.04600297575102556 -0.472137540882526 -0.08312418871364009 0.8763821359316081 0.04599087804497971 -0.4721496647801015 -0.08314977453151659 0.8763738119438695 0.04597878029378882 -0.4721617869419247 -0.08317535965341695 0.876365487627755 0.04596668210334727 -0.4721739078232743 -0.0832009435179373 0.876357162978773 0.04595458311164345 -0.4721860275418758 -0.0832265257057779 0.8763488381357125 0.04594248310103237 -0.4721981459074645 -0.08325210595685334 0.8763405133402467 0.04593038210187939 -0.4722102624832157 -0.08327768419006912 0.8763321889065635 0.04591828046784358 -0.4722223766315156 -0.08330326052196652 0.8763238652082141 0.04590617889212156 -0.4722344875405854 -0.08332883524531552 0.8763155380850934 0.04589410497637619 -0.4722465983998304 -0.08335441883211667 0.8763072171608342 0.0458820064145307 -0.4722586999401305 -0.08337999142521825 0.8762988983097004 0.0458699106176528 -0.4722707953534838 -0.08340556322765169 0.876290581959844 0.04585781783793178 -0.472282883863568 -0.08343113400363628 0.8762822684799644 0.04584572768569153 -0.4722949649356042 -0.08345670312834949 0.8762739581642854 0.04583363920089828 -0.4723070382821088 -0.08348226967374926 0.8762656512121381 0.04582155110631181 -0.4723191038388013 -0.08350783262000597 0.8762573476738033 0.04580946215391469 -0.4723311617785357 -0.08353339115455133 0.8762490473685636 0.04579737144388371 -0.47234321257958 -0.0835589449701086 0.8762407498228642 0.04578527861776395 -0.4723552570913647 -0.08358449443472941 0.8762324507751349 0.04577320428848579 -0.4723672996786096 -0.08361004827234642 0.8762241563691847 0.04576110815956849 -0.4723793353517638 -0.08363559235005565 0.8762158622571062 0.04574901131042845 -0.4723913685342391 -0.08366113570531372 0.8762075678656879 0.04573691426234549 -0.472403400075804 -0.08368667925945383 0.876199272997578 0.04572481726846719 -0.4724154302542756 -0.08371222337238947 0.8761909778271131 0.04571272029499227 -0.4724274587782725 -0.08373776788225765 0.8761826827827508 0.045700623098116 -0.4724394849600388 -0.08376331231964793 0.8761743883728428 0.04568852534168284 -0.4724515079754938 -0.08378885619973089 0.8761660950206447 0.04567642670037776 -0.4724635271147894 -0.08381439927847974 0.876157802964131 0.04566432691327046 -0.4724755419398139 -0.08383994168237484 0.8761495080526066 0.04565225007210247 -0.4724875561085917 -0.0838654930532218 0.8761412185246874 0.04564014740487159 -0.472499562229678 -0.08389103551453214 0.8761329299533359 0.04562804293567493 -0.4725115645104768 -0.08391657853550123 0.8761246420178208 0.04561593628101564 -0.4725235636393003 -0.08394212179810419 0.876116354324981 0.0456038269501461 -0.4725355605846476 -0.0839676642211646 0.8761080664207801 0.04559171440818495 -0.4725475565495872 -0.08399320406306195 0.8760997778292638 0.04557959819845762 -0.4725595528162957 -0.08401873932429831 0.8760914881172874 0.04556747811087866 -0.4725715505038191 -0.08404426834393842 0.8760831969664501 0.04555535433903098 -0.4725835503137398 -0.0840697903943529 0.8760749042266935 0.04554322755008128 -0.472595552361689 -0.08409530603108174 0.8760666067195135 0.04553111738060012 -0.4726075590808569 -0.084120824060785 0.8760583110116927 0.04551898788734039 -0.472619563824191 -0.08414633289504542 0.876050014136642 0.0455068587220256 -0.4726315685005298 -0.08417184206830791 0.8760417163473947 0.04549473057467193 -0.4726435722497673 -0.08419735340275192 0.8760334178659996 0.04548260365893662 -0.4726555745064058 -0.08422286764554282 0.8760251188578377 0.0454704777756359 -0.4726675750413039 -0.08424838446842774 0.8760168194226253 0.04545835249201571 -0.4726795738972742 -0.08427390282685615 0.8760085195936603 0.04544622735268759 -0.4726915712735169 -0.08429942150279193 0.8760002193427394 0.0454341020405602 -0.4727035674095714 -0.08432493961755931 0.8759919185900965 0.04542197644861146 -0.4727155625044708 -0.08435045694259913 0.8759836125334493 0.04540987785101871 -0.4727275609210074 -0.08437598421398534 0.8759753104359644 0.04539775211782981 -0.4727395542195029 -0.08440150167864102 0.8759670075035256 0.0453856267045615 -0.472751546654508 -0.08442702049535421 0.8759587036541534 0.04537350189266182 -0.4727635382609504 -0.08445254116673243 0.8759503988107801 0.04536137796179156 -0.4727755291650181 -0.08447806363417663 0.8759420928894167 0.04534925518580191 -0.4727875196040698 -0.08450358729209612 0.8759337858087008 0.04533713380473103 -0.4727995098775377 -0.0845291111793398 0.8759254775346551 0.04532501395882714 -0.472811500226021 -0.08455463422745184 0.8759171681494674 0.04531289560168544 -0.4728234906765172 -0.08458015546026057 0.8759088579066275 0.04530077842980523 -0.47283548092915 -0.08460567409376545 0.8759005434458549 0.04528868379433406 -0.4728474737809998 -0.08463119785492623 0.8758922328498242 0.04527656712847723 -0.4728594615704516 -0.08465670975009959 0.8758839227950047 0.04526444953786356 -0.4728714469786449 -0.08468221790666017 0.8758756135241592 0.04525233030638586 -0.4728834296112626 -0.08470772240244433 0.8758673049482538 0.04524020892692057 -0.4728954096162145 -0.0847332236070599 0.8758589966531751 0.04522808513841154 -0.4729073876732063 -0.0847587221500521 0.8758506880384557 0.0452159588849274 -0.4729193647633086 -0.08478421879423885 0.8758423785360521 0.04520383024495996 -0.4729313418024773 -0.08480971425729586 0.8758340678254013 0.04519169935822849 -0.4729433192793481 -0.08483520905000848 0.8758257559559925 0.04517956637921657 -0.4729552970484932 -0.08486070338897683 0.8758174382308103 0.04516746096962206 -0.4729672789810537 -0.084886208382968 0.875809125463468 0.04515532428432587 -0.4729792547447814 -0.08491170134182822 0.8758008131753116 0.04514318600885459 -0.4729912278829724 -0.08493719293802464 0.8757925018084552 0.04513104636801199 -0.4730031976785729 -0.08496268248861026 0.8757841915162109 0.04511890566201773 -0.4730151639690741 -0.08498816916176501 0.8757758821593797 0.04510676426603399 -0.4730271271404587 -0.0850136520486752 0.8757675733871811 0.04509462257860326 -0.4730390879529183 -0.08503913032653346 0.8757592647493242 0.04508248093700273 -0.4730510472930774 -0.08506460352702808 0.8757509557928873 0.04507033951605362 -0.473063005952963 -0.08509007182097747 0.8757426461252977 0.04505819825492054 -0.4730749644924918 -0.0851155361723667 0.875734332547097 0.04504607362921193 -0.4730869258262411 -0.08514100458157015 0.8757260207023757 0.04503393156122829 -0.4730988847013904 -0.08516646621306612 0.8757177076922387 0.04502178825599145 -0.473110843511874 -0.08519192900719245 0.8757093937355066 0.04500964321197537 -0.4731228017691172 -0.08521739369085851 0.8757010792725607 0.04499749613783315 -0.4731347587551573 -0.0852428598763397 0.875692764913571 0.04498534701264763 -0.4731467135921621 -0.08526832617750735 0.8756844513176828 0.04497319608997896 -0.4731586653830576 -0.08529379066980851 0.8756761390269682 0.04496104388248288 -0.4731706134062016 -0.0853192515240162 0.8756678283092312 0.04494889114642872 -0.4731825573051788 -0.0853447075748263 0.8756595190704072 0.04493673886375603 -0.473194497196434 -0.08537015863103395 0.8756512072422441 0.0449246091680152 -0.4732064369373059 -0.08539561339671484 0.8756428994494336 0.04491246113172695 -0.4732183707901916 -0.08542105727252979 0.8756345913545527 0.04490031650592089 -0.4732303030135344 -0.08544649969853771 0.8756262823375848 0.04488817542042708 -0.4732422345210948 -0.08547194190239542 0.8756179719356989 0.04487603724847439 -0.4732541660900972 -0.08549738465271209 0.8756096598561184 0.04486390069594742 -0.4732660983314782 -0.08552282824542504 0.8756013459524854 0.04485176413225948 -0.4732780316803401 -0.08554827262547805 0.8755930301958734 0.04483962606185797 -0.4732899663724911 -0.08557371756659461 0.8755847126587462 0.04482748557077371 -0.4733019024036256 -0.08559916282775337 0.8755763935094815 0.04481534257532551 -0.4733138394978127 -0.08562460825384634 0.8755680673181444 0.04480323056613792 -0.473325782286062 -0.08565006623987273 0.8755597457703183 0.04479108507848705 -0.4733377197556181 -0.08567551190777609 0.87555142352084 0.04477894003001809 -0.4733496563394036 -0.08570095765968636 0.8755431008937361 0.04476679616336259 -0.4733615913994528 -0.08572640332141858 0.8755347781621556 0.04475465369546845 -0.4733735244718202 -0.08575184855308196 0.8755264555371443 0.04474251239021302 -0.4733854552741835 -0.08577729288355197 0.8755181331661814 0.0447303717801753 -0.4733973836699341 -0.08580273580762483 0.8755098111241504 0.04471823143925034 -0.4734093096316039 -0.08582817693757874 0.8755014893924883 0.04470609120642711 -0.4734212332310683 -0.0858536161530299 0.8754931678460989 0.04469395128432588 -0.4734331546398241 -0.08587905368121616 0.875484843178339 0.04468183001879365 -0.4734450769179368 -0.08590449681675438 0.8754765213318576 0.04466969238375252 -0.47345699471792 -0.08592993268754465 0.8754681990294584 0.04465755671673148 -0.4734689110451021 -0.08595536859309039 0.8754598762302073 0.04464542317123646 -0.4734808259319631 -0.08598080469289306 0.8754515530823429 0.04463329145219812 -0.473492739195824 -0.08600624063806242 0.8754432299062302 0.04462116088377865 -0.4735046504545768 -0.08603167562369468 0.8754349071163665 0.04460903061116335 -0.4735165592090599 -0.08605710862505329 0.875426585104238 0.04459689985719516 -0.473528464972066 -0.08608253874659305 0.8754182641286301 0.04458476813970286 -0.4735403673901836 -0.08610796555438456 0.8754099442565199 0.04457263537231673 -0.473552266308334 -0.08613338926922623 0.8754016209733593 0.04456052723867217 -0.4735641657464816 -0.08615882038575927 0.8753933029370986 0.04454839337072796 -0.4735760577246589 -0.08618424085025535 0.8753849856478857 0.04453625969556755 -0.473587946130664 -0.08620966160657098 0.8753766692246184 0.04452412665663302 -0.4735998305105895 -0.08623508371317314 0.8753683540516494 0.04451199461257657 -0.4736117100020504 -0.08626050782049696 0.8753600407427485 0.04449986387319102 -0.4736235834011518 -0.08628593415136246 0.8753517300069082 0.0444877347465472 -0.4736354493903999 -0.08631136258794499 0.8753434224556311 0.04447560758305347 -0.4736473068702118 -0.0863367927848617 0.8753351184213936 0.04446348279396557 -0.4736591552787848 -0.08636222424546394 0.8753268178588824 0.04445136083300982 -0.4736709947690044 -0.08638765636176432 0.8753185158802976 0.0444392680353368 -0.4736828302324698 -0.08641309829275851 0.8753102209061092 0.04442715288395449 -0.4736946546467537 -0.08643852973655197 0.8753019278569935 0.04441504126795278 -0.4737064732541746 -0.08646396009950594 0.8752936363079064 0.04440293273190834 -0.4737182868861546 -0.08648938936849536 0.8752853460496295 0.04439082634782986 -0.4737300959191471 -0.08651481807975459 0.8752770570548348 0.04437872083236832 -0.4737419003345281 -0.08654024727339511 0.8752687693739158 0.04436661479654262 -0.4737536999371617 -0.08656567822189053 0.8752604829985137 0.04435450707267954 -0.4737654946554598 -0.08659111200011145 0.8752521977374874 0.04434239700843055 -0.4737772848221541 -0.08661654905266367 0.875243913143398 0.04433028462701531 -0.473789071343321 -0.08664198893119539 0.8752353842479171 0.04431792151084542 -0.4738013797335681 -0.08666715961612402 0.8752270663152263 0.04430578444694997 -0.4738132334890295 -0.08669255806846091 0.8752187482797791 0.04429364739593739 -0.4738250855456026 -0.08671795527826763 0.8752104301498763 0.04428151031096387 -0.4738369358959036 -0.08674335122780368 0.8752021119258196 0.04426937319125938 -0.4738487845398264 -0.08676874591675998 0.8751937935996474 0.04425723608356337 -0.4738606314847866 -0.0867941393628666 0.8751854751796757 0.0442450989409593 -0.4738724767233842 -0.08681953154835438 0.8751771566631994 0.04423296177995886 -0.4738843202582507 -0.08684492247947632 0.8751688380535677 0.04422082458225156 -0.4738961620865061 -0.08687031214928329 0.8751605193417996 0.04420868740042127 -0.4739080022164953 -0.08689570057772639 0.875152200536813 0.0441965501841045 -0.4739198406402687 -0.08692108774572595 0.8751438816389203 0.04418441293246765 -0.4739316773577112 -0.08694647365294875 0.8751355626395989 0.04417227569545063 -0.4739435123767515 -0.08697185831834282 0.8751272435475748 0.04416013842380184 -0.4739553456896133 -0.08699724172324981 0.8751189243600959 0.04414800113429789 -0.473967177298972 -0.08702262387402417 0.8751106050803104 0.04413586380978991 -0.4739790072021293 -0.08704800476415704 0.8751022856987269 0.04412372650576334 -0.4739908354078983 -0.08707338441470457 0.8750939662258411 0.04411158916282081 -0.4740026619068899 -0.08709876280315318 0.8750856466580885 0.04409945180239645 -0.4740144867025186 -0.08712413993762698 0.8750773269978255 0.04408731441189691 -0.4740263097928077 -0.08714951581334685 0.8750690072376018 0.04407517703506415 -0.4740381311847127 -0.08717489044691024 0.8750606873859573 0.04406303962375221 -0.4740499508706237 -0.08720026382007538 0.8750523674421317 0.04405090218329111 -0.4740617688514016 -0.08722563593485012 0.8750440473989085 0.04403876475606808 -0.474073585133791 -0.08725100680731848 0.8750357272641263 0.04402662729797407 -0.4740853997108189 -0.0872763764207708 0.8750274070356612 0.04401448982216218 -0.4740972125845894 -0.08730174478018692 0.8750190867162824 0.04400235231367496 -0.474109023752748 -0.08732711187988898 0.8750107662972362 0.04399021482371169 -0.4741208332234417 -0.08735247773930989 0.8750024457874579 0.04397807730188218 -0.4741326409886961 -0.08737784233935252 0.8749941251876548 0.04396593974508897 -0.4741444470480353 -0.08740320567882359 0.8749858044887272 0.04395380220650612 -0.4741562514099231 -0.08742856777790749 0.8749774836988923 0.04394166463987279 -0.474168054067038 -0.08745392861907469 0.8749691628167519 0.0439295270541707 -0.4741798550208239 -0.08747928820572083 0.8749608418442145 0.04391738943938956 -0.4741916542697098 -0.08750464653404717 0.8749525207738976 0.04390525183883174 -0.4742034518205959 -0.08753000362048897 0.8749441996129332 0.04389311421248124 -0.4742152476671482 -0.08755535944988797 0.8749358783634098 0.04388097654931951 -0.4742270418076313 -0.08758071401804121 0.8749275570146896 0.04386883891130626 -0.4742388342519157 -0.08760606734847422 0.8749192355777171 0.04385670123656948 -0.4742506249901886 -0.08763141941772323 0.874910914048423 0.04384456354940489 -0.474262414026331 -0.08765677023500359 0.874902592429859 0.04383242583324824 -0.4742742013577283 -0.08768211979402514 0.874894270714106 0.04382028813445638 -0.4742859869917734 -0.08770746811238668 0.8748859489093339 0.0438081504070814 -0.4742977709211825 -0.08773281517267362 0.8748776270136135 0.04379601266314144 -0.4743095531478846 -0.08775816097943637 0.8748693050285704 0.04378387489425253 -0.4743213336705658 -0.08778350552949317 0.8748609829474097 0.04377173714031177 -0.4743331124955954 -0.08780884883798937 0.8748526607780857 0.04375959935662422 -0.4743448896158833 -0.08783419088798498 0.8748443385200011 0.04374746154756979 -0.4743566650321449 -0.08785953168112819 0.8748360161661332 0.04373532375434182 -0.4743684387509575 -0.0878848712330579 0.8748276937238542 0.04372318593559101 -0.4743802107657622 -0.08791020952810469 0.8748193711911213 0.04371104810397353 -0.4743919810785928 -0.08793554657106226 0.8748110485715471 0.04369891023973083 -0.4744037496863207 -0.08796088235442537 0.8748027258553692 0.04368677239973506 -0.4744155165980262 -0.08798621689979322 0.8747944030519788 0.04367463453108471 -0.4744272818053061 -0.08801155018710446 0.8747860801623994 0.04366249662887512 -0.4744390453073942 -0.08803688221447845 0.8747777571760935 0.04365035875440191 -0.4744508071140812 -0.08806221300519737 0.8747694341032504 0.04363822085020699 -0.4744625672162324 -0.08808754253746633 0.8747611109416501 0.04362608292995767 -0.474474325616044 -0.08811287081646432 0.8747527876922844 0.04361394498890791 -0.4744860823127797 -0.08813819784039144 0.874744464349194 0.0436018070621229 -0.4744978373120506 -0.08816352362256086 0.8747361409186705 0.04358966911447822 -0.47450959060828 -0.088188848149666 0.8747278174028335 0.04357753113479455 -0.4745213421997009 -0.08821417141744056 0.8747194937920399 0.04356539317921308 -0.4745330920952907 -0.08823949344721088 0.8747111700954808 0.04355325519602376 -0.4745448402868229 -0.08826481421936415 0.8747028463103091 0.04354111720246939 -0.4745565867770671 -0.08829013374043919 0.874694522439548 0.04352897918218651 -0.4745683315634309 -0.08831545200421947 0.8746861984751114 0.04351684118238619 -0.474580074653471 -0.08834076902863781 0.8746778744246287 0.04350470316030854 -0.4745918160403854 -0.08836608479748261 0.8746695502866023 0.04349256512547374 -0.4746035557257123 -0.08839139931435719 0.8746612260637795 0.04348042706309944 -0.4746152937071098 -0.08841671257364545 0.874652901746778 0.04346828902779395 -0.4746270299933212 -0.08844202459609468 0.8746445773458165 0.04345615096200482 -0.4746387645751769 -0.08846733535986709 0.8746362528593449 0.04344401287555107 -0.4746504974542627 -0.0884926448686801 0.8746279282806477 0.04343187480777597 -0.4746622286368857 -0.08851795313747772 0.8746196036171345 0.04341973671720539 -0.4746739581164423 -0.08854326015053472 0.8746112788665921 0.04340759861744056 -0.4746856858951246 -0.08856856591300707 0.8746029540321598 0.04339546049146807 -0.4746974119702315 -0.08859387041842932 0.8745946291049894 0.04338332239081226 -0.4747091363500224 -0.08861917368637919 0.8745863040940443 0.04337118426512571 -0.4747208590264709 -0.08864447569775566 0.8745779790000203 0.04335904611138537 -0.4747325799991096 -0.08866977645139301 0.8745696538126879 0.04334690798899712 -0.4747442992774619 -0.08869507596986727 0.8745613285431795 0.0433347698352311 -0.4747560168515166 -0.08872037422936731 0.8745530031869593 0.0433226316769562 -0.4747677327255908 -0.08874567124009575 0.8745446777475517 0.043310493494964 -0.4747794468966303 -0.0887709669947515 0.8745363522169065 0.04329835533619159 -0.4747911593721684 -0.08879626151117052 0.8745280266033739 0.04328621715382526 -0.4748028701447344 -0.08882155477159283 0.8745197009064343 0.04327407895178082 -0.4748145792149739 -0.08884684677749199 0.8745113751193248 0.04326194076963142 -0.4748262865892432 -0.08887213754390393 0.8745030492491902 0.04324980256745807 -0.4748379922611738 -0.08889742705569043 0.8744947232945922 0.04323766435442249 -0.4748496962322517 -0.08892271531632016 0.8744863972569956 0.04322552612309064 -0.4748613985013047 -0.08894800232296998 0.874478071129235 0.04321338791531724 -0.4748730990750599 -0.0889732880915451 0.8744697449194869 0.04320124968530548 -0.4748847979462036 -0.08899857260467015 0.874461418625213 0.04318911144849445 -0.4748964951172278 -0.08902385586820211 0.8744530922491726 0.04317697319006279 -0.4749081905857759 -0.08904913787650715 0.8744447657833655 0.04316483495661489 -0.4749198843593401 -0.08907441864729906 0.8744364392358853 0.04315269670284345 -0.4749315764306808 -0.08909969816338689 0.8744281126075967 0.04314055842476336 -0.4749432667991758 -0.08912497642323855 0.8744197858891982 0.04312842017639401 -0.4749549554735095 -0.08915025344739005 0.8744114590905423 0.0431162819024038 -0.4749666424448304 -0.08917552921483533 0.8744031322073018 0.04310414362842642 -0.47497832771727 -0.0892008037353115 0.8743948052443027 0.04309200532785849 -0.4749900112865784 -0.08922607699870094 0.8743864781916835 0.04307986705789529 -0.475001693161955 -0.08925134902674986 0.8743781510588916 0.04306772876553192 -0.4750133733349173 -0.08927661979933589 0.8743698238458247 0.04305559045230243 -0.475025051805728 -0.08930188931702672 0.8743614965439719 0.04304345216768481 -0.475036728582352 -0.08932715759863356 0.874353169162283 0.04303131386152425 -0.4750484036567599 -0.08935242462511708 0.8743448416975765 0.04301917555290918 -0.4750600770320357 -0.08937769040372522 0.8743365141541108 0.04300703721848595 -0.4750717487044476 -0.08940295492557558 0.874328186521647 0.04299489891756798 -0.4750834186835448 -0.08942821821322371 0.8743198588097478 0.0429827605965248 -0.4750950869607352 -0.08945348024630623 0.8743115310192774 0.04297062225137527 -0.4751067535353958 -0.08947874102329205 0.8743032031402552 0.04295848393995021 -0.4751184184168416 -0.08950400056617402 0.8742948751824021 0.0429463456077271 -0.4751300815963338 -0.08952925885424791 0.8742865471433109 0.04293420726936773 -0.4751417430762475 -0.08955451589307788 0.8742782190251619 0.04292206891337616 -0.4751534028547535 -0.08957977167829341 0.8742698908197557 0.04290993058740782 -0.4751650609395359 -0.08960502622801639 0.8742615625358595 0.0428977922423954 -0.4751767173227282 -0.08963027952361703 0.8742532341710414 0.04288565389313759 -0.4751883720067289 -0.08965553157071235 0.8742449057282624 0.04287351552369118 -0.4752000249889922 -0.08968078236323847 0.8742365771977673 0.04286137719056195 -0.4752116762786311 -0.0897060319226877 0.8742282485904057 0.04284923883283303 -0.4752233258658674 -0.08973128022591845 0.8742199199049279 0.04283710045857074 -0.4752349737520158 -0.08975652727598522 0.8742115911335021 0.04282496211331118 -0.4752466199444272 -0.08978177309020589 0.8742032622840077 0.04281282375306875 -0.475258264436045 -0.08980701765188268 0.8741949333543717 0.04280068539058707 -0.47526990722894 -0.08983226096585083 0.87418660434819 0.04278854700632056 -0.4752815483199825 -0.08985750302467443 0.8741782752554513 0.04277640865819722 -0.4752931877185244 -0.08988274385039052 0.8741699460861486 0.04276427029021375 -0.4753048254155692 -0.08990798342172451 0.8741616168405733 0.04275213190165584 -0.4753164614110183 -0.08993322173838868 0.874153287508576 0.04273999355122509 -0.4753280957143517 -0.0899584588227159 0.8741449581011157 0.04272785517743454 -0.4753397283156846 -0.08998369465134259 0.8741366286135456 0.04271571680766793 -0.4753513592194494 -0.09000892923467889 0.8741282990502638 0.04270357841782448 -0.47536298842178 -0.0900341625635534 0.874119969402083 0.04269144006110744 -0.4753746159312753 -0.09005939465820763 0.8741116396775666 0.04267930168968258 -0.475386241740247 -0.09008462550047412 0.8741033098779211 0.04266716329762796 -0.4753978658477563 -0.09010985508808243 0.8740949799934296 0.04265502494115115 -0.475409488262891 -0.09013508344241919 0.8740866500331054 0.04264288656986608 -0.475421108977547 -0.09016031054434426 0.8740783199951097 0.04263074819516958 -0.4754327279935817 -0.09018553639818176 0.8740699898812099 0.04261860980793458 -0.4754443453095417 -0.09021076100046097 0.874061659683805 0.04260647145231512 -0.4754559609325735 -0.09023598436798039 0.874053329411885 0.04259433307807725 -0.4754675748545937 -0.09026120648165616 0.8740449990610711 0.04258219471105196 -0.4754791870797909 -0.0902864273513098 0.874036668636307 0.04257005632405924 -0.475490797603796 -0.09031164696659492 0.87402833812803 0.04255791797238938 -0.4755024064355585 -0.09033686534855299 0.87402000754539 0.04254577960491363 -0.4755140135668452 -0.09036208247775747 0.874011676888275 0.0425336412232088 -0.475525618997928 -0.09038729835479334 0.8740033461483231 0.04252150287573215 -0.4755372227366561 -0.09041251299810081 0.8739950153343882 0.04250936451304623 -0.4755488247750664 -0.09043772638889626 0.8739866844436701 0.04249722615200083 -0.4755604251159001 -0.09046293853358195 0.8739783534790568 0.04248508777710967 -0.4755720237566735 -0.09048814942626428 0.8739700224318616 0.04247294943865357 -0.4755836207055361 -0.09051335908607964 0.8739616913113334 0.0424608110849693 -0.4755952159541601 -0.09053856749339519 0.8739533601173592 0.04244867271764029 -0.4756068095028179 -0.09056377464879832 0.8739450288420862 0.04243653438220105 -0.4756184013588947 -0.09058898056961889 0.8739366974931935 0.04242439603591917 -0.4756299915155026 -0.09061418523962463 0.8739283660681223 0.04241225769425656 -0.4756415799751628 -0.09063938866469022 0.8739200345703882 0.04240011933817375 -0.4756531667348138 -0.09066459083756739 0.8739117029918341 0.04238798101491755 -0.4756647518021214 -0.09068979177623993 0.8739033713397065 0.04237584268422088 -0.4756763351705939 -0.09071499146541329 0.8738950396161038 0.0423637043351116 -0.4756879168384727 -0.09074018990089193 0.8738867078116012 0.04235156602202172 -0.4756994968145898 -0.09076538710339802 0.8738783759340922 0.04233942770102209 -0.4757110750918578 -0.09079058305624102 0.8738700439816702 0.04232728938386904 -0.4757226516721992 -0.09081577776388468 0.8738617119584232 0.04231515104828266 -0.4757342265520251 -0.09084097121784521 0.8738533798537771 0.04230301275519762 -0.475745799741226 -0.09086616344132405 0.8738450476776767 0.04229087444905722 -0.4757573712308273 -0.09089135441319911 0.873836715427833 0.04227873614378804 -0.4757689410231031 -0.09091654413876121 0.8738283831059516 0.04226659783063066 -0.4757805091166541 -0.09094173261467785 0.8738200507046727 0.04225445955226406 -0.4757920755184177 -0.09096691985719628 0.8738117182318864 0.04224232126480784 -0.4758036402213069 -0.09099210584964193 0.8738033856879062 0.04223018296742284 -0.4758152032252019 -0.09101729059167923 0.8737950530653819 0.04221804470272267 -0.4758267645370335 -0.09104247409953208 0.8737867203714649 0.04220590643102682 -0.475838324150392 -0.09106765635812479 0.873778387604602 0.04219376816207841 -0.4758498820668753 -0.09109283737115509 0.8737700547666226 0.0421816298864193 -0.4758614382849697 -0.09111801713502368 0.8737617218504429 0.04216949164514163 -0.4758729928113621 -0.09114319566537561 0.8737533888640999 0.04215735339355643 -0.4758845456388264 -0.09116837294522538 0.8737450558073637 0.04214521513390259 -0.4758960967677432 -0.09119354897541092 0.8737367226721467 0.04213307691295161 -0.4759076462057247 -0.09121872377374309 0.8737283894678123 0.04212093867850591 -0.4759191939443226 -0.0912438973203733 0.8737200561901783 0.04210880045520077 -0.4759307399875551 -0.09126906962467607 0.8737117228440671 0.0420966622166269 -0.4759422843311532 -0.09129424067659039 0.8737033894187995 0.04208452402421915 -0.4759538269851153 -0.09131941049951786 0.8736950559251099 0.0420723858180337 -0.4759653679397299 -0.09134457907065552 0.8736867223623092 0.04206024760290924 -0.4759769071958004 -0.09136974639183258 0.8736783887219973 0.04204810942735858 -0.475988444761229 -0.09139491248152633 0.8736700550125704 0.04203597124469441 -0.4759999806284552 -0.09142007732198597 0.8736617212319719 0.04202383306749726 -0.4760115147995412 -0.09144524091799168 0.8736533873827914 0.04201169488201485 -0.4760230472722721 -0.09147040326430639 0.8736450534565688 0.04199955673708458 -0.4760345780546075 -0.09149556437953278 0.8736367194620258 0.04198741858418984 -0.4760461071386845 -0.09152072424522088 0.8736283853966027 0.04197528043875685 -0.4760576345270298 -0.09154588286723668 0.8736200512627548 0.04196314228779569 -0.4760691602175511 -0.09157104024063284 0.873611717053602 0.04195100417118357 -0.4760806842167551 -0.0915961963805977 0.8736033827755383 0.04193886605359622 -0.4760922065189204 -0.0916213512737096 0.8735950484309923 0.04192672792222218 -0.4761037271219798 -0.09164650491506857 0.8735867140090767 0.04191458983960431 -0.4761152460361318 -0.09167165732850596 0.8735783795207653 0.04190245174451093 -0.4761267632514357 -0.09169680849072098 0.873570044962669 0.04189031365705001 -0.4761382787711833 -0.09172195840936551 0.8735617103371353 0.0418781755648533 -0.4761497925933806 -0.09174710707972865 0.8735533756360649 0.0418660375146669 -0.4761613047256597 -0.0917722545196205 0.8735450408680864 0.04185389945854763 -0.4761728151602388 -0.09179740071080521 0.8735367060337653 0.04184176139422838 -0.4761843238967657 -0.09182254565240316 0.8735283711240758 0.04182962337368814 -0.4761958309437285 -0.09184768936422107 0.8735200361486196 0.04181748534348784 -0.4762073362924458 -0.09187283182592604 0.8735117011038732 0.04180534732448717 -0.476218839946335 -0.09189797304545801 0.8735033659927673 0.04179320930102142 -0.4762303419028636 -0.09192311301684843 0.8734950308068378 0.04178107132187746 -0.4762418421700037 -0.09194825175868809 0.8734866955562758 0.0417689333302996 -0.476253340738529 -0.09197338924937776 0.8734783602389415 0.04175679533931976 -0.4762648376105813 -0.0919985254938725 0.8734700248474255 0.04174465739174711 -0.4762763327931618 -0.09202366050848475 0.8734616893915803 0.04173251943275743 -0.476287826277355 -0.09204879427235033 0.8734533538666106 0.04172038149038042 -0.4762993180677511 -0.09207392679614515 0.8734450182766312 0.04170824354227392 -0.4763108081607254 -0.0920990580713527 0.8734366826131978 0.0416961056370817 -0.4763222965642347 -0.09212418811651243 0.8734283468851866 0.04168396772551062 -0.4763337832702618 -0.09214931691286808 0.8734200110894614 0.04167182982621117 -0.476345268281868 -0.0921744444675188 0.8734116752292777 0.04165969192170144 -0.4763567515962198 -0.09219957077380139 0.8734033392952755 0.04164755406577915 -0.4763682332221208 -0.092224695852223 0.8733950032978862 0.04163541620038655 -0.4763797131501167 -0.09224981968068224 0.8733866672356188 0.04162327833487504 -0.4763911913817528 -0.0922749422627316 0.8733783311008692 0.04161114051311443 -0.4764026679242135 -0.09230006361509203 0.8733699949026347 0.04159900268515755 -0.4764141427693665 -0.09232518371875502 0.8733616586373392 0.04158686487212842 -0.4764256159206807 -0.09235030258176451 0.8733533223084601 0.04157472705529688 -0.4764370873751161 -0.0923754201969801 0.8733449859078986 0.04156258928131526 -0.4764485571403165 -0.09240053658218589 0.8733366494430321 0.04155045150939279 -0.4764600252096418 -0.09242565172186537 0.8733283129158115 0.04153831372945107 -0.4764714915814608 -0.09245076561215798 0.8733199763163717 0.04152617599809498 -0.4764829562650484 -0.0924758782746465 0.8733116396545058 0.04151403826091343 -0.4764944192515339 -0.09250098968861623 0.8733033029267798 0.04150190053821617 -0.4765058805442563 -0.09252609986180182 0.8732949661357957 0.04148976281622304 -0.476517340140983 -0.09255120878895064 0.8732866292744651 0.04147762513585672 -0.4765287980484273 -0.09257631648566311 0.8732782923493086 0.04146548746118542 -0.4765402542607377 -0.09260142293827447 0.8732699553637194 0.04145334977399585 -0.4765517087749507 -0.09262652813981949 0.8732616183065082 0.04144121213833431 -0.4765631616015677 -0.09265163211472406 0.8732532811866732 0.0414290745043014 -0.4765746127324478 -0.09267673484399196 0.8732449440029995 0.04141693687967703 -0.4765860621688827 -0.09270183633057744 0.8732366067573627 0.04140479925478806 -0.4765975099093089 -0.09272693657079425 0.873228269440991 0.0413926616800249 -0.476608955961998 -0.09275203558385897 0.8732199320640615 0.04138052409885914 -0.4766204003177181 -0.09277713334824375 0.8732115946220226 0.04136838653788039 -0.4766318429808431 -0.09280222987408183 0.8732032571192395 0.04135624897338225 -0.4766432839475097 -0.09282732515233093 0.8731949195467893 0.04134411145659109 -0.4766547232261307 -0.09285241920252817 0.8731865819131912 0.04133197394034055 -0.4766661608090036 -0.09287751200671723 0.8731782442186669 0.04131983642431025 -0.4766775966960934 -0.09290260356476092 0.873169906455572 0.04130769895250287 -0.476689030894633 -0.09292769389344058 0.8731615686309974 0.04129556148581853 -0.4767004633982379 -0.09295278297787762 0.873153230743994 0.04128342403052783 -0.4767118942079553 -0.09297787082045093 0.8731448927962642 0.04127128657794388 -0.4767233233223808 -0.09300295741785003 0.8731365547796718 0.04125914917482842 -0.4767347507492035 -0.09302804278791101 0.8731282167034671 0.04124701176992376 -0.4767461764800425 -0.09305312691111284 0.8731198785668915 0.04123487436842848 -0.4767576005157675 -0.09307820978942526 0.8731115403628037 0.04122273701149215 -0.4767690228631504 -0.09310329143854307 0.8731032020985046 0.04121059965885108 -0.4767804435156098 -0.09312837184314113 0.8730948637717812 0.04119846232388781 -0.4767918624753613 -0.09315345100831388 0.8730865253864084 0.04118632498624925 -0.4768032797390837 -0.09317852892629637 0.8730781869323544 0.04117418770334558 -0.4768146953162223 -0.09320360561899307 0.873069848420106 0.04116205041698463 -0.4768261091972485 -0.09322868106423231 0.8730615098484699 0.04114991313481077 -0.4768375213834357 -0.09325375526491808 0.873053171209506 0.04113777590244424 -0.4768489318822958 -0.09327882823845463 0.8730448325117145 0.04112563867289169 -0.4768603406861362 -0.09330389996694488 0.8730364937526244 0.04111350146098196 -0.4768717477974116 -0.09332897045603632 0.8730281549354099 0.04110136424975212 -0.4768831532133553 -0.09335403969925751 0.8730198160510001 0.04108922709117244 -0.4768945569425276 -0.09337910771643894 0.8730114771091214 0.04107708993136415 -0.4769059589760992 -0.09340417448705278 0.8730031381055585 0.04106495279496741 -0.4769173593181393 -0.09342924002049373 0.8729947990445391 0.0410528156590963 -0.4769287579649057 -0.09345430430802787 0.8729864599176134 0.04104067857220839 -0.476940154924386 -0.09347936736814594 0.8729781207325847 0.04102854149125859 -0.476951550189528 -0.09350442918445583 0.8729697814902778 0.04101640441253341 -0.4769629437597384 -0.09352948975552455 0.8729614421817802 0.0410042673870778 -0.4769743356434343 -0.09355454910083243 0.872953102816559 0.04099213036250336 -0.4769857258320225 -0.09357960720041759 0.8729447633912134 0.04097999335885602 -0.4769971143288199 -0.09360466406192162 0.8729364239090464 0.0409678563584611 -0.477008501130939 -0.09362971967859972 0.8729280843615157 0.04095571941026847 -0.4770198862464558 -0.0936547740691336 0.8729197447572992 0.04094358246634058 -0.4770312696675059 -0.09367982721525978 0.8729114050964157 0.04093144552749434 -0.4770426513942415 -0.09370487911727565 0.8729030653709935 0.04091930863889734 -0.4770540314341195 -0.09372992979241963 0.872894725588843 0.04090717175750196 -0.477065409780077 -0.09375497922429479 0.8728863857481178 0.04089503489460236 -0.4770767864339936 -0.0937800274172009 0.8728780458515486 0.04088289803575456 -0.4770881613935094 -0.0938050743656261 0.8728697058899542 0.04087076123346726 -0.4770995346672962 -0.09383012008961479 0.8728613658730147 0.04085862443419891 -0.4771109062465573 -0.09385516456875982 0.8728530258008116 0.04084648763841577 -0.4771222761313877 -0.09388020780322455 0.8728446856642567 0.04083435089808825 -0.4771336443303734 -0.0939052498128492 0.8728363454721335 0.0408222141647282 -0.4771450108355476 -0.09393029057915575 0.8728280052225323 0.0408100774499822 -0.4771563756488488 -0.09395533010657932 0.8728196649179215 0.04079794074088205 -0.4771677387681594 -0.09398036839017115 0.8728113245495004 0.04078580408777247 -0.4771791002018018 -0.09400540544915187 0.87280298412613 0.04077366744174235 -0.4771904599417351 -0.09403044126488047 0.8727946436458173 0.04076153081489868 -0.4772018179899757 -0.0940554758419683 0.872786303110986 0.04074939419453272 -0.4772131743444466 -0.09408050917556521 0.87277796251282 0.04073725763105624 -0.4772245290134862 -0.09410554128491946 0.8727696218605813 0.04072512107332452 -0.4772358819886812 -0.09413057215053459 0.8727612811544431 0.04071298452127995 -0.4772472332700394 -0.09415560177237421 0.8727529403855122 0.04070084802575933 -0.4772585828659726 -0.09418063016985018 0.8727445995626598 0.04068871153782247 -0.4772699307684278 -0.09420565732430709 0.872736258684081 0.04067657506851445 -0.4772812769792466 -0.0942306832399516 0.8727279177510927 0.04066443861134172 -0.4772926214973776 -0.094255707914308 0.8727195767564759 0.04065230220772564 -0.4773039643296828 -0.09428073136319168 0.8727112357080888 0.04064016581442537 -0.4773153054690449 -0.09430575357012388 0.8727028946073776 0.04062802942424475 -0.4773266449142934 -0.09433077453234003 0.8726945534444338 0.04061589309368498 -0.4773379826747837 -0.09435579427141974 0.8726862122287093 0.04060375677057247 -0.4773493187419211 -0.0943808127674694 0.8726778709580135 0.04059162046811356 -0.477360653117906 -0.09440583002552197 0.8726695296342305 0.04057948417663416 -0.4773719858011601 -0.09443084604188598 0.8726611882485483 0.04056734794646544 -0.477383316800025 -0.09445586083578469 0.8726528468118745 0.04055521171729021 -0.4773946461045538 -0.09448087438420998 0.872644505322432 0.04054307549999279 -0.4774059737165632 -0.09450588669130754 0.8726361637721537 0.04053093934071292 -0.4774172996437058 -0.09453089777470032 0.8726278221703982 0.04051880318783049 -0.4774286238774688 -0.0945559076147027 0.8726194805135568 0.04050666706249488 -0.4774399464213694 -0.09458091621938512 0.8726111388055884 0.04049453094340582 -0.4774512672719043 -0.09460592358061112 0.8726027970367261 0.04048239488622046 -0.4774625864383035 -0.09463092971964285 0.8725944552165651 0.04047025883800634 -0.4774739039118337 -0.09465593461629203 0.8725861133430125 0.04045812281140958 -0.4774852196946061 -0.09468093827537867 0.872577771418052 0.04044598679620735 -0.4774965337849488 -0.09470594069300053 0.8725694294328765 0.04043385084265707 -0.4775078461912041 -0.09473094188835766 0.8725610873976314 0.04042171489476496 -0.4775191569041258 -0.09475594184008919 0.8725527453112041 0.04040957895968058 -0.4775304659249151 -0.09478094055091418 0.8725444031654773 0.0403974430837839 -0.4775417732612759 -0.09480593803855147 0.8725360609697214 0.04038530721599757 -0.477553078904772 -0.09483093428351851 0.8725277187204256 0.0403731713768981 -0.4775643828588312 -0.09485592929366855 0.8725193764212905 0.04036103554665005 -0.4775756851201878 -0.09488092306142332 0.8725110340631719 0.04034889977737302 -0.4775869856975004 -0.09490591560669794 0.8725026916553734 0.04033676401781823 -0.4775982845822995 -0.0949309069099426 0.8724943491975239 0.04032462827097723 -0.4776095817750996 -0.09495589697228683 0.8724860066814347 0.04031249258360282 -0.4776208772836726 -0.09498088581159495 0.872477664116164 0.04030035690583505 -0.477632171099777 -0.09500587340884675 0.8724693214982424 0.04028822125800571 -0.4776434632268032 -0.09503085977180352 0.8724609788313213 0.04027608562056678 -0.4776547536615294 -0.09505584489299536 0.8724526361065198 0.04026395004413368 -0.4776660424123733 -0.09508082879176559 0.8724442933329226 0.0402518144787091 -0.4776773294710653 -0.09510581144903986 0.8724359505104732 0.04023967892552402 -0.4776886148378273 -0.09513079286527462 0.8724276076300422 0.04022754343656908 -0.4776998985213092 -0.09515577306034033 0.8724192647020417 0.0402154079544329 -0.4777111805120072 -0.09518075201232573 0.8724109217221014 0.04020327250447786 -0.4777224608141506 -0.09520572973091726 0.872402578693674 0.04019113706828013 -0.4777337394247008 -0.09523070620907403 0.8723942356093953 0.04017900168793734 -0.4777450163506692 -0.09525568146288438 0.8723858924760428 0.04016686632638757 -0.4777562915859271 -0.09528065547821883 0.8723775492922619 0.04015473099211832 -0.4777675651319025 -0.09530562825830979 0.8723692060606723 0.04014259567136878 -0.4777788369863301 -0.09533059979789962 0.8723608627730988 0.04013046041075816 -0.4777901071569767 -0.09535557011480771 0.8723525194376647 0.04011832516571284 -0.4778013756364612 -0.09538053919202975 0.8723441760551394 0.04010618993284144 -0.477812642424238 -0.09540550702825416 0.8723358326163511 0.04009405476432449 -0.4778239075290014 -0.09543047364342909 0.872327489130738 0.04008191960824719 -0.4778351709421468 -0.09545543901774056 0.8723191455954324 0.04006978448154863 -0.4778464326665093 -0.09548040315765512 0.8723108020129848 0.04005764937086095 -0.477857692699887 -0.09550536605806445 0.8723024583755197 0.04004551432110531 -0.4778689510497711 -0.09553032773614127 0.8722941146910376 0.04003337928841357 -0.4778802077088915 -0.09555528817514852 0.8722857709603227 0.04002124426931609 -0.4778914626766887 -0.09558024737374454 0.8722774271749559 0.04000910931175918 -0.4779027159611606 -0.09560520535026058 0.8722690833429533 0.03999697437179917 -0.4779139675550214 -0.09563016208792954 0.8722607394621984 0.03998483946217026 -0.4779252174604086 -0.09565511759160998 0.8722523955357196 0.03997270456683961 -0.4779364656746747 -0.09568007185517337 0.8722440515547554 0.03996056973565483 -0.4779477122061386 -0.09570502489768003 0.872235707528047 0.0399484349206329 -0.4779589570468373 -0.09572997670081572 0.872227363455607 0.03993630012261612 -0.4779702001969294 -0.0957549272648888 0.8722190193298307 0.03992416538497287 -0.477981441663658 -0.09577987660648146 0.8722106751583192 0.03991203066610319 -0.4779926814401206 -0.09580482470972097 0.8722023309388256 0.03989989597946022 -0.4780039195285769 -0.09582977157974179 0.8721939866743827 0.03988776130899797 -0.478015155926374 -0.0958547172104095 0.8721856423566179 0.03987562670235963 -0.4780263906414719 -0.09587966161994375 0.8721772979940907 0.03986349211260637 -0.4780376236660742 -0.09590460479042723 0.8721689535841284 0.03985135755556513 -0.4780488550028375 -0.09592954672790328 0.8721606091299179 0.03983922301433428 -0.4780600846489651 -0.09595448742590938 0.8721522646225114 0.03982708853975083 -0.4780713126129539 -0.09597942690388961 0.8721439200707968 0.03981495408306115 -0.4780825388866999 -0.09600436514323003 0.8721355754755282 0.03980281964096267 -0.4780937634696706 -0.09602930214265271 0.8721272308270132 0.03979068526843546 -0.4781049863710581 -0.09605423792318879 0.8721188861353221 0.03977855091013999 -0.4781162075816555 -0.09607917246370228 0.8721105413968367 0.03976641658716585 -0.4781274271050011 -0.09610410577225215 0.8721021966153734 0.03975428227911092 -0.4781386449377111 -0.09612903784103499 0.8720938517811386 0.03974214804149694 -0.4781498610890725 -0.09615396869129109 0.8720855069038767 0.0397300138208241 -0.4781610755501814 -0.09617889830258702 0.8720771619840061 0.03971787961566428 -0.4781722883208174 -0.09620382667436206 0.8720688170117679 0.03970574548133275 -0.478183499410237 -0.09622875382777908 0.8720604719973443 0.03969361136189875 -0.4781947088091269 -0.09625367974147246 0.8720521269368456 0.03968147727995338 -0.478205916521279 -0.09627860442407743 0.8720437818341893 0.03966934321454141 -0.4782171225432132 -0.09630352786757748 0.8720354366800979 0.03965720921827717 -0.4782283268837407 -0.09632845009210325 0.8720270914841483 0.03964507523862177 -0.4782395295341091 -0.09635337107758594 0.8720187462454819 0.03963294128126406 -0.4782507304952875 -0.09637829082618989 0.8720104009568953 0.0396208073872499 -0.478261929774156 -0.0964032093536176 0.8720020556252029 0.03960867351944475 -0.4782731273645342 -0.09642812664569728 0.8719937102497998 0.03959653968212296 -0.4782843232671555 -0.09645304270405179 0.8719853648326786 0.03958440586506275 -0.4782955174803319 -0.0964779575247736 0.8719770193654777 0.03957227211575036 -0.4783067100120243 -0.09650287112603291 0.871968673856009 0.03956013839150479 -0.4783179008551216 -0.09652778349153249 0.8719603283036825 0.0395480046965146 -0.478329090010343 -0.09655269462286277 0.8719519827092114 0.03953587102769264 -0.4783402774771928 -0.096577604518848 0.8719436370660189 0.0395237374225629 -0.4783514632619705 -0.09660251319384487 0.8719352913810909 0.03951160384306029 -0.4783626473583322 -0.09662742063332261 0.8719269456564085 0.03949947027905867 -0.4783738297646015 -0.0966523268333892 0.8719185998814262 0.03948733679017296 -0.4783850104907776 -0.0966772318168633 0.8719102540669472 0.03947520331709131 -0.4783961895269582 -0.09670213556107547 0.8719019082088322 0.03946306988376206 -0.4784073668771712 -0.0967270380751843 0.8718935623105888 0.03945093647154049 -0.4784185425383158 -0.0967519393520553 0.8718852163639603 0.03943880312727981 -0.4784297165182597 -0.09677683940962087 0.8718768703768757 0.0394266698076896 -0.4784408888097777 -0.0968017382313463 0.8718685243504181 0.03941453650764348 -0.4784520594120296 -0.09682663581525443 0.8718601782749452 0.03940240328169452 -0.4784632283341765 -0.09685153218222831 0.8718518321613161 0.03939027007025907 -0.4784743955662595 -0.09687642730949086 0.8718434860044502 0.03937813690250414 -0.4784855611131866 -0.09690132120820159 0.8718351398084891 0.03936600375626659 -0.4784967249712634 -0.09692621386987681 0.8718267935647808 0.03935387068057564 -0.4785078871487303 -0.09695110531328531 0.8718184472824648 0.03934173762542863 -0.4785190476372295 -0.09697599551931878 0.8718101009607252 0.03932960459626528 -0.4785302064376919 -0.09700088449004735 0.871801754591809 0.03931747163710057 -0.4785413635575202 -0.09702577224232029 0.8717934081845419 0.03930533869968913 -0.4785525189886476 -0.09705065875770089 0.8717850617357458 0.03929320580260251 -0.4785636727342095 -0.09707554404329094 0.8717767152486184 0.03928107292893934 -0.4785748247913909 -0.09710042809262148 0.8717683687148532 0.03926894012577993 -0.4785859751681124 -0.09712531092371786 0.8717600221428793 0.03925680734709697 -0.4785971238566761 -0.09715019251899142 0.8717516755292741 0.03924467461281414 -0.4786082708604458 -0.09717507288606302 0.8717433288798527 0.03923254189148939 -0.4786194161741634 -0.09719995201289114 0.871734982182326 0.03922040925232133 -0.4786305598094681 -0.09722482992597836 0.8717266354485174 0.03920827663043326 -0.4786417017554923 -0.09724970660051153 0.8717182886763423 0.03919614403830925 -0.4786528420143511 -0.09727458204126116 0.8717099418589127 0.03918401151511906 -0.4786639805926441 -0.09729945626322384 0.8717015950040551 0.03917187901821066 -0.4786751174832328 -0.097324329250102 0.8716932481092869 0.03915974656227455 -0.4786862526886046 -0.0973492010075117 0.871684901177917 0.03914761412980704 -0.4786973862058393 -0.09737407152875183 0.8716765542010944 0.03913548177086731 -0.4787085180433702 -0.09739894083299373 0.8716682071874292 0.03912334943846434 -0.4787196481933259 -0.09742380890227542 0.8716598601379127 0.03911121712799279 -0.4787307766549501 -0.09744867573481809 0.8716515130426742 0.03909908489516296 -0.4787419034376302 -0.09747354135196064 0.8716431659116624 0.03908695268556259 -0.4787530285322433 -0.09749840573289517 0.8716348187414006 0.03907482051939034 -0.4787641519422052 -0.09752326888535023 0.8716264715355135 0.0390626883773993 -0.4787752736643003 -0.09754813080195524 0.8716181242854081 0.03905055630819005 -0.4787863937067239 -0.0975729915013257 0.8716097769987941 0.03903842426979479 -0.4787975120624426 -0.0975978509674221 0.8716014296776362 0.03902629225220462 -0.4788086287297905 -0.09762270919639439 0.8715930823115937 0.03901416031371037 -0.4788197437185973 -0.09764756621057377 0.8715847349107729 0.03900202839905072 -0.4788308570195894 -0.09767242198882392 0.8715763874718945 0.03898989652732237 -0.4788419686359999 -0.09769727653845196 0.8715680399978053 0.03897776468360421 -0.4788530785653378 -0.09772212985374461 0.8715596924805438 0.03896563291296184 -0.4788641868152123 -0.0977469819519652 0.8715513449279719 0.03895350117260631 -0.4788752933784445 -0.09777183281675693 0.8715429973385285 0.03894136947209616 -0.4788863982566626 -0.09779668245177099 0.8715346497141884 0.03892923780134946 -0.4788975014481903 -0.09782153085314881 0.8715263020468446 0.03891710620622787 -0.4789086029607742 -0.09784637803846061 0.8715179543460019 0.0389049746348412 -0.4789197027856976 -0.09787122398785839 0.8715096066103989 0.03889284309508624 -0.4789308009243096 -0.09789606870435656 0.8715012588320357 0.03888071163221424 -0.478941897384258 -0.09792091220529275 0.8714929110202386 0.03886858019534015 -0.4789529921569921 -0.09794575447120277 0.8714845631718386 0.03885644880293089 -0.478964085245644 -0.09797059550915463 0.8714762152904029 0.03884431743608315 -0.4789751766470473 -0.09799543531190637 0.8714678673655526 0.03883218615322277 -0.4789862663710762 -0.09802027390184921 0.8714595194084288 0.03882005489342259 -0.478997354407481 -0.09804511125566652 0.8714511714182606 0.03880792366185292 -0.4790084407571518 -0.09806994737532762 0.8714428233859691 0.03879579250971927 -0.4790195254287484 -0.09809478228045621 0.8714344753207788 0.0387836613867311 -0.4790306084138123 -0.09811961595181334 0.8714261272199425 0.03877153030900347 -0.4790416897150819 -0.0981444483955661 0.8714177790871026 0.03875939925722922 -0.4790527693293193 -0.09816927960431636 0.8714094309124841 0.03874726828645432 -0.4790638472658376 -0.09819410959916287 0.8714010827057959 0.03873513734372142 -0.4790749235157226 -0.09821893835984201 0.8713927344667176 0.03872300643169644 -0.4790859980794433 -0.0982437658873629 0.8713843861870748 0.03871087559655127 -0.479097070964817 -0.09826859219942177 0.8713760378748346 0.03869874479498409 -0.4791081421645576 -0.09829341727945723 0.8713676895287578 0.03868661403475138 -0.4791192116799943 -0.09831824113043107 0.8713593411504403 0.03867448330788508 -0.479130279509802 -0.09834306374929393 0.871350992732334 0.03866235265707348 -0.479141345661214 -0.09836788515240752 0.8713426442824236 0.03865022203893084 -0.4791524101269258 -0.09839270532317647 0.8713342957982519 0.03863809146795382 -0.4791634729094068 -0.09841752426714871 0.8713259472833049 0.03862596092571453 -0.4791745340055629 -0.0984423419772619 0.8713175987284354 0.03861383046373746 -0.4791855934241254 -0.09846715847326905 0.8713092501428324 0.03860170003198556 -0.4791966511566608 -0.09849197373602181 0.8713009015262084 0.03858956963294374 -0.4792077072036081 -0.09851678776646025 0.8712925528702399 0.03857743931356205 -0.4792187615729285 -0.09854160058258365 0.8712842041839773 0.0385653090245856 -0.4792298142563171 -0.0985664121655425 0.8712758554645412 0.03855317878283699 -0.4792408652566389 -0.09859122252177788 0.8712675067145286 0.0385410485748179 -0.4792519145716315 -0.09861603164611782 0.8712591579261576 0.03852891844446663 -0.4792629622087511 -0.09864083955540781 0.8712508091070698 0.03851678835033785 -0.4792740081610097 -0.09866564623379295 0.8712424602591792 0.03850465828273372 -0.4792850524267848 -0.09869045167753911 0.8712341113724341 0.03849252829813987 -0.4792960950156587 -0.09871525590830722 0.8712257624554806 0.03848039834956272 -0.4793071359197025 -0.09874005890811269 0.8712174135070386 0.03846826844496842 -0.4793181751402841 -0.09876486067999907 0.8712090645287959 0.03845613857589597 -0.4793292126759917 -0.09878966122072669 0.8712007155133453 0.0384440087841869 -0.4793402485339331 -0.09881446054633916 0.8711923664681351 0.03843187902948437 -0.4793512827072988 -0.09883925864139678 0.8711840173941792 0.03841974930707587 -0.4793623151953088 -0.09886405550407795 0.8711756682828591 0.03840761966548778 -0.4793733460062068 -0.09888885115299284 0.8711673191428506 0.03839549005758982 -0.4793843751320319 -0.09891364557010117 0.8711589699716242 0.03838336049824991 -0.479395402575324 -0.09893843876109625 0.8711506207717706 0.03837123097402066 -0.4794064283338242 -0.09896323072082383 0.8711422715347051 0.03835910153322635 -0.4794174524157464 -0.09898802146781842 0.8711339222700161 0.03834697212370702 -0.4794284748122735 -0.09901281098210769 0.8711255729740485 0.03833484276654687 -0.4794394955269997 -0.09903759927177122 0.8711172236508758 0.03832271344010671 -0.4794505145562765 -0.09906238632851024 0.8711088742903891 0.03831058420111975 -0.4794615319097482 -0.09908717217408862 0.8711005249023791 0.03829845499632171 -0.4794725475784058 -0.09911195678810829 0.8710921754882178 0.03828632581902588 -0.4794835615611321 -0.09913674016798935 0.8710838260365561 0.03827419673279726 -0.4794945738687359 -0.09916152233811969 0.8710754765580835 0.03826206767942503 -0.4795055844913638 -0.09918630327620104 0.8710671270498302 0.0382499386761941 -0.4795165934319694 -0.09921108298885578 0.8710587775149949 0.03823780970631082 -0.4795276006877229 -0.09923586146964426 0.8710504279437755 0.0382256808247791 -0.4795386062679841 -0.09926063873966962 0.8710420783461985 0.03821355197706338 -0.4795496101635193 -0.09928541477804276 0.87103372872286 0.03820142316076239 -0.4795606123739392 -0.09931018958382863 0.8710253790632765 0.0381892944346293 -0.4795716129092441 -0.09933496317957163 0.8710170293778791 0.0381771657419081 -0.4795826117598196 -0.09935973554352849 0.8710086796635792 0.03816503710053316 -0.4795936089287316 -0.0993845066825722 0.8710003299231417 0.03815290849611178 -0.4796046044135559 -0.09940927659118365 0.8709919801479986 0.03814077997680324 -0.4796155982224984 -0.09943404528784175 0.8709836303472663 0.03812865149312906 -0.4796265903471756 -0.09945881275359555 0.8709752805211759 0.03811652304470141 -0.47963758078754 -0.09948357898828314 0.8709669306599965 0.0381043946860849 -0.4796485695528899 -0.09950834401284431 0.8709585807743724 0.03809226635938184 -0.4796595566334069 -0.09953310780509372 0.8709502308602004 0.03808013808811222 -0.4796705420331103 -0.09955787037405055 0.8709418809210695 0.03806800985334347 -0.4796815257488011 -0.09958263171245144 0.8709335309481034 0.03805588170491032 -0.479692507788978 -0.09960739183942179 0.8709251809505407 0.0380437535926851 -0.4797034881451397 -0.09963215073575819 0.8709168309249911 0.03803162553624848 -0.4797144668206367 -0.09965690840896779 0.8709084808755513 0.03801949751387568 -0.4797254438117931 -0.09968166485071428 0.8709001307922916 0.03800736958119292 -0.4797364191280984 -0.0997064200823491 0.8708917806849827 0.03799524168515326 -0.4797473927605488 -0.09973117408354584 0.8708834305538274 0.03798311382552649 -0.479758364709124 -0.09975592685420342 0.8708750803891354 0.03797098605660554 -0.4797693349830896 -0.09978067841516247 0.8708667302008496 0.03795885832440661 -0.4797803035732795 -0.09980542874573543 0.8708583799863445 0.03794673064428496 -0.4797912704823278 -0.09983017785180773 0.8708500297479741 0.03793460300412976 -0.4798022357081932 -0.09985492572873457 0.8708416794770201 0.03792247545286236 -0.4798131992592311 -0.09987967239529535 0.8708333291828064 0.03791034793992645 -0.4798241611268543 -0.09990441783211736 0.8708249788655301 0.03789822046512098 -0.4798351213110473 -0.09992916203911052 0.8708166285161428 0.03788609307917257 -0.4798460798204763 -0.0999539050357489 0.8708082781442557 0.03787396572995669 -0.4798570366462834 -0.09997864680205598 0.8707999277463419 0.03786183843778103 -0.4798679917919501 -0.1000033873458207 0.8707915773255397 0.03784971118622298 -0.4798789452546974 -0.1000281266607411 0.8707832268736926 0.0378375840210825 -0.4798898970423565 -0.1000528647644005 0.8707748763989442 0.0378254568983292 -0.4799008471474451 -0.1000776016399302 0.8707665259024705 0.03781332981237361 -0.4799117955690284 -0.1001023372851699 0.8707581753739202 0.03780120282108471 -0.479922742317 -0.1001270717223413 0.8707498248249279 0.03778907586122804 -0.4799336873805971 -0.1001518049271956 0.8707414742497256 0.03777694896543651 -0.4799446307654084 -0.1001765369122591 0.8707331236537124 0.03776482210485348 -0.4799555724665296 -0.100201267666451 0.8707247730266879 0.03775269533649729 -0.4799665124937147 -0.1002259972116684 0.8707164223783859 0.03774056860761579 -0.479977450837985 -0.1002507255276883 0.8707080717054592 0.03772844193750835 -0.4799883875026554 -0.1002754526219142 0.8706997210113998 0.03771631530781963 -0.4799993224846129 -0.1003001784873 0.8706913702874239 0.03770418876775931 -0.4800102557922823 -0.1003249031427439 0.8706830195425517 0.03769206226851508 -0.4800211874173534 -0.1003496265695352 0.8706746687767914 0.0376799358109228 -0.4800321173599875 -0.1003743487679823 0.8706663179816495 0.03766780944258134 -0.4800430456283383 -0.100399069756366 0.8706579671654756 0.03765568311838111 -0.4800539722147243 -0.1004237895173971 0.8706496163262196 0.03764355685047557 -0.4800648971212422 -0.100448508055734 0.8706412654666738 0.03763143062436801 -0.4800758203454358 -0.1004732253658124 0.8706329145774948 0.03761930449231535 -0.4800867418962586 -0.100497941467705 0.8706245636687518 0.03760717839976411 -0.4800976617644115 -0.1005226563404914 0.8706162127404803 0.03759505234740116 -0.4801085799500301 -0.1005473699844229 0.8706078617830406 0.03758292638910126 -0.4801194964623484 -0.1005720824201952 0.8705995108056062 0.0375708004752453 -0.4801304112929076 -0.1005967936287834 0.8705911598063522 0.03755867461674292 -0.4801413244435933 -0.1006215036143685 0.8705828087873506 0.03754654880306614 -0.4801522359126252 -0.1006462123729109 0.8705744577403971 0.03753442308018161 -0.4801631457078896 -0.1006709199220684 0.8705661066737465 0.03752229740353593 -0.4801740538217897 -0.1006956262447616 0.8705577555890249 0.03751017176507342 -0.4801849602529651 -0.1007203313378809 0.8705494044757262 0.03749804622340015 -0.4801958650114686 -0.1007450352239446 0.8705410533439312 0.03748592072393809 -0.4802067680879842 -0.1007697378820179 0.8705327021903346 0.03747379528572682 -0.4802176694857905 -0.1007944393194083 0.8705243510189502 0.03746166988757172 -0.4802285692012804 -0.1008191395279747 0.8705159998197556 0.03744954458540303 -0.4802394672440533 -0.1008438385292085 0.8705076486024 0.03743741932703198 -0.4802503636051974 -0.1008685363030919 0.8704992973643046 0.03742529412750163 -0.4802612582873085 -0.1008932328553961 0.8704909461079281 0.03741316897416298 -0.4802721512882419 -0.1009179281812654 0.8704825948248603 0.0374010439140734 -0.4802830426160817 -0.1009426222987815 0.8704742435238284 0.03738891890012809 -0.4802939322627821 -0.1009673151898794 0.8704658922058351 0.03737679392769579 -0.4803048202275684 -0.1009920068527658 0.8704575408615217 0.03736466904903171 -0.4803157065194193 -0.1010166973075224 0.8704491894994367 0.03735254421802119 -0.4803265911304553 -0.1010413865364639 0.8704408381171773 0.03734041944872606 -0.4803374740631076 -0.1010660745449855 0.8704324867184101 0.03732829472187915 -0.4803483553140936 -0.1010907613256852 0.8704241352931708 0.03731617009303944 -0.4803592348929636 -0.1011154468999174 0.87041578385167 0.03730404550698526 -0.4803701127902716 -0.1011401312464925 0.8704074323934062 0.03729192096734323 -0.4803809890066589 -0.1011648143667928 0.8703990809094095 0.03727979652420548 -0.4803918635507418 -0.1011894962800716 0.8703907294092018 0.03726767212613982 -0.4804027364137208 -0.1012141769665955 0.8703823778903053 0.03725554778761492 -0.4804136075980991 -0.101238856431917 0.8703740263542912 0.03724342350086635 -0.4804244771025654 -0.1012635346730572 0.870365674793922 0.03723129930646406 -0.4804353449341055 -0.1012882117056089 0.8703573232177154 0.03721917515850157 -0.4804462110848649 -0.101312887511962 0.8703489716260315 0.0372070510558817 -0.4804570755546732 -0.1013375620916819 0.8703406200092854 0.03719492705203637 -0.4804679383527288 -0.1013622354653101 0.8703322683773111 0.03718280309385027 -0.4804787994699351 -0.1013869076124624 0.8703239167267861 0.03717067920041715 -0.4804896589095917 -0.1014115785404712 0.8703155650615778 0.03715855535138529 -0.480500516668224 -0.1014362482415153 0.8703072133719025 0.03714643160126149 -0.480511372755219 -0.1014609167365515 0.8702988616672863 0.03713430789863842 -0.4805222271617687 -0.1014855840058504 0.8702905099454755 0.0371221842567389 -0.480533079890166 -0.101510250054487 0.8702821582081792 0.03711006066705079 -0.4805439309389689 -0.1015349148791941 0.8702738064477867 0.03709793717215188 -0.4805547803155191 -0.1015595784963409 0.8702654546731194 0.03708581372451249 -0.480565628011671 -0.1015842408876885 0.8702571028839069 0.03707369032648854 -0.4805764740278479 -0.1016089020541308 0.8702487510713888 0.03706156702694741 -0.480587318372477 -0.1016335620144583 0.8702403992477966 0.03704944377580362 -0.4805981610318205 -0.1016582207486022\nnCovRow = 25\nnDataRow = 1447\nnominalISDCovarinace = 4 0 0 4 0 16\nstartTime = 1437301190.460421\ntimeInterval = 0.02\nIsdBase::Attitude BEGIN\ncurrentValue = -0.05589632789831305 -0.0001215333262033745 0 0 -0.01405751429063273 -3.049845793898018e-05 0 0 0.000119766166461967 -2.581757110548717e-07\noriginalValue = 0 0 0 0 0 0 0 0 0 0\nparameterDelta = 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.01 0.01\nparameterId = 6 7 8 9 10 11 12 13 14 15\nparameterName = ROLL_0 ROLL_1 ROLL_2 ROLL_3 PITCH_0 PITCH_1 PITCH_2 PITCH_3 YAW_0 YAW_1\nparameterType = 2 2 3 3 2 2 3 3 2 2\nparameterUnit = microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 0 1 4 5 8 9\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 2 6\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationGroup::2 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 7\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::2 END\nCorrelationModel::CorrelationModel END\nIsdBase::Attitude END\nIsdBase::Attitude END\nIsdBase::Ephemeris BEGIN\nephCov = 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5\nephData = 5107029.66999999992549419 977303.939999999944120646 4667370.66000000014901161 5210.87499999906867742538 -817.399999999906867742538 -5518.125 5108071.9599999999627471 977140.5 4666267.13999999966472387 5210.87499999906867742538 -817.399999999906867742538 -5518.125 5109114.01999999955296516 976976.979999999981373549 4665163.41000000014901161 5209.67500000027939677238 -817.774999999965075403452 -5519.19999999925494194031 5110155.83000000007450581 976813.390000000013969839 4664059.4599999999627471 5208.45000000204890966415 -818.150000000023283064365 -5520.32499999972060322762 5111197.40000000037252903 976649.719999999972060323 4662955.28000000026077032 5207.25000000093132257462 -818.525000000081490725279 -5521.42500000074505805969 5112238.73000000044703484 976485.979999999981373549 4661850.88999999966472387 5206.04999999981373548508 -818.899999999848660081625 -5522.5 5113279.82000000029802322 976322.16000000003259629 4660746.28000000026077032 5204.84999999869614839554 -819.299999999930150806904 -5523.59999999869614839554 5114320.66999999992549419 976158.260000000009313226 4659641.45000000018626451 5203.62499999813735485077 -819.674999999988358467817 -5524.67500000027939677238 5115361.26999999955296516 975994.290000000037252903 4658536.41000000014901161 5202.39999999990686774254 -820.050000000046566128731 -5525.77500000130385160446 5116401.62999999988824129 975830.239999999990686774 4657431.13999999966472387 5201.20000000111758708954 -820.425000000104773789644 -5526.875 5117441.75 975666.119999999995343387 4656325.66000000014901161 5200 -820.79999999987194314599 -5527.97499999869614839554 5118481.62999999988824129 975501.920000000041909516 4655219.95000000018626451 5198.77499999944120645523 -821.199999999953433871269 -5529.07499999972060322762 5119521.25999999977648258 975337.640000000013969839 4654114.03000000026077032 5197.550000001210719347 -821.575000000011641532183 -5530.12499999953433871269 5120560.65000000037252903 975173.290000000037252903 4653007.90000000037252903 5196.35000000009313225746 -821.925000000046566128731 -5531.22500000055879354477 5121599.79999999981373549 975008.869999999995343387 4651901.5400000000372529 5195.14999999897554516792 -822.32500000012805685401 -5532.35000000102445483208 5122638.7099999999627471 974844.359999999986030161 4650794.9599999999627471 5193.92500000074505805969 -822.699999999895226210356 -5533.42500000027939677238 5123677.37000000011175871 974679.790000000037252903 4649688.16999999992549419 5192.70000000018626451492 -823.074999999953433871269 -5534.49999999953433871269 5124715.7900000000372529 974515.130000000004656613 4648581.16000000014901161 5191.49999999906867742538 -823.475000000034924596548 -5535.60000000055879354477 5125753.96999999973922968 974350.400000000023283064 4647473.92999999970197678 5190.30000000027939677238 -823.825000000069849193096 -5536.69999999925494194031 5126791.91000000014901161 974185.599999999976716936 4646366.48000000044703484 5189.07499999972060322762 -824.20000000012805685401 -5537.77499999850988388062 5127829.59999999962747097 974020.719999999972060323 4645258.82000000029802322 5187.84999999916180968285 -824.599999999918509274721 -5538.85000000009313225746 5128867.04999999981373549 973855.760000000009313226 4644150.94000000040978193 5186.62500000093132257462 -824.974999999976716935635 -5539.95000000111758708954 5129904.25 973690.729999999981373549 4643042.83999999985098839 5185.42499999981373548508 -825.350000000034924596548 -5541.05000000214204192162 5130941.21999999973922968 973525.619999999995343387 4641934.51999999955296516 5184.22500000102445483208 -825.725000000093132257462 -5542.14999999850988388062 5131977.94000000040978193 973360.439999999944120646 4640825.98000000044703484 5183.00000000046566128731 -826.099999999860301613808 -5543.22499999776482582092 5133014.41999999992549419 973195.180000000051222742 4639717.23000000044703484 5181.77499999990686774254 -826.499999999941792339087 -5544.30000000167638063431 5134050.65000000037252903 973029.83999999996740371 4638608.25999999977648258 5180.54999999934807419777 -826.875 -5545.40000000037252902985 5135086.63999999966472387 972864.430000000051222742 4637499.07000000029802322 5179.34999999823048710823 -827.225000000034924596548 -5546.49999999906867742538 5136122.38999999966472387 972698.949999999953433871 4636389.66000000014901161 5178.15000000176951289177 -827.600000000093132257462 -5547.57500000065192580223 5137157.90000000037252903 972533.390000000013969839 4635280.0400000000372529 5176.925000001210719347 -827.999999999883584678173 -5548.64999999990686774254 5138193.16000000014901161 972367.75 4634170.20000000018626451 5175.69999999832361936569 -828.374999999941792339087 -5549.75000000093132257462 5139228.17999999970197678 972202.040000000037252903 4633060.13999999966472387 5174.47500000009313225746 -828.75 -5550.82500000018626451492 5140262.95000000018626451 972036.25 4631949.87000000011175871 5173.25000000186264514923 -829.125000000058207660913 -5551.89999999944120645523 5141297.48000000044703484 971870.390000000013969839 4630839.37999999988824129 5172.04999999841675162315 -829.500000000116415321827 -5553.00000000046566128731 5142331.76999999955296516 971704.449999999953433871 4629728.66999999992549419 5170.82499999785795807838 -829.899999999906867742538 -5554.09999999916180968285 5143365.80999999959021807 971538.430000000051222742 4628617.74000000022351742 5169.60000000195577740669 -830.274999999965075403452 -5555.17500000074505805969 5144399.61000000033527613 971372.33999999996740371 4627506.59999999962747097 5168.40000000083819031715 -830.625 -5556.25 5145433.16999999992549419 971206.180000000051222742 4626395.24000000022351742 5167.17500000027939677238 -831.000000000058207660913 -5557.34999999869614839554 5146466.48000000044703484 971039.939999999944120646 4625283.66000000014901161 5165.94999999972060322762 -831.400000000139698386192 -5558.44999999972060322762 5147499.54999999981373549 970873.619999999995343387 4624171.86000000033527613 5164.74999999860301613808 -831.774999999906867742538 -5559.52500000130385160446 5148532.37999999988824129 970707.229999999981373549 4623059.84999999962747097 5163.52500000037252902985 -832.124999999941792339087 -5560.60000000055879354477 5149564.9599999999627471 970540.770000000018626451 4621947.62000000011175871 5162.29999999981373548508 -832.5 -5561.67499999981373548508 5150597.29999999981373549 970374.229999999981373549 4620835.17999999970197678 5161.07499999925494194031 -832.900000000081490725279 -5562.75000000139698386192 5151629.38999999966472387 970207.609999999986030161 4619722.51999999955296516 5159.85000000102445483208 -833.274999999848660081625 -5563.85000000009313225746 5152661.24000000022351742 970040.920000000041909516 4618609.63999999966472387 5158.64999999990686774254 -833.649999999906867742538 -5564.92499999934807419777 5153692.84999999962747097 969874.150000000023283064 4617496.54999999981373549 5157.42499999934807419777 -834.024999999965075403452 -5566.02499999804422259331 5154724.2099999999627471 969707.310000000055879354 4616383.23000000044703484 5156.20000000111758708954 -834.400000000023283064365 -5567.09999999962747097015 5155755.33000000007450581 969540.390000000013969839 4615269.7099999999627471 5154.97500000055879354477 -834.800000000104773789644 -5568.175000001210719347 5156786.20000000018626451 969373.390000000013969839 4614155.9599999999627471 5153.75 -835.175000000162981450558 -5569.27499999990686774254 5157816.83000000007450581 969206.319999999948777258 4613042 5152.52499999944120645523 -835.524999999906867742538 -5570.32499999972060322762 5158847.2099999999627471 969039.180000000051222742 4611927.83000000007450581 5151.29999999888241291046 -835.899999999965075403452 -5571.42500000074505805969 5159877.34999999962747097 968871.959999999962747097 4610813.42999999970197678 5150.10000000009313225746 -836.275000000023283064365 -5572.52499999944120645523 5160907.25 968704.670000000041909516 4609698.82000000029802322 5148.87500000186264514923 -836.649999999790452420712 -5573.57499999925494194031 5161936.90000000037252903 968537.300000000046566129 4608584 5147.64999999897554516792 -837.050000000162981450558 -5574.65000000083819031715 5162966.30999999959021807 968369.849999999976716936 4607468.9599999999627471 5146.42499999841675162315 -837.425000000221189111471 -5575.74999999953433871269 5163995.46999999973922968 968202.329999999958090484 4606353.70000000018626451 5145.20000000018626451492 -837.774999999965075403452 -5576.824999998789280653 5165024.38999999966472387 968034.739999999990686774 4605238.23000000044703484 5143.97499999962747097015 -838.150000000023283064365 -5577.90000000037252902985 5166053.05999999959021807 967867.069999999948777258 4604122.5400000000372529 5142.75000000139698386192 -838.550000000104773789644 -5579.00000000139698386192 5167081.49000000022351742 967699.319999999948777258 4603006.62999999988824129 5141.52500000083819031715 -838.92499999987194314599 -5580.07500000065192580223 5168109.66999999992549419 967531.5 4601890.50999999977648258 5140.30000000027939677238 -839.274999999906867742538 -5581.14999999990686774254 5169137.61000000033527613 967363.609999999986030161 4600774.16999999992549419 5139.07499999972060322762 -839.649999999965075403452 -5582.22499999916180968285 5170165.29999999981373549 967195.640000000013969839 4599657.62000000011175871 5137.84999999916180968285 -840.050000000046566128731 -5583.30000000074505805969 5171192.75 967027.58999999996740371 4598540.84999999962747097 5136.62500000093132257462 -840.425000000104773789644 -5584.375 5172219.95000000018626451 966859.469999999972060323 4597423.87000000011175871 5135.40000000037252902985 -840.774999999848660081625 -5585.44999999925494194031 5173246.91000000014901161 966691.280000000027939677 4596306.66999999992549419 5134.17499999981373548508 -841.149999999906867742538 -5586.52500000083819031715 5174273.62000000011175871 966523.010000000009313226 4595189.25999999977648258 5132.94999999925494194031 -841.549999999988358467817 -5587.60000000009313225746 5175300.08999999985098839 966354.66000000003259629 4594071.62999999988824129 5131.72499999869614839554 -841.900000000023283064365 -5588.67499999934807419777 5176326.30999999959021807 966186.25 4592953.7900000000372529 5130.50000000046566128731 -842.275000000081490725279 -5589.74999999860301613808 5177352.2900000000372529 966017.75 4591835.73000000044703484 5129.27499999990686774254 -842.67499999987194314599 -5590.82500000018626451492 5178378.01999999955296516 965849.180000000051222742 4590717.4599999999627471 5128.04999999934807419777 -843.024999999906867742538 -5591.875 5179403.50999999977648258 965680.540000000037252903 4589598.98000000044703484 5126.82500000111758708954 -843.400000000256113708019 -5592.97500000102445483208 5180428.75 965511.819999999948777258 4588480.26999999955296516 5125.57500000111758708954 -843.775000000023283064365 -5594.05000000027939677238 5181453.74000000022351742 965343.030000000027939677 4587361.36000000033527613 5124.35000000055879354477 -844.149999999790452420712 -5595.09999999776482582092 5182478.49000000022351742 965174.16000000003259629 4586242.23000000044703484 5123.125 -844.525000000139698386192 -5596.20000000111758708954 5183502.99000000022351742 965005.219999999972060323 4585122.87999999988824129 5121.89999999944120645523 -844.900000000197906047106 -5597.27500000037252902985 5184527.25 964836.199999999953433871 4584003.32000000029802322 5120.67499999888241291046 -845.274999999965075403452 -5598.34999999962747097015 5185551.25999999977648258 964667.109999999986030161 4582883.5400000000372529 5119.45000000065192580223 -845.650000000023283064365 -5599.40000000176951289177 5186575.03000000026077032 964497.939999999944120646 4581763.55999999959021807 5118.22500000009313225746 -846.025000000081490725279 -5600.47500000102445483208 5187598.54999999981373549 964328.699999999953433871 4580643.34999999962747097 5116.97500000009313225746 -846.399999999848660081625 -5601.57499999972060322762 5188621.82000000029802322 964159.380000000004656613 4579522.92999999970197678 5115.74999999953433871269 -846.774999999906867742538 -5602.62499999953433871269 5189644.84999999962747097 963989.989999999990686774 4578402.29999999981373549 5114.54999999841675162315 -847.124999999941792339087 -5603.699999998789280653 5190667.63999999966472387 963820.530000000027939677 4577281.45000000018626451 5113.30000000074505805969 -847.5 -5604.77500000037252902985 5191690.16999999992549419 963650.989999999990686774 4576160.38999999966472387 5112.05000000074505805969 -847.900000000081490725279 -5605.82500000018626451492 5192712.4599999999627471 963481.369999999995343387 4575039.12000000011175871 5110.84999999962747097015 -848.274999999848660081625 -5606.89999999944120645523 5193734.50999999977648258 963311.680000000051222742 4573917.62999999988824129 5109.59999999962747097015 -848.624999999883584678173 -5607.97500000102445483208 5194756.29999999981373549 963141.920000000041909516 4572795.92999999970197678 5108.37500000139698386192 -849.000000000232830643654 -5609.05000000027939677238 5195777.86000000033527613 962972.079999999958090484 4571674.00999999977648258 5107.15000000083819031715 -849.375 -5610.12499999953433871269 5196799.16000000014901161 962802.170000000041909516 4570551.87999999988824129 5105.89999999850988388062 -849.749999999767169356346 -5611.199999998789280653 5197820.21999999973922968 962632.180000000051222742 4569429.53000000026077032 5104.67500000027939677238 -850.125000000116415321827 -5612.27500000037252902985 5198841.03000000026077032 962462.119999999995343387 4568306.96999999973922968 5103.44999999972060322762 -850.50000000017462298274 -5613.32500000018626451492 5199861.59999999962747097 962291.979999999981373549 4567184.20000000018626451 5102.22499999916180968285 -850.874999999941792339087 -5614.39999999944120645523 5200881.91999999992549419 962121.770000000018626451 4566061.2099999999627471 5101.00000000093132257462 -851.25 -5615.47500000102445483208 5201902 961951.479999999981373549 4564938.00999999977648258 5099.75000000093132257462 -851.625000000058207660913 -5616.55000000027939677238 5202921.82000000029802322 961781.119999999995343387 4563814.58999999985098839 5098.50000000093132257462 -851.975000000093132257462 -5617.62499999953433871269 5203941.40000000037252903 961610.689999999944120646 4562690.9599999999627471 5097.29999999981373548508 -852.349999999860301613808 -5618.699999998789280653 5204960.74000000022351742 961440.180000000051222742 4561567.11000000033527613 5096.07499999925494194031 -852.749999999941792339087 -5619.75000000093132257462 5205979.83000000007450581 961269.58999999996740371 4560443.05999999959021807 5094.82499999925494194031 -853.100000000267755240202 -5620.82500000018626451492 5206998.66999999992549419 961098.939999999944120646 4559318.78000000026077032 5093.57499999925494194031 -853.475000000034924596548 -5621.89999999944120645523 5208017.25999999977648258 960928.199999999953433871 4558194.29999999981373549 5092.35000000102445483208 -853.87499999982537701726 -5622.95000000158324837685 5209035.61000000033527613 960757.390000000013969839 4557069.59999999962747097 5091.12500000046566128731 -854.224999999860301613808 -5624.05000000027939677238 5210053.7099999999627471 960586.510000000009313226 4555944.67999999970197678 5089.87499999813735485077 -854.574999999895226210356 -5625.10000000009313225746 5211071.55999999959021807 960415.560000000055879354 4554819.55999999959021807 5088.64999999990686774254 -854.974999999976716935635 -5626.17499999934807419777 5212089.16999999992549419 960244.520000000018626451 4553694.2099999999627471 5087.42500000167638063431 -855.350000000034924596548 -5627.24999999860301613808 5213106.53000000026077032 960073.420000000041909516 4552568.66000000014901161 5086.17499999934807419777 -855.700000000069849193096 -5628.30000000074505805969 5214123.63999999966472387 959902.239999999990686774 4551442.88999999966472387 5084.949999998789280653 -856.100000000151339918375 -5629.375 5215140.50999999977648258 959730.979999999981373549 4550316.91000000014901161 5083.72500000055879354477 -856.449999999895226210356 -5630.44999999925494194031 5216157.12999999988824129 959559.66000000003259629 4549190.7099999999627471 5082.47500000055879354477 -856.824999999953433871269 -5631.50000000139698386192 5217173.5 959388.25 4548064.30999999959021807 5081.22500000055879354477 -857.200000000011641532183 -5632.54999999888241291046 5218189.62000000011175871 959216.780000000027939677 4546937.69000000040978193 5080 -857.575000000069849193096 -5633.64999999990686774254 5219205.5 959045.219999999972060323 4545810.84999999962747097 5078.77499999944120645523 -857.95000000012805685401 -5634.72500000149011611938 5220221.12999999988824129 958873.599999999976716936 4544683.79999999981373549 5077.52499999944120645523 -858.29999999987194314599 -5635.77499999897554516792 5221236.50999999977648258 958701.900000000023283064 4543556.5400000000372529 5076.300000001210719347 -858.699999999953433871269 -5636.824999998789280653 5222251.65000000037252903 958530.119999999995343387 4542429.07000000029802322 5075.07500000065192580223 -859.075000000011641532183 -5637.90000000037252902985 5223266.5400000000372529 958358.270000000018626451 4541301.37999999988824129 5073.82499999832361936569 -859.425000000046566128731 -5638.97499999962747097015 5224281.17999999970197678 958186.349999999976716936 4540173.48000000044703484 5072.57500000065192580223 -859.800000000104773789644 -5640.02499999944120645523 5225295.57000000029802322 958014.349999999976716936 4539045.37000000011175871 5071.32500000065192580223 -860.17499999987194314599 -5641.10000000102445483208 5226309.7099999999627471 957842.280000000027939677 4537917.0400000000372529 5070.10000000009313225746 -860.524999999906867742538 -5642.17500000027939677238 5227323.61000000033527613 957670.140000000013969839 4536788.5 5068.87499999953433871269 -860.899999999965075403452 -5643.22500000009313225746 5228337.25999999977648258 957497.920000000041909516 4535659.75 5067.62499999953433871269 -861.300000000046566128731 -5644.27499999990686774254 5229350.66000000014901161 957325.619999999995343387 4534530.7900000000372529 5066.37499999953433871269 -861.675000000104773789644 -5645.34999999916180968285 5230363.80999999959021807 957153.25 4533401.61000000033527613 5065.14999999897554516792 -862.024999999848660081625 -5646.42500000074505805969 5231376.71999999973922968 956980.810000000055879354 4532272.21999999973922968 5063.92500000074505805969 -862.399999999906867742538 -5647.47500000055879354477 5232389.37999999988824129 956808.290000000037252903 4531142.62000000011175871 5062.67500000074505805969 -862.775000000256113708019 -5648.54999999981373548508 5233401.7900000000372529 956635.699999999953433871 4530012.79999999981373549 5061.42500000074505805969 -863.125 -5649.59999999962747097015 5234413.95000000018626451 956463.040000000037252903 4528882.78000000026077032 5060.17500000074505805969 -863.499999999767169356346 -5650.64999999944120645523 5235425.86000000033527613 956290.300000000046566129 4527752.5400000000372529 5058.95000000018626451492 -863.875000000116415321827 -5651.72500000102445483208 5236437.53000000026077032 956117.489999999990686774 4526622.08999999985098839 5057.72499999962747097015 -864.25000000017462298274 -5652.80000000027939677238 5237448.95000000018626451 955944.599999999976716936 4525491.41999999992549419 5056.47499999962747097015 -864.624999999941792339087 -5653.85000000009313225746 5238460.12000000011175871 955771.640000000013969839 4524360.54999999981373549 5055.22499999962747097015 -865 -5654.89999999990686774254 5239471.0400000000372529 955598.599999999976716936 4523229.4599999999627471 5053.97499999962747097015 -865.375000000058207660913 -5655.97499999916180968285 5240481.7099999999627471 955425.489999999990686774 4522098.16000000014901161 5052.72499999962747097015 -865.724999999802093952894 -5657.02499999897554516792 5241492.12999999988824129 955252.310000000055879354 4520966.65000000037252903 5051.49999999906867742538 -866.099999999860301613808 -5658.10000000055879354477 5242502.30999999959021807 955079.050000000046566129 4519834.91999999992549419 5050.27500000083819031715 -866.475000000209547579288 -5659.17499999981373548508 5243512.24000000022351742 954905.719999999972060323 4518702.98000000044703484 5049.02500000083819031715 -866.825000000244472175837 -5660.20000000018626451492 5244521.91999999992549419 954732.319999999948777258 4517570.83999999985098839 5047.77499999850988388062 -867.200000000011641532183 -5661.25 5245531.34999999962747097 954558.83999999996740371 4516438.48000000044703484 5046.52500000083819031715 -867.574999999778810888529 -5662.34999999869614839554 5246540.53000000026077032 954385.290000000037252903 4515305.90000000037252903 5045.27500000083819031715 -867.949999999837018549442 -5663.40000000083819031715 5247549.4599999999627471 954211.66000000003259629 4514173.12000000011175871 5044.05000000027939677238 -868.325000000186264514923 -5664.425000001210719347 5248558.15000000037252903 954037.959999999962747097 4513040.12999999988824129 5042.80000000027939677238 -868.699999999953433871269 -5665.50000000046566128731 5249566.58000000007450581 953864.180000000051222742 4511906.91999999992549419 5041.54999999795109033585 -869.075000000011641532183 -5666.57499999972060322762 5250574.76999999955296516 953690.329999999958090484 4510773.5 5040.32499999972060322762 -869.425000000046566128731 -5667.62499999953433871269 5251582.7099999999627471 953516.41000000003259629 4509639.87000000011175871 5039.07500000204890966415 -869.774999999790452420712 -5668.67499999934807419777 5252590.40000000037252903 953342.420000000041909516 4508506.03000000026077032 5037.82499999972060322762 -870.150000000139698386192 -5669.75000000093132257462 5253597.83999999985098839 953168.349999999976716936 4507371.96999999973922968 5036.57499999972060322762 -870.550000000221189111471 -5670.80000000074505805969 5254605.03000000026077032 952994.199999999953433871 4506237.7099999999627471 5036.57499999972060322762 -870.550000000221189111471 -5670.80000000074505805969\nnCovRow = 25\nnDataRow = 145\nnominalISDCovarinace = 0.5 0 0 0.5 0 0.5\nstartTime = 1437301190.460421\nstartTimeStamp = 2015-07-19T10:19:50.460421Z\ntimeInterval = 0.2\nIsdBase::Ephemeris BEGIN\ncurrentValue = 4.809770019313233e-05 -0.01066966216931186 -0.002796760544264161 0 0 0\noriginalValue = 0 0 0 0 0 0\nparameterDelta = 0.1 0.1 0.1 0.1 0.1 0.1\nparameterId = 0 1 2 3 4 5\nparameterName = IN_TRACK_POSITION CROSS_TRACK_POSITION RADIAL_TRACK_POSITION IN_TRACK_VELOCITY CROSS_TRACK_VELOCITY RADIAL_TRACK_VELOCITY\nparameterType = 2 2 2 3 3 3\nparameterUnit = meters meters meters kilometers/second kilometers/second kilometers/second\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0 3.7 20\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 4 5\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationModel::CorrelationModel END\nIsdBase::Ephemeris END\nIsdBase::Ephemeris END\nIsdBase::Geo BEGIN\ndetOriginX = 0\ndetOriginY = 169.9979\ndetPitch = 0.0122831821959\ndetRotAngle = 0\nfocalLength = 16018.01822\nqcs1 = 0\nqcs2 = 0\nqcs3 = 0\nqcs4 = 1\nIsdBase::Geo BEGIN\ncurrentValue = 0 0 0\noriginalValue = 0 0 0\nparameterDelta = 0.1 0.1 0.1\nparameterId = 16 17 18\nparameterName = FOCAL_LENGTH DETECTOR_OFFSET_X DETECTOR_OFFSET_Y\nparameterType = 3 3 3\nparameterUnit = mm mm mm\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationModel::CorrelationModel END\nIsdBase::Geo END\nIsdBase::Geo END\nIsdBase::Imd BEGIN\nLLHgt = 92\nLLLat = 0.7314343282550356\nLLLon = 0.2173060582439084\nLRHgt = 91.7\nLRLat = 0.7315161841969542\nLRLon = 0.2203200673291774\nULHgt = 134.1\nULLat = 0.7336315232503713\nULLon = 0.2173053601122076\nURHgt = 182.8\nURLat = 0.733710063066711\nURLon = 0.2203111661499922\navgLineRate = 13025.85307307739\nbandType = 0\ncatId = P10EC4DD00\nduration = 2.144658\nfirstLineTime = 1437301202.631388\nheightRange = -374.85 625.15\nimageId = ''19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                    ''\nmeanSatAz = 0\nmeanSatEl = 0\nmeanSunAz = 2.552194965191308\nmeanSunEl = 1.151341347663099\nnumColumns = 27680\nnumRows = 27936\nproductType = Basic1B\nrevNumber = 05042\nsatId = WV03\nscanDirection = 0\nt0_s = 2015-07-19T10:20:2.631388Z\ntileOffset = 0 0\nIsdBase::Imd BEGIN\ncurrentValue = 0\noriginalValue = 0\nparameterDelta = 0.1\nparameterId = 19\nparameterName = LINE_SCAN_RATE\nparameterType = 3\nparameterUnit = lines/second\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 0\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationModel::CorrelationModel END\nIsdBase::Imd END\ntm BEGIN\nhour = 10\nisdst = 0\nmday = 19\nmin = 20\nmon = 6\nsec = 2\nwday = 0\nyday = 199\nyear = 115\ntm END\nIsdBase::Imd END\nIsdModel::1B END\nProjectionModel::1B BEGIN\necfRef = 4635839.698967027 1030851.745347983 4243489.824944279\necfToTanXform = 0.652829428104613 0.1452152884283369 -0.7434556192586609 0.2170947762102438 -0.9761505298403917 -3.513611537449054e-05 0.7257296989532868 0.1613773933951014 0.6687852726833736\nimageLocation = 4635839.698967027 1030851.745347983 4243489.824944279\nsystematicCorrections = 1 1\nProjectionModel::1B END\nWV03_EO_BASIC_DG_5.1.0 END\n", "sensorModel": "WV03_EO_BASIC_DG_5.1.0"}, {"imageId": "19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                    ", "filename": "/data/s3/msp/Stereo/test/A.NTF", "entryIndex": 0, "modelState": "WV03_EO_BASIC_DG_5.1.0 BEGIN\nmodelVersion = 5.1.0\nsensorModelName = WV03_EO_BASIC_DG_5.1.0\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 0 3.7 20\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 4 5\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationGroup::2 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 6 7 10 11 14 15\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::2 END\nCorrelationGroup::3 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 8 12\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::3 END\nCorrelationGroup::4 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 9 13\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::4 END\nCorrelationGroup::5 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 16 17 18\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::5 END\nCorrelationGroup::6 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 20150719T103537Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 19\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::6 END\nCorrelationModel::CorrelationModel END\nCovarianceModel::1B BEGIN\ncurrentCovariance = 0.8058781975169234 0.1688888823232003 -0.7567983458374733 0 0 0 -0.00142654219135057 3.252675362089117e-07 0 0 -0.0004020725649599796 9.165551972503324e-08 0 0 -3.907994456242959e-06 1.031184744050114e-09 0 0 0 0 0.5443242352784929 -0.4233475242451679 0 0 0 -0.2413106126813002 1.589208764106698e-05 0 0 -0.06797872193406067 4.478489223750381e-06 0 0 -0.0005708572896613347 7.582463225634553e-08 0 0 0 0 2.340869928154337 0 0 0 -0.0572123953729585 2.990531497645009e-06 0 0 -0.01611639837707714 8.427735696045936e-07 0 0 -0.0001335526285103784 1.601837484026366e-08 0 0 0 0 5.41895309741943e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.871804553451305e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.614779802657119e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.670599527147259 8.596525957985432e-05 0 0 -0.3737983406667382 2.423199725615867e-05 0 0 -0.003135370856580707 8.370716799259129e-07 0 0 0 0 0.003051990036279721 0 0 2.474874405233666e-05 -1.864845532727439e-07 0 0 1.548841878020387e-06 1.686284762783349e-08 0 0 0 0 5.19743524883837e-13 0 0 0 0 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 0 0 0 0 3.892211586427892 7.605532825320105e-06 0 0 -0.0008844847598998003 -1.736542844342589e-06 0 0 0 0 0.003052738311244587 0 0 3.844945147469795e-07 -1.155393296324758e-09 0 0 0 0 5.199877889939213e-13 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 15.99004143630805 2.574707315010873e-06 0 0 0 0 0.01221114907200409 0 0 0 0 0.01682512727779459 0 0 0 1.33354186409847e-16 0 0 1.334168589398715e-16 0 1.213505738730986e-12\ngridSize = 4 4 4\nheightRange = -1000 4000\noriginalCovariance = 0.8058798233816066 0.1691484225256028 -0.7567371190437919 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5882088080069759 -0.4129432901540359 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.343337609342538 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.41895309741943e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.871804553451305e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2.614779802657119e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3.997512054329843 1.213143399798956e-07 0 0 -8.906202188154605e-08 4.059310970102831e-08 0 0 8.697596996069348e-08 4.240177382148999e-07 0 0 0 0 0.003052584227097638 0 0 4.026179864675961e-08 -1.905543046755356e-08 0 0 -1.106607136219811e-08 1.837296676203711e-08 0 0 0 0 5.19743524883837e-13 0 0 0 0 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 0 0 0 0 3.997512993488343 6.425314320135932e-07 0 0 2.407990030700426e-09 -1.854227336370085e-06 0 0 0 0 0.003052785488868883 0 0 -5.505690083542957e-08 -7.298765401664966e-10 0 0 0 0 5.199877889939213e-13 0 0 0 0 0 0 0 1e-12 0 0 0 0 0 0 15.99005197391627 2.570311414301636e-06 0 0 0 0 0.0122111490758709 0 0 0 0 0.01682512727779459 0 0 0 1.33354186409847e-16 0 0 1.334168589398715e-16 0 1.213505738730986e-12\nunmodeledError = 0.5 0 0.5\nunmodeledErrorCorrelation = 0.05\nCovarianceModel::1B END\nIsdModel::1B BEGIN\nIsdBase::Attitude BEGIN\nattCov = 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16 4 0 0 4 0 16\nattData = 0.9786117854763708 0.08108098249505322 -0.188499565909087 -0.01458633800760381 0.978612095210422 0.08106279172866879 -0.1885039501675886 -0.01460998549751587 0.9786124050424594 0.08104459815412163 -0.1885083303126018 -0.01463363283008398 0.9786127149775166 0.08102640172780494 -0.1885127063385925 -0.0146572799754213 0.9786130250137153 0.08100820246589074 -0.1885170782470897 -0.01468092694387799 0.9786133351524916 0.08099000035588445 -0.1885214460362357 -0.01470457372649652 0.978613645389274 0.08097179543723587 -0.1885258097103109 -0.01472822034932759 0.9786139557289105 0.0809535876679581 -0.1885301692639668 -0.01475186678357177 0.9786142661709656 0.08093537705174043 -0.1885345246972586 -0.01477551303116066 0.9786145767105645 0.08091716363064971 -0.1885388760147807 -0.01479915911991284 0.9786148873527656 0.08089894736088421 -0.1885432232109658 -0.01482280501980126 0.9786151980956727 0.0808807282587569 -0.1885475662873628 -0.0148464507412731 0.9786155089408511 0.0808625063106638 -0.188551905241979 -0.01487009627461935 0.9786158198832892 0.08084428155985049 -0.1885562400795541 -0.01489374164845747 0.9786161309285268 0.08082605395835475 -0.1885605707940219 -0.01491738682994869 0.9786164420733858 0.08080782353357376 -0.1885648973882464 -0.01494103183701937 0.97861675332117 0.08078959025687295 -0.188569219858452 -0.01496467664981771 0.9786170646656002 0.08077135418244843 -0.1885735382106819 -0.0149883213043533 0.9786173761119923 0.08075311526428294 -0.1885778524390936 -0.01501196576909451 0.9786176876604022 0.08073487350181535 -0.1885821625432398 -0.01503561004310456 0.9786179993059601 0.08071662893705518 -0.1885864685277227 -0.0150592541541733 0.9786183110528596 0.08069838153368793 -0.1885907703878467 -0.0150828980773128 0.9786186229001377 0.08068013129995585 -0.1885950681242093 -0.01510654181752697 0.9786189348488538 0.08066187822663493 -0.1885993617353322 -0.01513018536805749 0.9786192468943441 0.08064362235393759 -0.1886036512256104 -0.01515382875548517 0.9786195590412563 0.08062536364163857 -0.1886079365898785 -0.0151774719521785 0.9786198712896478 0.08060710208916319 -0.1886122178276869 -0.01520111495719046 0.9786201836346347 0.08058883773862537 -0.1886164949436605 -0.01522475779838804 0.9786204960809171 0.08057057054934945 -0.1886207679325761 -0.01524840044783226 0.9786208086264213 0.08055230053916976 -0.1886250367961737 -0.01527204291700231 0.9786211212736782 0.08053402768615027 -0.1886293015314607 -0.0152956851905563 0.9786214340168937 0.08051575204025722 -0.1886335621440015 -0.0153193273016656 0.9786217468610886 0.08049747355805278 -0.188637818628239 -0.01534296922052207 0.978622059806444 0.08047919223789318 -0.188642070983596 -0.0153666109454558 0.9786223728478894 0.08046090812349278 -0.1886463192148972 -0.01539025250542093 0.9786226859897972 0.08044262117701484 -0.1886505633172486 -0.01541389387438708 0.9786229992313836 0.0804243314051515 -0.1886548032910661 -0.01543753505631266 0.978623312573411 0.08040603880124308 -0.1886590391351725 -0.01546117604616578 0.978623626011257 0.08038774340512261 -0.1886632708539358 -0.01548481687028341 0.9786239395497105 0.08036944517536634 -0.1886674984420283 -0.01550845750020882 0.9786242531869859 0.08035114412731387 -0.1886717219008985 -0.01553209794574014 0.9786245669250585 0.0803328402438309 -0.188675941228119 -0.01555573819477055 0.9786248807583232 0.08031453357323337 -0.1886801564290745 -0.01557937827936936 0.9786251946920863 0.08029622406963433 -0.1886843674978996 -0.01560301816806095 0.9786255087262675 0.08027791173365006 -0.1886885744342862 -0.01562665786070011 0.978625822855425 0.08025959661217641 -0.1886927772434548 -0.01565029738840025 0.9786261370849324 0.08024127865875109 -0.1886969759194662 -0.01567393671929337 0.978626451412735 0.08022295789103241 -0.1887011704640494 -0.01569757586474535 0.9786267658409094 0.08020463429101951 -0.1887053608746689 -0.01572121481206032 0.9786270803639465 0.08018630790618121 -0.1887095471566193 -0.01574485359274293 0.9786273949869914 0.08016797869203478 -0.1887137293041922 -0.01576849217625707 0.9786277097096497 0.0801496466519082 -0.1887179073174038 -0.0157921305642887 0.9786280245272784 0.08013131182578993 -0.1887220812006591 -0.01581576878329225 0.9786283394445716 0.0801129741730944 -0.1887262509487114 -0.01583940680536073 0.9786286544602747 0.08009463370456837 -0.1887304165624656 -0.0158630446371928 0.9786289695748914 0.0800762904157899 -0.1887345780410077 -0.015886682275263 0.9786292847846508 0.08005794433921462 -0.1887387353878456 -0.01591031974093943 0.9786296000934819 0.08003959544086707 -0.188742888598519 -0.01593395701077722 0.9786299155020387 0.08002124371502445 -0.1887470376719601 -0.01595759408034586 0.9786302310046928 0.08000288921016477 -0.1887511826136004 -0.01598123098184295 0.9786305466066243 0.07998453188152442 -0.1887553234176825 -0.01600486768453003 0.9786308623063711 0.07996617174163605 -0.1887594600853285 -0.01602850419631358 0.9786311781051188 0.07994780878019363 -0.1887635926149167 -0.01605214050968979 0.9786314939981489 0.0799294430378182 -0.1887677210109422 -0.01607577665155033 0.978631809989891 0.0799110744762261 -0.1887718452684197 -0.01609941259553151 0.9786321260791081 0.07989270310600385 -0.1887759653882386 -0.01612304834822511 0.978632442266872 0.07987432891783436 -0.1887800813688953 -0.01614668390279443 0.9786327585491755 0.07985595194618827 -0.1887841932141513 -0.01617031928197713 0.9786330749297463 0.07983757215884954 -0.1887883009197445 -0.01619395446350666 0.9786333914088817 0.07981918955316937 -0.1887924044849744 -0.01621758944502792 0.978633707982061 0.07980080416805284 -0.1887965039141392 -0.01624122425227868 0.9786340246536896 0.07978241596543185 -0.1888005992022699 -0.01626485885903317 0.9786343414218035 0.07976402496216525 -0.1888046903510127 -0.01628849327612498 0.978634658288947 0.07974563113623262 -0.1888087773573334 -0.01631212748812572 0.9786349752490995 0.07972723453946411 -0.1888128602270904 -0.01633576152951594 0.9786352923076447 0.07970883512536428 -0.188816938954295 -0.01635939536836727 0.9786356094642551 0.07969043289667736 -0.1888210135388953 -0.0163830290059698 0.9786359267145599 0.07967202789100246 -0.1888250839850408 -0.01640666246718417 0.9786362440624209 0.07965362007497211 -0.1888291502883202 -0.0164302957289558 0.9786365615070319 0.07963520945545219 -0.188833212449179 -0.01645392879536246 0.9786368790493231 0.07961679602434919 -0.188837270466256 -0.0164775616603896 0.9786371966847789 0.07959837982049855 -0.1888413243438554 -0.01650119434973763 0.978637514417954 0.07957996080456835 -0.1888453740768411 -0.01652482683631385 0.9786378322488829 0.07956153897618104 -0.188849419664785 -0.01654845911929648 0.9786381501725862 0.07954311437816623 -0.1888534611124767 -0.01657209122709002 0.9786384681939588 0.07952468696826114 -0.1888574984144229 -0.01659572313061601 0.9786387863114053 0.07950625676013923 -0.1888615315718922 -0.01661935483855733 0.9786391045261593 0.07948782374308325 -0.1888655605832052 -0.01664298634312237 0.9786394228335614 0.07946938795716429 -0.1888695854528232 -0.01666661767085326 0.978639741238025 0.07945094936427473 -0.1888736061757496 -0.01669024879547796 0.9786400597386891 0.07943250797175275 -0.1888776227524892 -0.01671387972139409 0.9786403783362138 0.07941406377382797 -0.1888816351819588 -0.01673751044415517 0.978640697025685 0.07939561681275781 -0.18888564346889 -0.01676114099178656 0.9786410158128411 0.07937716703902575 -0.1888896476069 -0.01678477133029178 0.9786413346970579 0.07935871445792919 -0.1888936475962467 -0.01680840146268751 0.9786416536730606 0.07934025911482449 -0.1888976434420413 -0.01683203141909862 0.978641972745817 0.07932180096683687 -0.1889016351387005 -0.01685566117001942 0.9786422919139394 0.0793033400258424 -0.1889056226872799 -0.01687929072291876 0.9786426111788914 0.07928487627914968 -0.1889096060858569 -0.01690292006866469 0.9786429305357771 0.07926640976884625 -0.1889135853391516 -0.01692654923517373 0.9786432499891449 0.07924794045568023 -0.1889175604420137 -0.01695017819538718 0.978643569538962 0.07922946833985019 -0.1889215313940845 -0.01697380694887081 0.9786438891807523 0.07921099345982272 -0.1889254981996495 -0.01699743552109302 0.9786442089184901 0.07919251578129237 -0.1889294608541548 -0.01702106388834009 0.9786445287511408 0.07917403531308635 -0.1889334193582892 -0.01704469205601852 0.9786448486803637 0.07915555204083752 -0.1889373737099225 -0.0170683200138584 0.9786451687006735 0.07913706601168968 -0.1889413239143994 -0.01709194779320612 0.9786454888174537 0.07911857717921483 -0.1889452699656881 -0.01711557536213678 0.9786458090300412 0.07910008554903866 -0.1889492118640891 -0.01713920272388933 0.9786461293339154 0.07908159115999576 -0.1889531496139419 -0.01716282990418768 0.9786464497338083 0.07906309397126932 -0.188957083209892 -0.01718645687490218 0.978646770227861 0.07904459399878018 -0.1889610126534931 -0.01721008364624294 0.9786470908177977 0.07902609122760511 -0.1889649379425441 -0.01723371020756036 0.9786474114984373 0.07900758570225608 -0.18896885908208 -0.01725733658842608 0.9786477322753502 0.07898907737470678 -0.1889727760658636 -0.01728096275582373 0.9786480531456742 0.07897056626951103 -0.1889766888965016 -0.01730458872581073 0.9786483741118185 0.07895205236584972 -0.1889805975710726 -0.01732821448374262 0.9786486951686096 0.07893353570816594 -0.1889845020946091 -0.01735184005914839 0.978649016320956 0.07891501625413716 -0.1889884024615624 -0.01737546542286932 0.9786493375685228 0.07889649400655994 -0.1889922986718894 -0.0173990905762283 0.9786496589065264 0.07887796900651542 -0.1889961907302184 -0.01742271554648039 0.978649980339781 0.07885944121249913 -0.1890000786310951 -0.0174463403050173 0.9786503018666964 0.07884091063811091 -0.1890039623757959 -0.01746996486047992 0.9786506234888456 0.07882237726973074 -0.1890078419622724 -0.0174935892030957 0.9786509452006248 0.07880384115549206 -0.1890117173960183 -0.01751721336490088 0.9786512670079853 0.07878530224410943 -0.1890155886703803 -0.01754083731065623 0.9786515889099492 0.07876676054391607 -0.1890194557859923 -0.01756446104543508 0.9786519109018198 0.07874821609522974 -0.1890233187473977 -0.01758808459598197 0.978652232988885 0.07872966885247998 -0.1890271775486366 -0.01761170793092524 0.9786525551685881 0.07871111883758053 -0.1890310321920039 -0.01763533106454046 0.9786528774430947 0.07869256603181363 -0.189034882674825 -0.01765895398359782 0.9786531998073097 0.07867401047892676 -0.1890387290020684 -0.01768257671716907 0.9786535222662953 0.07865545213529403 -0.1890425711680044 -0.01770619923519528 0.9786538448193204 0.07863689100712153 -0.1890464091730097 -0.01772982154130904 0.9786541674620798 0.07861832713135063 -0.1890502430212233 -0.01775344365997291 0.9786544901990296 0.07859976046957703 -0.1890540727075518 -0.01777706556466283 0.9786548130287167 0.07858119103421356 -0.1890578982331316 -0.01780068726321847 0.9786551359525014 0.07856261881347928 -0.1890617195961329 -0.01782430874710688 0.9786554589656511 0.07854404384798508 -0.1890655368011501 -0.01784793004328111 0.9786557820729412 0.07852546609658477 -0.1890693498427475 -0.01787155112335414 0.978656105272197 0.07850688557789665 -0.1890731587228247 -0.01789517199937265 0.9786564285654853 0.07848830227406578 -0.1890769634388057 -0.01791879265868489 0.9786567519482638 0.07846971622405631 -0.1890807639950871 -0.01794241312713098 0.9786570754240128 0.07845112739787088 -0.1890845603875961 -0.01796603338387722 0.9786573989940951 0.07843253578370757 -0.189088352614501 -0.0179896534203481 0.9786577226528336 0.07841394143028295 -0.189092140681399 -0.01801327326899848 0.9786580464048564 0.07839534429773246 -0.1890959245830036 -0.01803689290230197 0.9786583702492926 0.07837674439345646 -0.1890997043198398 -0.01806051232470166 0.978658694186524 0.07835814171409128 -0.1891034798911067 -0.01808413153336722 0.9786590182129242 0.07833953629071616 -0.1891072513002431 -0.01810775054879881 0.9786593423321126 0.07832092809214737 -0.1891110185430216 -0.01813136934935156 0.9786596665447772 0.07830231711238345 -0.1891147816183205 -0.0181549879303805 0.9786599908458755 0.07828370339467405 -0.1891185405310775 -0.01817860632064107 0.9786603152401848 0.0782650868978829 -0.189122295275838 -0.01820222449173605 0.9786606397254162 0.07824646764159639 -0.1891260458546294 -0.0182258424563737 0.9786609643038284 0.07822784560631739 -0.1891297922646644 -0.01824946020078023 0.9786612889705015 0.07820922083423634 -0.1891335345107557 -0.01827307775299635 0.9786616137297858 0.07819059328789271 -0.1891372725878961 -0.01829669508711352 0.9786619385819844 0.0781719629645965 -0.1891410064953705 -0.01832031220073081 0.9786622635219969 0.07815332990808277 -0.1891447362381852 -0.01834392912293976 0.9786625885547398 0.07813469407602816 -0.1891484618107308 -0.01836754582452977 0.9786629136782102 0.07811605548555409 -0.1891521832147348 -0.01839116231653953 0.9786632388944857 0.07809741411873075 -0.1891559004475978 -0.0184147785862536 0.9786635641982355 0.07807877002126223 -0.1891596135145758 -0.01843839466410373 0.9786638895940299 0.07806012315380929 -0.1891633224104218 -0.01846201052289897 0.9786642150808609 0.07804147352494128 -0.1891670271358089 -0.01848562616787656 0.978664540660207 0.07802282112187847 -0.1891707276887722 -0.01850924158981337 0.9786648663259879 0.07800416599675121 -0.1891744240753672 -0.01853285682350568 0.9786651920847512 0.07798550809324772 -0.1891781162882444 -0.01855647183024092 0.9786655179348608 0.0779668474253318 -0.1891818043287443 -0.0185800866189171 0.9786658438727229 0.07794818402377798 -0.1891854882002883 -0.01860370120984163 0.9786661699021553 0.07792951785571969 -0.1891891678984191 -0.01862731558020802 0.9786664960218987 0.0779108489318837 -0.1891928434240796 -0.0186509297367185 0.9786668222332229 0.07789217724128136 -0.1891965147755225 -0.01867454367136242 0.9786671485315449 0.07787350282317794 -0.1892001819572242 -0.01869815741021261 0.9786674749213671 0.07785482563882981 -0.1892038449639954 -0.01872177092646984 0.978667801403 0.07783614568548856 -0.1892075037951111 -0.01874538421768979 0.978668127971 0.07781746300979846 -0.1892111584559649 -0.01876899731495702 0.9786684546307836 0.07779877756517825 -0.1892148089403932 -0.01879261018614834 0.9786687813798293 0.07778008937318531 -0.1892184552506826 -0.01881622284531941 0.9786691082208082 0.07776139841080655 -0.1892220973835932 -0.01883983527629332 0.9786694351474116 0.0777427047321083 -0.1892257353454449 -0.01886344751519786 0.9786697621657653 0.07772400828442211 -0.1892293691293125 -0.01888705952577171 0.9786700892748169 0.07770530907669761 -0.1892329987359215 -0.01891067131351171 0.9786704164703486 0.07768660714504715 -0.1892366241693691 -0.0189342829023589 0.9786707437565336 0.07766790245356955 -0.1892402454248067 -0.01895789426743269 0.9786710711324308 0.07764919501025544 -0.1892438625028409 -0.01898150541357933 0.9786713985987447 0.07763048480897336 -0.1892474754023225 -0.01900511633608044 0.9786717261511089 0.07761177188710588 -0.1892510841275119 -0.01902872705974323 0.9786720537941235 0.07759305620509332 -0.1892546886731003 -0.01905233755719801 0.9786723815260336 0.07757433777790708 -0.1892582890405638 -0.01907594783803247 0.9786727093488367 0.0775556165883242 -0.1892618852273731 -0.01909955788999408 0.9786730372569196 0.07753689268441405 -0.1892654772391221 -0.01912316774515156 0.9786733652556825 0.07751816601976276 -0.1892690650696439 -0.01914677737147533 0.9786736933445932 0.07749943659885083 -0.1892726487191106 -0.01917038677142762 0.9786740215190416 0.07748070446113693 -0.1892762281920498 -0.01919399597123159 0.9786743497835639 0.07746196956762272 -0.1892798034832127 -0.0192176049438911 0.9786746781367723 0.07744323193012737 -0.1892833745936863 -0.01924121369685391 0.9786750065798616 0.07742449153831496 -0.1892869415217948 -0.01926482222254226 0.9786753351084523 0.07740574842966107 -0.1892905042718235 -0.01928843054583576 0.9786756637267006 0.07738700256843374 -0.1892940628389261 -0.01931203864195247 0.9786759924348211 0.07736825395270362 -0.1892976172224759 -0.01933564650899974 0.978676321227977 0.0773495026238688 -0.1893011674272513 -0.01935925417452464 0.978676650111059 0.07733074853989533 -0.1893047134476162 -0.01938286160946022 0.9786769790816303 0.0773119917215959 -0.1893082552857812 -0.01940646882736686 0.9786773081422881 0.07729323214661284 -0.1893117929385688 -0.01943007581249482 0.9786776372876255 0.07727446986122118 -0.1893153264113708 -0.0194536825957091 0.9786779665222943 0.0772557048254453 -0.1893188556988018 -0.01947728914933669 0.9786782958462049 0.07723693703997045 -0.189322380800562 -0.0195008954732605 0.9786786252547224 0.07721816654444336 -0.1893259017212208 -0.01952450159384408 0.9786789547528106 0.07719939329622219 -0.1893294184550549 -0.01954810748159847 0.9786792843379464 0.07718061731685075 -0.1893329310043719 -0.01957171315058402 0.9786796140125334 0.07716183858563462 -0.1893364393661962 -0.01959531858617642 0.9786799437713163 0.07714305714753894 -0.1893399435457669 -0.01961892381835812 0.9786802736189335 0.07712427296271447 -0.1893434435377051 -0.01964252881953349 0.9786806035537625 0.07710548604498056 -0.1893469393433546 -0.01966613359851364 0.9786809335778729 0.0770866963765106 -0.1893504309600954 -0.01968973814262111 0.9786812636855692 0.07706790400603399 -0.1893539183936442 -0.0197133424844015 0.978681593882018 0.07704910888918157 -0.1893574016380506 -0.01973694659318183 0.9786819241670428 0.07703031102737694 -0.1893608806931061 -0.01976055046934556 0.9786822545359809 0.07701151046049287 -0.1893643555634233 -0.01978415413941997 0.9786825849934492 0.07699270714887661 -0.1893678262436375 -0.01980775757593494 0.9786829155375762 0.0769739011084755 -0.1893712927353629 -0.01983136078915012 0.978683246170199 0.07695509232346487 -0.1893747550362258 -0.01985496376774509 0.9786835768861424 0.0769362808380932 -0.1893782131513927 -0.01987856654122654 0.9786839076905163 0.07691746660849456 -0.1893816670749648 -0.01990216907925446 0.9786842385828807 0.07689864963835275 -0.1893851168070181 -0.01992577138374881 0.9786845695585754 0.07687982996749967 -0.1893885623521691 -0.01994937348121557 0.9786849006221091 0.07686100755722387 -0.1893920037051622 -0.01997297534481668 0.9786852317721552 0.07684218241880265 -0.189395440867028 -0.01999657698163722 0.9786855630102947 0.07682335453860292 -0.1893988738356647 -0.02002017838184366 0.9786858943309101 0.07680452396465602 -0.1894023026167236 -0.02004377957752332 0.9786862257397636 0.0767856906475169 -0.1894057272035951 -0.02006738053453182 0.978686557236136 0.07676685459325809 -0.1894091475966557 -0.0200909812564138 0.9786868888150616 0.076748015844322 -0.1894125638008596 -0.02011458177145776 0.9786872204820789 0.07672917435318119 -0.1894159758098324 -0.02013818204681972 0.9786875522344053 0.07671033014358354 -0.1894193836261766 -0.02016178209807024 0.9786878840743359 0.07669148319578131 -0.1894227872470175 -0.02018538191121245 0.9786882159968192 0.07667263355294819 -0.1894261866774066 -0.02020898151503596 0.9786885480064759 0.07665378117542603 -0.1894295819119537 -0.02023258088204594 0.9786888801018274 0.07663492607578393 -0.1894329729518569 -0.02025618002020832 0.9786892122842814 0.07661606824188491 -0.1894363597951971 -0.02027977892070235 0.9786895445488721 0.07659720771615416 -0.1894397424469371 -0.02030337761181261 0.9786898769005465 0.07657834445614899 -0.1894431209013307 -0.02032697606414437 0.978690209339152 0.07655947846308825 -0.1894464951581451 -0.02035057427793949 0.9786905418597516 0.07654060977914671 -0.1894498652223158 -0.020374172281315 0.9786908744671106 0.07652173836344192 -0.1894532310882889 -0.0203977700459344 0.9786912071596879 0.076502864229077 -0.1894565927573321 -0.02042136758012866 0.9786915399386481 0.07648398736599556 -0.1894599502277863 -0.02044496487648987 0.9786918727996288 0.07646510781144672 -0.1894633035039706 -0.02046856195978635 0.9786922057471253 0.07644622552686432 -0.1894666525806185 -0.02049215880325344 0.9786925387809263 0.07642734051396945 -0.1894699974575602 -0.02051575540747413 0.9786928718962311 0.07640845281375885 -0.189473338139592 -0.02053935179977039 0.9786932050980676 0.07638956238311545 -0.1894766746208678 -0.02056294795027596 0.978693538384385 0.07637066923949797 -0.1894800069032095 -0.02058654387028853 0.9786938717567598 0.07635177336932543 -0.1894833349845093 -0.02061013954999789 0.9786942052104444 0.07633287481313861 -0.189486658869512 -0.02063373501641948 0.9786945387503087 0.07631397352917166 -0.1894899785525354 -0.02065733024060196 0.9786948723760541 0.07629506951989229 -0.1894932940335051 -0.0206809252236359 0.9786952060828488 0.07627616282655514 -0.1894966053172604 -0.02070451999302588 0.978695539875492 0.07625725340800604 -0.1894999123981927 -0.02072811452023311 0.978695873752165 0.07623834127971525 -0.189503215277876 -0.02075170881520374 0.9786962077148642 0.07621942642451403 -0.1895065139537444 -0.02077530286568045 0.9786965417578247 0.07620050889163246 -0.1895098084316532 -0.02079889670460336 0.9786968758864161 0.07618158863504641 -0.1895130987053712 -0.02082249030011222 0.9786972100992612 0.07616266566644084 -0.1895163847759938 -0.02084608365957568 0.9786975443973042 0.07614373997765558 -0.1895196666420953 -0.02086967677687034 0.9786978787758518 0.07612481160874277 -0.189522944308374 -0.02089326967868934 0.9786982132396163 0.07610588051930801 -0.1895262177693058 -0.02091686233700179 0.9786985477886178 0.07608694670908892 -0.1895294870244701 -0.02094045475103789 0.9786988824179675 0.07606801021980567 -0.1895327520787809 -0.02096404694862981 0.9786992171321708 0.076049071012839 -0.1895360129269358 -0.02098763890295253 0.9786995519300427 0.07603012909823233 -0.1895392695698245 -0.02101123062025761 0.9786998868125091 0.07601118446797511 -0.1895425220060381 -0.02103482209452126 0.9787002217753322 0.07599223715821748 -0.1895457702397878 -0.02105841334978433 0.9787005568228654 0.07597328713164417 -0.1895490142659318 -0.02108200436010552 0.9787008919548517 0.07595433439036346 -0.1895522540843512 -0.02110559512632971 0.9787012271669214 0.07593537897164226 -0.1895554896994019 -0.02112918567326103 0.9787015624632699 0.07591642083952375 -0.189558721106112 -0.02115277597588083 0.9787018978428397 0.07589746000295766 -0.1895619483052336 -0.02117636603969635 0.9787022333068134 0.07587849645174356 -0.1895651712950776 -0.02119995585718866 0.9787025688498534 0.0758595302314196 -0.1895683900810587 -0.02122354545880315 0.9787029044777282 0.07584056129258418 -0.1895716046564866 -0.02124713481035275 0.9787032401896528 0.07582158964185684 -0.1895748150218173 -0.02127072391575658 0.9787035759808626 0.07580261531987746 -0.1895780211818457 -0.02129431280212409 0.9787039118564665 0.07578363828287805 -0.1895812231305944 -0.02131790143910426 0.9787042478138196 0.07576465855338349 -0.1895844208705496 -0.02134148984145899 0.9787045838557851 0.07574567610682698 -0.1895876143981866 -0.02136507799187324 0.9787049199762864 0.07572669099505203 -0.1895908037197356 -0.02138866592509815 0.978705256180747 0.07570770317161797 -0.1895939888288721 -0.02141225360895541 0.9787055924674598 0.07568871265102198 -0.1895971697270599 -0.0214358410527356 0.9787059288379157 0.07566971942043139 -0.1896003464122693 -0.02145942824712079 0.9787062652871115 0.07565072352251288 -0.1896035188895653 -0.02148301522061013 0.9787066018193082 0.07563172492076091 -0.1896066871538863 -0.02150660194779433 0.9787069384354736 0.0756127236068148 -0.1896098512037765 -0.02153018842237798 0.9787072751300693 0.07559371962790939 -0.1896130110448887 -0.02155377467597825 0.9787076119080353 0.07557471294174298 -0.1896161666714161 -0.02157736067922961 0.9787079487675995 0.07555570356336529 -0.189619318084897 -0.02160094644180144 0.9787082857105172 0.07553669147768741 -0.1896224652830096 -0.02162453195283371 0.9787086227312228 0.07551767673216793 -0.1896256082714422 -0.02164811724410099 0.9787089598355226 0.07549865927711187 -0.189628747043436 -0.02167170228118995 0.9787092970225787 0.07547963911958652 -0.189631881599508 -0.02169528706832592 0.9787096342875593 0.07546061630077253 -0.1896350119445471 -0.02171887163300441 0.9787099716355027 0.07544159077754424 -0.1896381380726309 -0.02174245594528926 0.9787103090643854 0.07542256256709316 -0.1896412599855749 -0.02176604001631254 0.9787106465763261 0.07540353165123137 -0.1896443776806572 -0.02178962383309639 0.9787109841659402 0.07538449807585496 -0.1896474911633763 -0.02181320742635718 0.9787113218378083 0.07536546180175507 -0.1896506004283062 -0.02183679076882585 0.9787116595924539 0.07534642282436418 -0.1896537054744733 -0.02186037385678976 0.9787119974246613 0.07532738118813555 -0.1896568063071955 -0.02188395671998416 0.9787123353390419 0.07530833685359721 -0.1896599029210091 -0.02190753933095685 0.9787126733343616 0.07528928983119584 -0.1896629953168677 -0.02193112169623982 0.9787130114115871 0.07527024011258579 -0.1896660834933086 -0.02195470380956711 0.9787133495658823 0.07525118773896523 -0.1896691674552383 -0.02197828569845697 0.9787136878031453 0.07523213265988532 -0.1896722471957764 -0.02200186732796132 0.9787140261195444 0.07521307490796941 -0.1896753227187283 -0.02202544871974755 0.9787143645188171 0.07519401445121471 -0.189678394019589 -0.02204902985140244 0.9787147029948423 0.07517495134178701 -0.18968146110468 -0.02207261075793376 0.978715041552476 0.07515588553813951 -0.18968452396826 -0.02209619141046348 0.9787153801919468 0.07513681703822844 -0.1896875826096772 -0.02211977180699885 0.9787157189079865 0.07511774588693171 -0.1896906370343217 -0.0221433519775769 0.9787160577060988 0.07509867203717786 -0.1896936872357362 -0.02216693188954438 0.9787163965838251 0.07507959550985986 -0.1896967332162223 -0.02219051155656615 0.9787167355427243 0.07506051629158189 -0.1896997749736636 -0.02221409096892468 0.9787170745783049 0.07504143442058345 -0.1897028125126012 -0.02223767015212922 0.9787174136954144 0.07502234985540208 -0.1897058458272935 -0.02226124907735042 0.9787177528935627 0.07500326260012929 -0.1897088749178792 -0.02228482774678305 0.9787180921678611 0.07498417269639025 -0.189711899789339 -0.02230840618825075 0.9787184315233527 0.07496508010105818 -0.1897149204357133 -0.02233198437178413 0.9787187709582392 0.07494598482938296 -0.1897179368585812 -0.02235556230719777 0.9787191104742448 0.07492688686656458 -0.1897209490556409 -0.02237913998381154 0.9787194500659613 0.07490778625865317 -0.1897239570324506 -0.02240271743247486 0.9787197897385169 0.07488868296179961 -0.1897269607829506 -0.02242629462271991 0.9787201294918482 0.07486957697645681 -0.1897299603068108 -0.0224498715542562 0.9787204693211644 0.07485046834339872 -0.1897329556089121 -0.022473448254333 0.978720809230915 0.07483135702458021 -0.1897359466839394 -0.0224970246964425 0.9787211492195614 0.07481224303302712 -0.1897389335331893 -0.02252060088888204 0.9787214892884998 0.07479312635674201 -0.1897419161547184 -0.02254417682288251 0.9787218294330534 0.07477400703552116 -0.1897448945532871 -0.02256775252502894 0.9787221696580062 0.07475488502846818 -0.1897478687232066 -0.02259132796686127 0.9787225099615406 0.07473576035099178 -0.1897508386660821 -0.02261490315830556 0.9787228503453294 0.074716632988735 -0.1897538043796637 -0.02263847808897856 0.9787231908039635 0.07469750298773165 -0.1897567658695251 -0.02266205278973096 0.9787235313428945 0.07467837030139982 -0.1897597231292347 -0.02268562722821306 0.9787238719618891 0.07465923493163383 -0.1897626761586499 -0.02270920140511806 0.9787242126557546 0.07464009692262387 -0.1897656249631085 -0.02273277535003993 0.9787245534295217 0.07462095623137831 -0.1897685695366407 -0.02275634903307829 0.9787248942810495 0.07460181287605852 -0.1897715098812132 -0.02277992246604227 0.9787252352127764 0.07458266683577812 -0.189774445993725 -0.02280349563408311 0.9787255762186021 0.07456351816246112 -0.1897773778805237 -0.02282706857208426 0.9787259173047504 0.07454436680294642 -0.1897803055343145 -0.02285064124319012 0.9787262584697928 0.07452521276932159 -0.1897832289562761 -0.02287421365505973 0.9787265997093292 0.07450605609900654 -0.1897861481508796 -0.02289778583266737 0.9787269410281979 0.07448689675065802 -0.1897890631123585 -0.02292135774723026 0.978727282425079 0.07446773473543734 -0.1897919738417732 -0.02294492940577522 0.9787276239007094 0.0744485700469686 -0.1897948803379036 -0.02296850080336717 0.9787279654507661 0.07442940272200621 -0.1897977826051383 -0.02299207196452897 0.9787283070798627 0.07441023272113456 -0.1898006806379557 -0.02301564286179049 0.9787286487878899 0.07439106004518797 -0.1898035744360754 -0.02303921349511906 0.9787289905696677 0.07437188473822737 -0.1898064640048395 -0.02306278389403532 0.9787293324308107 0.07435270675230064 -0.1898093493376122 -0.02308635402522919 0.9787296743686702 0.07433352610989363 -0.1898122304369302 -0.02310992390347144 0.9787300163850112 0.07431434279586938 -0.189815107300431 -0.02313349351783472 0.9787303584756784 0.07429515684554287 -0.1898179799323251 -0.02315706289186363 0.9787307006442852 0.0742759682280303 -0.1898208483281922 -0.02318063200391355 0.9787310428902031 0.0742567769485926 -0.1898237124883282 -0.02320420085697859 0.9787313852141685 0.07423758300086179 -0.1898265724115114 -0.0232277694461255 0.97873172761171 0.07421838642284256 -0.1898294281023067 -0.02325133779674187 0.9787320700876083 0.07419918717370916 -0.1898322795549942 -0.02327490588037982 0.9787324126414654 0.07417998525675756 -0.1898351267696133 -0.02329847369868914 0.9787327552686527 0.07416078071132792 -0.1898379697509078 -0.02332204127797327 0.9787330979739788 0.07414157349635871 -0.1898408084931222 -0.0233456085896195 0.9787334407556681 0.07412236362688573 -0.1898436429978289 -0.02336917564330774 0.9787337836147264 0.07410315109424492 -0.189846473263505 -0.02339274243253245 0.9787341265473108 0.0740839359310759 -0.1898492992940244 -0.02341630897901734 0.9787344695575165 0.07406471810240361 -0.1898521210844202 -0.0234398752583081 0.9787348126451245 0.07404549760999804 -0.1898549386345338 -0.02346344127101029 0.9787351558058716 0.0740262744900767 -0.1898577519487104 -0.02348700704129766 0.9787354990436823 0.07400704870912216 -0.1898605610221696 -0.0235105725457101 0.9787358423579633 0.07398782027208806 -0.1898633658551702 -0.0235341377870314 0.9787361857491994 0.07396858917475638 -0.1898661664467677 -0.02355770276179519 0.9787365292125945 0.07394935545787464 -0.1898689628019045 -0.02358126749727875 0.9787368727537301 0.07393011907381672 -0.1898717549139498 -0.02360483196036311 0.9787372163719672 0.0739108800279322 -0.189874542783214 -0.02362839615410256 0.9787375600622108 0.07389163836350876 -0.189877326414976 -0.0236519601075156 0.9787379038296388 0.07387239403636336 -0.1898801058030513 -0.02367552378983525 0.9787382476726006 0.07385314706045712 -0.1898828809488786 -0.02369908721001019 0.9787385915919977 0.07383389742802027 -0.189885651851047 -0.02372265036214141 0.9787389355836862 0.07381464517423569 -0.1898884185137802 -0.02374621326970405 0.9787392796519407 0.07379539026261829 -0.1898911809318953 -0.02376977590719525 0.9787396237955343 0.07377613270351989 -0.1898939391063604 -0.02379333828109358 0.9787399680153049 0.07375687248971174 -0.1898966930358343 -0.02381690038586931 0.9787403123068336 0.07373760965871563 -0.1898994427248519 -0.02384046224660213 0.9787406566750512 0.0737183441684636 -0.1899021881674926 -0.02386402383396227 0.9787410011193505 0.07369907602402895 -0.1899049293640331 -0.02388758515081521 0.9787413456353987 0.0736798052621979 -0.1899076663189146 -0.02391114622173964 0.9787416902274729 0.0736605318464716 -0.189910399026944 -0.02393470702121497 0.9787420348941288 0.07364125578904647 -0.1899131274893343 -0.02395826755698435 0.9787423796370018 0.07362197707591134 -0.1899158517038514 -0.02398182781887132 0.97874272445068 0.0736026957530256 -0.1899185716761469 -0.02400538783773953 0.9787430693408952 0.07358341177151745 -0.1899212873993968 -0.02402894757959111 0.9787434143064089 0.0735641251418328 -0.1899239988745839 -0.02405250705097068 0.9787437593431917 0.07354483589816214 -0.1899267061058183 -0.0240760662746855 0.9787441044555768 0.07352554400354148 -0.1899294090878356 -0.02409962522488856 0.9787444496421931 0.07350624946953897 -0.1899321078217692 -0.02412318390889404 0.9787447949041357 0.07348695228674543 -0.1899348023059872 -0.02414674231967363 0.9787451402370396 0.07346765249219901 -0.1899374925449778 -0.02417030048198856 0.9787454856448501 0.07344835005224508 -0.1899401785339083 -0.02419385837225392 0.9787458311285505 0.07342904495841646 -0.1899428602712739 -0.02421741598405986 0.9787461766823508 0.07340973725987862 -0.1899455377631644 -0.02424097335047775 0.9787465223117497 0.07339042690975847 -0.189948211003001 -0.02426453043886403 0.9787468680144511 0.07337111392749199 -0.1899508799929572 -0.02428808726192429 0.9787472137924313 0.07335179829617408 -0.1899535447304095 -0.02431164380749204 0.9787475596400719 0.07333248006349971 -0.1899562052212611 -0.02433520010763595 0.9787479055632414 0.07331315917945526 -0.189958861458513 -0.02435875612755526 0.9787482515593555 0.07329383566592911 -0.1899615134446639 -0.02438231188163729 0.978748597630185 0.07327450950776307 -0.1899641611773186 -0.02440586735891036 0.9787489437709889 0.07325518074518197 -0.1899668046614011 -0.02442942258632889 0.978749289986572 0.07323584933722986 -0.1899694438911011 -0.02445297753529289 0.9787496362766364 0.0732165152863465 -0.1899720788663503 -0.02447653220686313 0.9787499826361981 0.07319717863481368 -0.1899747095923476 -0.02450008662940653 0.9787503290703119 0.07317783933955725 -0.1899773360629993 -0.02452364077286784 0.9787506755771869 0.07315849741570717 -0.1899799582799155 -0.02454719464700557 0.9787510221584013 0.07313915284975103 -0.189982576240915 -0.02457074824197218 0.9787513688089813 0.07311980568387966 -0.1899851899511915 -0.02459430158607638 0.9787517155333399 0.07310045588048142 -0.1899877994053666 -0.02461785465300198 0.9787520623323998 0.07308110343161246 -0.1899904046019987 -0.02464140743669118 0.9787524092000197 0.07306174838938868 -0.1899930055475983 -0.02466495997225963 0.9787527561416252 0.07304239070759132 -0.1899956022356449 -0.02468851222748721 0.9787531031559112 0.07302303039721628 -0.1899981946672045 -0.02471206420930003 0.9787534502437537 0.07300366745072415 -0.1900007828408844 -0.02473561591194206 0.9787537974002407 0.07298430190977113 -0.190003366761816 -0.02475916736336291 0.9787541446304948 0.07296493373071972 -0.1900059464238141 -0.02478271853310619 0.978754491934554 0.07294556291314995 -0.1900085218264323 -0.02480626942027076 0.9787548393067425 0.07292618950520841 -0.1900110929756672 -0.02482982005725979 0.9787551867528675 0.07290681345743931 -0.1900136598645573 -0.02485337040962311 0.9787555342704592 0.07288743479074243 -0.190016222495485 -0.02487692049108006 0.9787558818611091 0.07286805349149608 -0.1900187808662492 -0.02490047029170109 0.9787562295205504 0.07284866959585772 -0.1900213349812606 -0.02492401983567145 0.978756577252858 0.07282928306910862 -0.1900238848355077 -0.02494756909864251 0.9787569250565643 0.07280989392362335 -0.1900264304302443 -0.02497111808848826 0.9787572729335346 0.07279050214345581 -0.190028971762957 -0.02499466679368248 0.9787576208783265 0.07277110777475179 -0.1900315088393898 -0.02501821524526541 0.9787579688956247 0.0727517107776138 -0.1900340416538379 -0.02504176341533171 0.9787583169864321 0.07273231114342238 -0.1900365702047638 -0.02506531129735372 0.9787586651444786 0.07271290892535096 -0.1900390944988513 -0.02508885892719622 0.9787590133756117 0.07269350407362912 -0.1900416145290773 -0.02511240627017663 0.9787593616769812 0.07267409661236877 -0.1900441302982604 -0.02513595334222316 0.9787597100515513 0.07265468651629758 -0.1900466418026418 -0.02515950012540673 0.9787600584932347 0.07263527383702355 -0.190049149048704 -0.0251830466545235 0.9787604070073679 0.07261585852912529 -0.1900516520299964 -0.02520659289786901 0.9787607555939347 0.07259644059264246 -0.1900541507461328 -0.02523013885485469 0.978761104247328 0.07257702007510139 -0.1900566452030574 -0.0252536845574799 0.9787614529733767 0.07255759692690036 -0.1900591353937574 -0.025277229971167 0.9787618017694284 0.07253817117047161 -0.1900616213208327 -0.02530077511069517 0.9787621506376973 0.0725187427869123 -0.1900641029813679 -0.0253243199625009 0.9787624995729574 0.07249931182050591 -0.1900665803808813 -0.02534786455636253 0.9787628485799122 0.07247987823121467 -0.1900690535136286 -0.02537140886426067 0.9787631976588483 0.07246044201651025 -0.1900715223788811 -0.02539495288384354 0.9787635468043534 0.07244100322225076 -0.190073986982372 -0.02541849664597334 0.9787638960213607 0.07242156180645369 -0.1900764473180933 -0.0254420401212922 0.9787642453086177 0.07240211777965498 -0.1900789033870612 -0.02546558331641617 0.9787645946670727 0.07238267113370958 -0.1900813551877931 -0.02548912622516242 0.9787649440920957 0.07236322190782726 -0.1900838027251397 -0.02551266887383353 0.9787652935886406 0.07234377005985333 -0.1900862459930637 -0.0255362112329483 0.978765643154312 0.07232431561002874 -0.1900886849938811 -0.02555975331578653 0.9787659927915698 0.07230485853737506 -0.1900911197243914 -0.02558329510735262 0.9787663424950119 0.07228539888765165 -0.1900935501903261 -0.02560683663844997 0.978766692269283 0.07226593662133464 -0.1900959763859951 -0.02563037788139878 0.9787670421145648 0.07224647173678622 -0.1900983983107875 -0.02565391883445609 0.9787673920259901 0.07222700427521864 -0.1901008159698315 -0.02567745952530643 0.9787677420078692 0.07220753419995483 -0.1901032293578131 -0.02570099992822111 0.9787680920590857 0.07218806152037119 -0.1901056384755979 -0.0257245400490216 0.9787684421810703 0.07216858622422941 -0.1901080433211504 -0.02574807987870976 0.9787687923684543 0.07214910835699465 -0.1901104439001745 -0.02577161944789505 0.9787691426266094 0.07212962787298176 -0.1901128402061441 -0.02579515872465699 0.9787694929552808 0.07211014477426006 -0.1901152322389446 -0.0258186977097977 0.9787698433488671 0.07209065910826157 -0.1901176200045482 -0.02584223643528149 0.9787701938131662 0.07207117082569224 -0.19012000349594 -0.02586577486670416 0.9787705443460194 0.07205167994477112 -0.1901223827151733 -0.02588931301596279 0.9787708949490831 0.07203218645135029 -0.1901247576599538 -0.02591285087274395 0.9787712456171754 0.07201269038929245 -0.190127128335781 -0.02593638846656427 0.9787715963552056 0.07199319171685399 -0.1901294947366467 -0.02595992576820125 0.9787719471634633 0.07197369043147996 -0.1901318568618155 -0.02598346277527936 0.9787722980364888 0.07195418657938876 -0.1901342147171082 -0.02600699951893717 0.9787726489791642 0.07193468011906951 -0.1901365682965432 -0.02603053597010818 0.9787729999897863 0.07191517106487214 -0.1901389176016584 -0.02605407213803329 0.9787733510706375 0.07189565939734067 -0.1901412626294421 -0.02607760800874763 0.9787737022155006 0.07187614516910923 -0.1901436033865841 -0.0261011436178035 0.978774053430312 0.07185662832973194 -0.190145939865895 -0.02612467892998851 0.9787744047125652 0.0718371089003708 -0.190148272069831 -0.02614821395922649 0.9787747560644174 0.07181758686263255 -0.190150599995521 -0.02617174869228018 0.9787751074804533 0.07179806226234464 -0.1901529236487458 -0.02619528316002889 0.9787754589657327 0.07177853505649992 -0.1901552430233101 -0.02621881733236713 0.9787758105201593 0.07175900524582206 -0.190157558118919 -0.02624235120917071 0.9787761621387547 0.07173947287242231 -0.190159868940858 -0.02626588481876781 0.9787765138262016 0.07171993789650374 -0.1901621754833598 -0.02628941813325575 0.9787768655808259 0.07170040033216034 -0.1901644777479329 -0.02631295116170238 0.9787772174046615 0.07168086016204855 -0.1901667757318433 -0.02633648389158762 0.9787775692918251 0.07166131743595276 -0.190169069441416 -0.02636001635651936 0.978777921247772 0.07164177210752792 -0.1901713588699953 -0.02638354852408778 0.9787782732728598 0.07162222417364146 -0.1901736440167662 -0.02640708039151627 0.9787786253611285 0.07160267368472401 -0.1901759248881458 -0.02643061199286067 0.9787789775176027 0.07158312059808032 -0.1901782014779672 -0.02645414329821689 0.9787793297414241 0.07156356492089218 -0.1901804737868084 -0.02647767431190107 0.9787796820331035 0.07154400664873185 -0.1901827418136749 -0.02650120503027095 0.9787800343882935 0.07152444581834658 -0.1901850055631428 -0.02652473547797746 0.9787803868115187 0.07150488239129534 -0.1901872650296126 -0.02654826562803627 0.9787807393029496 0.07148531636603135 -0.1901895202124836 -0.02657179547876034 0.9787810918574558 0.07146574778594048 -0.1901917711172325 -0.02659532505936905 0.9787814444797225 0.07144617661121633 -0.1901940177380713 -0.0266188543419357 0.9787817971683828 0.07142660285334554 -0.1901962600761631 -0.02664238333373825 0.9787821499249981 0.0714070264989996 -0.1901984981293074 -0.02666591202500982 0.9787825027441223 0.07138744759423106 -0.1902007319033485 -0.02668944044680868 0.9787828556308178 0.0713678660960448 -0.1902029613920613 -0.02671296856900953 0.9787832085838102 0.07134828201513983 -0.1902051865965032 -0.02673649639834906 0.9787835616041942 0.07132869534214559 -0.1902074075150084 -0.02676002392778147 0.9787839146867504 0.07130910612118685 -0.1902096241531663 -0.02678355118704346 0.9787842678369023 0.07128951430621161 -0.190211836504331 -0.0268070781439008 0.9787846210544365 0.07126991989893543 -0.1902140445683424 -0.02683060479890879 0.9787849743338777 0.07125032294564293 -0.1902162483510875 -0.02685413118329385 0.9787853276810765 0.07123072339667377 -0.190218447845426 -0.02687765726233411 0.9787856810930429 0.07121112127725852 -0.1902206430543898 -0.02690118305276811 0.9787860345721699 0.07119151656702692 -0.1902228339748174 -0.02692470853997702 0.9787863881135113 0.07117190930778208 -0.1902250206119943 -0.02694823375210744 0.9787867417213468 0.07115229946317247 -0.1902272029605798 -0.02697175866359161 0.9787870953961225 0.07113268702932327 -0.1902293810196553 -0.02699528327113646 0.9787874491327193 0.07111307204949373 -0.1902315547947074 -0.0270188076038939 0.9787878029359054 0.07109345448320131 -0.1902337242798311 -0.02704233163344914 0.9787881568038257 0.0710738343460609 -0.1902358894767567 -0.02706585536992541 0.9787885107382199 0.07105421162323929 -0.1902380503830713 -0.02708937880251059 0.9787888647341104 0.07103458635679011 -0.1902402070041036 -0.02711290195953114 0.9787892187966606 0.07101495850289299 -0.1902423593334882 -0.02713642481026893 0.9787895729247065 0.0709953280713076 -0.1902445073721607 -0.02715994736081662 0.9787899271145565 0.07097569509318935 -0.1902466511239712 -0.0271834696320001 0.9787902813702537 0.07095605953421237 -0.1902487905838418 -0.02720699159963452 0.9787906356904782 0.07093642140545038 -0.190250925752889 -0.02723051327071829 0.9787909900765229 0.07091678069586044 -0.1902530566292118 -0.02725403463704562 0.978791344523572 0.07089713744611577 -0.1902551832179609 -0.02727755572599957 0.9787916990363751 0.07087749161590719 -0.1902573055132393 -0.02730107650927043 0.9787920536133485 0.07085784321854556 -0.1902594235164688 -0.02732459699539806 0.9787924082557622 0.07083819224318121 -0.1902615372257736 -0.0273481171763079 0.9787927629588432 0.07081853873011794 -0.1902636466462599 -0.02737163707913279 0.9787931177275503 0.07079888263728355 -0.1902657517717841 -0.02739515667434353 0.9787934725616548 0.07077922396651842 -0.1902678526022038 -0.0274186759625793 0.9787938274560608 0.07075956276085041 -0.1902699491430016 -0.02744219497285249 0.9787941824158216 0.07073989897741548 -0.190272041387921 -0.02746571367508447 0.9787945374391523 0.07072023263122156 -0.1902741293386191 -0.0274892320789857 0.978794892527426 0.07070056371055057 -0.1902762129930983 -0.02751275017588038 0.9787952476759612 0.07068089225491871 -0.1902782923563674 -0.02753626799236562 0.9787956028893935 0.07066121822500113 -0.1902803674226472 -0.02755978550079599 0.9787959581678802 0.07064154161937029 -0.1902824381913494 -0.0275833026995583 0.9787963135061603 0.07062186248244441 -0.1902845046681567 -0.02760681961863052 0.9787966689089519 0.07060218077420077 -0.1902865668471909 -0.02763033622988255 0.9787970243750603 0.07058249650465143 -0.190288624729429 -0.02765385253958417 0.9787973799057551 0.07056280966295707 -0.1902906783129905 -0.02767736853966173 0.9787977354959309 0.07054312029221203 -0.1902927276033834 -0.02770088425918523 0.9787980911505472 0.07052342835036036 -0.1902947725944452 -0.02772439966861832 0.9787984468696627 0.07050373383680553 -0.1902968132857006 -0.02774791476691918 0.9787988026480007 0.07048403679608964 -0.1902988496828602 -0.02777142958415909 0.9787991584906138 0.07046433718537173 -0.1903008817796492 -0.02779494409025644 0.9787995143955498 0.07044463502106743 -0.1903029095779253 -0.02781845829589618 0.9787998703650055 0.07042493028449616 -0.1903049330747301 -0.02784197218759619 0.9788002263930385 0.07040522302582247 -0.1903069522765506 -0.02786548579930807 0.9788005824851185 0.07038551319868494 -0.1903089671766243 -0.02788899909851799 0.9788009386397971 0.07036580081523451 -0.1903109777762247 -0.02791251209297173 0.9788012948576045 0.07034608587088913 -0.1903129840743261 -0.02793602477890487 0.9788016511345117 0.07032636839962353 -0.1903149860752015 -0.027959537179112 0.9788020074752678 0.0703066483611763 -0.1903169837729168 -0.02798304926527876 0.9788023638792201 0.07028692576097019 -0.1903189771678238 -0.02800656104051259 0.9788027203415404 0.07026720063973482 -0.1903209662651264 -0.0280300725322683 0.9788030768679044 0.07024747294937682 -0.1903229510578115 -0.02805358370682715 0.9788034334554185 0.07022774271426413 -0.1903249315488347 -0.02807709458036172 0.978803790106313 0.07020800991544267 -0.1903269077351938 -0.028100605139194 0.9788041468154408 0.07018827459633183 -0.1903288796224675 -0.02812411541263804 0.9788045035877206 0.07016853671524483 -0.1903308472045169 -0.02814762537138762 0.9788048604230424 0.07014879627301651 -0.1903328104810636 -0.02817113501538573 0.9788052173162408 0.07012905331321279 -0.1903347694577111 -0.02819464437405068 0.9788055742723805 0.070109307792923 -0.1903367241281477 -0.02821815341722826 0.9788059312896914 0.07008955972700827 -0.1903386744940268 -0.02824166215453699 0.9788062883696994 0.07006980910247441 -0.1903406205531612 -0.02826517057640541 0.9788066455073763 0.0700500559617229 -0.1903425623110004 -0.02828867871145307 0.9788070027079295 0.0700303002606401 -0.1903444997610606 -0.02831218652869018 0.9788073599704278 0.0700105420070001 -0.1903464329040196 -0.02833569403284653 0.9788077170190991 0.06999078353146609 -0.1903483620609229 -0.0283592028314353 0.9788080746736815 0.06997101790788228 -0.1903502862748395 -0.02838270814461271 0.9788084321169058 0.06995125203915577 -0.1903522064999858 -0.02840621473526377 0.978808789622186 0.06993148361654078 -0.190354122416258 -0.02842972100948342 0.9788091471848246 0.06991171267963507 -0.1903560340287293 -0.02845322699396381 0.9788095048096001 0.06989193918795895 -0.1903579413314062 -0.02847673266021326 0.9788098624945172 0.06987216315827463 -0.19035984432621 -0.02850023801916545 0.9788102202412486 0.06985238457634897 -0.1903617430107775 -0.02852374306038846 0.9788105780452343 0.06983260348061292 -0.1903636373900257 -0.02854724780977309 0.9788109359103607 0.06981281983813181 -0.1903655274589985 -0.02857075224403026 0.9788112931388383 0.06979303954423804 -0.1903674140324437 -0.02859426043197663 0.9788116504460707 0.06977325656015995 -0.1903692962718652 -0.02861776820411395 0.9788120084921418 0.06975346530903088 -0.1903711734055269 -0.02864127170996308 0.9788123665987998 0.06973367151544298 -0.19037304622792 -0.02866477490118024 0.978812724766126 0.0697138751786083 -0.1903749147385378 -0.02868827777661179 0.9788130829902442 0.06969407633117147 -0.1903767789415059 -0.02871178035816058 0.9788134412755262 0.06967427493610411 -0.1903786388312934 -0.02873528261970344 0.9788135374670711 0.0696549612284777 -0.1903816604039466 -0.02875880090153624 0.9788139275002632 0.06963510085546111 -0.1903833695824194 -0.02878229745526548 0.9788143161327543 0.06961523777964344 -0.1903850821406524 -0.02880579283320106 0.9788147032866175 0.06959537208160932 -0.1903867983623843 -0.02882928760955173 0.9788150838964261 0.06957554824016715 -0.1903885233147863 -0.02885281292920104 0.9788154683477092 0.06955568124736901 -0.1903902435196626 -0.02887631039438682 0.9788158516297152 0.06953581574347034 -0.190391963743462 -0.02889981088508697 0.9788162338130734 0.06951595217684904 -0.1903936834704703 -0.02892331432397233 0.9788166149091457 0.06949609002776876 -0.1903954030236527 -0.02894681944729313 0.9788169948795263 0.06947622811560054 -0.1903971233475759 -0.02897032417510089 0.9788173736580121 0.06945636510669063 -0.1903988456003479 -0.02899382633341784 0.9788177511774738 0.06943650000531626 -0.1904005707169501 -0.02901732443807375 0.9788181273903234 0.06941663248108924 -0.1904022991007616 -0.02904081824312506 0.9788185022729708 0.06939676295922589 -0.1904040305531399 -0.02906430883400455 0.978818875045229 0.06937689897707519 -0.1904057653409763 -0.02908780274332072 0.9788192472709525 0.0693570286151082 -0.1904075008113024 -0.02911129314205957 0.9788196182337032 0.06933715924492831 -0.190409237022976 -0.02913478616704035 0.9788199880688702 0.06931729098455523 -0.1904109731596231 -0.02915828231951629 0.9788203570055738 0.06929742310523732 -0.1904127084159007 -0.02918178089452236 0.9788207253449266 0.06927755420711625 -0.1904144419920376 -0.02920528033032515 0.9788210933923595 0.06925768265706667 -0.190416173187117 -0.02922877883068159 0.9788214613550273 0.06923780715802905 -0.1904179016161353 -0.02925227503741097 0.9788218292387676 0.06921792726253947 -0.1904196274719176 -0.02927576855706599 0.9788221967971706 0.0691980436281257 -0.1904213516622998 -0.02929926016649015 0.9788225620507942 0.06917817071729453 -0.1904230774776425 -0.0293227604510872 0.9788229275081832 0.06915828489212161 -0.1904248030377464 -0.02934625364720146 0.9788232912130785 0.06913840083085991 -0.1904265314714101 -0.02936975010306054 0.978823652984491 0.06911851966204061 -0.1904282632555178 -0.02939325009780309 0.9788240129511891 0.06909864169166881 -0.1904299977932071 -0.02941675248860535 0.9788243714940853 0.06907876658322364 -0.1904317335947473 -0.02944025503708557 0.9788247291047216 0.0690588936218092 -0.190433468791808 -0.02946375517003165 0.9788250862201844 0.06903902190304069 -0.1904352017748691 -0.02948725090076951 0.9788254430959613 0.06901915041731335 -0.1904369316981626 -0.02951074158771068 0.9788257997611832 0.0689992780857427 -0.1904386586493429 -0.02953422823378647 0.9788261520874862 0.0689794373794017 -0.1904403881225902 -0.02955773638395938 0.9788265078001079 0.06895956025202232 -0.1904421118148824 -0.02958122250991145 0.9788268627255821 0.06893967963846041 -0.1904438352795262 -0.02960471216151006 0.9788272167663867 0.06891979545132815 -0.1904455588931934 -0.02962820632734038 0.9788275699346464 0.06889990819825959 -0.1904472825088235 -0.02965170435423075 0.9788279223187106 0.06888001881495942 -0.1904490056291432 -0.02967520433219662 0.978828274030442 0.06886012833244365 -0.1904507276736155 -0.02969870389790984 0.9788286251581318 0.06884023755854113 -0.1904524482080311 -0.02972220105396582 0.9788289757449018 0.06882034693381381 -0.190454167027434 -0.02974569467977176 0.9788293257982751 0.06880045659620143 -0.1904558840729971 -0.0297691845945053 0.9788296728656005 0.0687805872395916 -0.1904576021651377 -0.02979268558395851 0.9788300218734813 0.06876069743129409 -0.190459315316015 -0.02981616972846894 0.978830370402256 0.06874080781235968 -0.1904610261613393 -0.02983965202639326 0.978830718481087 0.06872091828023705 -0.1904627344936325 -0.02986313308626661 0.9788310661117172 0.06870102865254459 -0.1904644402664546 -0.02988661356974937 0.9788314132732631 0.06868113862741267 -0.1904661435738819 -0.02991009425598746 0.9788317599566679 0.06866124775525213 -0.1904678445034379 -0.02993357591465097 0.9788321062088835 0.0686413554507725 -0.1904695429462233 -0.0299570590415439 0.978832452168521 0.06862146105021442 -0.1904712384304515 -0.02998054362189011 0.9788327980850451 0.06860156387583551 -0.1904729300089133 -0.03000402907295487 0.9788331412742557 0.06858168884455684 -0.1904746198680984 -0.03002753210813034 0.9788334882075538 0.06856178407819828 -0.1904762991909584 -0.03005101618853594 0.9788338362011136 0.06854187447775163 -0.1904779701514173 -0.0300744981318619 0.9788341854557774 0.06852195944667383 -0.1904796319890548 -0.03009797757371344 0.978834535974169 0.06850203855088759 -0.1904812847973016 -0.03012145482169263 0.9788348876061501 0.06848211147910414 -0.1904829293215271 -0.03014493074314767 0.9788352401580909 0.06846217794118485 -0.1904845664852903 -0.03016840643973879 0.9788355935088342 0.06844223758780396 -0.1904861968848015 -0.03019188285860113 0.9788359476973841 0.06842228996279276 -0.1904878204002126 -0.03021536051063805 0.9788363029690086 0.06840233445046374 -0.1904894359884919 -0.03023883940359427 0.978836657462745 0.06838238957013099 -0.1904910444931264 -0.03026233255645423 0.9788370162722232 0.0683624157666084 -0.1904926382711134 -0.0302858126910218 0.9788373774869341 0.0683424317529749 -0.1904942183632647 -0.03030929274596105 0.9788377411796133 0.0683224376382075 -0.1904957843937061 -0.03033277247124488 0.9788381070532582 0.06830243446732334 -0.190497337517515 -0.03035625182675332 0.9788384745574517 0.06828242396608017 -0.190498879927774 -0.03037973090107021 0.9788388431027955 0.06826240795749242 -0.190500413981726 -0.03040320979464291 0.9788392122501638 0.06824238782610148 -0.1905019414307906 -0.03042668855414247 0.9788395818049553 0.06822236431507452 -0.1905034629999789 -0.03045016722740885 0.9788399518172719 0.06820233766997084 -0.1905049783127981 -0.03047364600359412 0.9788403176442371 0.06818234898003672 -0.190506491902102 -0.03049715371715675 0.9788406893347453 0.06816231619746499 -0.1905079905234593 -0.03052063400375175 0.9788410622685551 0.06814228055460422 -0.1905094785495292 -0.03054411564558687 0.9788414365428495 0.06812224247843449 -0.1905109553304266 -0.03056759862220578 0.9788418120688728 0.0681022027525519 -0.1905124211120983 -0.03059108249118578 0.9788421886272185 0.06808216251909506 -0.1905138767293096 -0.03061456652918587 0.9788425659556502 0.06806212308710108 -0.190515323180881 -0.03063804999538347 0.9788429438128237 0.06804208557711187 -0.1905167613851479 -0.03066153240588511 0.9788433220027664 0.06802205056729467 -0.1905181921527385 -0.03068501370476018 0.9788437003798626 0.0680020179364027 -0.1905196162168716 -0.03070849426153951 0.9788440796874731 0.06798197997267076 -0.1905210331940354 -0.03073196984341354 0.9788444582188747 0.06796194984238456 -0.190522445481431 -0.03075545082735865 0.9788448368036682 0.06794191985354726 -0.1905238522942499 -0.03077893267111696 0.9788452154476842 0.06792188981020615 -0.1905252537208848 -0.03080241507381059 0.9788455941665104 0.06790185996764282 -0.190526649768935 -0.03082589693052731 0.9788459730027521 0.06788183080055632 -0.190528040343311 -0.03084937643450414 0.9788463520257049 0.06786180270599043 -0.1905294252816853 -0.03087285152514624 0.9788467312890158 0.06784177576887873 -0.1905308045442567 -0.03089632057467195 0.9788471107673564 0.06782174966529811 -0.1905321784693625 -0.03091978302730455 0.9788474903230788 0.06780172372387418 -0.1905335478817496 -0.0309432396473719 0.9788478666452745 0.06778172309513715 -0.1905349176258098 -0.03096671024786198 0.9788482456889752 0.06776169481481012 -0.1905362814790674 -0.03099016081871418 0.9788486242170298 0.06774166398410116 -0.190537643961054 -0.03101361092913676 0.9788490022209421 0.06772162970789938 -0.1905390053572203 -0.0310370610440732 0.978849379845789 0.06770159105158637 -0.1905403653665198 -0.03106051046894039 0.9788497573531957 0.06768154697756563 -0.1905417232664016 -0.03108395764672791 0.9788501350221938 0.06766149640420703 -0.1905430783167485 -0.03110740067820093 0.9788505130033374 0.06764143846046961 -0.1905444303301001 -0.03113083786664568 0.978850891177933 0.06762137283428131 -0.1905457802118667 -0.03115426808038704 0.9788512690976271 0.06760129996096627 -0.1905471301969462 -0.03117769079422685 0.9788516419453248 0.06758125549710933 -0.1905484884781615 -0.0312011298683896 0.9788520171888033 0.06756117141246215 -0.1905498486956979 -0.03122453722368294 0.9788523901348906 0.06754108332643106 -0.1905512184025876 -0.03124793682138696 0.9788527605674028 0.06752099182201056 -0.1905525984993928 -0.03127132869061004 0.9788531286758557 0.06750089709996225 -0.1905539879175908 -0.0312947129862486 0.9788534949491738 0.06748079909389811 -0.1905553841402153 -0.03131808989404768 0.9788538599748802 0.06746069761112018 -0.1905567841983224 -0.03134145953992693 0.9788542242274657 0.06744059250934781 -0.1905581856742507 -0.03136482211925156 0.9788545879218971 0.06742048385900402 -0.1905595873391179 -0.03138817824621207 0.9788549509762469 0.06740037199148362 -0.1905609892801334 -0.03141152924128449 0.9788553097323457 0.06738028558890335 -0.1905623966005191 -0.0314348966058109 0.9788556704877476 0.06736016884043965 -0.1905638027865899 -0.03145824335978449 0.9788560295299676 0.06734005053618471 -0.1905652132154276 -0.03148159079160134 0.9788563866044363 0.06731993158243389 -0.1905666287066078 -0.03150493991171754 0.9788567415601271 0.06729981344647072 -0.1905680494692495 -0.03152829100738517 0.9788570943066371 0.06727969815958958 -0.190569475280441 -0.03155164389472261 0.9788574447883035 0.06725958794842511 -0.1905709057003399 -0.0315749982117732 0.97885779300725 0.06723948464836513 -0.1905723401284538 -0.03159835361475382 0.9788581390753943 0.06721938920800577 -0.1905737776952662 -0.031621709873349 0.9788584832433743 0.06719930156397137 -0.190575217153243 -0.03164506689500787 0.9788588257943801 0.06717922156384927 -0.1905766570268262 -0.03166842514243869 0.97885916727843 0.06715914677381619 -0.1905780954958827 -0.03169178374206296 0.978859507957839 0.06713907675009391 -0.1905795312983592 -0.03171514313037178 0.9788598480618824 0.0671190105858082 -0.1905809635997364 -0.03173850317275027 0.9788601877039547 0.06709894760171557 -0.1905823921032362 -0.03176186359660864 0.9788605269169922 0.06707888732379114 -0.1905838168746708 -0.03178522399909042 0.9788608656913993 0.0670588294297801 -0.1905852381614617 -0.03180858387811309 0.978861203983302 0.0670387737073376 -0.1905866563462713 -0.03183194274506849 0.9788615416902272 0.06701872009562372 -0.190588072018531 -0.03185530035701183 0.9788618786237369 0.06699866883419762 -0.1905894860178029 -0.03187865698431868 0.9788622086358105 0.06697867004230657 -0.1905909064098622 -0.03190204786301199 0.9788625432256367 0.06695862566455066 -0.1905923198836396 -0.03192540556242891 0.978862876336818 0.06693858580060981 -0.1905937339855179 -0.03194876564256472 0.9788632079840949 0.06691855026634791 -0.1905951485811717 -0.03197212884151343 0.9788635383996528 0.06689851776594967 -0.1905965629065067 -0.03199549531819249 0.9788638679889826 0.0668784860368027 -0.1905979757146103 -0.03201886482319021 0.9788641972256843 0.06685845237953167 -0.1905993855881276 -0.03204223694686299 0.9788645265293258 0.06683841431574815 -0.1906007913119572 -0.03206561126083643 0.9788648561826614 0.06681837006882448 -0.1906021921291367 -0.03208898732292579 0.9788651863265091 0.06679831866400518 -0.1906035877377175 -0.03211236464574213 0.9788655155686539 0.06677827187406137 -0.1906049798188895 -0.03213575118568385 0.9788658468449914 0.06675820515205871 -0.1906063648262338 -0.03215912954422508 0.978866178727072 0.06673813066598198 -0.1906077444649047 -0.03218250781825081 0.9788665111815318 0.0667180487330028 -0.1906091188474814 -0.03220588568481558 0.9788668440810001 0.06669796021640674 -0.1906104883942039 -0.03222926272809706 0.9788671772158514 0.06667786645338515 -0.1906118538162971 -0.03225263833254843 0.9788675103489656 0.06665776889109888 -0.1906132159507942 -0.03227601175137208 0.9788678432786658 0.06663766867297417 -0.1906145755361801 -0.03229938237747146 0.9788681758834615 0.06661756639488486 -0.1906159330077621 -0.03232275009630761 0.9788685081388478 0.06659746208769522 -0.1906172883792967 -0.03234611550755936 0.9788688383038551 0.06657737048169629 -0.1906186434500486 -0.03236949036774431 0.9788691700813043 0.06655726071604864 -0.1906199932928793 -0.03239285518964296 0.9788695017592044 0.06653714736000249 -0.1906213395919787 -0.03241622185017549 0.9788698333691915 0.06651703017991872 -0.190622682126206 -0.03243959116305777 0.9788701648775663 0.06649690941340484 -0.1906240209638354 -0.0324629632444563 0.9788704962135931 0.06647678568476967 -0.1906253563313053 -0.03248633760733979 0.9788708273087792 0.06645665973478168 -0.1906266884639979 -0.03250971340955759 0.9788711581174316 0.06643653212988569 -0.1906280175570942 -0.03253308971870228 0.9788714886119293 0.06641640308530486 -0.1906293438245684 -0.03255646566951481 0.9788718187698363 0.06639627242750602 -0.1906306675760659 -0.03257984047641967 0.9788721475350155 0.06637614835931933 -0.1906319904763716 -0.03260321941442267 0.9788724769572474 0.06635601291184975 -0.1906333104488888 -0.03262658966737325 0.9788728059869569 0.06633587438830074 -0.1906346290535593 -0.03264995672237388 0.9788731346141902 0.06631573295573703 -0.1906359463092155 -0.03267332043002062 0.9788734628465767 0.06629558947248011 -0.1906372618182274 -0.03269668114192413 0.9788737907347448 0.06627544526920733 -0.1906385747358976 -0.03272003957248647 0.9788741183869684 0.0662553016405877 -0.190639883923213 -0.03274339650057882 0.9788744459458686 0.06623515935046023 -0.1906411882803542 -0.03276675252512062 0.9788747735313684 0.06621501844903252 -0.1906424871047645 -0.032790108054354 0.9788751011895885 0.06619487846685167 -0.1906437802525661 -0.03281346349965213 0.9788754220659667 0.06617479605493275 -0.1906450762906115 -0.03283685929577911 0.978875749737469 0.06615465612907158 -0.1906463590522804 -0.03286021650052202 0.9788760773309871 0.06613451556504508 -0.190647637116171 -0.03288357556739975 0.9788764048227023 0.06611437409923812 -0.1906489106603459 -0.03290693669837254 0.9788767321843777 0.06609423164510606 -0.1906501799119107 -0.03293029958614704 0.9788770593512132 0.06607408831402486 -0.190651445280358 -0.03295366355813476 0.9788773862237787 0.06605394434204948 -0.190652707324415 -0.03297702785927627 0.9788777127033577 0.06603379993389681 -0.1906539665796511 -0.03300039191249228 0.9788780387316329 0.06601365512550987 -0.1906552233764029 -0.03302375546748271 0.9788783643080322 0.06599350973643731 -0.1906564777631287 -0.0330471186225982 0.9788786911376616 0.06597334947653849 -0.1906577275496778 -0.03307047204165585 0.9788790159644739 0.06595320169625159 -0.1906589765525785 -0.03309383553413065 0.9788793404826686 0.06593305198559213 -0.1906602226788235 -0.03311719976300617 0.9788796646751439 0.0659128999594836 -0.1906614661320457 -0.03314056482300972 0.9788799884713665 0.06589274539404662 -0.1906627073981071 -0.03316393044192145 0.9788803117741771 0.06587258818791104 -0.1906639471206375 -0.0331872959834702 0.9788806345000838 0.06585242827167324 -0.1906651859028407 -0.03321066057868741 0.978880956612099 0.06583226558316427 -0.1906664241120829 -0.03323402332973237 0.9788812781315791 0.06581210015019967 -0.1906676617607654 -0.03325738348079243 0.9788815991333933 0.0657919321790493 -0.1906688984933264 -0.0332807404596038 0.9788819147250519 0.06577180407706641 -0.1906701397673497 -0.0333041230745325 0.9788822350820078 0.06575163210935558 -0.1906713725291344 -0.03332747235637522 0.9788825553614539 0.06573145849804145 -0.1906726020218756 -0.03335081724572958 0.9788828757248987 0.06571128318430289 -0.1906738274462622 -0.0333741576945104 0.9788831963047232 0.06569110595054327 -0.1906750481258584 -0.03339749411924245 0.9788835171982321 0.06567092652177313 -0.1906762635067498 -0.03342082737597656 0.9788838384661981 0.06565074465783212 -0.1906774731782143 -0.03344415850228233 0.978884160116702 0.06563056028951783 -0.1906786769641275 -0.03346748840162472 0.9788844820732661 0.06561037372294906 -0.1906798750477381 -0.03349081766495837 0.9788848041557907 0.0655901858115937 -0.1906810680083537 -0.03351414658429754 0.9788851232304902 0.06557002202653602 -0.1906822602012248 -0.0335374920651521 0.978885444775476 0.06554983565156408 -0.1906834454746154 -0.03356082053080536 0.9788857656953023 0.06552965197319548 -0.1906846280846664 -0.03358414869557116 0.978886085860005 0.06550947145025265 -0.1906858085812422 -0.03360747633645592 0.97888640522499 0.065489293779567 -0.190686987365777 -0.0336308030726922 0.9788867237999065 0.06546911813707973 -0.1906881647608981 -0.03365412840587752 0.9788870416148543 0.0654489435389858 -0.1906893410432149 -0.03367745181354849 0.9788873586980327 0.06542876916175712 -0.1906905164243898 -0.03370077288380992 0.9788876750647576 0.06540859452920147 -0.1906916910146225 -0.03372409147793552 0.9788879907133451 0.06538841955320808 -0.1906928648050202 -0.03374740787050085 0.9788883061160488 0.06536809695591791 -0.1906940372852007 -0.03377099633539028 0.9788886234479866 0.06534789015988589 -0.1906951980073697 -0.03379434261363418 0.9788889405397803 0.06532768166715086 -0.1906963555903106 -0.03381768858860466 0.9788892573960633 0.06530747143886249 -0.19069751002805 -0.03384103423283773 0.9788895740168847 0.06528725947459402 -0.1906986613202434 -0.03386437954556609 0.9788898903971339 0.0652670458171777 -0.1906998094728747 -0.03388772455617216 0.9788902065414716 0.06524683042753121 -0.190700954479933 -0.03391106923702668 0.9788905224489258 0.06522661331379392 -0.1907020963423282 -0.03393441359333292 0.9788908381203294 0.06520639446897018 -0.1907032350587503 -0.03395775761977121 0.9788911525391377 0.06518618241274043 -0.1907043718764563 -0.03398110725473612 0.9788914667530602 0.065165968365769 -0.190705505508966 -0.03400445637801167 0.9788917817129063 0.06514574436004647 -0.1907066347885311 -0.03402779943430818 0.9788920964316189 0.06512551866579221 -0.1907077609272193 -0.03405114218860288 0.9788924109141613 0.06510529124140205 -0.1907088839186408 -0.03407448461149959 0.9788927251594028 0.06508506209634196 -0.1907100037639017 -0.03409782670912787 0.9788930391683814 0.06506483122190314 -0.190711120461439 -0.03412116847497137 0.978893352936786 0.06504459865419873 -0.1907122340162677 -0.0341445099337408 0.9788936664683795 0.06502436436168917 -0.1907133444234684 -0.03416785106305262 0.9788939797641921 0.06500412833573052 -0.1907144516814905 -0.03419119185640826 0.9788942928188002 0.06498389062175612 -0.190715555796721 -0.03421453234502097 0.9788946056367797 0.06496365118141695 -0.1907166567632371 -0.03423787250175523 0.9788949182172421 0.06494341002214661 -0.1907177545818485 -0.03426121233132461 0.9788952305610209 0.06492316713695312 -0.1907188492512425 -0.03428455182840794 0.9788955426634943 0.06490292256454536 -0.1907199407768245 -0.03430789101953336 0.9788958545296336 0.06488267626326785 -0.1907210291521808 -0.03433122987525426 0.9788961661574823 0.0648624282494992 -0.1907221143794365 -0.03435456840652418 0.9788964775485548 0.06484217851054756 -0.1907231964564399 -0.03437790660404476 0.9788967886986734 0.06482192708139373 -0.1907242753880542 -0.03440124449174793 0.9788970996114634 0.06480167393166393 -0.1907253511695182 -0.03442458204805197 0.9788974102879896 0.06478141905243136 -0.1907264237992367 -0.0344479192662575 0.9788977207225442 0.06476116249149265 -0.1907274932839622 -0.0344712561792406 0.9788980309202713 0.06474090420575289 -0.1907285596170578 -0.03449459275654108 0.9788983408795814 0.06472064420851883 -0.1907296228002017 -0.03451792900697209 0.9788986506023453 0.06470038248411084 -0.1907306828307982 -0.0345412649191471 0.9788989600826838 0.06468011908175747 -0.1907317397158176 -0.03456460052694695 0.978899269326285 0.06465985395381661 -0.1907327934479478 -0.03458793579673292 0.978899578332648 0.064639587104476 -0.1907338440275232 -0.03461127073095501 0.9788998870971016 0.06461931857283669 -0.1907348914600271 -0.0346346053564305 0.9789001956244248 0.06459904831887893 -0.1907359357392651 -0.03465793964483566 0.9789005039131947 0.06457877635450575 -0.1907369768667108 -0.03468127360400609 0.9789008119643721 0.06455850267166983 -0.1907380148408911 -0.03470460722787874 0.9789011197733666 0.06453822730878839 -0.1907390496671935 -0.03472794054279805 0.9789014273449339 0.06451795022604201 -0.1907400813394482 -0.03475127352057499 0.978901734679356 0.06449767142106201 -0.1907411098570231 -0.03477460615908326 0.9789020417713867 0.06447739093775925 -0.1907421352261208 -0.03479793848850537 0.9789023486257385 0.06445710873667716 -0.1907431574406203 -0.034821270480902 0.9789026552411222 0.0644368248285985 -0.1907441765018332 -0.03484460214332857 0.9789029616189336 0.06441653920183361 -0.1907451924077455 -0.03486793346717675 0.9789032677541272 0.06439625189860732 -0.1907462051643177 -0.03489126448145693 0.9789035736518168 0.06437596287610757 -0.1907472147649265 -0.03491459515588159 0.9789038793098588 0.06435567215227186 -0.1907482212119432 -0.03493792550250331 0.9789041847303529 0.06433537970951846 -0.1907492245024806 -0.03496125550859754 0.9789044899081255 0.0643150855911387 -0.1907502246426632 -0.03498458520392427 0.9789047948478224 0.06429478975824633 -0.1907512216264421 -0.03500791456093216 0.9789050995499085 0.0642744922069467 -0.1907522154529595 -0.03503124357642744 0.9789054040090097 0.06425419298219966 -0.1907532061285903 -0.03505457228133928 0.9789057082301613 0.06423389204186576 -0.1907541936468005 -0.03507790064584013 0.9789060122114605 0.06421358940186205 -0.1907551780096657 -0.03510122868057466 0.9789063159548277 0.06419328504611319 -0.190756159214519 -0.03512455637386635 0.9789066194550968 0.06417297901783486 -0.1907571372674833 -0.03514788375543097 0.9789069227170047 0.06415267127739231 -0.1907581121623898 -0.03517121079718544 0.9789072257410938 0.06413236182024284 -0.1907590838982826 -0.03519453749548195 0.9789075285215337 0.06411205069515294 -0.1907600524821131 -0.03521786388391811 0.9789078310638575 0.06409173785583223 -0.190761017906721 -0.0352411899297569 0.9789081333662231 0.06407142331768366 -0.1907619801741097 -0.03526451564328648 0.9789084354300991 0.06405110706841786 -0.1907629392821693 -0.03528784101547173 0.9789087372503267 0.06403078915117962 -0.1907638952370236 -0.03531116607598765 0.9789090388325303 0.06401046951891949 -0.1907648480313928 -0.03533449079156078 0.9789093401757749 0.06399014817945203 -0.1907657976661551 -0.03535781516717736 0.978909641275972 0.06396982516696985 -0.1907667441461091 -0.03538113922625973 0.9789099421369671 0.06394950044930499 -0.1907676874661809 -0.0354044629459305 0.9789102427576453 0.06392917403577526 -0.1907686276274737 -0.03542778633222779 0.9789105431401379 0.06390884590855159 -0.1907695646270512 -0.03545110937224097 0.9789108432780392 0.06388851612120132 -0.1907704984725972 -0.03547443210293904 0.9789111431778167 0.06386818461963212 -0.1907714291557733 -0.03549775448611497 0.9789114428370029 0.06384785142447473 -0.1907723566793659 -0.03552107653571558 0.9789117422568698 0.06382751652508878 -0.1907732810415061 -0.03554439824385362 0.9789120414330317 0.06380717995814286 -0.1907742022473704 -0.03556771963569007 0.9789123403700272 0.06378684168568141 -0.1907751202910145 -0.03559104068429288 0.9789126390682927 0.06376650170405074 -0.1907760351716121 -0.03561436138663179 0.9789129375221889 0.06374616006039971 -0.1907769468959045 -0.03563768177519872 0.9789132357369108 0.06372581671128746 -0.1907778554571262 -0.03566100181922246 0.9789135337110275 0.06370547166867536 -0.1907787608567775 -0.03568432152659151 0.9789138314454333 0.06368512492508245 -0.1907796630934576 -0.03570764089162529 0.9789141289359689 0.0636647765152772 -0.1907805621720687 -0.03573095993816308 0.9789144261870638 0.06364442640222447 -0.1907814580867942 -0.035754278639908 0.9789147231987678 0.06362407458550967 -0.1907823508372896 -0.03577759699609373 0.978915019966028 0.06360372110736101 -0.1907832404295746 -0.0358009150357803 0.9789153164936411 0.0635833659276852 -0.1907841268573718 -0.03582423273052796 0.9789156127802235 0.06356300905804024 -0.190785010122125 -0.03584755008794531 0.9789159088274929 0.06354265048407004 -0.190785890221404 -0.03587086709754018 0.9789162046294038 0.0635222902562976 -0.1907867671624728 -0.03589418379417972 0.9789165001924336 0.06350192832058361 -0.1907876409369511 -0.0359175001395932 0.9789167955153181 0.06348156468749311 -0.1907885115461343 -0.03594081614069483 0.9789170905935759 0.06346119939447344 -0.1907893789953382 -0.03596413182320831 0.9789173854316774 0.06344083240416221 -0.1907902432786833 -0.03598744716059576 0.9789176800288857 0.06342046372271667 -0.190791104396809 -0.03601076215668839 0.9789179743857603 0.06340009334546179 -0.1907919623487295 -0.0360340768077647 0.9789182684976423 0.06337972131132014 -0.190792817139986 -0.03605739114058478 0.9789185623697271 0.06335934757688207 -0.1907936687637896 -0.03608070512437399 0.9789188560002202 0.06333897215713746 -0.1907945172221016 -0.03610401876914543 0.9789191493904105 0.06331859504131784 -0.1907953625130233 -0.03612733206691203 0.9789194425351722 0.06329821627224455 -0.1907962046426864 -0.03615064504716711 0.9789197354402291 0.06327783580209492 -0.1907970436036338 -0.03617395767604175 0.9789200281046915 0.06325745363830405 -0.1907978793966972 -0.03619726995826239 0.9789203205242686 0.0632370698167135 -0.190798712026966 -0.03622058191844009 0.9789206127031546 0.06321668430228354 -0.1907995414888945 -0.03624389353164942 0.9789209046403259 0.06319629710356696 -0.1908003677834827 -0.03626720480340009 0.9789211963367845 0.06317590821218988 -0.1908011909091885 -0.03629051572737856 0.9789214877876555 0.06315551766887041 -0.1908020108718388 -0.0363138263316143 0.9789217789986918 0.06313512542555905 -0.1908028276639305 -0.03633713658206856 0.978922069968288 0.06311473149566188 -0.1908036412871922 -0.03636044648764953 0.9789223606928904 0.06309433590885843 -0.1908044517457987 -0.03638375606866125 0.9789226511764796 0.06307393863190396 -0.1908052590344641 -0.03640706530142669 0.9789229414179277 0.06305353967421666 -0.1908060631543215 -0.03643037419206303 0.9789232314183561 0.06303313902643243 -0.1908068641036769 -0.03645368273356105 0.9789235211733582 0.06301273672534792 -0.1908076618877786 -0.03647699095121192 0.978923810687243 0.06299233273498239 -0.1908084565009247 -0.03650029881941837 0.9789240999601756 0.06297192705395778 -0.1908092479426257 -0.03652360633673673 0.9789243889873059 0.0629515197227687 -0.1908100362186891 -0.03654691353105149 0.9789246777735648 0.06293111070024669 -0.1908108213226296 -0.0365702203731281 0.9789249663169676 0.06291070000296213 -0.1908116032566574 -0.03659352687409491 0.9789252546193884 0.0628902876152708 -0.1908123820181325 -0.03661683302254096 0.9789255426754905 0.06286987358172429 -0.1908131576134784 -0.03664013884919745 0.9789258304905817 0.06284945785801138 -0.1908139300357312 -0.03666344432262299 0.9789261180626209 0.0628290404611746 -0.1908146992871745 -0.03668674945427831 0.9789264053936257 0.06280862137437096 -0.1908154653649853 -0.03671005423191027 0.9789266924781257 0.06278820064326628 -0.1908162282757618 -0.036733358687036 0.9789269793211491 0.06276777822588829 -0.1908169880128856 -0.0367566627898472 0.9789272659231484 0.06274735411846449 -0.1908177445755055 -0.03677996653722079 0.978927552278259 0.06272692836994261 -0.1908184979707188 -0.0368032699629774 0.978927838392046 0.06270650093387331 -0.1908192481912279 -0.03682657303416762 0.9789281242626721 0.06268607182559906 -0.1908199952390647 -0.0368498757610636 0.9789284098917871 0.06266564103134714 -0.1908207391118648 -0.03687317813355998 0.9789286952740475 0.06264520859571573 -0.190821479816077 -0.03689648018243466 0.9789289804146269 0.062624774475531 -0.1908222173448902 -0.03691978187702769 0.9789292653138344 0.06260433866821656 -0.1908229516976337 -0.03694308321505319 0.9789295499655315 0.0625839012249963 -0.1908236828817604 -0.03696638423193713 0.9789298343758838 0.0625634620944255 -0.1908244108892068 -0.03698968489121789 0.9789301185426763 0.06254302129498517 -0.1908251357224826 -0.03701298520537058 0.9789304024674953 0.0625225788134459 -0.1908258573793014 -0.03703628516466703 0.9789306861451598 0.06250213469303686 -0.1908265758659174 -0.03705958479893474 0.978930969581118 0.06248168888830345 -0.1908272911751632 -0.0370828840759047 0.9789312527748298 0.06246124140375452 -0.1908280033074388 -0.03710618299825765 0.978931535721285 0.06244079228119411 -0.1908287122687855 -0.03712948159482513 0.978931818425772 0.06242034147650231 -0.1908294180522343 -0.03715277983427001 0.9789321008863815 0.06239988900561325 -0.1908301206599144 -0.03717607772728492 0.9789323831046892 0.0623794348553843 -0.19083082008955 -0.03719937526419935 0.9789326650757715 0.06235897906689004 -0.1908315163470782 -0.03722267247333824 0.978932946804387 0.06233852160043891 -0.1908322094261946 -0.03724596932646417 0.9789332282887845 0.06231806247064275 -0.19083289932883 -0.03726926583334424 0.9789335095309918 0.06229760166059039 -0.1908335860521358 -0.03729256198166294 0.9789337905255494 0.06227713921582061 -0.190834269602732 -0.03731585780288085 0.9789340712778809 0.06225667509110334 -0.1908349499734681 -0.03733915326487075 0.9789343517872855 0.06223620929228736 -0.1908356271649483 -0.03736244837125362 0.9789346320491177 0.06221574185811923 -0.1908363011827676 -0.03738574314872979 0.978934912068351 0.06219527274712378 -0.1908369720203397 -0.03740903756780137 0.9789351918430473 0.06217480197546699 -0.190837639679836 -0.03743233163932859 0.9789354713751411 0.06215432952702565 -0.1908383041585227 -0.03745562535154424 0.9789357506591634 0.06213385544740566 -0.1908389654630419 -0.03747891873596571 0.9789360297006978 0.06211337969005178 -0.19083962358603 -0.03750221175952527 0.9789363084990887 0.0620929022604386 -0.1908402785280357 -0.03752550442558222 0.9789365870494362 0.06207242319942145 -0.1908409302949846 -0.0375487967623245 0.9789368653568818 0.06205194246413916 -0.1908415788800693 -0.03757208873927219 0.9789371434197873 0.06203146006825376 -0.1908422242850842 -0.03759538036553092 0.9789374212391825 0.06201097600318822 -0.1908428665084385 -0.03761867163462565 0.978937698810718 0.06199049030520339 -0.1908435055553652 -0.03764196257152432 0.9789379761388217 0.06197000293739018 -0.1908441414199558 -0.03766525314991905 0.9789382532240115 0.06194951389544121 -0.1908447741012733 -0.03768854336630381 0.9789385300605606 0.06192902322709559 -0.1908454036062993 -0.0377118332537066 0.9789388066540993 0.06190853088543048 -0.1908460299275986 -0.03773512277878659 0.9789390830023427 0.06188803688949317 -0.1908466530677881 -0.03775841195443228 0.9789393591074693 0.06186754122113326 -0.190847273023818 -0.03778170076744555 0.9789396349634676 0.06184704393046255 -0.190847889803039 -0.03780498925252571 0.9789399105766182 0.06182654496513669 -0.1908485033971826 -0.03782827737251945 0.9789401859444152 0.06180604434605197 -0.1908491138091503 -0.03785156514161553 0.9789404610681691 0.06178554206228869 -0.1908497210369916 -0.03787485255169011 0.9789407359436882 0.06176503814878688 -0.1908503250857519 -0.03789813962679536 0.9789410105752738 0.06174453256970617 -0.1908509259496712 -0.03792142634136018 0.9789412849632825 0.06172402532208651 -0.1908515236280157 -0.03794471269282252 0.9789415591022047 0.06170351645184009 -0.190852118127508 -0.03796799871294289 0.9789418329974914 0.06168300591355343 -0.1908527094409243 -0.03799128436942353 0.9789421066471927 0.0616624937234816 -0.1908532975704627 -0.03801456967319766 0.9789423800529137 0.06164197986825969 -0.1908538825137967 -0.03803785461442096 0.9789426532094849 0.06162146439096052 -0.1908544642772219 -0.03806113922286508 0.9789429261225304 0.06160094724473815 -0.1908550428532891 -0.03808442346522006 0.9789431987907138 0.06158042844073253 -0.1908556182434172 -0.03810770734882727 0.9789434712105052 0.06155990800835812 -0.1908561904518202 -0.03813099089386719 0.9789437433854187 0.06153938591834618 -0.1908567594737287 -0.03815427407937361 0.9789440153149208 0.06151886217514964 -0.1908573253095424 -0.0381775569079913 0.9789442870000288 0.061498336770301 -0.1908578879576798 -0.03820083937331317 0.9789445584359561 0.06147780974368123 -0.1908584474239588 -0.03822412150287698 0.9789448296270891 0.06145728105876083 -0.1908590037024963 -0.03824740327061095 0.9789451005742956 0.06143675070831814 -0.1908595567919054 -0.03827068467095618 0.9789453712719457 0.06141621873925364 -0.1908601066990823 -0.03829396573638624 0.9789456417246506 0.06139568511317063 -0.1908606534178545 -0.03831724643951369 0.9789459119316549 0.06137514983636494 -0.1908611969489037 -0.03834052678427866 0.9789461818936672 0.06135461290295044 -0.1908617372910419 -0.03836380676608616 0.978946451606251 0.06133407434987549 -0.1908622744496482 -0.03838708641042071 0.9789467210743175 0.0613135341362541 -0.1908628084181626 -0.03841036568814019 0.9789469902956386 0.06129299228064724 -0.1908633391991474 -0.03843364461180603 0.9789472592722285 0.06127244876629359 -0.1908638667897473 -0.03845692316917807 0.9789475279990901 0.06125190363480815 -0.1908643911960615 -0.03848020138902541 0.978947796480895 0.06123135684730237 -0.1908649124118307 -0.03850347924360478 0.9789480647178053 0.0612108084024396 -0.1908654304365673 -0.03852675673149104 0.9789483327050413 0.0611902583400195 -0.1908659452760977 -0.03855003388018083 0.9789486004469257 0.06116970662406549 -0.1908664569246042 -0.03857331066397412 0.9789488679421176 0.06114915326574939 -0.1908669653835205 -0.03859658709024076 0.9789491351924187 0.06112859825008164 -0.1908674706502579 -0.03861986314798192 0.9789494021922236 0.0611080416237335 -0.1908679727317035 -0.03864313886953074 0.9789496689469991 0.06108748334120888 -0.1908684716205729 -0.03866641422248844 0.9789499354564801 0.06106692340472527 -0.190868967316924 -0.03868968920792841 0.9789502017158418 0.06104636185445016 -0.1908694598266498 -0.03871296385361412 0.978950467729386 0.06102579865458963 -0.1908699491439517 -0.03873623813396571 0.9789507334963811 0.06100523381124204 -0.1908704352694862 -0.03875951205278663 0.9789509990176656 0.06098466731744051 -0.1908709182018945 -0.03878278560471686 0.9789512642886355 0.06096409921151063 -0.1908713979467918 -0.03880605881622903 0.9789515293136598 0.06094352945710414 -0.1908718744982894 -0.03882933166134877 0.9789517940933828 0.06092295804886959 -0.1908723478552812 -0.03885260413582495 0.9789520586227509 0.06090238502887265 -0.1908728180239626 -0.03887587626876454 0.978952322905803 0.06088181036351353 -0.1908732849988636 -0.03889914803612298 0.9789525869421059 0.06086123405641013 -0.1908737487802599 -0.03892241943995926 0.9789528507321241 0.06084065610370377 -0.19087420936727 -0.03894569047709837 0.9789531142716876 0.06082007654010819 -0.1908746667649623 -0.03896896117147933 0.9789533775650325 0.06079949533038482 -0.19087512096761 -0.03899223149790004 0.9789536406111368 0.0607789124830496 -0.1908755719762439 -0.03901550146186622 0.9789539034111003 0.06075832798896467 -0.1908760197891676 -0.03903877105648686 0.9789541659600752 0.06073774188847194 -0.1908764644123234 -0.03906204030966599 0.9789544282631721 0.06071715413906619 -0.1908769058388576 -0.03908530919108261 0.9789546903199906 0.06069656474409332 -0.1908773440690039 -0.03910857770260415 0.9789549521255625 0.0606759737448893 -0.1908777791088621 -0.03913184587283774 0.9789552136850829 0.06065538109825565 -0.1908782109514668 -0.03915511367097022 0.9789554749968289 0.06063478681853175 -0.190878639598751 -0.03917838110660769 0.9789557360619512 0.06061419089616118 -0.1908790650489511 -0.03920164817256212 0.9789559968760541 0.06059359336771867 -0.1908794873074371 -0.03922491489409373 0.9789562574435587 0.06057299419644114 -0.1908799063682323 -0.03924818124491417 0.9789565177648503 0.0605523933791409 -0.1908803222305614 -0.03927144722229128 0.9789567778345194 0.06053179096081715 -0.1908807349011006 -0.0392947128574196 0.9789570376577514 0.06051118689836002 -0.1908811443728876 -0.03931797811953855 0.9789572972325669 0.06049058120824317 -0.1908815506481886 -0.03934124301975957 0.9789575565611204 0.06046997387256343 -0.1908819537239468 -0.03936450754501459 0.9789578156376131 0.06044936493955241 -0.1908823536073452 -0.0393877717287799 0.9789580744676418 0.06042875436268522 -0.1908827502908865 -0.03941103553788414 0.9789583330510572 0.06040814214321839 -0.1908831437744831 -0.03943429897272362 0.9789585913822673 0.06038752832766061 -0.1908835340650556 -0.03945756206556544 0.9789588494668793 0.06036691286940248 -0.1908839211550893 -0.03948082478317427 0.9789591073029021 0.06034629578501314 -0.1908843050468695 -0.03950408713673179 0.9789593648919199 0.06032567706133711 -0.19088468573807 -0.03952734911650964 0.9789596222290715 0.06030505673879991 -0.1908850632346765 -0.03955061075049552 0.9789598793190561 0.06028443477835175 -0.1908854375303387 -0.039573872010773 0.9789601361604059 0.06026381119220677 -0.1908858086266687 -0.03959713290545763 0.9789603927547488 0.06024318596684999 -0.1908861765212832 -0.03962039342456588 0.9789606490965914 0.06022255914795507 -0.1908865412209874 -0.03964365359978755 0.9789609051914469 0.06020193068971153 -0.1908869027183769 -0.03966691339843784 0.978961161039004 0.06018130059472285 -0.1908872610135726 -0.03969017282186164 0.9789614166340371 0.06016066890643516 -0.1908876161130394 -0.03971343190018336 0.9789616719821411 0.0601400355783624 -0.1908879680092622 -0.03973669060023744 0.9789619270807133 0.06011940063215087 -0.1908883167053216 -0.03975994893678828 0.9789621819322709 0.06009876404689702 -0.1908886621976825 -0.03978320689464208 0.9789624365308124 0.06007812587248875 -0.1908890044938175 -0.039806464508468 0.9789626908822703 0.06005748605964248 -0.190889343585769 -0.03982972174312284 0.9789629449861391 0.0600368446125747 -0.1908896794739106 -0.03985297860108845 0.9789631988368477 0.06001620157759523 -0.1908900121651633 -0.03987623511451657 0.9789634524404357 0.05999555690452976 -0.1908903416514268 -0.03989949124763137 0.978963705794392 0.05997491061426376 -0.1908906679356678 -0.03992274701466492 0.9789639589006329 0.05995426269089005 -0.1908909910151242 -0.03994600240394035 0.9789642117540629 0.05993361317675916 -0.1908913108961074 -0.03996925744482376 0.9789644643595086 0.05991296203178727 -0.1908916275720808 -0.03999251210864641 0.9789647167170958 0.05989230925494468 -0.1908919410426009 -0.04001576639419177 0.9789649688217397 0.05987165488849357 -0.1908922513139702 -0.04003902033076737 0.9789652206782173 0.05985099889275956 -0.1908925583797117 -0.0400622738899892 0.9789654722852799 0.05983034127813814 -0.190892862241163 -0.04008552707869668 0.9789657236439774 0.0598096820359224 -0.1908931628966796 -0.0401087798902863 0.9789659747495355 0.05978902120578667 -0.1908934603521666 -0.04013203235224555 0.9789662256072021 0.05976835874415671 -0.190893754600533 -0.04015528443343486 0.9789664762144934 0.05974769467168002 -0.190894045644717 -0.04017853614792497 0.9789667265739209 0.05972702896751478 -0.1908943334811801 -0.04020178748055239 0.9789669766796879 0.05970636167982395 -0.1908946181171571 -0.04022503846479641 0.9789672265371863 0.05968569276383989 -0.1908948995453651 -0.04024828906866999 0.978967476146465 0.05966502221917578 -0.1908951777654598 -0.04027153929140867 0.9789677255020012 0.05964435009171409 -0.1908954527843263 -0.04029478916488771 0.9789679746088701 0.05962367633932383 -0.1908957245950876 -0.04031803865897537 0.9789682234659071 0.05960300097169767 -0.1908959931989761 -0.0403412877800182 0.97896847207413 0.05958232398039987 -0.1908962585943858 -0.04036453652159976 0.9789687204287527 0.05956164540518813 -0.1908965207872512 -0.04038778491127958 0.9789689685346631 0.0595409652054976 -0.1908967797709333 -0.04041103292002527 0.9789692163916479 0.05952028338311687 -0.1908970355454295 -0.04043428054860695 0.978969463995103 0.05949959997629026 -0.1908972881164416 -0.04045752782351958 0.9789697113496081 0.05947891494701176 -0.1908975374777261 -0.04048077471753238 0.9789699584533912 0.05945822831001137 -0.1908977836313071 -0.04050402124054831 0.9789702053084586 0.05943754004865608 -0.1908980265742936 -0.04052726738036375 0.9789704519093453 0.05941685020832745 -0.1908982663135097 -0.04055051316851525 0.9789706982613906 0.0593961587447229 -0.1908985028417218 -0.04057375857332306 0.9789709443642853 0.05937546566042801 -0.190898736159052 -0.04059700359611938 0.9789711902129145 0.05935477099792132 -0.1908989662718747 -0.04062024826639613 0.978971435812234 0.05933407471608311 -0.1908991931734501 -0.04064349255471568 0.9789716811615442 0.05931337682074098 -0.1908994168644094 -0.04066673646469918 0.9789719262606625 0.05929267731342978 -0.1908996373447054 -0.04068997999696403 0.9789721711056714 0.05927197622668453 -0.1908998546191612 -0.04071322317398747 0.978972415701294 0.05925127352132087 -0.1909000686813325 -0.04073646596769265 0.9789726600462729 0.05923056920779856 -0.1909002795325793 -0.04075970838497166 0.9789729041415751 0.05920986327811135 -0.1909004871713575 -0.04078295041970513 0.9789731479820637 0.05918915577490908 -0.1909006916040808 -0.04080619210151597 0.9789733915732611 0.05916844665238025 -0.1909008928232612 -0.04082943339764269 0.9789736349148285 0.0591477359133625 -0.190901090829061 -0.0408526743095955 0.9789738780018907 0.05912702359832622 -0.1909012856275563 -0.04087591486546182 0.9789741208390821 0.0591063096688373 -0.1909014772124122 -0.04089915503768556 0.9789743634250833 0.05908559413586623 -0.1909016655850714 -0.04092239483352143 0.9789746057611636 0.0590648769888983 -0.1909018507435931 -0.0409456342450761 0.9789748478422193 0.05904415827030104 -0.1909020326943583 -0.04096887330178191 0.978975089673942 0.0590234379328753 -0.1909022114296477 -0.04099211196988636 0.978975331255362 0.0590027159846849 -0.190902386950447 -0.04101535025459128 0.9789755725817636 0.05898199246487355 -0.190902559262634 -0.04103858818305577 0.9789758136583427 0.05896126733035561 -0.1909027283591325 -0.04106182572442846 0.9789760544831129 0.05894054059763603 -0.1909028942422581 -0.04108506288987589 0.9789762950579346 0.05891981225130004 -0.1909030569092964 -0.04110829966803978 0.9789765353776431 0.05889908233421136 -0.1909032163667169 -0.0411315360887119 0.9789767754468376 0.05887835080823926 -0.1909033726082165 -0.04115477212453614 0.9789770152657162 0.05885761767176653 -0.1909035256332591 -0.04117800777387552 0.9789772548299039 0.05883688296109928 -0.1909036754472845 -0.04120124306189154 0.9789774941433114 0.05881614664382685 -0.1909038220448871 -0.0412244779652663 0.9789777332047594 0.0587954087297491 -0.1909039654273307 -0.04124771249043129 0.9789779720157514 0.05877466920642187 -0.1909041055923651 -0.04127094662812366 0.9789782105715183 0.05875392811341616 -0.1909042425459514 -0.0412941804058168 0.978978448876497 0.05873318541396032 -0.1909043762819914 -0.04131741379710634 0.9789786869291123 0.05871244112113905 -0.1909045068022685 -0.04134064681074631 0.9789789247314957 0.05869169521730114 -0.1909046341037089 -0.04136387943379136 0.9789791622779193 0.05867094774996214 -0.1909047581935336 -0.04138711169933556 0.978979399574014 0.05865019867245604 -0.1909048790640768 -0.04141034357397498 0.9789796366188173 0.05862944799278984 -0.1909049967163204 -0.04143357506287479 0.9789798734085287 0.05860869574249376 -0.1909051111549652 -0.04145680618783193 0.978980109946588 0.05858794189307215 -0.1909052223752116 -0.04148003692828456 0.9789803462327724 0.05856718644639429 -0.1909053303770731 -0.04150326728505911 0.978980582267538 0.05854642939870504 -0.1909054351596687 -0.04152649725503148 0.9789808180467426 0.05852567078436525 -0.1909055367281513 -0.04154972686200388 0.9789810535745997 0.05850491056847035 -0.1909056350767033 -0.04157295608087843 0.9789812888515945 0.05848414874702246 -0.1909057302044095 -0.04159618490833213 0.9789815238722294 0.05846338536561593 -0.1909058221182041 -0.04161941337611454 0.9789817586420286 0.05844262037848167 -0.1909059108105466 -0.0416426414514405 0.9789819931586292 0.05842185380523363 -0.1909059962842598 -0.04166586914768645 0.9789822274240366 0.05840108562927154 -0.1909060785364276 -0.0416890964526417 0.9789824614334192 0.0583803158906662 -0.1909061575731165 -0.04171232339415435 0.978982695191149 0.05835954455320578 -0.1909062333882923 -0.0417355499461935 0.9789829286975167 0.05833877161450924 -0.1909063059812953 -0.04175877610657826 0.9789831619476907 0.05831799711463573 -0.1909063753581944 -0.04178200190315233 0.9789833949459132 0.05829722101846013 -0.1909064415131241 -0.04180522731064977 0.9789836276913718 0.05827644333273781 -0.1909065044468736 -0.04182845233335368 0.9789838601851673 0.05825566404837324 -0.1909065641577129 -0.04185167696435863 0.978984092421929 0.05823488320989204 -0.1909066206524248 -0.04187490123467335 0.9789843244077054 0.05821410076720143 -0.1909066739227641 -0.04189812510843631 0.9789845561396158 0.05819331674419671 -0.1909067239722414 -0.04192134860205954 0.9789847876197203 0.05817253112383708 -0.1909067707978637 -0.04194457170301379 0.9789850188431993 0.05815174394607426 -0.1909068144056947 -0.04196779443907629 0.9789852498151363 0.05813095516882002 -0.1909068547887527 -0.04199101678004355 0.9789854805344504 0.05811016480105707 -0.1909068919481813 -0.0420142387317758 0.9789857109971682 0.05808937287572374 -0.1909069258889352 -0.04203746031708986 0.978985941208066 0.05806857935328124 -0.1909069566044326 -0.04206068150758261 0.9789861711650769 0.05804778425087768 -0.1909069840971171 -0.0420839023148949 0.9789864008700468 0.05802698755324874 -0.1909070083642747 -0.04210712272775076 0.9789866303177382 0.05800618930380257 -0.1909070294125286 -0.04213034277638241 0.9789868595134436 0.05798538945873015 -0.1909070472346127 -0.04215356242935848 0.9789870884566888 0.0579645880219863 -0.1909070618308733 -0.04217678168898092 0.9789873171428836 0.05794378503161179 -0.1909070732070847 -0.04220000058168578 0.9789875455767179 0.0579229804487948 -0.1909070813567708 -0.04222321907957537 0.9789877737564066 0.05790217428834244 -0.1909070862820079 -0.04224643719263639 0.9789880016838001 0.05788136653496313 -0.1909070879800728 -0.04226965490956931 0.9789882293536798 0.05786055723189427 -0.1909070864575727 -0.04229287226049484 0.9789884567711519 0.057839746336882 -0.1909070817074781 -0.04231608921507237 0.9789886839360161 0.05781893385161387 -0.1909070737297749 -0.04233930577399852 0.9789889108429833 0.05779811981991051 -0.1909070625311683 -0.04236252196781086 0.9789891374977708 0.05777730419445903 -0.1909070481038177 -0.0423857377625816 0.9789893638980723 0.05775648699438565 -0.1909070304504908 -0.04240895317135905 0.9789895900455735 0.05773566820576169 -0.1909070095686784 -0.04243216818380538 0.9789898159350833 0.05771484787159033 -0.1909069854649615 -0.04245538282988437 0.978990041572015 0.05769402594708375 -0.1909069581318956 -0.04247859707745054 0.978990266954665 0.05767320244637546 -0.1909069275714541 -0.0425018109360174 0.9789904920839395 0.05765237736199175 -0.1909068937821563 -0.04252502439981811 0.978990716955177 0.05763155073254653 -0.1909068567698889 -0.0425482374957119 0.9789909415739487 0.0576107225119549 -0.1909068165269932 -0.04257145019062818 0.9789911659390935 0.05758989270985454 -0.1909067730547256 -0.04259466249089622 0.9789913900465387 0.05756906135998448 -0.1909067263581983 -0.04261787441992465 0.9789916139006998 0.05754822842582661 -0.1909066764312765 -0.04264108595141711 0.9789918374997395 0.05752739392261765 -0.1909066232761141 -0.04266429709567199 0.9789920608462364 0.05750655782904547 -0.1909065668890156 -0.04268750783711289 0.9789922839337354 0.05748572019856158 -0.1909065072782501 -0.04271071821312267 0.9789925067680698 0.05746488098291837 -0.1909064444358017 -0.04273392818908722 0.9789927293490821 0.05744404018345241 -0.1909063783616011 -0.04275713776545381 0.9789929516718018 0.05742319784132212 -0.1909063090619566 -0.04278034697089687 0.9789931737410736 0.05740235391646881 -0.1909062365301562 -0.04280355577660166 0.9789933955548893 0.05738150842554 -0.1909061607685849 -0.04282676419386947 0.978993617115296 0.05736066135162595 -0.1909060817742461 -0.04284997221023942 0.9789938384170225 0.05733981273837133 -0.1909059995538522 -0.04287317985615353 0.978994059465109 0.05731896254410371 -0.1909059141004276 -0.04289638710164786 0.9789942802596289 0.05729811076824959 -0.1909058254135976 -0.04291959394581499 0.9789945007952068 0.05727725745530815 -0.1909057335002162 -0.04294280041970687 0.9789947210771898 0.05725640256107355 -0.1909056383528971 -0.04296600649155869 0.9789949411035835 0.05723554610207481 -0.1909055399740099 -0.04298921217259079 0.978995160875873 0.05721468806606222 -0.1909054383613008 -0.04301241745364259 0.9789953803894479 0.05719382849119819 -0.1909053335206148 -0.04303562236127761 0.9789955996489923 0.05717296733877028 -0.1909052254454395 -0.04305882686762085 0.9789958186530422 0.05715210462091913 -0.1909051141374429 -0.04308203098078207 0.9789960374027579 0.05713124032808031 -0.1909049995948012 -0.04310523469350336 0.9789962558933439 0.05711037449994544 -0.1909048818236096 -0.04312843803343742 0.9789964741299624 0.05708950709385303 -0.1909047608167161 -0.04315164096990304 0.9789966921123665 0.05706863811187585 -0.1909046365741714 -0.04317484350386894 0.9789969098352616 0.05704776759783304 -0.1909045091027386 -0.0431980456659196 0.9789971273041619 0.05702689550615276 -0.1909043783947935 -0.04322124742330457 0.9789973445167861 0.05700602185573383 -0.190904244453093 -0.04324444878893038 0.9789975614753166 0.05698514662856521 -0.1909041072744524 -0.04326764974954372 0.9789977781742188 0.0569642698704379 -0.1909039668659584 -0.04329085033713316 0.9789979946186621 0.05694339153864269 -0.1909038232204414 -0.04331405052097353 0.9789982108085222 0.05692251163424144 -0.1909036763377886 -0.04333725030131612 0.9789984267387458 0.05690163019904498 -0.1909035262244513 -0.04336044970732964 0.9789986424148208 0.05688074718771502 -0.1909033728728312 -0.04338364870641859 0.9789988578337758 0.05685986262484943 -0.1909032162866081 -0.04340684731553759 0.9789990729985202 0.05683897648642815 -0.1909030564616254 -0.04343004551716412 0.9789992879034544 0.05681808881877636 -0.1909028934050666 -0.04345324334367576 0.9789995025537056 0.05679719957954204 -0.1909027271098086 -0.04347644076459042 0.978999716948828 0.05677630877244404 -0.1909025575761676 -0.04349963778204519 0.9789999310841553 0.05675541643608574 -0.1909023848100884 -0.04352283442294081 0.9790001449644921 0.0567345225307881 -0.190902208804874 -0.04354603065868842 0.9790003585885262 0.05671362706743006 -0.1909020295619971 -0.04356922649650843 0.9790005719568267 0.05669273004134476 -0.1909018470804166 -0.04359242193261183 0.9790007850656463 0.05667183148353267 -0.1909016613648566 -0.04361561698850609 0.9790009979192419 0.05665093135884686 -0.190901472409345 -0.04363881163881481 0.9790012105158327 0.05663002968203978 -0.1909012802159819 -0.04366200589350968 0.979001422857279 0.05660912643777238 -0.190901084782002 -0.04368519974122283 0.9790016349386539 0.05658822166679302 -0.1909008861137077 -0.04370839321038748 0.9790018467643169 0.05656731533310962 -0.1909006842049862 -0.04373158627502195 0.9790020583348933 0.05654640743159272 -0.1909004790547257 -0.04375477893098017 0.9790022696448576 0.056525498007931 -0.1909002706700312 -0.04377797121020754 0.9790024806997064 0.05650458701674439 -0.190900059043268 -0.04380116308005119 0.9790026914971984 0.05648367447658337 -0.1908998441771539 -0.04382435455318331 0.9790029020391445 0.05646276037252518 -0.1908996260689874 -0.04384754561852765 0.9790031123206064 0.05644184474540246 -0.1908994047250945 -0.04387073630458586 0.9790033223461947 0.05642092755715977 -0.1908991801390191 -0.04389392658390204 0.979003532116264 0.05640000880490206 -0.1908989523100102 -0.04391711645391558 0.9790037416256869 0.05637908853102289 -0.1908987212446509 -0.04394030594424062 0.9790039508794606 0.05635816669427658 -0.190898486935964 -0.04396349502515091 0.9790041598752764 0.05633724331376968 -0.1908982493867624 -0.04398668370971726 0.9790043686157544 0.05631631836789862 -0.1908980085932584 -0.04400987198211281 0.979004577095045 0.05629539190501243 -0.1908977645630068 -0.04403305987618859 0.979004785318205 0.05627446388338034 -0.1908975172889457 -0.04405624736186779 0.9790049932856546 0.05625353429956991 -0.1908972667702358 -0.04407943443620679 0.9790052009922336 0.05623260319623576 -0.1908970130135138 -0.04410262112901438 0.979005408442344 0.05621167053705659 -0.190896756012591 -0.04412580741405375 0.9790056156348482 0.05619073633146519 -0.1908964957687152 -0.04414899329752466 0.9790058225711179 0.05616980056816932 -0.1908962322797664 -0.04417217877092323 0.9790060292460707 0.05614886328917897 -0.1908959655522832 -0.04419536386360535 0.9790062356647597 0.056127924452799 -0.190895695579199 -0.04421854854550958 0.9790064418258524 0.05610698407007429 -0.1908954223620248 -0.04424173282398221 0.9790066477299723 0.05608604213589202 -0.1908951458996421 -0.04426491669491041 0.9790068533731674 0.05606509868292036 -0.1908948661970787 -0.04428810018101418 0.9790070587597638 0.05604415367547533 -0.1908945832482378 -0.04431128325649971 0.9790072638897483 0.05602320711370611 -0.1908942970528611 -0.04433446592096767 0.9790074687582542 0.05600225903783105 -0.1908940076172065 -0.04435764820250913 0.9790076733703338 0.05598130940617442 -0.1908937149341993 -0.04438083007106633 0.9790078777237103 0.0559603582375691 -0.190893419006621 -0.04440401153952545 0.9790080818205504 0.05593940551416936 -0.1908931198312802 -0.04442719259471754 0.979008285656134 0.05591845127497885 -0.1908928174142435 -0.04445037326387469 0.9790084892343681 0.0558974954877783 -0.1908925117499691 -0.04447355352365848 0.9790086925561271 0.05587653814539581 -0.1908922028370062 -0.04449673336846229 0.9790088956157426 0.05585557929465217 -0.1908918906826995 -0.04451991283108164 0.9790090984184852 0.05583461889208559 -0.1908915752796716 -0.04454309188017846 0.9790093009628597 0.0558136569500721 -0.1908912566296575 -0.04456627052404988 0.9790095032500739 0.05579269345868622 -0.1908909347307514 -0.04458944875515602 0.9790097052751596 0.0557717284589689 -0.190890609589362 -0.04461262660218688 0.9790099070433252 0.0557507619079728 -0.1908902811981905 -0.04463580403416412 0.9790101085542692 0.05572979380822713 -0.190889949557366 -0.0446589810523805 0.9790103098028682 0.05570882420205084 -0.1908896146735108 -0.04468215768643887 0.9790105107943933 0.05568785304598296 -0.1908892765392373 -0.04470533390499123 0.9790107115269376 0.05566688035580134 -0.1908889351568372 -0.04472850971875731 0.9790109120021883 0.05564590611762477 -0.1908885905237579 -0.04475168511738003 0.9790111122150231 0.05562493037375552 -0.1908882426466244 -0.04477486013045535 0.9790113121707636 0.05560395308032455 -0.1908878915179755 -0.04479803472633889 0.9790115118668007 0.05558297425890142 -0.1908875371410522 -0.04482120891987397 0.9790117113057241 0.05556199388815889 -0.1908871795120832 -0.044844382695402 0.9790119104818416 0.0555410120150967 -0.1908868186384671 -0.04486755608586762 0.9790121094007184 0.05552002859384575 -0.1908864545124097 -0.0448907290581966 0.9790123080619327 0.05549904362792366 -0.1908860871342029 -0.04491390161438538 0.9790125064597901 0.05547805716434825 -0.1908857165112546 -0.0449370737873958 0.9790127046006806 0.05545706915044622 -0.1908853426346526 -0.04496024553930561 0.9790129024817351 0.05543607960992623 -0.1908849655079926 -0.04498341688648512 0.979013100105201 0.05541508852429076 -0.190884585127961 -0.04500658781528484 0.9790132974655327 0.05539409593932432 -0.1908842015017695 -0.04502975835779438 0.9790134945681582 0.05537310181029415 -0.1908838146217981 -0.04505292848173779 0.9790136914128047 0.055352106139496 -0.1908834244881404 -0.04507609818824146 0.9790138879945368 0.05533110896767252 -0.1908830311071874 -0.04509926750580918 0.9790140843178743 0.05531011025758943 -0.190882634472543 -0.04512243640750013 0.9790142803816393 0.05528911001900395 -0.1908822345855231 -0.04514560489975429 0.97901447618746 0.05526810823853157 -0.190881831443647 -0.04516877297255874 0.9790146717297017 0.05524710496267739 -0.1908814250542567 -0.04519194065852615 0.9790148670138911 0.05522610014590899 -0.1908810154095896 -0.0452151079248001 0.9790150620399412 0.05520509378899012 -0.1908806025094882 -0.04523827477141603 0.9790152568023684 0.05518408593717166 -0.190880186361094 -0.04526144123009764 0.9790154513066387 0.05516307654543252 -0.1908797669567228 -0.04528460726834799 0.979015645550656 0.05514206563109477 -0.1908793442989358 -0.04530777289799801 0.9790158395367293 0.05512105317516726 -0.1908789183843275 -0.04533093810503667 0.9790160332587046 0.0551000392284271 -0.1908784892209534 -0.04535410292513034 0.9790162267222674 0.05507902374404331 -0.1908780568008263 -0.04537726732448654 0.9790164199256947 0.05505800673626383 -0.1908776211260039 -0.04540043131274779 0.9790166128703012 0.05503698819429393 -0.1908771821944251 -0.04542359488174038 0.9790168055513887 0.05501596815690502 -0.1908767400121802 -0.04544675805858241 0.9790169979738622 0.05499494658370984 -0.1908762945723334 -0.04546992081406642 0.9790171901370313 0.05497392348044235 -0.1908758458755449 -0.04549308315176909 0.9790173820368891 0.05495289888017145 -0.1908753939269712 -0.04551624509474818 0.9790175736777856 0.05493187274708774 -0.1908749387204257 -0.04553940661705448 0.9790177650578769 0.0549108450964326 -0.1908744802581327 -0.04556256772904141 0.9790179561790475 0.05488981591271605 -0.1908740185372565 -0.04558572841918582 0.9790181470364195 0.054868785236187 -0.1908735535641403 -0.04560888871566711 0.9790183376346362 0.05484775302862074 -0.1908730853321941 -0.0456320485908096 0.9790185279738075 0.0548267192891577 -0.1908726138409928 -0.04565520804349045 0.9790187180485069 0.05480568406255627 -0.1908721390976282 -0.04567836710510766 0.9790189078645395 0.05478464730102937 -0.1908716610939299 -0.04570152574116437 0.9790190974191927 0.05476360902696868 -0.1908711798333055 -0.04572468396711443 0.9790192867147016 0.054742569222008 -0.1908706953124403 -0.04574784176938002 0.9790194757462033 0.05472152792625608 -0.1908702075376653 -0.04577099917604933 0.979019664518004 0.0547004851042775 -0.1908697165028402 -0.04579415616142616 0.9790198530302399 0.05467944075499881 -0.1908692222075052 -0.04581731272423446 0.9790200412786729 0.05465839491337745 -0.1908687246571459 -0.04584046888889276 0.979020229266762 0.05463734755096387 -0.1908682238467703 -0.04586362463468287 0.9790204169942841 0.05461629866964199 -0.190867719776408 -0.04588677996243805 0.9790206044618884 0.05459524826410842 -0.1908672124448952 -0.0459099348678918 0.9790207916650123 0.05457419637199579 -0.1908667018581643 -0.045933089377375 0.9790209786083743 0.05455314295447818 -0.1908661880095066 -0.04595624346276442 0.9790211652901732 0.05453208802644083 -0.1908656709010982 -0.04597939713416695 0.9790213517124106 0.0545110315714446 -0.1908651505299357 -0.04600255037937157 0.9790215378696738 0.05448997363411334 -0.1908646269031119 -0.0460257032297012 0.9790217237671884 0.05446891417145518 -0.1908641000132234 -0.04604885565405519 0.9790219094049408 0.05444785318363015 -0.1908635698600141 -0.0460720076520361 0.979022094777374 0.05442679071644969 -0.190863036450778 -0.04609515925581806 0.9790222798897785 0.05440572672638948 -0.1908624997780194 -0.04611831043391636 0.9790224647409741 0.05438466122321877 -0.190861959843072 -0.04614146119279006 0.9790226493314922 0.05436359420260532 -0.1908614166449305 -0.04616461152886288 0.9790228336572974 0.05434252569782744 -0.190860870188823 -0.04618776146537132 0.9790230177224704 0.05432145567532989 -0.1908603204688965 -0.04621091097793854 0.9790232015278894 0.0543003841279291 -0.1908597674836786 -0.04623406006092585 0.9790233850676869 0.05427931110398335 -0.1908592112408977 -0.04625720874833496 0.9790235683474154 0.05425823655782448 -0.1908586517326911 -0.04628035700714032 0.9790237513649458 0.0542371605070275 -0.1908580889616882 -0.04630350484937409 0.9790239341219912 0.0542160829375407 -0.1908575229252727 -0.04632665226452105 0.9790241166137014 0.05419500388933875 -0.1908569536297906 -0.04634979928060453 0.9790242988451547 0.05417392332066156 -0.1908563810680194 -0.04637294586738244 0.9790244808155881 0.05415284123784271 -0.190855805240727 -0.04639609202886338 0.9790246625204079 0.05413175767874355 -0.190855226153914 -0.04641923779156609 0.979024843965139 0.05411067259792909 -0.1908546437997433 -0.04644238312262014 0.9790250251470684 0.05408958601778392 -0.1908540581816474 -0.04646552803749515 0.9790252060684507 0.05406849791979989 -0.1908534692962665 -0.04648867252249012 0.9790253867238465 0.05404740834879427 -0.1908528771507611 -0.04651181660909499 0.9790255671185392 0.05402631726132932 -0.1908522817376199 -0.04653496026585946 0.97902574725085 0.05400522467127266 -0.1908516830588641 -0.04655810350217374 0.9790259271221153 0.05398413056767667 -0.1908510811123865 -0.04658124630973309 0.9790261067274416 0.05396303499085896 -0.1908504759046072 -0.04660438871681973 0.9790262860716384 0.05394193790129045 -0.1908498674286573 -0.04662753069476882 0.9790264651550323 0.05392083929633491 -0.1908492556838166 -0.04665067224118376 0.9790266439719115 0.05389973922304122 -0.1908486406776272 -0.04667381338915853 0.9790268225282241 0.05387863763251598 -0.1908480224016594 -0.04669695410333489 0.9790270008212441 0.05385753454723929 -0.190847400859371 -0.04672009439925814 0.9790271788532309 0.05383642994866879 -0.1908467760473886 -0.04674323426319502 0.9790273566188905 0.05381532388041411 -0.1908461479726897 -0.04676637372578817 0.9790275341233586 0.05379421630027118 -0.1908455166279506 -0.04678951275645197 0.9790277113662645 0.05377310721134059 -0.1908448820134048 -0.04681265135688748 0.9790278883428617 0.05375199665272153 -0.1908442441352837 -0.04683578955451884 0.9790280650578216 0.05373088458603344 -0.1908436029868954 -0.04685892732148794 0.9790282415099741 0.05370977102095302 -0.1908429585695704 -0.04688206466419557 0.9790284177003364 0.05368865594916502 -0.190842310881635 -0.04690520157621205 0.9790285936239707 0.05366753941133804 -0.1908416599295881 -0.04692833808608782 0.9790287692864609 0.05364642136158924 -0.1908410057054812 -0.04695147416059767 0.9790289446867834 0.05362530180839266 -0.1908403482104445 -0.04697460980528338 0.9790291198205602 0.0536041807878054 -0.1908396874502126 -0.04699774504540321 0.9790292946927117 0.05358305825941267 -0.190839023417744 -0.04702087985163552 0.9790294693011222 0.05356193424066266 -0.1908383561156688 -0.04704401423593797 0.9790296436477578 0.05354080871544288 -0.1908376855410094 -0.04706714818630461 0.9790298177275207 0.05351968172572684 -0.1908370117004929 -0.04709028173222762 0.9790299915455276 0.0534985532294857 -0.1908363345868029 -0.04711341484322574 0.979030165099446 0.05347742324595585 -0.1908356542028704 -0.04713654753253721 0.9790303383916562 0.05345629175561424 -0.1908349705451458 -0.047159679785715 0.9790305114166702 0.05343515880364254 -0.1908342836208987 -0.04718281163455043 0.9790306841794174 0.05341402434955545 -0.1908335934230636 -0.04720594304966019 0.979030856680176 0.05339288839112494 -0.1908328999509861 -0.04722907402893545 0.9790310289137166 0.05337175097139372 -0.190832203211583 -0.04725220460264212 0.979031200884862 0.05335061205076689 -0.1908315031979334 -0.04727533474202934 0.9790313725921849 0.0533294716410284 -0.1908307999117269 -0.04729846445500935 0.9790315440369977 0.05330832973144518 -0.1908300933508791 -0.04732159373341666 0.9790317152145118 0.05328718636143526 -0.1908293835217074 -0.04734472260493017 0.9790318861295134 0.053266041491706 -0.1908286704173357 -0.04736785104100975 0.9790320567819663 0.05324489512260996 -0.1908279540375402 -0.04739097904139126 0.9790322271672394 0.05322374729226643 -0.1908272343884245 -0.04741410663282816 0.9790323972893866 0.0532025979674072 -0.1908265114641174 -0.04743723379108584 0.9790325671477185 0.05318144715375394 -0.1908257852652957 -0.0474603605197416 0.9790327367428718 0.05316029484612615 -0.1908250557908035 -0.04748348681459972 0.979032906070876 0.05313914107721286 -0.1908243230458397 -0.04750661269853295 0.9790330751354819 0.05311798581623964 -0.190823587024946 -0.04752973814908643 0.979033243938084 0.05309682905180051 -0.1908228477259272 -0.04755286315758163 0.9790334124721937 0.05307567083727477 -0.1908221051574566 -0.04757598776170022 0.9790335807436886 0.05305451112441272 -0.1908213593111407 -0.04759911192647845 0.9790337487502914 0.05303334993198754 -0.1908206101898478 -0.04762223566483443 0.979033916494241 0.05301218724165317 -0.190819857790211 -0.04764535896314832 0.979034083969876 0.05299102309998556 -0.1908191021197689 -0.0476684818542391 0.9790342511822039 0.05296985746240009 -0.1908183431728356 -0.04769160430608571\nnCovRow = 25\nnDataRow = 1415\nnominalISDCovarinace = 4 0 0 4 0 16\nstartTime = 1437301137.710156\ntimeInterval = 0.02\nIsdBase::Attitude BEGIN\ncurrentValue = 0.05920024074181806 0.0001113311795720586 0 0 0.01657415402882883 3.137038360894401e-05 0 0 -0.0001256071859842119 2.71783668176958e-07\noriginalValue = 0 0 0 0 0 0 0 0 0 0\nparameterDelta = 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.01 0.01\nparameterId = 6 7 8 9 10 11 12 13 14 15\nparameterName = ROLL_0 ROLL_1 ROLL_2 ROLL_3 PITCH_0 PITCH_1 PITCH_2 PITCH_3 YAW_0 YAW_1\nparameterType = 2 2 3 3 2 2 3 3 2 2\nparameterUnit = microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians microRadians\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 0 1 4 5 8 9\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 2 6\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationGroup::2 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 7\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::2 END\nCorrelationModel::CorrelationModel END\nIsdBase::Attitude END\nIsdBase::Attitude END\nIsdBase::Ephemeris BEGIN\nephCov = 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5 0.5 0 0 0.5 0 0.5\nephData = 4823829.03000000026077032 1017723.4599999999627471 4950651.80999999959021807 5521.09999999869614839554 -714.974999999976716935635 -5221.39999999897554516792 4824933.36000000033527613 1017580.51000000000931323 4949607.65000000037252903 5521.09999999869614839554 -714.974999999976716935635 -5221.39999999897554516792 4826037.46999999973922968 1017437.46999999997206032 4948563.25 5519.949999998789280653 -715.375000000058207660913 -5222.57500000065192580223 4827141.33999999985098839 1017294.35999999998603016 4947518.62000000011175871 5518.800000001210719347 -715.774999999848660081625 -5223.72500000055879354477 4828244.99000000022351742 1017151.16000000003259629 4946473.75999999977648258 5517.65000000130385160446 -716.174999999930150806904 -5224.87500000046566128731 4829348.40000000037252903 1017007.89000000001396984 4945428.66999999992549419 5516.49999999906867742538 -716.575000000011641532183 -5226.04999999981373548508 4830451.58999999985098839 1016864.53000000002793968 4944383.33999999985098839 5515.37499999860301613808 -716.975000000093132257462 -5227.22499999916180968285 4831554.54999999981373549 1016721.09999999997671694 4943337.78000000026077032 5514.22500000102445483208 -717.350000000151339918375 -5228.34999999962747097015 4832657.28000000026077032 1016577.58999999996740371 4942292 5513.10000000055879354477 -717.774999999965075403452 -5229.49999999953433871269 4833759.7900000000372529 1016433.98999999999068677 4941245.98000000044703484 5511.94999999832361936569 -718.175000000046566128731 -5230.70000000065192580223 4834862.05999999959021807 1016290.31999999994877726 4940199.71999999973922968 5510.80000000074505805969 -718.550000000104773789644 -5231.85000000055879354477 4835964.11000000033527613 1016146.56999999994877726 4939153.24000000022351742 5509.67500000027939677238 -718.949999999895226210356 -5233.00000000046566128731 4837065.92999999970197678 1016002.73999999999068677 4938106.51999999955296516 5508.49999999860301613808 -719.349999999976716935635 -5234.15000000037252902985 4838167.50999999977648258 1015858.82999999995809048 4937059.58000000007450581 5507.35000000102445483208 -719.750000000058207660913 -5235.29999999795109033585 4839268.87000000011175871 1015714.83999999996740371 4936012.40000000037252903 5506.25 -720.149999999848660081625 -5236.47499999962747097015 4840370.00999999977648258 1015570.77000000001862645 4934964.99000000022351742 5505.10000000009313225746 -720.549999999930150806904 -5237.62500000186264514923 4841470.91000000014901161 1015426.61999999999534339 4933917.34999999962747097 5503.92500000074505805969 -720.950000000011641532183 -5238.77499999944120645523 4842571.58000000007450581 1015282.39000000001396984 4932869.48000000044703484 5502.80000000027939677238 -721.325000000069849193096 -5239.949999998789280653 4843672.03000000026077032 1015138.08999999996740371 4931821.37000000011175871 5501.65000000037252902985 -721.725000000151339918375 -5241.10000000102445483208 4844772.24000000022351742 1014993.69999999995343387 4930773.0400000000372529 5500.50000000046566128731 -722.149999999965075403452 -5242.25000000093132257462 4845872.23000000044703484 1014849.22999999998137355 4929724.46999999973922968 5499.35000000055879354477 -722.525000000023283064365 -5243.40000000083819031715 4846971.98000000044703484 1014704.68999999994412065 4928675.67999999970197678 5498.19999999832361936569 -722.924999999813735485077 -5244.54999999841675162315 4848071.50999999977648258 1014560.06000000005587935 4927626.65000000037252903 5497.07499999785795807838 -723.324999999895226210356 -5245.72500000009313225746 4849170.80999999959021807 1014415.35999999998603016 4926577.38999999966472387 5495.92500000027939677238 -723.700000000244472175837 -5246.875 4850269.87999999988824129 1014270.57999999995809048 4925527.90000000037252903 5494.77500000037252902985 -724.125000000058207660913 -5248.02499999990686774254 4851368.71999999973922968 1014125.7099999999627471 4924478.17999999970197678 5493.62500000046566128731 -724.524999999848660081625 -5249.17499999981373548508 4852467.33000000007450581 1013980.77000000001862645 4923428.23000000044703484 5492.47500000055879354477 -724.899999999906867742538 -5250.32499999972060322762 4853565.7099999999627471 1013835.75 4922378.04999999981373549 5491.32500000065192580223 -725.299999999988358467817 -5251.50000000139698386192 4854663.86000000033527613 1013690.65000000002328306 4921327.62999999988824129 5490.17500000074505805969 -725.700000000069849193096 -5252.64999999897554516792 4855761.78000000026077032 1013545.46999999997206032 4920276.99000000022351742 5489.02499999850988388062 -726.100000000151339918375 -5253.77499999944120645523 4856859.46999999973922968 1013400.2099999999627471 4919226.12000000011175871 5487.90000000037252902985 -726.499999999941792339087 -5254.95000000111758708954 4857956.94000000040978193 1013254.86999999999534339 4918175.00999999977648258 5486.75000000046566128731 -726.900000000023283064365 -5256.10000000102445483208 4859054.16999999992549419 1013109.44999999995343387 4917123.67999999970197678 5485.574999998789280653 -727.275000000081490725279 -5257.24999999860301613808 4860151.16999999992549419 1012963.9599999999627471 4916072.11000000033527613 5484.425000001210719347 -727.67499999987194314599 -5258.42500000027939677238 4861247.94000000040978193 1012818.38000000000465661 4915020.30999999959021807 5483.30000000074505805969 -728.099999999976716935635 -5259.55000000074505805969 4862344.49000000022351742 1012672.71999999997206032 4913968.2900000000372529 5482.14999999850988388062 -728.475000000034924596548 -5260.69999999832361936569 4863440.79999999981373549 1012526.98999999999068677 4912916.03000000026077032 5480.97499999916180968285 -728.849999999802093952894 -5261.875 4864536.87999999988824129 1012381.18000000005122274 4911863.5400000000372529 5479.82500000158324837685 -729.274999999906867742538 -5263.02499999990686774254 4865632.73000000044703484 1012235.28000000002793968 4910810.82000000029802322 5478.70000000111758708954 -729.674999999988358467817 -5264.15000000037252902985 4866728.36000000033527613 1012089.31000000005587935 4909757.87999999988824129 5477.54999999888241291046 -730.050000000046566128731 -5265.30000000027939677238 4867823.75 1011943.26000000000931323 4908704.70000000018626451 5476.37499999953433871269 -730.45000000012805685401 -5266.47499999962747097015 4868918.91000000014901161 1011797.13000000000465661 4907651.2900000000372529 5475.22499999962747097015 -730.849999999918509274721 -5267.62499999953433871269 4870013.83999999985098839 1011650.92000000004190952 4906597.65000000037252903 5474.07499999972060322762 -731.25 -5268.77499999944120645523 4871108.5400000000372529 1011504.63000000000465661 4905543.78000000026077032 5472.94999999925494194031 -731.625000000058207660913 -5269.89999999990686774254 4872203.01999999955296516 1011358.27000000001862645 4904489.69000000040978193 5471.79999999934807419777 -732.025000000139698386192 -5271.04999999981373548508 4873297.25999999977648258 1011211.81999999994877726 4903435.36000000033527613 5470.625 -732.449999999953433871269 -5272.22500000149011611938 4874391.26999999955296516 1011065.2900000000372529 4902380.79999999981373549 5469.47500000009313225746 -732.825000000011641532183 -5273.37500000139698386192 4875485.04999999981373549 1010918.68999999994412065 4901326.00999999977648258 5468.30000000074505805969 -733.200000000069849193096 -5274.52499999897554516792 4876578.58999999985098839 1010772.01000000000931323 4900270.99000000022351742 5467.15000000083819031715 -733.624999999883584678173 -5275.64999999944120645523 4877671.91000000014901161 1010625.23999999999068677 4899215.75 5466.02500000037252902985 -734.024999999965075403452 -5276.80000000167638063431 4878765 1010478.40000000002328306 4898160.26999999955296516 5464.87500000046566128731 -734.400000000023283064365 -5277.97500000102445483208 4879857.86000000033527613 1010331.47999999998137355 4897104.55999999959021807 5463.70000000111758708954 -734.800000000104773789644 -5279.09999999916180968285 4880950.48000000044703484 1010184.47999999998137355 4896048.62999999988824129 5462.54999999888241291046 -735.17499999987194314599 -5280.24999999906867742538 4882042.87999999988824129 1010037.41000000003259629 4894992.4599999999627471 5461.39999999897554516792 -735.574999999953433871269 -5281.39999999897554516792 4883135.0400000000372529 1009890.25 4893936.07000000029802322 5460.22499999962747097015 -736.000000000058207660913 -5282.54999999888241291046 4884226.96999999973922968 1009743.01000000000931323 4892879.44000000040978193 5459.09999999916180968285 -736.375000000116415321827 -5283.70000000111758708954 4885318.67999999970197678 1009595.69999999995343387 4891822.58999999985098839 5457.95000000158324837685 -736.774999999906867742538 -5284.85000000102445483208 4886410.15000000037252903 1009448.30000000004656613 4890765.5 5456.77499999990686774254 -737.174999999988358467817 -5285.99999999860301613808 4887501.38999999966472387 1009300.82999999995809048 4889708.19000000040978193 5455.625 -737.550000000046566128731 -5287.12499999906867742538 4888592.40000000037252903 1009153.28000000002793968 4888650.65000000037252903 5454.45000000065192580223 -737.949999999837018549442 -5288.27500000130385160446 4889683.16999999992549419 1009005.65000000002328306 4887592.87999999988824129 5453.29999999841675162315 -738.350000000209547579288 -5289.425000001210719347 4890773.71999999973922968 1008857.93999999994412065 4886534.87999999988824129 5452.15000000083819031715 -738.75 -5290.574999998789280653 4891864.03000000026077032 1008710.15000000002328306 4885476.65000000037252903 5450.97500000149011611938 -739.124999999767169356346 -5291.69999999925494194031 4892954.11000000033527613 1008562.2900000000372529 4884418.20000000018626451 5449.82499999925494194031 -739.525000000139698386192 -5292.85000000149011611938 4894043.9599999999627471 1008414.33999999996740371 4883359.50999999977648258 5448.67499999934807419777 -739.925000000221189111471 -5294.00000000139698386192 4895133.58000000007450581 1008266.31999999994877726 4882300.59999999962747097 5447.52499999944120645523 -740.299999999988358467817 -5295.12499999953433871269 4896222.96999999973922968 1008118.21999999997206032 4881241.4599999999627471 5446.37499999953433871269 -740.699999999778810888529 -5296.27499999944120645523 4897312.12999999988824129 1007970.0400000000372529 4880182.08999999985098839 5445.20000000018626451492 -741.099999999860301613808 -5297.42499999934807419777 4898401.04999999981373549 1007821.78000000002793968 4879122.49000000022351742 5444.02500000083819031715 -741.500000000232830643654 -5298.57499999925494194031 4899489.74000000022351742 1007673.43999999994412065 4878062.66000000014901161 5442.87500000093132257462 -741.900000000023283064365 -5299.69999999972060322762 4900578.20000000018626451 1007525.02000000001862645 4877002.61000000033527613 5441.72499999869614839554 -742.274999999790452420712 -5300.84999999962747097015 4901666.42999999970197678 1007376.53000000002793968 4875942.32000000029802322 5440.574999998789280653 -742.650000000139698386192 -5302.00000000186264514923 4902754.42999999970197678 1007227.9599999999627471 4874881.80999999959021807 5439.40000000176951289177 -743.074999999953433871269 -5303.125 4903842.19000000040978193 1007079.30000000004656613 4873821.07000000029802322 5438.25000000186264514923 -743.475000000034924596548 -5304.24999999813735485077 4904929.73000000044703484 1006930.56999999994877726 4872760.11000000033527613 5437.09999999962747097015 -743.850000000093132257462 -5305.40000000037252902985 4906017.03000000026077032 1006781.76000000000931323 4871698.91000000014901161 5435.89999999850988388062 -744.224999999860301613808 -5306.55000000027939677238 4907104.08999999985098839 1006632.88000000000465661 4870637.49000000022351742 5434.74999999860301613808 -744.624999999941792339087 -5307.67500000074505805969 4908190.92999999970197678 1006483.91000000003259629 4869575.83999999985098839 5433.60000000102445483208 -745.025000000023283064365 -5308.82500000065192580223 4909277.53000000026077032 1006334.86999999999534339 4868513.9599999999627471 5432.42500000167638063431 -745.425000000104773789644 -5309.97500000055879354477 4910363.90000000037252903 1006185.73999999999068677 4867451.84999999962747097 5431.27499999944120645523 -745.824999999895226210356 -5311.10000000102445483208 4911450.0400000000372529 1006036.5400000000372529 4866389.51999999955296516 5430.12499999953433871269 -746.199999999953433871269 -5312.22499999916180968285 4912535.95000000018626451 1005887.26000000000931323 4865326.9599999999627471 5428.95000000018626451492 -746.575000000011641532183 -5313.37499999906867742538 4913621.62000000011175871 1005737.91000000003259629 4864264.16999999992549419 5427.77499999850988388062 -746.975000000093132257462 -5314.52499999897554516792 4914707.05999999959021807 1005588.46999999997206032 4863201.15000000037252903 5426.62499999860301613808 -747.400000000197906047106 -5315.67499999888241291046 4915792.26999999955296516 1005438.94999999995343387 4862137.90000000037252903 5425.47500000102445483208 -747.774999999965075403452 -5316.80000000167638063431 4916877.25 1005289.35999999998603016 4861074.42999999970197678 5424.30000000167638063431 -748.150000000023283064365 -5317.92499999981373548508 4917961.99000000022351742 1005139.68999999994412065 4860010.73000000044703484 5423.125 -748.550000000104773789644 -5319.07499999972060322762 4919046.5 1004989.93999999994412065 4858946.79999999981373549 5421.97500000009313225746 -748.949999999895226210356 -5320.20000000018626451492 4920130.78000000026077032 1004840.10999999998603016 4857882.65000000037252903 5420.82500000018626451492 -749.349999999976716935635 -5321.35000000009313225746 4921214.83000000007450581 1004690.19999999995343387 4856818.25999999977648258 5419.64999999850988388062 -749.725000000034924596548 -5322.5 4922298.63999999966472387 1004540.21999999997206032 4855753.65000000037252903 5418.47499999916180968285 -750.12499999982537701726 -5323.62500000046566128731 4923382.21999999973922968 1004390.15000000002328306 4854688.80999999959021807 5417.29999999981373548508 -750.524999999906867742538 -5324.77500000037252902985 4924465.55999999959021807 1004240.01000000000931323 4853623.74000000022351742 5416.14999999990686774254 -750.899999999965075403452 -5325.89999999850988388062 4925548.67999999970197678 1004089.7900000000372529 4852558.45000000018626451 5415 -751.300000000046566128731 -5327.02500000130385160446 4926631.55999999959021807 1003939.48999999999068677 4851492.92999999970197678 5413.800000001210719347 -751.675000000104773789644 -5328.175000001210719347 4927714.20000000018626451 1003789.11999999999534339 4850427.17999999970197678 5412.65000000130385160446 -752.074999999895226210356 -5329.324999998789280653 4928796.62000000011175871 1003638.66000000003259629 4849361.20000000018626451 5411.49999999906867742538 -752.474999999976716935635 -5330.44999999925494194031 4929878.79999999981373549 1003488.13000000000465661 4848295 5410.32499999972060322762 -752.875000000058207660913 -5331.60000000149011611938 4930960.75 1003337.51000000000931323 4847228.55999999959021807 5409.15000000037252902985 -753.275000000139698386192 -5332.72499999962747097015 4932042.4599999999627471 1003186.81999999994877726 4846161.91000000014901161 5407.97500000102445483208 -753.649999999906867742538 -5333.85000000009313225746 4933123.94000000040978193 1003036.05000000004656613 4845095.01999999955296516 5406.82500000111758708954 -754.024999999965075403452 -5335 4934205.19000000040978193 1002885.2099999999627471 4844027.91000000014901161 5405.64999999944120645523 -754.425000000046566128731 -5336.12499999813735485077 4935286.20000000018626451 1002734.28000000002793968 4842960.57000000029802322 5404.47500000009313225746 -754.824999999837018549442 -5337.27500000037252902985 4936366.98000000044703484 1002583.28000000002793968 4841893 5403.32500000018626451492 -755.225000000209547579288 -5338.40000000083819031715 4937447.53000000026077032 1002432.18999999994412065 4840825.2099999999627471 5402.14999999850988388062 -755.625 -5339.55000000074505805969 4938527.83999999985098839 1002281.03000000002793968 4839757.17999999970197678 5400.97499999916180968285 -755.974999999743886291981 -5340.67499999888241291046 4939607.91999999992549419 1002129.80000000004656613 4838688.94000000040978193 5399.82499999925494194031 -756.375000000116415321827 -5341.79999999934807419777 4940687.76999999955296516 1001978.47999999998137355 4837620.4599999999627471 5398.64999999990686774254 -756.800000000221189111471 -5342.95000000158324837685 4941767.37999999988824129 1001827.07999999995809048 4836551.75999999977648258 5397.47500000055879354477 -757.174999999988358467817 -5344.07499999972060322762 4942846.75999999977648258 1001675.60999999998603016 4835482.83000000007450581 5396.300000001210719347 -757.549999999755527824163 -5345.20000000018626451492 4943925.90000000037252903 1001524.06000000005587935 4834413.67999999970197678 5395.12499999953433871269 -757.949999999837018549442 -5346.35000000009313225746 4945004.80999999959021807 1001372.43000000005122274 4833344.2900000000372529 5393.97499999962747097015 -758.350000000209547579288 -5347.47499999823048710823 4946083.49000000022351742 1001220.71999999997206032 4832274.69000000040978193 5392.80000000027939677238 -758.725000000267755240202 -5348.60000000102445483208 4947161.92999999970197678 1001068.93999999994412065 4831204.84999999962747097 5391.62499999860301613808 -759.125000000058207660913 -5349.75000000093132257462 4948240.13999999966472387 1000917.06999999994877726 4830134.7900000000372529 5390.45000000158324837685 -759.524999999848660081625 -5350.87499999906867742538 4949318.11000000033527613 1000765.13000000000465661 4829064.5 5389.27499999990686774254 -759.899999999906867742538 -5351.99999999953433871269 4950395.84999999962747097 1000613.10999999998603016 4827993.99000000022351742 5388.125 -760.274999999965075403452 -5353.125 4951473.36000000033527613 1000461.02000000001862645 4826923.25 5386.95000000065192580223 -760.675000000046566128731 -5354.27499999990686774254 4952550.62999999988824129 1000308.83999999996740371 4825852.28000000026077032 5385.77499999897554516792 -761.07500000012805685401 -5355.40000000037252902985 4953627.66999999992549419 1000156.58999999996740371 4824781.08999999985098839 5384.59999999962747097015 -761.474999999918509274721 -5356.52500000083819031715 4954704.46999999973922968 1000004.25 4823709.66999999992549419 5383.42500000027939677238 -761.875 -5357.67500000074505805969 4955781.0400000000372529 999851.83999999996740371 4822638.01999999955296516 5382.25000000093132257462 -762.225000000034924596548 -5358.79999999888241291046 4956857.37000000011175871 999699.359999999986030161 4821566.15000000037252903 5381.07499999925494194031 -762.62499999982537701726 -5359.92499999934807419777 4957933.46999999973922968 999546.790000000037252903 4820494.04999999981373549 5379.89999999990686774254 -763.024999999906867742538 -5361.04999999981373548508 4959009.33000000007450581 999394.150000000023283064 4819421.73000000044703484 5378.72500000055879354477 -763.399999999965075403452 -5362.17500000027939677238 4960084.9599999999627471 999241.430000000051222742 4818349.17999999970197678 5377.57500000065192580223 -763.800000000046566128731 -5363.32500000018626451492 4961160.36000000033527613 999088.630000000004656613 4817276.40000000037252903 5376.39999999897554516792 -764.20000000012805685401 -5364.44999999832361936569 4962235.51999999955296516 998935.75 4816203.40000000037252903 5375.20000000018626451492 -764.599999999918509274721 -5365.57500000111758708954 4963310.44000000040978193 998782.790000000037252903 4815130.16999999992549419 5374.02500000083819031715 -764.974999999976716935635 -5366.70000000158324837685 4964385.12999999988824129 998629.760000000009313226 4814056.71999999973922968 5372.87499999860301613808 -765.350000000034924596548 -5367.82499999972060322762 4965459.58999999985098839 998476.650000000023283064 4812983.0400000000372529 5371.69999999925494194031 -765.750000000116415321827 -5368.95000000018626451492 4966533.80999999959021807 998323.459999999962747097 4811909.13999999966472387 5370.50000000046566128731 -766.150000000197906047106 -5370.07500000065192580223 4967607.7900000000372529 998170.189999999944120646 4810835.00999999977648258 5369.32500000111758708954 -766.524999999965075403452 -5371.22499999823048710823 4968681.5400000000372529 998016.849999999976716936 4809760.65000000037252903 5368.17499999888241291046 -766.899999999732244759798 -5372.34999999869614839554 4969755.05999999959021807 997863.430000000051222742 4808686.07000000029802322 5366.99999999953433871269 -767.299999999813735485077 -5373.45000000204890966415 4970828.33999999985098839 997709.930000000051222742 4807611.26999999955296516 5365.80000000074505805969 -767.700000000186264514923 -5374.57500000018626451492 4971901.37999999988824129 997556.349999999976716936 4806536.24000000022351742 5364.62500000139698386192 -768.100000000267755240202 -5375.72499999776482582092 4972974.19000000040978193 997402.689999999944120646 4805460.98000000044703484 5363.44999999972060322762 -768.475000000034924596548 -5376.85000000055879354477 4974046.75999999977648258 997248.959999999962747097 4804385.5 5362.27499999804422259331 -768.849999999802093952894 -5377.97500000102445483208 4975119.09999999962747097 997095.150000000023283064 4803309.7900000000372529 5361.10000000102445483208 -769.249999999883584678173 -5379.09999999916180968285 4976191.20000000018626451 996941.260000000009313226 4802233.86000000033527613 5359.92500000167638063431 -769.649999999965075403452 -5380.22499999962747097015 4977263.07000000029802322 996787.290000000037252903 4801157.70000000018626451 5359.92500000167638063431 -769.649999999965075403452 -5380.22499999962747097015\nnCovRow = 25\nnDataRow = 142\nnominalISDCovarinace = 0.5 0 0 0.5 0 0.5\nstartTime = 1437301137.710156\nstartTimeStamp = 2015-07-19T10:18:57.710156Z\ntimeInterval = 0.2\nIsdBase::Ephemeris BEGIN\ncurrentValue = 1.80653341615433e-05 0.01071117984678449 0.00269159294674129 0 0 0\noriginalValue = 0 0 0 0 0 0\nparameterDelta = 0.1 0.1 0.1 0.1 0.1 0.1\nparameterId = 0 1 2 3 4 5\nparameterName = IN_TRACK_POSITION CROSS_TRACK_POSITION RADIAL_TRACK_POSITION IN_TRACK_VELOCITY CROSS_TRACK_VELOCITY RADIAL_TRACK_VELOCITY\nparameterType = 2 2 2 3 3 3\nparameterUnit = meters meters meters kilometers/second kilometers/second kilometers/second\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0 3.7 20\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationGroup::1 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 0.1 10 100\nparameterList = 3 4 5\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::1 END\nCorrelationModel::CorrelationModel END\nIsdBase::Ephemeris END\nIsdBase::Ephemeris END\nIsdBase::Geo BEGIN\ndetOriginX = 0\ndetOriginY = 169.9982\ndetPitch = 0.0115479093781\ndetRotAngle = 0\nfocalLength = 16018.01822\nqcs1 = 0\nqcs2 = 0\nqcs3 = 0\nqcs4 = 1\nIsdBase::Geo BEGIN\ncurrentValue = 0 0 0\noriginalValue = 0 0 0\nparameterDelta = 0.1 0.1 0.1\nparameterId = 16 17 18\nparameterName = FOCAL_LENGTH DETECTOR_OFFSET_X DETECTOR_OFFSET_Y\nparameterType = 3 3 3\nparameterUnit = mm mm mm\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 0 1 2\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationModel::CorrelationModel END\nIsdBase::Geo END\nIsdBase::Geo END\nIsdBase::Imd BEGIN\nLLHgt = 134.2\nLLLat = 0.7316031015937035\nLLLon = 0.2172294382897458\nLRHgt = 92.7\nLRLat = 0.7314482908890516\nLRLon = 0.2203376951546225\nULHgt = 144.7\nULLat = 0.733798376726862\nULLon = 0.2172292637568206\nURHgt = 176.7\nURLat = 0.7336570050574504\nURLon = 0.2203342044961185\navgLineRate = 13855.84872030585\nbandType = 0\ncatId = P10E17F900\nduration = 1.815551\nfirstLineTime = 1437301149.880786\nheightRange = -362.925 637.075\nimageId = ''19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                    ''\nmeanSatAz = 0\nmeanSatEl = 0\nmeanSunAz = 2.544183903924654\nmeanSunEl = 1.149770551336304\nnumColumns = 29442\nnumRows = 25156\nproductType = Basic1B\nrevNumber = 05042\nsatId = WV03\nscanDirection = 0\nt0_s = 2015-07-19T10:19:9.880786Z\ntileOffset = 0 0\nIsdBase::Imd BEGIN\ncurrentValue = 0\noriginalValue = 0\nparameterDelta = 0.1\nparameterId = 19\nparameterName = LINE_SCAN_RATE\nparameterType = 3\nparameterUnit = lines/second\nCorrelationModel::CorrelationModel BEGIN\nCorrelationGroup::0 BEGIN\nallowableTimeDelta = 1000\ndecorrelationEventTime = 00000000T000000Z\ngroupCoefficients = 1 1 0 10000\nparameterList = 0\nsharable = 0\nsharingCriteria = 1 1 1 0 0 1\nCorrelationGroup::0 END\nCorrelationModel::CorrelationModel END\nIsdBase::Imd END\ntm BEGIN\nhour = 10\nisdst = 0\nmday = 19\nmin = 19\nmon = 6\nsec = 9\nwday = 0\nyday = 199\nyear = 115\ntm END\nIsdBase::Imd END\nIsdModel::1B END\nProjectionModel::1B BEGIN\necfRef = 4635643.768221247 1030683.859527596 4243760.763398123\necfToTanXform = 0.6528617983179064 0.1452600715686049 -0.7434184446897946 0.217104944656884 -0.9761482660759904 -7.511570336195036e-05 0.7256975370652987 0.1613507801181058 0.6688265922140342\nimageLocation = 4635643.768221247 1030683.859527596 4243760.763398123\nsystematicCorrections = 1 1\nProjectionModel::1B END\nWV03_EO_BASIC_DG_5.1.0 END\n", "sensorModel": "WV03_EO_BASIC_DG_5.1.0"}], "tiePoints": [{"id": "12081243641", "type": "M", "imagePoints": [{"x": 17087.127553359525, "y": 8042.7231100068238, "imageId": "19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                    ", "covariance": [1, 1, 0]}, {"x": 18312.253552553026, "y": 7539.2926973312524, "imageId": "19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                    ", "covariance": [1, 1, 0]}]}, {"id": "12081245917", "type": "M", "imagePoints": [{"x": 15759.105423153354, "y": 16744.687595693904, "imageId": "19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                    ", "covariance": [1, 1, 0]}, {"x": 16949.501985255512, "y": 15473.138392396995, "imageId": "19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                    ", "covariance": [1, 1, 0]}]}], "groundPoints": []}');


--
-- Data for Name: raster_data_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO raster_data_set (id, version, repository_id) VALUES (3035, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3036, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3037, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3038, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3039, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3023, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3024, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3025, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3026, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3027, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3028, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3029, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3030, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3031, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3032, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3033, 0, NULL);
INSERT INTO raster_data_set (id, version, repository_id) VALUES (3034, 0, NULL);


--
-- Name: raster_data_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raster_data_set_id_seq', 3039, true);


--
-- Data for Name: raster_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3035, 0, NULL, '2008-03-11 07:14:29+00', 0.142448214941883006, NULL, 11, 'ossimKakaduNitfReader', NULL, 'IR', false, 'uint', 'DigitalGlobe', '0', NULL, 'nitf', '/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.ntf', 60.9200000000000017, '0106000020E610000001000000010300000001000000650000004A8FFDD2C3AE4940F5CCDF4852DE4140C97DA42908B0494022B78C5F80DE4140222940E345B14940CAEC30D4A6DE4140389EAE7B89B24940D5208BBBD4DE41407D73B97CCAB34940BF1AD3D8FFDE4140217666B908B54940A869A8EA27DF4140D4351EFC45B6494020F8B81B4FDF414082A2D13983B74940BE33B09876DF414051A778D7BFB84940930495A19DDF414078D1AB2FFDB949405392EFE6C5DF4140839317793BBB4940908062B2EFDF4140F7BCBE1C7ABC4940CD8FE34A1AE04140DB752FA6B8BD4940C1F1A21F45E041407A6722ABF5BE4940C139DA626EE04140DF3F4DBE32C04940EEF3AF1398E04140CE6D2C8B71C1494079869D5BC4E041409AC0DC80AFC249408DA1E4F0EFE041400FA5F8BCEDC34940F41444451CE14140433B2B1C2CC549409628892D49E1414080F9E9296BC64940C4DDD76377E1414032FE8F5CA8C74940BC526691A3E141408DD2ED74E6C8494064714558D1E141402AD964E623CA49402C5667ACFEE1414009BDDE9261CB49409FDBFEBB2CE241409FE555E5A0CC49406FCD05755DE24140C868EAA0DECD4940554CC27B8CE2414089CB1889D9CD4940BA1A1B7FB4E14140BB202EA9D2CD49409B07B2FFD9E04140E5375F9BCECD494005A0354403E041400D52EE6FCBCD49404ACB12AC2DDF414070B79798C8CD49400831CD7658DE4140B9C1F96BC6CD494076736C1C84DD4140A343FF24C6CD49400670B64EB2DC41409FB4187ACDCD49403D2CE3E9EADB4140C7818054DDCD4940396CBD392FDB41402056039FE5CD49407974702469DA41407CC32686D8CD494048B2918F85D941407D3E09ECDACD49404801544BB7D8414035E4B93DDDCD494036895DE5E8D741402A8853CCDFCD49404ED134CE1AD741409B0A49AEE2CD4940EE9A95254DD64140EE3634AFE6CD4940DE83BF0681D54140C71DFC4BEECD49400A4181E8B9D44140D4D9D569F5CD49403EF1C019F2D341403C1BDB93F9CD4940D98E952D26D341407E614CB4EDCD4940B05070DE43D241400CCEAA51EACD4940312992586DD1414047979B6EE6CD4940E97D831496D04140DAE3E960E4CD4940B3229356C1CF4140973ADF0AEACD4940F0019D61F7CE41403870D971F1CD4940808991DA2FCE414064A56EFFB4CC49401E51FC7600CE4140F849A4A176CB4940E6B9A5DCCECD41402DB2154337CA49405D48B6589CCD414060470FD0F1C84940B144AFF461CD41400C7F9632B0C74940946DE25D2DCD41400F9FE03B71C64940C1DED3E0FCCC4140E61EF6532EC54940C0BFC681C7CC414017DFC5F0F1C34940137524679BCC4140847E489EB3C249406250551B6DCC4140A258F1C07FC149409A8ADB264DCC4140D102B73452C04940F51D92D435CC4140775A6DF10ABF4940C11593CCFCCB414036A21755BFBD49406F6B1D96BECB414043D2CB757FBC49408368DC4090CB4140DA6D5F9D40BB49406A0B4AA863CB41403DCCD61204BA49400F00D66B3ACB41409A7A4223C7B8494028D3B50611CB41409A34C90A8AB74940460147C6E7CA414019DEA2834CB6494000681351BECA414099CCA9CB0EB549409F8C0AF694CA4140F85A3E9FD0B34940A46C755F6BCA414072C4272792B249400E822CC141CA4140566EE37F53B1494048B4B23E18CA414042F793F014B04940FE4FCE2FEFC9414037B229D7D5AE49407E2D73CAC5C941404F54E4B9D3AE494039F948D896CA414084CCF2DDD1AE49409A77BD2F68CB41405FE65806D0AE49400FD2E28539CC414000B42470CEAE4940B02228260BCD4140EB4E237BCDAE4940CC033C86DDCD41406ECD320BCCAE49407BD11149AFCE4140E28A7643CAAE4940CCFE699A80CF4140461EDD69C8AE4940971B53D051D0414091F534ACC6AE4940073EE32223D14140A4820AC4C4AE49400BADE63BF4D14140488A9E16C3AE4940EB36E796C5D241407854F081C1AE4940EAB2040A97D34140CEC16D04C0AE49406C9EF49268D44140F1F4EAC5BEAE49407066AC613AD54140D3A74764BDAE4940EC4060FE0BD64140A441A788BCAE4940EE42CB35DED64140B14FAF19BCAE4940360C18E8B0D741405B7C13B3BBAE49406585DD9A83D8414048DEAFABBBAE4940BE4750B656D9414092037F03BCAE4940FED63C392ADA41400BC23A6DBCAE494034B240C5FDDA41408F6F16BDBCAE49400D8CA424D1DB41407D59C282BDAE49406AD55103A5DC41405D5CEC1FC0AE49403BC084087BDD41404A8FFDD2C3AE4940F5CCDF4852DE4140', 'meters', 0.617270034660065026, 0.638953485090189011, 27648, 'VIS', NULL, 'MONO', '1f802a29c0fbb28840cf86e4b1a5ecf4d77163e6ce8d74fde73374cab20074d9', '2017-08-13 07:04:08.432+00', 'DigitalGlobe', NULL, 'WV01', NULL, 1, 13, 'DigitalGlobe', NULL, NULL, 3035, NULL, NULL, 'UNCLASSIFIED', '0', 'AA', NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 35839,0 35839,27647 0,27647</coordinates></Image><Ground><coordinates>51.3653510797581,35.7368861286904 51.6083565849854,35.7699122141573 51.6089308082305,35.610835381568 51.3659008935542,35.5763485968009</coordinates></Ground></TiePointSet>', '11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003', 1, NULL, 35840);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3036, 0, NULL, '2003-01-23 12:33:30+00', 359.618157898327013, NULL, 11, 'ossimNitfTileSource', NULL, 'IZ', false, 'uint', 'SPACE IMAGING SATELLITE', '0', NULL, 'nitf', 's3://o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ntf', NULL, '0106000020E610000001000000010300000001000000650000000EF9161F082346405693112AF9BE4040860EACD0BE234640384D350FFABE404030C57A8275244640E8C334F2FABE404053FA82342C254640B8F70FD3FBBE4040BF6FE57BE1254640AF9D42A4FDBE404097D3159798264640D004C03AFEBE4040006C521A502746404EB6E689FEBE4040F595BD7A0528464060A2ED4300BF40406FAAADECBB2846404B7F5E4501BF40405559B05E722946405C0FB64402BF4040E5E68193292A4640295355C002BF4040C171E205E02A46408FDA69BB03BF4040C2285578962B4640121465B404BF40408318EDCB4C2C46409A5DD2BF05BF40402D1BA5DC032D464003F99B4B06BF4040CEDC18D0B92D46406EE6BE9207BF40409FCAD242702E46408AE1548308BF4040BECC37BE262F464042B41E6C09BF4040151D9DE6DC2F46404AD0C98A0ABF40405EAED359933046400625E5730BBF404058630A204A3146405FAC05250CBF40409BC97AAF00324640589A5DF80CBF40402929FA25B7324640AE9B26DA0DBF40403DB08AEB6D3346401983B1850EBF40402B8309DB23344640AE1175BC0FBF4040850E5B4EDA3446404D18279A10BF40401247D768DB344640EC4155B056BE4040BFB22AD3DC344640B2CBC7919CBD4040DB2258D3DD344640D26317B9E2BC404083428115DF3446401666CEB428BC4040C78A9357E0344640CF077AB06EBB404030FD8E99E13446401A491AACB4BA40406CE731F2E2344640115AB298FAB94040184F755FE434464042C6987740B94040D760F85EE534464089CBB69E86B84040DF91D7E2E63446400367836ECCB74040DE6DC51DE834464043C6456E12B74040749BDE65E9344640E085406558B640404530019EE93446404D2E4C0F9FB540402B8235DFEA3446400EDE9A0AE5B440408F453CABEC34464072B75CAA2AB44040CC28BAA3ED344640EB325DD570B340407837561CEF344640D0D1DEABB6B240406381B9A0F0344640B8F4847AFCB1404020E5C8E3F03446404F9AB31C43B1404046657EE9F2344640DD4CF99588B04040BBB216AFF4344640D3A46039CEAF4040D388C12DF53446401868FAB314AF4040D2532438F634464060B475D25AAE4040186876EBF734464034A79881A0AD4040114BAD67F93446402DC7EB54E6AC40406BAF5D0443344640BDFCE79FE5AC404063137C1F8D3346409FEE8A95E4AC40400F9D2BF8D6324640AF58E7B4E3AC4040029E989320324640E367A8FAE2AC4040907EED5A6A314640B2D26A21E2AC40405AE87D40B4304640B52D2A32E1AC4040C60BEAD9FD2F464001754073E0AC4040958D7543472F464037E2F5D1DFAC4040A3DF8E4F922E4640E8FB9519DEAC404083655321DB2D46408B3FD4D8DDAC4040A831457E252D4640AB9A3A90DCAC404008DC98926E2C4640C56E811FDCAC40400D7CDAADB82B4640674759FEDAAC40402A888087022B4640E409AE06DAAC404005550C3A4C2A464025ADF626D9AC404039F0CA6D962946405CF94CEFD7AC40407F6591D3DF28464041659D3ED7AC4040760FCFEE292846402F8D2013D6AC404008EA9A0E75274640BF2AE537D4AC404080A950E8BE26464071D5CE33D3AC4040816619C208264640A610A22DD2AC4040BE46F59B52254640EFDC5E25D1AC4040EB6FE4759C244640DF3A051BD0AC4040D007E74FE6234640002B950ECFAC4040C7129BD72E234640674273E2CEAC4040E7D1A75A2D234640076254DC88AD4040539273D12C234640F415FF3242AE4040CAF491E32A234640305A3278FCAE404013DEB83929234640224EC28FB6AF404018C94DFB27234640F7B04F5F70B04040912610E126234640B81C87162AB140407FFA85542523464083FA1D1AE4B140403B7EBFBB23234640711CC7259EB2404092FF1C3B222346408583292158B34040BB6DD48D2023464073B5503A12B4404024EAA4B01E234640A9846B73CCB4404015E0FE6C1D2346404C729F4586B5404041B2AD451B2346404B1221B040B64040A8966EB8192346404BD25EB3FAB64040BE49766B182346401240748BB4B7404007979B9D162346401D1DB8B96EB84040F79E5F501523464060E8BC9128B940405BDEA9C213234640671FD094E2B94040CBA22475122346402F56C76C9CBA40401241A26610234640C0D3E1C556BB4040862E9DD80E234640C4BBCFC810BC404041FFF3CA0D234640A37DA375CABC40405094077C0B2346402A9B8DF984BD4040086F120F0A23464034A3FAE53EBE40400EF9161F082346405693112AF9BE4040', 'meters', 1.00035970191423007, 1.00035964670676991, 15736, 'VIS', '0000000000', 'MONO', '0675613fc80e02149b77079cf8a21e445c7a8c4dcdc6ea5a37a992e88f3a8627', '2017-08-13 07:04:14.287+00', 'SPACE IMAGING SATELLITE', NULL, 'SI_CARTERRA_01', NULL, 1, 12, 'Space Imaging', NULL, NULL, 3036, NULL, NULL, 'UNCLASSIFIED', NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 12931,0 12931,15735 0,15735</coordinates></Image><Ground><coordinates>44.2736853468106,33.4919788919275 44.4129121727574,33.4926941576856 44.4138612362059,33.3507791663418 44.2748670108027,33.350063616065</coordinates></Ground></TiePointSet>', '20030123123330SI_CARTERRA_0101228AA00000 00100001AA05100062P  GC   UCT', 1, '0427', 12932);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3037, 0, NULL, '2003-01-23 12:33:30+00', 359.618157898327013, NULL, 11, 'ossimNitfTileSource', NULL, 'IZ', false, 'uint', 'SPACE IMAGING SATELLITE', '0', NULL, 'nitf', '/s3/o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ntf', NULL, '0106000020E610000001000000010300000001000000650000000EF9161F082346405693112AF9BE4040860EACD0BE234640384D350FFABE404030C57A8275244640E8C334F2FABE404053FA82342C254640B8F70FD3FBBE4040BF6FE57BE1254640AF9D42A4FDBE404097D3159798264640D004C03AFEBE4040006C521A502746404EB6E689FEBE4040F595BD7A0528464060A2ED4300BF40406FAAADECBB2846404B7F5E4501BF40405559B05E722946405C0FB64402BF4040E5E68193292A4640295355C002BF4040C171E205E02A46408FDA69BB03BF4040C2285578962B4640121465B404BF40408318EDCB4C2C46409A5DD2BF05BF40402D1BA5DC032D464003F99B4B06BF4040CEDC18D0B92D46406EE6BE9207BF40409FCAD242702E46408AE1548308BF4040BECC37BE262F464042B41E6C09BF4040151D9DE6DC2F46404AD0C98A0ABF40405EAED359933046400625E5730BBF404058630A204A3146405FAC05250CBF40409BC97AAF00324640589A5DF80CBF40402929FA25B7324640AE9B26DA0DBF40403DB08AEB6D3346401983B1850EBF40402B8309DB23344640AE1175BC0FBF4040850E5B4EDA3446404D18279A10BF40401247D768DB344640EC4155B056BE4040BFB22AD3DC344640B2CBC7919CBD4040DB2258D3DD344640D26317B9E2BC404083428115DF3446401666CEB428BC4040C78A9357E0344640CF077AB06EBB404030FD8E99E13446401A491AACB4BA40406CE731F2E2344640115AB298FAB94040184F755FE434464042C6987740B94040D760F85EE534464089CBB69E86B84040DF91D7E2E63446400367836ECCB74040DE6DC51DE834464043C6456E12B74040749BDE65E9344640E085406558B640404530019EE93446404D2E4C0F9FB540402B8235DFEA3446400EDE9A0AE5B440408F453CABEC34464072B75CAA2AB44040CC28BAA3ED344640EB325DD570B340407837561CEF344640D0D1DEABB6B240406381B9A0F0344640B8F4847AFCB1404020E5C8E3F03446404F9AB31C43B1404046657EE9F2344640DD4CF99588B04040BBB216AFF4344640D3A46039CEAF4040D388C12DF53446401868FAB314AF4040D2532438F634464060B475D25AAE4040186876EBF734464034A79881A0AD4040114BAD67F93446402DC7EB54E6AC40406BAF5D0443344640BDFCE79FE5AC404063137C1F8D3346409FEE8A95E4AC40400F9D2BF8D6324640AF58E7B4E3AC4040029E989320324640E367A8FAE2AC4040907EED5A6A314640B2D26A21E2AC40405AE87D40B4304640B52D2A32E1AC4040C60BEAD9FD2F464001754073E0AC4040958D7543472F464037E2F5D1DFAC4040A3DF8E4F922E4640E8FB9519DEAC404083655321DB2D46408B3FD4D8DDAC4040A831457E252D4640AB9A3A90DCAC404008DC98926E2C4640C56E811FDCAC40400D7CDAADB82B4640674759FEDAAC40402A888087022B4640E409AE06DAAC404005550C3A4C2A464025ADF626D9AC404039F0CA6D962946405CF94CEFD7AC40407F6591D3DF28464041659D3ED7AC4040760FCFEE292846402F8D2013D6AC404008EA9A0E75274640BF2AE537D4AC404080A950E8BE26464071D5CE33D3AC4040816619C208264640A610A22DD2AC4040BE46F59B52254640EFDC5E25D1AC4040EB6FE4759C244640DF3A051BD0AC4040D007E74FE6234640002B950ECFAC4040C7129BD72E234640674273E2CEAC4040E7D1A75A2D234640076254DC88AD4040539273D12C234640F415FF3242AE4040CAF491E32A234640305A3278FCAE404013DEB83929234640224EC28FB6AF404018C94DFB27234640F7B04F5F70B04040912610E126234640B81C87162AB140407FFA85542523464083FA1D1AE4B140403B7EBFBB23234640711CC7259EB2404092FF1C3B222346408583292158B34040BB6DD48D2023464073B5503A12B4404024EAA4B01E234640A9846B73CCB4404015E0FE6C1D2346404C729F4586B5404041B2AD451B2346404B1221B040B64040A8966EB8192346404BD25EB3FAB64040BE49766B182346401240748BB4B7404007979B9D162346401D1DB8B96EB84040F79E5F501523464060E8BC9128B940405BDEA9C213234640671FD094E2B94040CBA22475122346402F56C76C9CBA40401241A26610234640C0D3E1C556BB4040862E9DD80E234640C4BBCFC810BC404041FFF3CA0D234640A37DA375CABC40405094077C0B2346402A9B8DF984BD4040086F120F0A23464034A3FAE53EBE40400EF9161F082346405693112AF9BE4040', 'meters', 1.00035970191423007, 1.00035964670676991, 15736, 'VIS', '0000000000', 'MONO', 'fc277484135e9db32672ccc0eb891e867ac628f1b5448c466a2b57d76bfd106e', '2017-08-13 07:04:16.358+00', 'SPACE IMAGING SATELLITE', NULL, 'SI_CARTERRA_01', NULL, 1, 12, 'Space Imaging', NULL, NULL, 3037, NULL, NULL, 'UNCLASSIFIED', NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 12931,0 12931,15735 0,15735</coordinates></Image><Ground><coordinates>44.2736853468106,33.4919788919275 44.4129121727574,33.4926941576856 44.4138612362059,33.3507791663418 44.2748670108027,33.350063616065</coordinates></Ground></TiePointSet>', '20030123123330SI_CARTERRA_0101228AA00000 00100001AA05100062P  GC   UCT', 1, '0427', 12932);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3038, 0, NULL, '2015-07-19 10:19:09+00', 0.0239835466597411, NULL, 8, 'ossimNitfTileSource', NULL, NULL, false, 'uint', 'DigitalGlobe', '0', NULL, 'nitf', '/data/s3/msp/Stereo/test/A.NTF', 64.8799999999999955, '0106000020E61000000100000001030000000100000065000000233E1FF084E42840DD90FD52920545408AADA8AE28E82840A1320DAA86054540DCB3D89FCAEB2840C45E78A57C0545400235DACC6BEF284095812264730545409E86875611F328407F95A7C566054540B3B3DDFBB5F62840EEDAB30B5B0545400A72023859FA28407692089950054540690DAB85FDFD284095A8CC7545054540C8F23C24A2012940156D693B3A054540BD30108148052940A490BBD12D054540DABE0841F3082940C06C5A3C1E05454014EE400A980C2940B8EF4D6113054540C06D4FEC3C102940460C55980805454028629305E2132940961652CAFD044540966CF144871729401D38EA03F30445408759F5AD2B1B2940180DAFFDE8044540DA61D5BDCD1E29408AA817CCE00445401F362B456D22294005D87186DA0445409B1CE8BD0F26294035D85D36D20445404F359C07BA2929405370B971C404454020EF0690622D2940955DA416B80445402D80294609312940882FDB28AD0445400D266029AF342940D5A7E0EEA2044540981A5AA853382940C89CD4C8990445406BDB0449F73B2940221DF754910445407143B978953F2940A0379CAA8C044540F20E0B349A3F29403868574AE403454087146E46A43F2940689B515B38034540722BD2489D3F294032218707980245406775CF9E983F2940ECB5B726F6014540A87B40D59B3F2940F0235EF94E014540B994E4109C3F2940356607D4A9004540FD56508D9A3F2940D5294FDE050045408230410A9C3F2940AC0CE3E35FFF4440FEA1D9229F3F2940D632A6D4B8FE444098B7A86AA53F2940452872A10FFE44408D2C3C72A93F2940DAE7B5EE67FD4440B70AF758AC3F2940AAE058F9C0FC44406B51BCADAC3F2940D146E3B51BFC4440E1506149AD3F2940654C433B76FB44402C25CA44AE3F2940B5050578D0FA44402B3300A2AF3F294056C51B6A2AFA4440939808FCB03F2940DF4C0F5484F944408AF4C86BB13F294030918ACEDEF8444056289B29B23F294018084F0939F844400EED9F3CB33F2940FED55AFF92F744405211BD66B43F2940B6DD95D9ECF64440A288CE8CB53F2940B7AAB9A946F644409F5E2985B63F29408B161B8BA0F54440C2342398B63F2940337693F6FAF4444082E958ECB53F2940772C42D255F444401DD048860D3C294007C75A9A61F444407E9FF3DA653829407DF126086DF4444037E8CA3ABF342940D041C6E377F4444046CDD0A0183129404260CADA82F44440D1F1E3B2712D2940E6BB4E2B8EF44440309C34B0CA2929402D70FBAB99F444404E9816D62326294040928D33A5F444402EDD31387D222940269E92B4B0F44440AD1771D6D61E2940980D0C2FBCF44440D5D68D6A301B29405A489AD4C7F444407AF61B6C8A172940D4D72251D3F444401B4CABE6E41329408E62839BDEF4444041F32BA73F102940CDC59AD7E9F44440FF170E699A0C2940F48C2237F5F44440563DA6D4F4082940F8C566FB00F54440F4F6E0E84D05294066031CE50DF54440BE694359A8012940011C80F719F54440622B15CD03FE2840A7463F7025F54440CFF454EC5FFA284076C0738E30F54440C5ACF9DBBCF628407A3EC9333BF54440DD9CCBF919F32840EC3B54DA45F54440DB6CAD1879EF284067C0B2174FF54440B8D63E5CD6EB2840D610CEE859F544401DA5AA0131E82840B1CBA6F166F54440ED5F782989E42840717BC42676F54440E901BA9881E42840FFBE787021F644406C382BC77FE42840CE60951AC8F64440A688D6CB81E42840759E95A66BF744408A4C038782E428401B759C2B10F844405139B87783E4284058D1C877B4F844407FA6D24385E4284052CDE70558F94440CD36BACB86E428409F210ABDFBF94440AA575B2388E42840D28DEA8D9FFA44402B800F2486E42840CC86C20446FB4440A64119D584E42840294D8DE3EBFB44404FCB5FC285E428403DA9BEE98FFC4440BC343D3685E42840E068AB1835FD44400CCAF6D083E42840394CA6F0DAFD4440BA1408F582E428408FC92C5380FE44409B8DE83383E4284040F367CA24FF4440204082A785E428407B0D6370C7FF4440DDDE1B9586E4284002E573516B00454031BCA8B386E42840FB9AE7DA0F014540192F7EAD87E42840688A68B1B301454021DBD82288E428403BFA27F75702454036D02F7E87E4284081F9D229FD0245407A21DDCB85E4284029157C42A303454087CCDDB383E428407B0FABB94904454022DAE8AB84E42840783113B5ED044540233E1FF084E42840DD90FD5292054540', 'meters', 0.502074631234540991, 0.555910016114948946, 25156, 'VIS', NULL, 'MONO', 'fcb8f40b396d2b2518a9b2af90ca2ce7155737dcf7551742951210a1dd20833f', '2017-08-13 11:41:04.011+00', 'DigitalGlobe', NULL, 'WV03', NULL, 1, 13, 'DigitalGlobe', NULL, NULL, 3038, NULL, NULL, 'UNCLASSIFIED', NULL, 'AA', NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 29441,0 29441,25155 0,25155</coordinates></Image><Ground><coordinates>12.4463267362726,42.0435279596438 12.6241872526313,42.0355427992611 12.624434839109,41.908869058906 12.4463589629595,41.9176681956659</coordinates></Ground></TiePointSet>', '19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001', 1, NULL, 29442);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3039, 0, NULL, '2015-07-19 10:20:02+00', 0.0541807312792911971, NULL, 8, 'ossimNitfTileSource', NULL, NULL, false, 'uint', 'DigitalGlobe', '0', NULL, 'nitf', '/data/s3/msp/Stereo/test/B.NTF', 73.6899999999999977, '0106000020E61000000100000001030000000100000065000000B86EE40BBEE62840E2A489DA5904454025B9F2C24BEA2840AF6366F360044540E2A9DBE3C4ED28403BE5C82666044540DDCA055B48F12840B28C5E3A6C0445404E0B0375CFF42840B94B9A937204454010A17E3755F82840495B18C1780445406160332CE0FB28404E06A7567F044540BDABF54B67FF284063605688850445405B5B8376F1022940F1F407F18B0445405D6223877C06294096C84D60920445405EF4655E060A2940DC03DCA698044540D018307B8D0D29400055C2A39E044540BEA949FA1411294038156F9CA40445403D5D31F39C1429406529E892AA04454093B25708251829407927267FB0044540CB158444A91B29404ACFC10AB60445409528BDCF281F294073ED5024BB044540E91F5A9FA5222940BBCE72F7BF0445400F92BAAB282629408845CF46C504454091AEDD09BE292940720A7915CC044540FE0C0C1A4E2D29405B841D64D2044540ACF434B2D73029406793121BD80445402DF3692B5F34294013A09798DD0445401ABA97FBE937294007885051E3044540619D5A306E3B29402129D571E804454063BF28BCEB3E2940584284FAEC044540FA1322D7E93E2940171D5CEE470445403D363D20FB3E29400BE05775A4034540339A8537033F294061E0AF380003454098D0FD37F43E29406B9310145A0245402D851671F43E294045FB2A2FB50145407FF7F246FC3E2940D1535CE9100145402D7E696FF93E2940A163ABC16B004540D068F1CCF83E294091D759C7C6FF4440574C3354FC3E29400802632322FF44408C31BDF4053F29401DDA37FE7DFE4440CB3EF359123F29407AD1A311DAFD4440CA93C4D1183F294026BB0AA735FD4440B410B96E1D3F2940CABEDC1391FC4440F9868EB61E3F294081E00839ECFB444032AB3D1E213F2940D051CD7347FB444068E30004243F2940C4CEAAB6A2FA44400C30269F273F294030CDDE05FEF944402682392A2A3F2940EC60113C59F9444082F622102B3F29408286CF4CB4F844409CF829B72C3F294004CDE9690FF84440403735B32E3F294004E4288A6AF744401C4C602C313F29404F5566B0C5F64440FAE6F149333F2940D87388CA20F64440C984D9E9343F29408AC855D57BF54440770BC32A343F2940F5DE2DA9D6F444400C0C0505A43B2940B1809E8CD0F44440DC56D797153829402C6B6A87CAF4444097FAA05F893429409DF90EA4C4F4444076C4A52AFD3029408F77A0B4BEF44440D6A28FA6702D2940940F3BB2B8F44440F3969B1CE42929406EB6CBA2B2F444405C4391CC57262940891F8A8BACF444403C3262FACB22294092EE1872A6F44440B87CE5A5401F2940401D7956A0F444403A866A27B51B29406375952A9AF44440A6B0114E2A182940646BC7FF93F44440FEFFCDEBA0142940F4CCE1E78DF444404CC35A3818112940F92C1DD287F44440481D55578F0D29408197C0AB81F44440D271AEA3060A29405FAE717C7BF44440034E81B97D062940F67B903B75F444401A7FFA66F5022940F6B0B9FA6EF444401868AC726EFF284060EB1FCB68F44440677783E8E8FB2840AEB203AE62F444404255B68560F828401E7CB9445CF444402D96D6CDDCF428402C49703656F4444066DB329C59F12840A68A382750F44440AB769721D5ED28404CFE60EE49F444400E6900C650EA2840561A46AB43F44440F23D4695CDE628406CEF8C753DF444407A73907ECAE62840F8E93D5BE2F444408D029E08C2E62840551165C186F544407E925AFFACE62840A52FB3042AF644402D5A9C78ACE628404EB5D714CFF644401B50681EB8E62840DAC79E3575F744403C11520DB4E6284033FF7BED19F84440C9B45B00B4E62840889F4DFDBEF84440FC86826FBCE62840748565CB64F9444010C3B396BEE628407D46E0070AFA44402AFE11E3BDE62840DA01E900AFFA4440860C25ADBDE62840FEE2FF0254FB44405817732EBEE62840A3E48713F9FB44401DD6BDE1BFE6284035B0B23D9EFC4440510D2F60BBE628402E8E79D842FD4440655AF2D8B4E62840B87A7A43E7FD444000E14181B5E62840DE8090518CFE44404C875ACFBAE6284010A0FCC831FF44404C8FCCE3C6E6284052FCC6DAD7FF444074347723C6E6284019B980C57C004540C170BD38C2E62840E317796621014540BE4D2F59C6E628405178FEBEC60145407F0FD9CAC6E62840EB1ED8C16B02454071E07CABC2E628403CB6735A10034540CF19AED4BFE62840B9F3210FB5034540B86EE40BBEE62840E2A489DA59044540', 'meters', 0.517056301752413017, 0.500459171166442007, 27936, 'VIS', NULL, 'MONO', '9247f5847e44eeaf1b24d657819b8016a0616ed119f7ea6a3b985069cb46ebde', '2017-08-13 11:41:08.992+00', 'DigitalGlobe', NULL, 'WV03', NULL, 1, 13, 'DigitalGlobe', NULL, NULL, 3039, NULL, NULL, 'UNCLASSIFIED', NULL, 'AA', NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 27679,0 27679,27935 0,27935</coordinates></Image><Ground><coordinates>12.4506686893795,42.0339921161738 12.6228922652951,42.0384820123479 12.6234448779194,41.912800929449 12.4507872246022,41.9081255853806</coordinates></Ground></TiePointSet>', '19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001', 1, NULL, 27680);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3028, 0, NULL, '2005-01-31 23:10:48+00', 359.431453144340026, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.TIF', NULL, '0106000020E6100000010000000103000000010000000500000088FE3F7D67515540B053CACA9E0234400361DDB96A58554064D5C6A4E2023440E2C2D9077C5855403D16DDD75EE8334090FECBF6795155406567325F1BE8334088FE3F7D67515540B053CACA9E023440', 'meters', 2.79999999999999982, 2.79999999999999982, 4096, NULL, NULL, NULL, '47801300648dc188a701a99112aeac905aceac388411a5c7db4103a8472cb68e', '2017-08-13 06:56:31.854+00', NULL, NULL, NULL, NULL, 4, 10, NULL, NULL, NULL, 3028, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 4095,0 4095,4095 0,4095</coordinates></Image><Ground><coordinates>85.2719414830154,20.010235475918 85.3815140401748,20.0112708077844 85.382570231111,19.9076971926463 85.2730690948613,19.9066676614815</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 4096);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3029, 0, NULL, '2005-01-31 23:07:57+00', 359.431453144340026, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.TIF', NULL, '0106000020E610000001000000010300000001000000050000004B0FBB5267515540FC0344689F023440CE958BE36A585540AB387145E30234402FA650327C5855407FC5433A5EE83340B5D52BCD79515540228471BE1AE833404B0FBB5267515540FC0344689F023440', 'meters', 0.699999999999999956, 0.699999999999999956, 16384, NULL, NULL, NULL, '0b56ca6900b0ebe071bb22cdf890514e72bf31c2fd3013c7c40c70754b7f2414', '2017-08-13 06:57:48.978+00', NULL, NULL, NULL, NULL, 1, 12, NULL, NULL, NULL, 3029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 16383,0 16383,16383 0,16383</coordinates></Image><Ground><coordinates>85.2719313456302,20.0102448621801 85.3815239775788,20.0112803841991 85.3825803554143,19.9076877990205 85.2730591705393,19.9066580798282</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 16384);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3030, 0, NULL, NULL, 0.462727515467891981, NULL, 16, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.tif', NULL, '0106000020E61000000100000001030000000100000005000000A08CFCE615BB63C04571C9F2B17C3540444BCDBC5DB363C09F38ED66397C3540D791B63E6FB363C0919799686D423540F141376224BB63C0F6594D91E4423540A08CFCE615BB63C04571C9F2B17C3540', 'meters', 5, 5, 5000, NULL, NULL, NULL, '7684451336a3bb0ce55fc9cac80212dc6e72f3d895df696ecb846adc7bb56109', '2017-08-13 06:58:23.294+00', NULL, NULL, NULL, NULL, 5, 11, NULL, NULL, NULL, 3030, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 4999,0 4999,4999 0,4999</coordinates></Image><Ground><coordinates>-157.846423619519,21.4870902768901 -157.605192566838,21.4852508858827 -157.607329708654,21.2594819426518 -157.848191364217,21.2613001645895</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 5000);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3031, 0, NULL, '2015-09-14 10:00:18+00', 259.938182156713026, NULL, 8, 'ossimNitfTileSource', NULL, NULL, false, 'uint', 'TerraSAR-X', '0', NULL, 'nitf', '/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.ntf', NULL, '0106000020E610000001000000010300000001000000650000003E6DA0D3062E5E40400AD7A3708D384006BDBFA3022E5E401359F345B78D3840CD0CDF73FE2D5E40E6A70FE8FD8D3840955CFE43FA2D5E40B9F62B8A448E38405DAC1D14F62D5E408C45482C8B8E384024FC3CE4F12D5E405F9464CED18E3840EC4B5CB4ED2D5E4033E38070188F3840B39B7B84E92D5E4006329D125F8F38407BEB9A54E52D5E40D980B9B4A58F3840433BBA24E12D5E40ACCFD556EC8F38400A8BD9F4DC2D5E407F1EF2F832903840D2DAF8C4D82D5E40526D0E9B799038409A2A1895D42D5E4025BC2A3DC0903840617A3765D02D5E40F80A47DF0691384029CA5635CC2D5E40CB5963814D913840F1197605C82D5E409EA87F2394913840B86995D5C32D5E4072F79BC5DA91384080B9B4A5BF2D5E404546B867219238404709D475BB2D5E401895D409689238400F59F345B72D5E40EBE3F0ABAE923840D7A81216B32D5E40BE320D4EF59238409EF831E6AE2D5E40918129F03B933840664851B6AA2D5E4064D04592829338402E987086A62D5E40371F6234C9933840F5E78F56A22D5E400A6E7ED60F943840BD37AF269E2D5E40DDBC9A785694384040FAEDEBC02D5E40A75C6C0B6D943840C5BC2CB1E32D5E4072FC3D9E83943840487F6B76062E5E403C9C0F319A943840CD41AA3B292E5E40063CE1C3B09438405004E9004C2E5E40CFDBB256C7943840D4C627C66E2E5E409A7B84E9DD9438405889668B912E5E40641B567CF4943840DC4BA550B42E5E402EBB270F0B9538405F0EE415D72E5E40F95AF9A121953840E4D022DBF92E5E40C3FACA3438953840679361A01C2F5E408D9A9CC74E953840EC55A0653F2F5E40573A6E5A659538406F18DF2A622F5E4022DA3FED7B953840F3DA1DF0842F5E40EB79118092953840779D5CB5A72F5E40B519E312A9953840FB5F9B7ACA2F5E4080B9B4A5BF9538407F22DA3FED2F5E404A598638D695384003E5180510305E4014F957CBEC95384086A757CA32305E40DF98295E039638400B6A968F55305E40A938FBF0199638408E2CD55478305E4073D8CC833096384012EF131A9B305E403C789E164796384096B152DFBD305E40071870A95D9638401A7491A4E0305E40D1B7413C749638409E36D06903315E409B5713CF8A963840F90A47DF06315E40EB2C8D724396384054DFBD540A315E403B020716FC953840AFB334CA0D315E408AD780B9B49538400988AB3F11315E40DAACFA5C6D953840655C22B514315E402A82740026953840BF30992A18315E407A57EEA3DE9438401A0510A01B315E40C92C68479794384075D986151F315E401902E2EA4F943840D0ADFD8A22315E4069D75B8E089438402B82740026315E40B7ACD531C19338408656EB7529315E4007824FD579933840E02A62EB2C315E405757C978329338403CFFD86030315E40A62C431CEB92384096D34FD633315E40F601BDBFA3923840F1A7C64B37315E4046D736635C9238404C7C3DC13A315E4096ACB00615923840A750B4363E315E40E5812AAACD91384001252BAC41315E403557A44D869138405DF9A12145315E40852C1EF13E913840B7CD189748315E40D3019894F790384013A28F0C4C315E4023D71138B09038406D7606824F315E4073AC8BDB68903840C84A7DF752315E40C381057F21903840231FF46C56315E4012577F22DA8F38407EF36AE259315E40622CF9C5928F3840D70C96D737315E40756891ED7C8F38403126C1CC15315E4088A42915678F38408A3FECC1F3305E409BE0C13C518F3840E45817B7D1305E40AF1C5A643B8F38403E7242ACAF305E40C258F28B258F3840978B6DA18D305E40D5948AB30F8F3840F1A498966B305E40E8D022DBF98E38404BBEC38B49305E40FB0CBB02E48E3840A4D7EE8027305E400E49532ACE8E3840FEF0197605305E402185EB51B88E3840570A456BE32F5E4034C18379A28E3840B1237060C12F5E4048FD1BA18C8E38400B3D9B559F2F5E405B39B4C8768E38406456C64A7D2F5E406E754CF0608E3840BE6FF13F5B2F5E4081B1E4174B8E384017891C35392F5E4094ED7C3F358E384071A2472A172F5E40A72915671F8E3840CBBB721FF52E5E40BA65AD8E098E384024D59D14D32E5E40CDA145B6F38D38407EEEC809B12E5E40E0DDDDDDDD8D3840D807F4FE8E2E5E40F4197605C88D384031211FF46C2E5E4007560E2DB28D38408B3A4AE94A2E5E401A92A6549C8D3840E45375DE282E5E402DCE3E7C868D38403E6DA0D3062E5E40400AD7A3708D3840', 'meters', 0.427129038388443016, 0.427129038388443016, 7866, 'SAR', NULL, 'MONO', '29d939bef9560670c0856278a5e534d1655536768eb6d9c506326b53fb3d05da', '2017-08-13 06:59:02.147+00', 'TerraSAR-X', NULL, 'TerraSAR-X', NULL, 1, 12, NULL, NULL, NULL, 3031, NULL, NULL, 'UNCLASSIFIED', NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 18240,0 18240,7865 0,7865</coordinates></Image><Ground><coordinates>120.719166666667,24.5525 120.712777777778,24.5794444444444 120.765833333333,24.5880555555556 120.771111111111,24.5608333333333</coordinates></Ground></TiePointSet>', 'SIDD: 14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG', 1, NULL, 18241);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3032, 0, NULL, '2014-10-28 13:50:03+00', 359.952978689834026, NULL, 8, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.TIF', NULL, '0106000020E6100000010000000103000000010000006500000013CFEC9CBCA80140C6BAB9EF377848401608000865C001408020034B30784840184113730DD801403A864CA6287848401B7A26DEB5EF0140F3EB9501217848401DB339495E070240AD51DF5C1978484020EC4CB4061F024067B728B8117848402225601FAF360240211D72130A784840255E738A574E0240DA82BB6E02784840279786F5FF65024094E804CAFA7748402AD09960A87D02404E4E4E25F37748402C09ADCB5095024008B49780EB7748402F42C036F9AC0240C219E1DBE3774840317BD3A1A1C402407B7F2A37DC77484034B4E60C4ADC024035E57392D477484036EDF977F2F30240EF4ABDEDCC77484039260DE39A0B0340A9B00649C57748403C5F204E43230340621650A4BD7748403E9833B9EB3A03401C7C99FFB577484041D1462494520340D6E1E25AAE774840430A5A8F3C6A034090472CB6A677484046436DFAE48103404AAD75119F774840487C80658D9903400313BF6C977748404BB593D035B10340BD7808C88F7748404DEEA63BDEC8034077DE5123887748405027BAA686E0034031449B7E807748405260CD112FF80340EAA9E4D9787748400C49502342F80340EC1FC7A3C6764840C631D33455F80340EC95A96D147648407F1A564668F80340EE0B8C37627548403903D9577BF80340EF816E01B0744840F2EB5B698EF80340F1F750CBFD734840ACD4DE7AA1F80340F16D33954B73484066BD618CB4F80340F3E3155F997248401FA6E49DC7F80340F559F828E7714840D98E67AFDAF80340F5CFDAF2347148409377EAC0EDF80340F745BDBC827048404D606DD200F90340F8BB9F86D06F48400749F0E313F90340F93182501E6F4840BF3173F526F90340FAA7641A6C6E4840791AF6063AF90340FC1D47E4B96D4840330379184DF90340FE9329AE076D4840EDEBFB2960F90340FE090C78556C4840A7D47E3B73F903400080EE41A36B484060BD014D86F9034001F6D00BF16A48401AA6845E99F90340026CB3D53E6A4840D48E0770ACF9034003E2959F8C6948408D778A81BFF9034005587869DA68484047600D93D2F9034006CE5A3328684840004990A4E5F9034007443DFD75674840BA3113B6F8F9034009BA1FC7C3664840741A96C70BFA03400A30029111664840567AD15344E20340168E5A0E1A66484037DA0CE07CCA034020ECB28B22664840193A486CB5B203402B4A0B092B664840FB9983F8ED9A034035A8638633664840DCF9BE84268303404006BC033C664840BE59FA105F6B03404B641481446648409FB9359D9753034055C26CFE4C66484082197129D03B03406020C57B556648406379ACB5082403406A7E1DF95D66484045D9E741410C034076DC757666664840263923CE79F40240803ACEF36E66484008995E5AB2DC02408A98267177664840EAF899E6EAC4024095F67EEE7F664840CC58D57223AD0240A054D76B88664840ADB810FF5B950240ABB22FE9906648408F184C8B947D0240B51088669966484070788717CD650240C06EE0E3A166484052D8C2A3054E0240CACC3861AA6648403438FE2F3E360240D52A91DEB2664840159839BC761E0240E088E95BBB664840F7F77448AF060240EAE641D9C3664840D857B0D4E7EE0140F5449A56CC664840BBB7EB6020D7014000A3F2D3D46648409C1727ED58BF01400B014B51DD6648407E77627991A70140155FA3CEE5664840E0F590709DA701404F251F2C976748404274BF67A9A7014089EB9A8948684840A4F2ED5EB5A70140C4B116E7F968484006711C56C1A70140FE779244AB69484069EF4A4DCDA70140383E0EA25C6A4840CB6D7944D9A7014072048AFF0D6B48402DECA73BE5A70140ADCA055DBF6B48408F6AD632F1A70140E79081BA706C4840F1E8042AFDA701402157FD17226D48405367332109A801405C1D7975D36D4840B5E5611815A8014096E3F4D2846E48401764900F21A80140D0A97030366F48407AE2BE062DA801400A70EC8DE76F4840DC60EDFD38A80140453668EB987048403EDF1BF544A801407FFCE3484A714840A05D4AEC50A80140B9C25FA6FB71484002DC78E35CA80140F488DB03AD724840645AA7DA68A801402E4F57615E734840C6D8D5D174A801406815D3BE0F744840285704C980A80140A3DB4E1CC17448408BD532C08CA80140DDA1CA7972754840ED5361B798A80140176846D7237648404FD28FAEA4A80140512EC234D5764840B150BEA5B0A801408CF43D928677484013CFEC9CBCA80140C6BAB9EF37784840', 'meters', 2.25419200287971, 2.25419200287971, 7189, NULL, NULL, NULL, 'dd2199c319941bc9c41b605a65ea1b0cfab7d7dc0b4f3dede48a205a4576de21', '2017-08-13 06:59:40.553+00', NULL, NULL, NULL, NULL, 4, 11, NULL, NULL, NULL, 3032, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 8819,0 8819,7188 0,7188</coordinates></Image><Ground><coordinates>2.20739100072559,48.9392070443042 2.49618352802285,48.9333755842707 2.49709278036908,48.7974110851938 2.20682043868777,48.80388815858</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 8820);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3023, 0, NULL, '2014-09-05 16:54:00+00', 359.992449079742016, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.TIF', NULL, '0106000020E610000001000000010300000001000000650000009DDA832A525D614052EEC151388637C0422E7F00855D61403EF6812B3F8637C0E7817AD6B75D61402AFE4105468637C08CD575ACEA5D6140170602DF4C8637C0312971821D5E6140030EC2B8538637C0D67C6C58505E6140EF1582925A8637C07BD0672E835E6140DB1D426C618637C020246304B65E6140C7250246688637C0C5775EDAE85E6140B42DC21F6F8637C06ACB59B01B5F6140A03582F9758637C00F1F55864E5F61408C3D42D37C8637C0B472505C815F6140784502AD838637C059C64B32B45F6140654DC2868A8637C0FE194708E75F614051558260918637C0A36D42DE196061403D5D423A988637C048C13DB44C606140296502149F8637C0ED14398A7F606140156DC2EDA58637C092683460B2606140027582C7AC8637C037BC2F36E5606140EE7C42A1B38637C0DC0F2B0C18616140DA84027BBA8637C0816326E24A616140C68CC254C18637C026B721B87D616140B294822EC88637C0CB0A1D8EB06161409F9C4208CF8637C0705E1864E36161408BA402E2D58637C015B2133A1662614077ACC2BBDC8637C0BA050F104962614063B48295E38637C0158D3E1149626140305F50313F8837C071146E1249626140FD091ECD9A8937C0CB9B9D1349626140CAB4EB68F68A37C02723CD1449626140985FB904528C37C082AAFC1549626140640A87A0AD8D37C0DE312C174962614031B5543C098F37C039B95B1849626140FF5F22D8649037C094408B1949626140CB0AF073C09137C0EFC7BA1A4962614098B5BD0F1C9337C04B4FEA1B4962614066608BAB779437C0A6D6191D49626140330B5947D39537C0025E491E4962614000B626E32E9737C05DE5781F49626140CD60F47E8A9837C0B86CA820496261409A0BC21AE69937C013F4D7214962614067B68FB6419B37C06F7B07234962614034615D529D9C37C0CA02372449626140010C2BEEF89D37C0268A662549626140CEB6F889549F37C080119626496261409B61C625B0A037C0DC98C52749626140690C94C10BA237C03720F5284962614035B7615D67A337C092A7242A4962614002622FF9C2A437C0EE2E542B49626140D00CFD941EA637C048B6832C496261409CB7CA307AA737C0A43DB32D49626140696298CCD5A837C0627C8B5816626140C4014CCBCEA837C021BB6383E361614020A1FFC9C7A837C0DFF93BAEB06161407B40B3C8C0A837C09E3814D97D616140D5DF66C7B9A837C05D77EC034B616140317F1AC6B2A837C01BB6C42E186161408C1ECEC4ABA837C0DAF49C59E5606140E7BD81C3A4A837C098337584B2606140435D35C29DA837C057724DAF7F6061409DFCE8C096A837C015B125DA4C606140F89B9CBF8FA837C0D4EFFD041A606140543B50BE88A837C0922ED62FE75F6140AFDA03BD81A837C0516DAE5AB45F61400A7AB7BB7AA837C00FAC8685815F614065196BBA73A837C0CEEA5EB04E5F6140C0B81EB96CA837C08C2937DB1B5F61401B58D2B765A837C04B680F06E95E614076F785B65EA837C009A7E730B65E6140D19639B557A837C0C8E5BF5B835E61402C36EDB350A837C086249886505E614087D5A0B249A837C0456370B11D5E6140E37454B142A837C003A248DCEA5D61403E1408B03BA837C0C2E02007B85D614098B3BBAE34A837C0801FF931855D6140F4526FAD2DA837C03F5ED15C525D61404FF222AC26A837C08044CE5A525D61403BA0E137CBA637C0C22ACB58525D6140274EA0C36FA537C00311C856525D614012FC5E4F14A437C044F7C454525D6140FEA91DDBB8A237C085DDC152525D6140EA57DC665DA137C0C6C3BE50525D6140D5059BF201A037C008AABB4E525D6140C1B3597EA69E37C04990B84C525D6140AC61180A4B9D37C08A76B54A525D6140980FD795EF9B37C0CB5CB248525D614084BD9521949A37C00C43AF46525D61406F6B54AD389937C04E29AC44525D61405B191339DD9737C08F0FA942525D614047C7D1C4819637C0D0F5A540525D614032759050269537C011DCA23E525D61401E234FDCCA9337C052C29F3C525D614009D10D686F9237C093A89C3A525D6140F57ECCF3139137C0D58E9938525D6140E12C8B7FB88F37C016759636525D6140CCDA490B5D8E37C0575B9334525D6140B8880897018D37C098419032525D6140A436C722A68B37C0D9278D30525D61408FE485AE4A8A37C01B0E8A2E525D61407B92443AEF8837C05CF4862C525D6140664003C6938737C09DDA832A525D614052EEC151388637C0', 'meters', 2.01897441294104008, 2.01897441294104008, 7208, NULL, NULL, NULL, 'd5ae3a0b48d650dddf7eadd01e0e55f88193cf5921645c41803edc450c434079', '2017-08-13 06:51:17.595+00', NULL, NULL, NULL, NULL, 4, 11, NULL, NULL, NULL, 3023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 7916,0 7916,7207 0,7207</coordinates></Image><Ground><coordinates>138.916280038383,-23.5242968653168 139.071418790188,-23.5269101566413 139.071432924347,-23.6595123168976 138.916304024622,-23.6568400941199</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 7917);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3024, 0, NULL, '2009-02-05 00:02:01+00', 359.500877528232024, NULL, 11, 'ossimKakaduNitfReader', NULL, 'AS', false, 'uint', 'GEOEYE1', '0', NULL, 'nitf', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.ntf', 71.960000000000008, '0106000020E61000000100000001030000000100000065000000D4E147904B65624007A6D3553F6445C04A787361896562403721C84B406445C084EC92EBC965624029F55F5F4B6445C0DAE5E72F0B6662407E531215596445C0A8672F3148666240E98ECEE9566445C0B3E1E63E826662405D3F70D2496445C0623599ECBB666240D201D8633B6445C0D8E88C2AF6666240CB63FF142F6445C099897804326762405E3734B9286445C051412A3D6E6762401E60D4BB236445C018A9CCCCAA6762403B53C8FD1F6445C0B996F8C6E76762405AC133C41D6445C04A484CDB246862401DC7FBE71B6445C0DAD96D20626862409B8B93BA1A6445C01F4B0F8D9F686240CA78FF181A6445C0004576F0DC68624019635652196445C0D5AD328A1A69624073469F4B196445C0A371D70B58696240014ECDE9186445C0CA3AC5A49769624041C65D00206445C026620161DA6962402BEF353D326445C039A30714166A62403138844D2B6445C01E3200A1516A6240C44F2DDB236445C0E8B5CD598F6A6240D34C231F246445C05BFE1B1CCE6A6240868BBF07286445C07C2505820C6B6240251E61A02A6445C02B0FF1224A6B6240DBCE367C2A6445C0A7B01575486B6240B8ED9663F16445C0A11C91FD466B6240BBF6C215B96545C053FA66D5456B62403DB26FE7816645C0B5979B09466B624060DD33784F6745C0E0130D31476B6240D43BC14F206845C0AA2405F1476B6240180808BEEF6845C07E5F62D1476B6240D84B5E2CBC6945C096184FB6466B6240CD71E944856A45C01F5FAA11476B62409A40595D536B45C02F2E703A476B6240DDB940CA206C45C003F61A02476B6240D4B50BF1EC6C45C041811099476B6240A5D940D2BB6D45C03C8D0B05486B6240A471C3218A6E45C0D34C6F1B486B624007A78F53576F45C00C4C34FF476B62403B79EEDE237045C0DA09604A486B62401A7F19C2F17045C0F2049295486B6240E17F35A5BF7145C08A46CAE0486B6240737B42888D7245C0D8D7082C496B62405170406B5B7345C013C24D77496B6240895B2F4E297445C07A0CF25B4B6B6240BCDC5A5CFC7445C069606C6A4B6B62404D6CD575C97545C079F242594A6B6240C8B0A1F6927645C0979CA1A44A6B6240CE3B54D9607745C0C3CD06F04A6B62404C99F7BB2E7845C019B8D4870E6B62402ACEBE41337845C0222A9775D36A6240C746CC103C7845C02EDFA436986A6240D800425A447845C0FF52FF71596A6240FDDC1F53417845C0D1E21388196A62409FF0888D3A7845C094305AF2DD696240566DE2C1417845C0FCF72693A06962408E5C892C437845C078BC91746269624029D8B523427845C0FA2B5FD425696240BB4365F8457845C01C7276A1E8686240882952EC477845C033DA4839AA68624020EA3EE3457845C08B730EE96C686240C68D5F6F477845C0175C737A31686240AF2DEE354F7845C0355D96B5F5676240BE03D5E4557845C0895D3DDEB86762407EDB8405597845C054CEDD377C6762408CC5E6C95C7845C00DF575B03F676240BD95F9F6607845C0102028C800676240A58E2C245D7845C0C27BAED6C1666240F9CFC427597845C0420E5C1687666240FAA33D51637845C0CC78DE464C666240557346516D7845C07365AC2F0E66624064C45E306C7845C0185D4556D0656240CA14DFDB6B7845C09430B89992656240A46CC9E46B7845C0AAF19314526562405F52A45A627845C0AD6A8C9F52656240784E67F6967745C02E0E067A546562402A235F1ED07645C0EBB62A7E56656240FC845BE3097645C099FAF2C357656240B752F51E417545C0FDE9733553656240736DBC04647445C0A0586861526562400E508DE1937345C0DA6F4666526562405B8F40B5C67245C0CF3DC674536562406DC6E333FD7145C01BEBC89958656240F4906436427145C069B79DA4596562404A8AB4C3787045C0FA67370258656240F9A551CBA56F45C04D75390355656240A6C53BE9CD6E45C0D072F85052656240237AB508F76D45C0E52C0126516562401DD0A09A256D45C05B113BAF506562402147CFB1566C45C0CABAA06850656240206EB075886B45C02644E79E4F656240776C055BB86A45C052B48D285065624022256914ED6945C07F372E774F6562405F1FCF4E1D6945C081CB46A84C65624032A130BD456845C01BADA7B8476562404E40B23F666745C050E6E1E846656240405C99EA956645C09AC75AB34765624068ECBA85CB6545C0FB78335A4965624063EC495C046545C0D4E147904B65624007A6D3553F6445C0', 'meters', 2.00057105091077014, 2.00036638071255979, 8718, 'MS', NULL, 'MULTI', '64e98d4b4e381e24a98cf80a65b78c0178d693a46987198ff5a77983e537faed', '2017-08-13 06:51:57.6+00', 'GEOEYE1', NULL, 'OV05', NULL, 4, 11, 'GeoEye', NULL, NULL, 3024, NULL, NULL, 'UNCLASSIFIED', NULL, 'GA', NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 7671,0 7671,8717 0,8717</coordinates></Image><Ground><coordinates>147.165474071879,-42.783182838768 147.352799864596,-42.7825465457551 147.352897656716,-42.9389262160281 147.166269577935,-42.9405015280106</coordinates></Ground></TiePointSet>', '05FEB09OV05010005V090205M0001912264B220000100072M_001508507', 1, '1556', 7672);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3025, 0, NULL, '2014-09-05 16:53:54+00', 359.992451598874027, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.TIF', NULL, '0106000020E610000001000000010300000001000000650000009010C125525D6140CFEDC931388637C095D1F7FC845D6140DAB9B30B3F8637C09A922ED4B75D6140E5859DE5458637C0A05365ABEA5D6140F15187BF4C8637C0A5149C821D5E6140FC1D7199538637C0AAD5D259505E614007EA5A735A8637C0AF960931835E614012B6444D618637C0B5574008B65E61401E822E27688637C0BA1877DFE85E6140294E18016F8637C0BFD9ADB61B5F6140341A02DB758637C0C49AE48D4E5F61403FE6EBB47C8637C0CA5B1B65815F61404AB2D58E838637C0CF1C523CB45F6140567EBF688A8637C0D4DD8813E75F6140614AA942918637C0D99EBFEA196061406C16931C988637C0DF5FF6C14C60614077E27CF69E8637C0E4202D997F60614083AE66D0A58637C0E9E16370B26061408E7A50AAAC8637C0EEA29A47E560614099463A84B38637C0F363D11E18616140A412245EBA8637C0F92408F64A616140AFDE0D38C18637C0FEE53ECD7D616140BBAAF711C88637C003A775A4B0616140C676E1EBCE8637C00868AC7BE3616140D142CBC5D58637C00E29E35216626140DC0EB59FDC8637C013EA192A49626140E8DA9E79E38637C05E8C492B496261400B3DB31E3F8837C0A72E792C496261402D9FC7C39A8937C0F2D0A82D496261404F01DC68F68A37C03C73D82E496261407163F00D528C37C0861508304962614094C504B3AD8D37C0D0B7373149626140B6271958098F37C01B5A673249626140D9892DFD649037C064FC963349626140FBEB41A2C09137C0AF9EC634496261401D4E56471C9337C0F940F6354962614040B06AEC779437C043E325374962614062127F91D39537C08D85553849626140857493362F9737C0D727853949626140A8D6A7DB8A9837C021CAB43A49626140C938BC80E69937C06C6CE43B49626140EC9AD025429B37C0B50E143D496261400EFDE4CA9D9C37C000B1433E49626140315FF96FF99D37C04A53733F4962614053C10D15559F37C094F5A24049626140752322BAB0A037C0DE97D241496261409885365F0CA237C0293A024349626140BAE74A0468A337C072DC314449626140DD495FA9C3A437C0BD7E614549626140FFAB734E1FA637C00721914649626140210E88F37AA737C051C3C0474962614044709C98D6A837C0B42E5D7116626140AD851B97CFA837C0179AF99AE3616140189B9A95C8A837C07A0596C4B061614082B01994C1A837C0DE7032EE7D616140ECC59892BAA837C041DCCE174B61614055DB1791B3A837C0A4476B4118616140BFF0968FACA837C007B3076BE56061402A06168EA5A837C06B1EA494B2606140941B958C9EA837C0CE8940BE7F606140FE30148B97A837C032F5DCE74C6061406746938990A837C0946079111A606140D15B128889A837C0F8CB153BE75F61403C71918682A837C05B37B264B45F6140A68610857BA837C0BFA24E8E815F61400F9C8F8374A837C0210EEBB74E5F614079B10E826DA837C0857987E11B5F6140E3C68D8066A837C0E8E4230BE95E61404DDC0C7F5FA837C04C50C034B65E6140B8F18B7D58A837C0AEBB5C5E835E614021070B7C51A837C01227F987505E61408B1C8A7A4AA837C0759295B11D5E6140F531097943A837C0D9FD31DBEA5D61405F4788773CA837C03B69CE04B85D6140C95C077635A837C09FD46A2E855D6140337286742EA837C002400758525D61409D87057327A837C050710456525D6140054488F5CBA637C09DA20154525D61406D000B7870A537C0EAD3FE51525D6140D6BC8DFA14A437C03805FC4F525D61403E79107DB9A237C08536F94D525D6140A73593FF5DA137C0D267F64B525D61400FF2158202A037C02099F349525D614077AE9804A79E37C06DCAF047525D6140E06A1B874B9D37C0BAFBED45525D614048279E09F09B37C0082DEB43525D6140B1E3208C949A37C0555EE841525D614019A0A30E399937C0A28FE53F525D6140825C2691DD9737C0F0C0E23D525D6140EA18A913829637C03DF2DF3B525D614052D52B96269537C08B23DD39525D6140BB91AE18CB9337C0D854DA37525D6140234E319B6F9237C02586D735525D61408C0AB41D149137C073B7D433525D6140F4C636A0B88F37C0C0E8D131525D61405C83B9225D8E37C00D1ACF2F525D6140C53F3CA5018D37C05B4BCC2D525D61402DFCBE27A68B37C0A87CC92B525D614096B841AA4A8A37C0F5ADC629525D6140FE74C42CEF8837C043DFC327525D6140673147AF938737C09010C125525D6140CFEDC931388637C0', 'meters', 0.504743593775879962, 0.504743593775879962, 28832, NULL, NULL, NULL, 'e18b8b36ce0e907709409a8261785fbfe7126e910932c0d1e7c4edc688fefec6', '2017-08-13 06:54:17.836+00', NULL, NULL, NULL, NULL, 1, 13, NULL, NULL, NULL, 3025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 31667,0 31667,28831 0,28831</coordinates></Image><Ground><coordinates>138.916277768211,-23.5242949598303 139.071431208242,-23.5269084942655 139.0714453473,-23.6595244771891 138.916301740799,-23.6568519485951</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 31668);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3026, 0, NULL, '2009-02-05 00:02:01+00', 359.502176358418978, NULL, 11, 'ossimKakaduNitfReader', NULL, 'AS', false, 'uint', 'GEOEYE1', '0', NULL, 'nitf', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.ntf', 71.960000000000008, '0106000020E61000000100000001030000000100000065000000F95744774B656240C1949B0C3F6445C01D47244D89656240338BE902406445C0F6F250DAC96562407DFAB6104B6445C0E3BA21230B6662402C4BF7C5586445C05B51B62948666240B8CA409D566445C082F2113C82666240E80CF785496445C032B374EEBB666240EC67A0173B6445C0E4A30B31F6666240E5B9D9C82E6445C019E5A30F32676240FCDB446D286445C046FD0C4D6E67624016AC4270236445C0AC6840E1AA676240D1B207B21F6445C0325F0AE0E767624056D073781D6445C08F24C9F82468624082DE829B1B6445C07ECFAB42626862403A259A6E1A6445C0EBD1CCB39F686240175597CC196445C00258241CDD686240482A1707196445C0DBB885BA1A69624085B77600196445C040CA724258696240D9F69BA4186445C050ACC9DF97696240515065BA1F6445C0F95B66A3DA696240A53F0A01326445C04CC81A54166A62402F4F95F82A6445C0882559E6516A6240189E9488236445C0C0C077A78F6A62407771A2D9236445C027902D6ECE6A62404F196FC1276445C003115DD80C6B6240A67ACC582A6445C061BDB67C4A6B6240DC0267302A6445C0F58B38CF486B624056E58717F16445C069913F58476B6240779F13CAB86545C05BA06B2F466B62400809E997816645C091D67363466B6240DE5C89264F6745C0547BE58B476B624019ECFDFF1F6845C0E12FAB4D486B62401B6AE772EF6845C046E0AD2E486B62402620E1E1BB6945C0F7716511476B624048BD54F1846A45C0D28CDD6A476B6240C124CF01536B45C0E4A1F693476B624038FB486E206C45C0911FF15B476B62400BF99894EC6C45C07D243AF4476B62409042B678BB6D45C09223C960486B6240A1B998C8896E45C0F097B776486B62404A5E4FF7566F45C05291E058486B624025D7CB7B237045C09E0B0EA4486B62402BE4735DF17045C045C341EF486B624082EC0C3FBF7145C074C17B3A496B6240E6EF96208D7245C05A0FBC85496B6240A2EC11025B7345C025B602D1496B624090DF7DE3287445C028AB80B14B6B6240483AB3E2FB7445C0566169C24B6B624042958702C97545C0C11BFDB24A6B624001486787927645C005825DFE4A6B6240F7D69668607745C0276FC4494B6B62408136B7492E7845C046CBD0DB0E6B62406B0FECCB327845C0F9663FC3D36A624037038A953B7845C05AFC3383986A6240D7BD52EA437845C0C6A018BC596A6240461438EA407845C02947B6C8196A6240D9710F153A7845C0EF3A1E2EDE696240ECC19F48417845C09E0F95CCA06962406D68BBBA427845C0F282F7A9626962406FAFDEB3417845C01F6A76032669624015461483457845C0D63269CDE8686240154CE37B477845C080967C61AA6862407E10BC75457845C0FED3490A6D686240E1A224FA467845C09F111D973168624059DEE5C04E7845C08B7F63CEF5676240ECE35972557845C096AD09F3B86762404EF12095587845C078AA36487C6762401FA01D5A5C7845C03A495CBC3F676240CC0FCF87607845C0EA4F74D00067624031A575B85C7845C0896995D9C16662407DB377B9587845C0099D551487666240DF61F3E1627845C0BAF1A4404C66624082F975E36C7845C0DFE9D9250E66624054440FC66B7845C09CE6E447D06562408192D0716B7845C029C1D4859265624047B1B4776B7845C0DFF43CFA51656240CE2942E7617845C003F4C084526562406E4DF382967745C02F7FF35F54656240DB04ECAECF7645C09CE6F3635665624022C1EE74097645C0574BDBA657656240364004A8407545C088F99917536562407B338D8C637445C0AFB6A4475265624023B72379937345C03B59554E52656240605AC054C67245C0A142CA5F53656240D9325DDFFC7145C0E937098258656240C7CAADD9417145C0F0C5D989596562401E05CC5D787045C0EA7C7AE65765624029A26863A56F45C0E28F76E954656240C415D889CD6E45C0C578BE36526562406F831EA9F66D45C0D72BCA0C51656240E8802A40256D45C0821B85965065624008B8AB5A566C45C0B61CAA4F506562407420241F886B45C01611F6854F65624015C70C06B86A45C0EEC1FE0E506562407522B3BEEC6945C0A9D7135C4F656240B15FEDF41C6945C088FEE58B4C656240B7551260456845C04D68059F47656240D71821EE656745C01357B7CE46656240BD4B8D98956645C04E34F69947656240097A0E38CB6545C033C4344149656240266F9D11046545C0F95744774B656240C1949B0C3F6445C0', 'meters', 0.500142563169431953, 0.500091643163635968, 34868, 'VIS', NULL, 'MONO', '0ee4bbb5fb8847fee76b24410e4be8cff363dc91323ecebd9a2062948f173ab7', '2017-08-13 06:55:08.312+00', 'GEOEYE1', NULL, 'OV05', NULL, 1, 13, 'GeoEye', NULL, NULL, 3026, NULL, NULL, 'UNCLASSIFIED', NULL, 'AA', NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 30693,0 30693,34867 0,34867</coordinates></Image><Ground><coordinates>147.165462144359,-42.7831741103814 147.352842671312,-42.7825375082955 147.352940448437,-42.938912596187 147.166257018142,-42.9404877732337</coordinates></Ground></TiePointSet>', '05FEB09OV05010005V090205P0001912264B220000100282M_001508507', 1, '1556', 30694);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3027, 0, NULL, '2003-02-05 15:10:53+00', 359.776452111360982, NULL, 11, 'ossimNitfTileSource', NULL, 'IZ', false, 'uint', 'SPACE IMAGING SATELLITE', '0', NULL, 'nitf', '/data/s3/2009/02/05/00/po_106005_pan_0000000.ntf', NULL, '0106000020E610000001000000010300000001000000650000009DF4A1DCFB45464051B8D99827A440403F3151B28F464640079DCA2128A44040277208882347464024E85BA928A440404DA3C75DB747464063998D2F29A44040ACB08E334B4846408CB05FB429A440404638AB13DF484640B8039C4F2AA440408FCD14F472494640336C3BEA2AA44040868961C4064A464079FE235E2BA440407D39DFC59A4A46402F0711432CA44040E322478A2E4B46402DD67F982CA440404374843FC24B46406ECABFC82CA440403580AB35564C464001FA8C8F2DA44040B5CD9304EA4C4640D63AEDF82DA44040AE5354CD7D4D4640D0783B522EA440401EC455A3114E4640B3514FC92EA440405C345E79A54E4640788D033F2FA44040EAF02B3B394F4640C57F17832FA44040CB0E5211CD4F464061AF0EF62FA44040ABBBA0FB605046401490E29730A44040DF62C4D1F45046407555180831A44040BEA5EEA788514640C77CEE7631A4404042701F7E1C524640DE0565E431A4404064AE5654B052464097F07B5032A440400C16C2164453464088E4018B32A4404052EA15EDD75346400EC55BF432A4404043F66FC36B5446405507565C33A44040DC0C8C3E6C544640EB1EEA2FB7A3404020D2F6A56C544640C7C549D33AA34040B5BDB2346D544640905103D7BEA240406DA4B0A46D544640CA0C6C8F42A24040C8F620176E5446406C56D54DC6A140404C5C23926E544640D5324F214AA140401BF5AC196F544640B202A213CEA04040FCAE16886F54464075ED33C851A0404000CF9D167054464034E5DDCBD59F404025B58D91705446405950599F599F4040F77FE01F715446407024B2A2DD9E4040A9035C8771544640FD294146619E40409D6C3A02725446405B98AD19E59D40400FD2906972544640F195D6BC689D40401044E8D072544640F60FF85FEC9C40409A12BC4B7354464084FD5233709C4040376FF2AF735446407641A8CEF39B404064C6DD2D74544640765EB6A9779B4040198CA3A8745446401C0B017DFB9A4040697F632375544640F8B746507F9A4040497FB38A75544640092140F3029A4040FAEFD118765446401512C3F6869940405E2B1D8076544640D4F5AF990A9940405A1A290E77544640816C2B9D8E984040EEF5CB8877544640BE19587012984040CD6329E3E3534640D73EF21C12984040EA69DA1950534640E7D58A6F119840403A46196CBC52464085D93C0511984040037FFAD1285246403385E5C9109840405743AA10955146401EDD852C10984040C34BB87601514640E52F76EE0F9840402E7655B56D504640BB87554E0F984040452F8B14DA4F4640049C73FC0E9840406A7E1B5A464F4640D8DAAB6A0E98404046637FD4B24E4640B5678D570E984040EE2E08131F4E4640E0F0ECB10D984040273878518B4D4640E0D6E90A0D984040A98150CCF74C46405047BDF30C98404097A73433644C4640A56BD0AA0C9840403FD43F9AD04B4640DC8089600C984040DDECAC9B3C4B4640BE83BE220B98404003F5B602A94A4640B7CEB8D50A984040D970094D154A4640330B0B430A984040B8898BA681494640359CDDD2099840406C5FF2FAED4846405C47255509984040AF43B34D5A484640542419D20898404022CB95A0C64746405C4AEB4D08984040E54773F332474640FFCE40C8079840400370325B9F464640DCD2B77107984040013346990B464640BADFD0B8069840400AC3F5F40A464640E208E3E2829840400FF57E520A46464027074C11FF9840404DB524AF09464640C4CFB23D7B994040D7EFDDF0084646405485E22BF799404068EF4153084646409F9EB465739A4040986FB8DE0746464078C166FEEF9A40402374394B0746464081898C4F6C9B4040AAC23A80064646402C42B920E89B4040469E66E205464640DF77265A649C4040CBF3703605464640E2AF1273E09C4040DD6BCA9204464640A3EB309F5C9D4040191A1CEF0346464042254ACBD89D404032947C6003464640C949D027559E40406124C2BC024646400845DE53D19E4040C9E9FF1802464640663EE77F4D9F40400EDE568A01464640637359DCC99F40409E1E8FE6004646401750660846A04040C1B1C4420046464077DC7934C2A04040E47CF29EFF454640846688603EA14040555A4710FF454640714EFBBCBAA14040CC0B696CFE454640BD9AFEE836A240404DF482C8FD45464004E5FC14B3A2404082139524FD454640542DF6402FA3404010699F80FC454640BC73EA6CABA340409DF4A1DCFB45464051B8D99827A44040', 'meters', 1.00038647439665995, 1.00038775526786994, 10504, 'VIS', '0000000000', 'MONO', '96b26313af1ac8a77f870bd09b7c9f5fcecda80d897cfcf6d30b41a29a6a765e', '2017-08-13 06:55:57.775+00', 'SPACE IMAGING SATELLITE', NULL, 'SI_CARTERRA_01', NULL, 1, 12, 'Space Imaging', NULL, NULL, 3027, NULL, NULL, 'UNCLASSIFIED', NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 10503,0 10503,10503 0,10503</coordinates></Image><Ground><coordinates>44.5467487135695,33.2824584067427 44.6595386788072,33.2828174037992 44.6598978992368,33.1880627088717 44.5472289650697,33.1877051372425</coordinates></Ground></TiePointSet>', '20030205151053SI_CARTERRA_0101684AA00000 00100001AA04200042P  GC   UCT', 1, '0427', 10504);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3033, 0, NULL, '2016-12-09 12:52:55+00', 0.0505376500496874034, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.TIF', NULL, '0106000020E61000000100000001030000000100000065000000E0633851C6C70140B56069EFBB6D4840FA6FDAF956D701400A65BFBAC26D4840147C7CA2E7E601405E691586C96D48402F881E4B78F60140B36D6B51D06D48404994C0F3080602400872C11CD76D484063A0629C991502405C7617E8DD6D48407DAC04452A250240B17A6DB3E46D484097B8A6EDBA340240067FC37EEB6D4840B2C448964B4402405A83194AF26D4840CCD0EA3EDC530240AF876F15F96D4840E6DC8CE76C630240048CC5E0FF6D484000E92E90FD72024058901BAC066E48401AF5D0388E820240AD9471770D6E4840350173E11E9202400299C742146E48404F0D158AAFA10240569D1D0E1B6E48406919B73240B10240ABA173D9216E4840832559DBD0C0024000A6C9A4286E48409D31FB8361D0024054AA1F702F6E4840B83D9D2CF2DF0240A9AE753B366E4840D2493FD582EF0240FEB2CB063D6E4840EC55E17D13FF024053B721D2436E484006628326A40E0340A7BB779D4A6E4840206E25CF341E0340FCBFCD68516E48403B7AC777C52D034051C42334586E484055866920563D0340A5C879FF5E6E48406F920BC9E64C0340FACCCFCA656E4840B7BB4E20D14C034006C291E8DD6D4840FEE49177BB4C034012B75306566D4840450ED5CEA54C03401FAC1524CE6C48408D371826904C03402BA1D741466C4840D4605B7D7A4C03403896995FBE6B48401C8A9ED4644C0340448B5B7D366B484064B3E12B4F4C034050801D9BAE6A4840ABDC2483394C03405D75DFB8266A4840F20568DA234C0340696AA1D69E694840392FAB310E4C0340755F63F4166948408158EE88F84B0340815425128F684840C98131E0E24B03408E49E72F0768484010AB7437CD4B03409A3EA94D7F67484058D4B78EB74B0340A6336B6BF76648409FFDFAE5A14B0340B3282D896F664840E6263E3D8C4B0340BF1DEFA6E76548402E508194764B0340CC12B1C45F6548407679C4EB604B0340D80773E2D7644840BDA207434B4B0340E4FC34005064484004CC4A9A354B0340F0F1F61DC86348404CF58DF11F4B0340FCE6B83B40634840931ED1480A4B034009DC7A59B8624840DB4714A0F44A034015D13C7730624840227157F7DE4A034021C6FE94A86148406A9A9A4EC94A03402EBBC0B2206148409FB90B2B5E3B03400BD731391B614840D5D87C07F32B0340E9F2A2BF156148400AF8EDE3871C0340C60E1446106148403F175FC01C0D0340A22A85CC0A6148407436D09CB1FD02408046F65205614840A955417946EE02405D6267D9FF604840DF74B255DBDE02403A7ED85FFA6048401494233270CF0240179A49E6F460484048B3940E05C00240F4B5BA6CEF6048407ED205EB99B00240D1D12BF3E9604840B3F176C72EA10240AEED9C79E4604840E810E8A3C39102408C090E00DF6048401E3059805882024069257F86D9604840524FCA5CED7202404541F00CD4604840876E3B3982630240235D6193CE604840BD8DAC15175402400079D219C9604840F2AC1DF2AB440240DD9443A0C360484028CC8ECE40350240BAB0B426BE6048405CEBFFAAD525024097CC25ADB8604840910A71876A16024074E89633B3604840C729E263FF060240520408BAAD604840FC48534094F701402F207940A86048403168C41C29E801400B3CEAC6A2604840668735F9BDD80140E9575B4D9D6048409BA6A6D552C90140C673CCD397604840045250F942C90140875E43641E6148406DFDF91C33C901404949BAF4A4614840D6A8A34023C901400B3431852B6248403F544D6413C90140CD1EA815B2624840A8FFF68703C901408F091FA63863484012ABA0ABF3C8014051F49536BF6348407B564ACFE3C8014013DF0CC745644840E401F4F2D3C80140D5C98357CC6448404DAD9D16C4C8014097B4FAE752654840B658473AB4C80140599F7178D96548402004F15DA4C801401A8AE8086066484089AF9A8194C80140DC745F99E6664840F25A44A584C801409E5FD6296D6748405B06EEC874C80140604A4DBAF3674840C4B197EC64C801402235C44A7A6848402D5D411055C80140E41F3BDB006948409708EB3345C80140A60AB26B8769484000B4945735C8014068F528FC0D6A4840695F3E7B25C801402AE09F8C946A4840D20AE89E15C80140EBCA161D1B6B48403BB691C205C80140ADB58DADA16B4840A4613BE6F5C701406FA0043E286C48400E0DE509E6C70140318B7BCEAE6C484077B88E2DD6C70140F375F25E356D4840E0633851C6C70140B56069EFBB6D4840', 'meters', 0.505999706471342958, 0.505999706471342958, 22696, NULL, NULL, NULL, '40db8ccac66fa1494559adcf9b726fd8120ae88938ac36b227762abd63ca2022', '2017-08-13 07:01:27.772+00', NULL, NULL, NULL, NULL, 1, 13, NULL, NULL, NULL, 3033, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 27445,0 27445,22695 0,22695</coordinates></Image><Ground><coordinates>2.22254622891749,48.8572978271999 2.41254956308904,48.8624814524319 2.41151677522003,48.758810371501 2.22330252566173,48.7546334026625</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 27446);
INSERT INTO raster_entry (id, version, access_date, acquisition_date, azimuth_angle, be_number, bit_depth, class_name, cloud_cover, country_code, crosses_dateline, data_type, description, entry_id, exclude_policy, file_type, filename, grazing_angle, ground_geom, gsd_unit, gsdx, gsdy, height, image_category, image_id, image_representation, index_id, ingest_date, isorce, keep_forever, mission_id, niirs, number_of_bands, number_of_res_levels, organization, other_tags_xml, product_id, raster_data_set_id, receive_date, release_id, security_classification, security_code, sensor_id, style_id, sun_azimuth, sun_elevation, target_id, tie_point_set, title, valid_model, wac_code, width) VALUES (3034, 0, NULL, '2016-12-09 12:52:48+00', 0.0760568538431306007, NULL, 11, 'ossimTiffTileSource', NULL, NULL, false, 'uint', NULL, '0', NULL, 'tiff', '/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.TIF', NULL, '0106000020E610000001000000010300000001000000650000008D507BDB80C601404C29FCE9587648404367235132D6014020C5A3D160764840F87DCBC6E3E50140F4604BB968764840AE94733C95F50140C7FCF2A07076484063AB1BB2460502409B989A887876484019C2C327F81402406F34427080764840CED86B9DA924024043D0E9578876484084EF13135B340240166C913F907648403906BC880C440240EA07392798764840EF1C64FEBD530240BEA3E00EA0764840A5330C746F630240923F88F6A77648405A4AB4E92073024066DB2FDEAF76484010615C5FD28202403977D7C5B7764840C57704D5839202400D137FADBF7648407B8EAC4A35A20240E1AE2695C776484030A554C0E6B10240B54ACE7CCF764840E6BBFC3598C1024088E67564D77648409CD2A4AB49D102405C821D4CDF76484051E94C21FBE00240301EC533E77648400700F596ACF0024004BA6C1BEF764840BC169D0C5E000340D8551403F7764840722D45820F100340ABF1BBEAFE7648402744EDF7C01F03407F8D63D206774840DD5A956D722F034053290BBA0E77484092713DE3233F034027C5B2A1167748404888E558D54E0340FA605A891E774840B5378FC4BA4E0340652714109576484022E73830A04E0340D0EDCD960B7648408F96E29B854E03403BB4871D82754840FC458C076B4E0340A67A41A4F874484069F53573504E03401041FB2A6F744840D6A4DFDE354E03407B07B5B1E57348404354894A1B4E0340E6CD6E385C734840B00333B6004E0340519428BFD27248401DB3DC21E64D0340BC5AE245497248408B62868DCB4D034027219CCCBF714840F91130F9B04D034093E755533671484066C1D964964D0340FEAD0FDAAC704840D37083D07B4D03406874C9602370484040202D3C614D0340D33A83E7996F4840ADCFD6A7464D03403E013D6E106F48401A7F80132C4D0340A9C7F6F4866E4840872E2A7F114D0340148EB07BFD6D4840F4DDD3EAF64C03407F546A02746D4840618D7D56DC4C0340EA1A2489EA6C4840CE3C27C2C14C034055E1DD0F616C48403BECD02DA74C0340BFA79796D76B4840A89B7A998C4C03402A6E511D4E6B4840154B2405724C034095340BA4C46A484082FACD70574C034000FBC42A3B6A4840EFA977DC3C4C03406BC17EB1B16948406E7490B9B73C0340C67B6045AB694840EE3EA996322D0340203642D9A46948406D09C273AD1D03407AF0236D9E694840EDD3DA50280E0340D4AA0501986948406C9EF32DA3FE02402F65E79491694840EC680C0B1EEF0240891FC9288B6948406B3325E898DF0240E3D9AABC84694840EBFD3DC513D002403D948C507E6948406AC856A28EC00240974E6EE477694840E9926F7F09B10240F208507871694840695D885C84A102404CC3310C6B694840E827A139FF910240A67D13A06469484068F2B9167A8202400038F5335E694840E7BCD2F3F47202405BF2D6C7576948406787EBD06F630240B4ACB85B51694840E55104AEEA5302400E679AEF4A694840651C1D8B6544024068217C8344694840E4E63568E0340240C2DB5D173E69484063B14E455B2502401D963FAB37694840E37B6722D61502407750213F31694840624680FF50060240D10A03D32A694840E21099DCCBF601402BC5E4662469484061DBB1B946E70140867FC6FA1D694840E1A5CA96C1D70140E039A88E176948406070E3733CC801403AF4892211694840BEDF78B52AC80140A1D74620996948401C4F0EF718C8014008BB031E216A48407ABEA33807C801406F9EC01BA96A4840D82D397AF5C70140D6817D19316B4840369DCEBBE3C701403E653A17B96B4840940C64FDD1C70140A548F714416C4840F27BF93EC0C701400C2CB412C96C484050EB8E80AEC70140730F7110516D4840AE5A24C29CC70140DAF22D0ED96D48400CCAB9038BC7014041D6EA0B616E48406A394F4579C70140A8B9A709E96E4840C8A8E48667C701400F9D6407716F484026187AC855C7014077802105F96F484084870F0A44C70140DE63DE0281704840E1F6A44B32C7014045479B00097148403F663A8D20C70140AC2A58FE907148409DD5CFCE0EC70140130E15FC18724840FB446510FDC601407AF1D1F9A072484059B4FA51EBC60140E1D48EF728734840B7239093D9C6014048B84BF5B0734840159325D5C7C60140B09B08F3387448407302BB16B6C60140177FC5F0C0744840D1715058A4C601407E6282EE487548402FE1E59992C60140E5453FECD07548408D507BDB80C601404C29FCE958764840', 'meters', 0.505682160220044974, 0.505682160220044974, 22908, NULL, NULL, NULL, 'e895ffa9aafdd1d853aea3345c1513da7f30d36c75350973d0e5b73e17e3c420', '2017-08-13 07:03:31.79+00', NULL, NULL, NULL, NULL, 1, 13, NULL, NULL, NULL, 3034, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '<TiePointSet><Image><coordinates>0,0 27703,0 27703,22907 0,22907</coordinates></Image><Ground><coordinates>2.22192546339108,48.9245884400612 2.41349286509015,48.9306194011023 2.41222545852838,48.8257352703975 2.22277155435408,48.8208354161838</coordinates></Ground></TiePointSet>', NULL, 1, NULL, 27704);


--
-- Data for Name: raster_entry_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6071, 0, '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.ovr', 3029, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6072, 0, '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.his', 3029, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6073, 0, '/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.ovr', 3030, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6074, 0, '/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.his', 3030, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6075, 0, '/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.ovr', 3031, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6076, 0, '/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.his', 3031, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6077, 0, '/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.ovr', 3032, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6078, 0, '/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.his', 3032, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6079, 0, '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.ovr', 3033, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6080, 0, '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.his', 3033, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6081, 0, '/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.ovr', 3034, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6082, 0, '/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.his', 3034, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6083, 0, '/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.ovr', 3035, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6084, 0, '/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.his', 3035, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6091, 0, '/data/s3/msp/Stereo/test/A.ovr', 3038, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6092, 0, '/data/s3/msp/Stereo/test/A.his', 3038, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6093, 0, '/data/s3/msp/Stereo/test/B.ovr', 3039, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6094, 0, '/data/s3/msp/Stereo/test/B.his', 3039, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6059, 0, '/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.ovr', 3023, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6060, 0, '/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.his', 3023, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6061, 0, '/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.ovr', 3024, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6062, 0, '/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.his', 3024, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6063, 0, '/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.ovr', 3025, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6064, 0, '/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.his', 3025, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6085, 0, 's3://o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ovr', 3036, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6086, 0, 's3://o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.his', 3036, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6065, 0, '/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.ovr', 3026, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6066, 0, '/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.his', 3026, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6067, 0, '/data/s3/2009/02/05/00/po_106005_pan_0000000.ovr', 3027, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6068, 0, '/data/s3/2009/02/05/00/po_106005_pan_0000000.his', 3027, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6069, 0, '/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.ovr', 3028, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6070, 0, '/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.his', 3028, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6087, 0, 's3://o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.omd', 3036, 'omd');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6088, 0, '/s3/o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ovr', 3037, 'overview');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6089, 0, '/s3/o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.his', 3037, 'histogram');
INSERT INTO raster_entry_file (id, version, name, raster_entry_id, type) VALUES (6090, 0, '/s3/o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.omd', 3037, 'omd');


--
-- Name: raster_entry_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raster_entry_file_id_seq', 6094, true);


--
-- Name: raster_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raster_entry_id_seq', 3039, true);


--
-- Data for Name: raster_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3035, 0, 'nitf', '/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.ntf', 3035, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3036, 0, 'nitf', 's3://o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ntf', 3036, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3037, 0, 'nitf', '/s3/o2-test-data/direct-test/celtic/007/po_105215_pan_0000000.ntf', 3037, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3038, 0, 'nitf', '/data/s3/msp/Stereo/test/A.NTF', 3038, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3039, 0, 'nitf', '/data/s3/msp/Stereo/test/B.NTF', 3039, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3023, 0, 'tiff', '/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.TIF', 3023, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3024, 0, 'nitf', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.ntf', 3024, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3025, 0, 'tiff', '/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.TIF', 3025, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3026, 0, 'nitf', '/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.ntf', 3026, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3027, 0, 'nitf', '/data/s3/2009/02/05/00/po_106005_pan_0000000.ntf', 3027, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3028, 0, 'tiff', '/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.TIF', 3028, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3029, 0, 'tiff', '/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.TIF', 3029, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3030, 0, 'tiff', '/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.tif', 3030, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3031, 0, 'nitf', '/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.ntf', 3031, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3032, 0, 'tiff', '/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.TIF', 3032, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3033, 0, 'tiff', '/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.TIF', 3033, 'main');
INSERT INTO raster_file (id, version, format, name, raster_data_set_id, type) VALUES (3034, 0, 'tiff', '/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.TIF', 3034, 'main');


--
-- Name: raster_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raster_file_id_seq', 3039, true);


--
-- Data for Name: repository; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: repository_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('repository_id_seq', 1, false);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: rdsadmin
--



--
-- Data for Name: stream_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stream_definitions (definition_name, definition) VALUES ('omar-dropbox', 'omar-scdf-sqs | omar-scdf-aggregator | log');


--
-- Data for Name: task_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: task_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: task_execution_params; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: task_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('task_seq', 1, false);


--
-- Data for Name: task_task_batch; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tie_point; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tie_point (id, version, col, covariance, dx, dy, lat, lon, point_id, rho, "row", sigma_column, sigma_row, x, y, z) VALUES (103, 0, 17087.1275533595253, NULL, NULL, NULL, NULL, NULL, '12081243641', NULL, 8042.72311000682384, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tie_point (id, version, col, covariance, dx, dy, lat, lon, point_id, rho, "row", sigma_column, sigma_row, x, y, z) VALUES (104, 0, 15759.1054231533544, NULL, NULL, NULL, NULL, NULL, '12081245917', NULL, 16744.6875956939039, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tie_point (id, version, col, covariance, dx, dy, lat, lon, point_id, rho, "row", sigma_column, sigma_row, x, y, z) VALUES (106, 0, 18312.2535525530257, NULL, NULL, NULL, NULL, NULL, '12081243641', NULL, 7539.29269733125238, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tie_point (id, version, col, covariance, dx, dy, lat, lon, point_id, rho, "row", sigma_column, sigma_row, x, y, z) VALUES (107, 0, 16949.5019852555124, NULL, NULL, NULL, NULL, NULL, '12081245917', NULL, 15473.1383923969952, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: tie_point_generation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tie_point_generation_image; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: triangulation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO triangulation (id, version, finish, name, photo_block_id, report, start, submitted) VALUES (101, 1, '2017-07-12 12:12:51.003', '1499861566874_Triangulation', 108, 'TRIANGULATION RESULTS

   A POSTERIORI REFERENCE VARIANCE IS 0.0114 WITH 2 DEGREES OF FREEDOM

GROUND POINTS

12081243641
 X:  4633488.7825 m
 Y:  1032050.8150 m
 Z:  4245730.9280 m
 LAT:     42.000630 deg
 LON:     12.556928 deg
 HGT:      112.2794 m
 COVARIANCE MATRIX (m): 
          7.7858       -0.7483        7.3108
         -0.7483        1.5864       -0.8569
          7.3108       -0.8569       10.3214
 COVARIANCE MATRIX ENU (m): 
          2.1970       -0.4691       -3.1044
         -0.4691        2.0011        2.2908
         -3.1044        2.2908       15.4955
 CE90:        3.1147 m
 LE90:        6.4749 m

12081245917
 X:  4636479.7003 m
 Y:  1032020.1686 m
 Z:  4242465.0425 m
 LAT:     41.961232 deg
 LON:     12.548724 deg
 HGT:       93.0362 m
 COVARIANCE MATRIX (m): 
          7.7770       -0.7538        7.2904
         -0.7538        1.5883       -0.8624
          7.2904       -0.8624       10.2881
 COVARIANCE MATRIX ENU (m): 
          2.2002       -0.4698       -3.1056
         -0.4698        2.0020        2.2863
         -3.1056        2.2863       15.4512
 CE90:        3.1162 m
 LE90:        6.4656 m

NO BLUNDERS DETECTED

DISTANCES

    POINT NAME    POINT NAME    DISTANCE(m)     CE(m)     LE(m)  SIGMA(m)
   12081243641   12081245917      4428.6044    2.1474    4.3373    0.9474

POINT RESIDUALS

   IMAGE: 19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                    

       POINT NAME         CSM ROW       CSM COLUMN      ROW RESIDUAL         COLUMN RESIDUAL
  12081243641           8042.7231   17087.1276      -0.0299 pixels      -0.1051 pixels
  12081245917          16744.6876   15759.1054       0.0391 pixels       0.1370 pixels

   FIT RESIDUALS''            0.0024        0.0084
   DISPERSION MATRIX:        0.0084        0.0293

   IMAGE: 19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                    

       POINT NAME         CSM ROW       CSM COLUMN      ROW RESIDUAL         COLUMN RESIDUAL
  12081243641           7539.2927   18312.2536       0.0228 pixels       0.1071 pixels
  12081245917          15473.1384   16949.5020      -0.0296 pixels      -0.1396 pixels

   FIT RESIDUALS''            0.0014        0.0065
   DISPERSION MATRIX:        0.0065        0.0304

INITIAL METRICS 

    IDENTIFIER           PARAMETER  P RATIO        VALUE   ORIG VALUE  DELTA VALUE     VARIANCE  ORIG VARIANCE  
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         0    0.0142  +1.8065e-05  +0.0000e+00  +1.8065e-05  +8.0588e-01  +8.0588e-01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         1    0.0511  +1.0711e-02  +0.0000e+00  +1.0711e-02  +5.4432e-01  +5.8821e-01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         2    0.0542  +2.6916e-03  +0.0000e+00  +2.6916e-03  +2.3409e+00  +2.3433e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         6    0.0514  +5.9200e-02  +0.0000e+00  +5.9200e-02  +2.6706e+00  +3.9975e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         7    0.1444  +1.1133e-04  +0.0000e+00  +1.1133e-04  +3.0520e-03  +3.0526e-03
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        10    0.0511  +1.6574e-02  +0.0000e+00  +1.6574e-02  +3.8922e+00  +3.9975e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        11    0.1444  +3.1370e-05  +0.0000e+00  +3.1370e-05  +3.0527e-03  +3.0528e-03
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        14    0.0387  -1.2560e-04  +0.0000e+00  -1.2560e-04  +1.5990e+01  +1.5990e+01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        15    0.1382  +2.7179e-07  +0.0000e+00  +2.7179e-07  +1.2211e-02  +1.2211e-02

  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         0    0.0302  +4.8099e-05  +0.0000e+00  +4.8099e-05  +5.9454e-01  +5.9454e-01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         1    0.0510  -1.0670e-02  +0.0000e+00  -1.0670e-02  +6.0558e-01  +6.4927e-01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         2    0.0556  -2.7968e-03  +0.0000e+00  -2.7968e-03  +3.5177e+00  +3.5203e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         6    0.0513  -5.5896e-02  +0.0000e+00  -5.5896e-02  +2.8113e+00  +3.9971e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         7    0.1422  -1.2153e-04  +0.0000e+00  -1.2153e-04  +3.6102e-03  +3.6109e-03
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        10    0.0514  -1.4058e-02  +0.0000e+00  -1.4058e-02  +3.9224e+00  +3.9971e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        11    0.1422  -3.0498e-05  +0.0000e+00  -3.0498e-05  +3.6110e-03  +3.6110e-03
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        14    0.0451  +1.1977e-04  +0.0000e+00  +1.1977e-04  +1.5988e+01  +1.5988e+01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        15    0.1377  -2.5817e-07  +0.0000e+00  -2.5817e-07  +1.4444e-02  +1.4444e-02

                12081243641     0    0.0000  +4.6335e+06  +4.6335e+06  +4.2808e-03  +7.7858e+00  +1.0000e+12
                12081243641     1    0.0000  +1.0321e+06  +1.0321e+06  +1.9956e-03  +1.5864e+00  +1.0000e+12
                12081243641     2    0.0000  +4.2457e+06  +4.2457e+06  +5.1248e-04  +1.0321e+01  +1.0000e+12

                12081245917     0    0.0000  +4.6365e+06  +4.6365e+06  -4.9895e-03  +7.7770e+00  +1.0000e+12
                12081245917     1    0.0000  +1.0320e+06  +1.0320e+06  +3.2857e-03  +1.5883e+00  +1.0000e+12
                12081245917     2    0.0000  +4.2425e+06  +4.2425e+06  -8.1170e-04  +1.0288e+01  +1.0000e+12

FINAL METRICS 

    IDENTIFIER           PARAMETER  P RATIO        VALUE   ORIG VALUE  DELTA VALUE     VARIANCE  ORIG VARIANCE  
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         0    0.0142  +1.8065e-05  +0.0000e+00  +1.8065e-05  +8.0588e-01  +8.0588e-01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         1    0.0511  +1.0711e-02  +0.0000e+00  +1.0711e-02  +5.4432e-01  +5.8821e-01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         2    0.0542  +2.6916e-03  +0.0000e+00  +2.6916e-03  +2.3409e+00  +2.3433e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         6    0.0514  +5.9200e-02  +0.0000e+00  +5.9200e-02  +2.6706e+00  +3.9975e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                         7    0.1444  +1.1133e-04  +0.0000e+00  +1.1133e-04  +3.0520e-03  +3.0526e-03
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        10    0.0511  +1.6574e-02  +0.0000e+00  +1.6574e-02  +3.8922e+00  +3.9975e+00
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        11    0.1444  +3.1370e-05  +0.0000e+00  +3.1370e-05  +3.0527e-03  +3.0528e-03
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        14    0.0387  -1.2561e-04  +0.0000e+00  -1.2561e-04  +1.5990e+01  +1.5990e+01
  19JUL15WV030800015JUL19101909-P1BS_R1C1-056263760010_01_P001                        15    0.1382  +2.7178e-07  +0.0000e+00  +2.7178e-07  +1.2211e-02  +1.2211e-02

  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         0    0.0302  +4.8098e-05  +0.0000e+00  +4.8098e-05  +5.9454e-01  +5.9454e-01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         1    0.0510  -1.0670e-02  +0.0000e+00  -1.0670e-02  +6.0558e-01  +6.4927e-01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         2    0.0556  -2.7968e-03  +0.0000e+00  -2.7968e-03  +3.5177e+00  +3.5203e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         6    0.0513  -5.5896e-02  +0.0000e+00  -5.5896e-02  +2.8113e+00  +3.9971e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                         7    0.1422  -1.2153e-04  +0.0000e+00  -1.2153e-04  +3.6102e-03  +3.6109e-03
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        10    0.0514  -1.4058e-02  +0.0000e+00  -1.4058e-02  +3.9224e+00  +3.9971e+00
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        11    0.1422  -3.0498e-05  +0.0000e+00  -3.0498e-05  +3.6110e-03  +3.6110e-03
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        14    0.0451  +1.1977e-04  +0.0000e+00  +1.1977e-04  +1.5988e+01  +1.5988e+01
  19JUL15WV030800015JUL19102002-P1BS_R1C1-056263760010_01_P001                        15    0.1377  -2.5818e-07  +0.0000e+00  -2.5818e-07  +1.4444e-02  +1.4444e-02

                12081243641     0    0.0000  +4.6335e+06  +4.6335e+06  +4.2808e-03  +7.7858e+00  +1.0000e+12
                12081243641     1    0.0000  +1.0321e+06  +1.0321e+06  +1.9956e-03  +1.5864e+00  +1.0000e+12
                12081243641     2    0.0000  +4.2457e+06  +4.2457e+06  +5.1247e-04  +1.0321e+01  +1.0000e+12

                12081245917     0    0.0000  +4.6365e+06  +4.6365e+06  -4.9895e-03  +7.7770e+00  +1.0000e+12
                12081245917     1    0.0000  +1.0320e+06  +1.0320e+06  +3.2857e-03  +1.5883e+00  +1.0000e+12
                12081245917     2    0.0000  +4.2425e+06  +4.2425e+06  -8.1169e-04  +1.0288e+01  +1.0000e+12
', '2017-07-12 12:12:50.618', '2017-07-12 12:12:50.277');


--
-- Data for Name: triangulation_dem_generation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: triangulation_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO triangulation_image (triangulation_images_id, image_id) VALUES (101, 102);
INSERT INTO triangulation_image (triangulation_images_id, image_id) VALUES (101, 105);


--
-- Data for Name: uri_registry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO uri_registry (name, uri) VALUES ('sink.task-launcher-yarn', 'maven://org.springframework.cloud.stream.app:task-launcher-yarn-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.tcp', 'maven://org.springframework.cloud.stream.app:tcp-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.http', 'maven://org.springframework.cloud.stream.app:http-source-kafka-10:1.1.2.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.jdbc', 'maven://org.springframework.cloud.stream.app:jdbc-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.rabbit', 'maven://org.springframework.cloud.stream.app:rabbit-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.rabbit', 'maven://org.springframework.cloud.stream.app:rabbit-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.ftp', 'maven://org.springframework.cloud.stream.app:ftp-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.gpfdist', 'maven://org.springframework.cloud.stream.app:gpfdist-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.transform', 'maven://org.springframework.cloud.stream.app:transform-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.loggregator', 'maven://org.springframework.cloud.stream.app:loggregator-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.sftp', 'maven://org.springframework.cloud.stream.app:sftp-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.filter', 'maven://org.springframework.cloud.stream.app:filter-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.file', 'maven://org.springframework.cloud.stream.app:file-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.cassandra', 'maven://org.springframework.cloud.stream.app:cassandra-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.groovy-filter', 'maven://org.springframework.cloud.stream.app:groovy-filter-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.router', 'maven://org.springframework.cloud.stream.app:router-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.trigger', 'maven://org.springframework.cloud.stream.app:trigger-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.hdfs-dataset', 'maven://org.springframework.cloud.stream.app:hdfs-dataset-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.splitter', 'maven://org.springframework.cloud.stream.app:splitter-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.load-generator', 'maven://org.springframework.cloud.stream.app:load-generator-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.sftp', 'maven://org.springframework.cloud.stream.app:sftp-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.tcp-client', 'maven://org.springframework.cloud.stream.app:tcp-client-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.file', 'maven://org.springframework.cloud.stream.app:file-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.time', 'maven://org.springframework.cloud.stream.app:time-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.tasklaunchrequest-transform', 'maven://org.springframework.cloud.stream.app:tasklaunchrequest-transform-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.gemfire', 'maven://org.springframework.cloud.stream.app:gemfire-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.twitterstream', 'maven://org.springframework.cloud.stream.app:twitterstream-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.tcp', 'maven://org.springframework.cloud.stream.app:tcp-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.jdbc', 'maven://org.springframework.cloud.stream.app:jdbc-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.field-value-counter', 'maven://org.springframework.cloud.stream.app:field-value-counter-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.redis-pubsub', 'maven://org.springframework.cloud.stream.app:redis-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.hdfs', 'maven://org.springframework.cloud.stream.app:hdfs-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.task-launcher-local', 'maven://org.springframework.cloud.stream.app:task-launcher-local-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.httpclient', 'maven://org.springframework.cloud.stream.app:httpclient-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.bridge', 'maven://org.springframework.cloud.stream.app:bridge-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.pmml', 'maven://org.springframework.cloud.stream.app:pmml-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.s3', 'maven://org.springframework.cloud.stream.app:s3-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.ftp', 'maven://org.springframework.cloud.stream.app:ftp-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.log', 'maven://org.springframework.cloud.stream.app:log-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.gemfire', 'maven://org.springframework.cloud.stream.app:gemfire-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.aggregate-counter', 'maven://org.springframework.cloud.stream.app:aggregate-counter-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.triggertask', 'maven://org.springframework.cloud.stream.app:triggertask-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.throughput', 'maven://org.springframework.cloud.stream.app:throughput-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.jms', 'maven://org.springframework.cloud.stream.app:jms-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.gemfire-cq', 'maven://org.springframework.cloud.stream.app:gemfire-cq-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.s3', 'maven://org.springframework.cloud.stream.app:s3-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.tcp-client', 'maven://org.springframework.cloud.stream.app:tcp-client-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.counter', 'maven://org.springframework.cloud.stream.app:counter-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.scriptable-transform', 'maven://org.springframework.cloud.stream.app:scriptable-transform-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.mail', 'maven://org.springframework.cloud.stream.app:mail-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.mongodb', 'maven://org.springframework.cloud.stream.app:mongodb-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('sink.websocket', 'maven://org.springframework.cloud.stream.app:websocket-sink-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('processor.groovy-transform', 'maven://org.springframework.cloud.stream.app:groovy-transform-processor-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.syslog', 'maven://org.springframework.cloud.stream.app:syslog-source-kafka-10:1.1.1.RELEASE');
INSERT INTO uri_registry (name, uri) VALUES ('source.omar-scdf-sqs', 'https://artifacts.radiantbluecloud.com/artifactory/omar-local/omar-scdf-sqs/1.0.12-SNAPSHOT/omar-scdf-sqs-1.0.12-SNAPSHOT.jar');
INSERT INTO uri_registry (name, uri) VALUES ('processor.omar-scdf-aggregator', 'https://artifacts.radiantbluecloud.com/artifactory/omar-local/omar-scdf-aggregator/1.0.8-SNAPSHOT/omar-scdf-aggregator-1.0.8-SNAPSHOT.jar');


--
-- Data for Name: video_data_set; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: video_data_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('video_data_set_id_seq', 1, false);


--
-- Data for Name: video_file; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: video_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('video_file_id_seq', 1, false);


--
-- Name: wms_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('wms_log_id_seq', 45697, true);


--
-- Data for Name: wmts_layer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO wmts_layer (id, version, description, filter, name, sort_by, title, wmts_tile_matrix_set_id) VALUES (1, 0, 'World Geographic Layer', NULL, 'WorldGeographic', NULL, 'World Geographic Layer', 1);


--
-- Name: wmts_layer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('wmts_layer_id_seq', 1, true);


--
-- Data for Name: wmts_tile_matrix_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO wmts_tile_matrix_set (id, version, epsg_code, max_level, maxx, maxy, min_level, minx, miny, name, tile_height, tile_width) VALUES (1, 0, 'epsg:4326', 20, 180, 90, 0, -180, -90, 'WorldGeographic', 256, 256);


--
-- Name: wmts_tile_matrix_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('wmts_tile_matrix_set_id_seq', 1, true);


--
-- Data for Name: workspace_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO workspace_info (id, version, name, namespace_info_id) VALUES (12, 2, 'omar_prod', 12);


--
-- Name: workspace_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('workspace_info_id_seq', 12, true);


--
-- Data for Name: workspace_info_workspace_params; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'dbtype', 'postgis');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'host', 'o2db-instance.cfussmnw2zzg.us-east-1.rds.amazonaws.com');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'port', '5432');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'database', 'o2_omar_db');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'user', 'postgres');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'passwd', 'omarftw123');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'Expose primary keys', 'true');
INSERT INTO workspace_info_workspace_params (workspace_info_id, workspace_params_string, workspace_params_idx, workspace_params_elt) VALUES (12, NULL, 'namespace', 'http://omar.ossim.org');


--
-- Name: avro_file avro_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_file
    ADD CONSTRAINT avro_file_pkey PRIMARY KEY (id);


--
-- Name: avro_payload avro_payload_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_payload
    ADD CONSTRAINT avro_payload_pkey PRIMARY KEY (id);


--
-- Name: batch_job_execution_context batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_execution batch_job_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- Name: batch_job_instance batch_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- Name: batch_step_execution_context batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- Name: batch_step_execution batch_step_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- Name: dem_generation dem_generation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dem_generation
    ADD CONSTRAINT dem_generation_pkey PRIMARY KEY (id);


--
-- Name: deployment_ids deployment_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY deployment_ids
    ADD CONSTRAINT deployment_ids_pkey PRIMARY KEY (deployment_key);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: ingest_metrics ingest_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ingest_metrics
    ADD CONSTRAINT ingest_metrics_pkey PRIMARY KEY (id);


--
-- Name: batch_job_instance job_inst_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- Name: layer_info layer_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY layer_info
    ADD CONSTRAINT layer_info_pkey PRIMARY KEY (id);


--
-- Name: namespace_info namespace_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY namespace_info
    ADD CONSTRAINT namespace_info_pkey PRIMARY KEY (id);


--
-- Name: omar_stage_file omar_stage_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY omar_stage_file
    ADD CONSTRAINT omar_stage_file_pkey PRIMARY KEY (id);


--
-- Name: opir_raster_data_set opir_raster_data_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_data_set
    ADD CONSTRAINT opir_raster_data_set_pkey PRIMARY KEY (id);


--
-- Name: opir_raster_entry_file opir_raster_entry_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry_file
    ADD CONSTRAINT opir_raster_entry_file_pkey PRIMARY KEY (id);


--
-- Name: opir_raster_entry opir_raster_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry
    ADD CONSTRAINT opir_raster_entry_pkey PRIMARY KEY (id);


--
-- Name: opir_raster_file opir_raster_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_file
    ADD CONSTRAINT opir_raster_file_pkey PRIMARY KEY (id);


--
-- Name: photo_block photo_block_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photo_block
    ADD CONSTRAINT photo_block_pkey PRIMARY KEY (id);


--
-- Name: raster_data_set raster_data_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_data_set
    ADD CONSTRAINT raster_data_set_pkey PRIMARY KEY (id);


--
-- Name: raster_entry_file raster_entry_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry_file
    ADD CONSTRAINT raster_entry_file_pkey PRIMARY KEY (id);


--
-- Name: raster_entry raster_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry
    ADD CONSTRAINT raster_entry_pkey PRIMARY KEY (id);


--
-- Name: raster_file raster_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_file
    ADD CONSTRAINT raster_file_pkey PRIMARY KEY (id);


--
-- Name: repository repository_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repository
    ADD CONSTRAINT repository_pkey PRIMARY KEY (id);


--
-- Name: stream_definitions stream_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stream_definitions
    ADD CONSTRAINT stream_definitions_pkey PRIMARY KEY (definition_name);


--
-- Name: task_definitions task_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_definitions
    ADD CONSTRAINT task_definitions_pkey PRIMARY KEY (definition_name);


--
-- Name: task_execution task_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_execution
    ADD CONSTRAINT task_execution_pkey PRIMARY KEY (task_execution_id);


--
-- Name: tie_point_generation tie_point_generation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tie_point_generation
    ADD CONSTRAINT tie_point_generation_pkey PRIMARY KEY (id);


--
-- Name: tie_point tie_point_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tie_point
    ADD CONSTRAINT tie_point_pkey PRIMARY KEY (id);


--
-- Name: triangulation triangulation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation
    ADD CONSTRAINT triangulation_pkey PRIMARY KEY (id);


--
-- Name: wmts_tile_matrix_set uk_72iuajrq499ndj8pypw11hxsm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_tile_matrix_set
    ADD CONSTRAINT uk_72iuajrq499ndj8pypw11hxsm UNIQUE (name);


--
-- Name: workspace_info uk_7vf740h1jg76ljvfof1s6xfyh; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workspace_info
    ADD CONSTRAINT uk_7vf740h1jg76ljvfof1s6xfyh UNIQUE (name);


--
-- Name: avro_payload uk_a1egagsflkuufx5a0o2dd9i6k; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_payload
    ADD CONSTRAINT uk_a1egagsflkuufx5a0o2dd9i6k UNIQUE (message_id);


--
-- Name: raster_entry uk_aglehq0wlpuqf84r796p4v4jw; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry
    ADD CONSTRAINT uk_aglehq0wlpuqf84r796p4v4jw UNIQUE (index_id);


--
-- Name: video_file uk_cfjeb7vjkwrqbtyt9gx9xccgx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_file
    ADD CONSTRAINT uk_cfjeb7vjkwrqbtyt9gx9xccgx UNIQUE (name);


--
-- Name: video_data_set uk_euanun2rxqv6j0f6c9o3q1uvg; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_data_set
    ADD CONSTRAINT uk_euanun2rxqv6j0f6c9o3q1uvg UNIQUE (index_id);


--
-- Name: wmts_layer uk_fauyjvgghbgagoqw2wqq8b1b2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_layer
    ADD CONSTRAINT uk_fauyjvgghbgagoqw2wqq8b1b2 UNIQUE (name);


--
-- Name: raster_file uk_fnrwqa43tn3wkbxdxr8qmydt0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_file
    ADD CONSTRAINT uk_fnrwqa43tn3wkbxdxr8qmydt0 UNIQUE (name);


--
-- Name: repository uk_jtepri47p340m68eb3cehgns5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repository
    ADD CONSTRAINT uk_jtepri47p340m68eb3cehgns5 UNIQUE (repository_base_dir);


--
-- Name: namespace_info uk_mfuke53xhcq4dlcut09j3hysf; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY namespace_info
    ADD CONSTRAINT uk_mfuke53xhcq4dlcut09j3hysf UNIQUE (prefix);


--
-- Name: avro_file uk_nnap8lsnw4jxs52cg5b3vderm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_file
    ADD CONSTRAINT uk_nnap8lsnw4jxs52cg5b3vderm UNIQUE (process_id);


--
-- Name: avro_file uk_oba2xtnekmfshdblv5x20y9ev; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avro_file
    ADD CONSTRAINT uk_oba2xtnekmfshdblv5x20y9ev UNIQUE (filename);


--
-- Name: uri_registry uri_registry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uri_registry
    ADD CONSTRAINT uri_registry_pkey PRIMARY KEY (name);


--
-- Name: video_data_set video_data_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_data_set
    ADD CONSTRAINT video_data_set_pkey PRIMARY KEY (id);


--
-- Name: video_file video_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_file
    ADD CONSTRAINT video_file_pkey PRIMARY KEY (id);


--
-- Name: wmts_layer wmts_layer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_layer
    ADD CONSTRAINT wmts_layer_pkey PRIMARY KEY (id);


--
-- Name: wmts_tile_matrix_set wmts_tile_matrix_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_tile_matrix_set
    ADD CONSTRAINT wmts_tile_matrix_set_pkey PRIMARY KEY (id);


--
-- Name: workspace_info workspace_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workspace_info
    ADD CONSTRAINT workspace_info_pkey PRIMARY KEY (id);


--
-- Name: avro_file_date_created_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_file_date_created_idx ON avro_file USING btree (date_created);


--
-- Name: avro_file_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_file_filename_idx ON avro_file USING btree (filename);


--
-- Name: avro_file_process_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_file_process_id_idx ON avro_file USING btree (process_id);


--
-- Name: avro_file_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_file_status_idx ON avro_file USING btree (status);


--
-- Name: avro_payload_date_created_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_payload_date_created_idx ON avro_payload USING btree (date_created);


--
-- Name: avro_payload_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX avro_payload_message_id_idx ON avro_payload USING btree (message_id);


--
-- Name: ingest_metrics_end_copy_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_end_copy_idx ON ingest_metrics USING btree (end_copy);


--
-- Name: ingest_metrics_end_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_end_date_idx ON ingest_metrics USING btree (end_date);


--
-- Name: ingest_metrics_end_staging_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_end_staging_idx ON ingest_metrics USING btree (end_staging);


--
-- Name: ingest_metrics_object_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_object_id_idx ON ingest_metrics USING btree (ingest_id);


--
-- Name: ingest_metrics_start_copy_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_start_copy_idx ON ingest_metrics USING btree (start_copy);


--
-- Name: ingest_metrics_start_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_start_date_idx ON ingest_metrics USING btree (start_date);


--
-- Name: ingest_metrics_start_staging_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_start_staging_idx ON ingest_metrics USING btree (start_staging);


--
-- Name: ingest_metrics_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingest_metrics_status_idx ON ingest_metrics USING btree (status);


--
-- Name: omar_stage_file_date_created_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_stage_file_date_created_idx ON omar_stage_file USING btree (date_created);


--
-- Name: omar_stage_file_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_stage_file_filename_idx ON omar_stage_file USING btree (filename);


--
-- Name: omar_stage_file_process_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_stage_file_process_id_idx ON omar_stage_file USING btree (process_id);


--
-- Name: omar_stage_file_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_stage_file_status_idx ON omar_stage_file USING btree (status);


--
-- Name: omar_wmts_layer_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_wmts_layer_name_idx ON wmts_layer USING btree (name);


--
-- Name: omar_wmts_tile_matrix_set_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX omar_wmts_tile_matrix_set_name_idx ON wmts_tile_matrix_set USING btree (name);


--
-- Name: opir_raster_entry_access_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_access_date_idx ON opir_raster_entry USING btree (access_date);


--
-- Name: opir_raster_entry_acquisition_start_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_acquisition_start_idx ON opir_raster_entry USING btree (acquisition_start);


--
-- Name: opir_raster_entry_acquistion_end_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_acquistion_end_idx ON opir_raster_entry USING btree (acquisition_end);


--
-- Name: opir_raster_entry_bit_depth_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_bit_depth_idx ON opir_raster_entry USING btree (bit_depth);


--
-- Name: opir_raster_entry_data_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_data_type_idx ON opir_raster_entry USING btree (data_type);


--
-- Name: opir_raster_entry_entry_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_entry_id_idx ON opir_raster_entry USING btree (entry_id);


--
-- Name: opir_raster_entry_file_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_file_name_idx ON opir_raster_entry_file USING btree (name);


--
-- Name: opir_raster_entry_file_raster_entry_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_file_raster_entry_idx ON opir_raster_entry_file USING btree (opir_raster_entry_id);


--
-- Name: opir_raster_entry_file_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_file_type_idx ON opir_raster_entry_file USING btree (type);


--
-- Name: opir_raster_entry_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_filename_idx ON opir_raster_entry USING btree (filename);


--
-- Name: opir_raster_entry_filter1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_filter1_idx ON opir_raster_entry USING btree (filter1);


--
-- Name: opir_raster_entry_filter2_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_filter2_idx ON opir_raster_entry USING btree (filter2);


--
-- Name: opir_raster_entry_focal_plane_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_focal_plane_idx ON opir_raster_entry USING btree (focal_plane_id);


--
-- Name: opir_raster_entry_frame_rate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_frame_rate_idx ON opir_raster_entry USING btree (frame_rate);


--
-- Name: opir_raster_entry_gain_setting_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_gain_setting_idx ON opir_raster_entry USING btree (gain_setting);


--
-- Name: opir_raster_entry_hdf_location_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_hdf_location_idx ON opir_raster_entry USING btree (hdf_location);


--
-- Name: opir_raster_entry_hdf_snapshot_size_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_hdf_snapshot_size_idx ON opir_raster_entry USING btree (snapshot_size);


--
-- Name: opir_raster_entry_height_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_height_idx ON opir_raster_entry USING btree (height);


--
-- Name: opir_raster_entry_index_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_index_id_idx ON opir_raster_entry USING btree (index_id);


--
-- Name: opir_raster_entry_ingest_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_ingest_date_idx ON opir_raster_entry USING btree (ingest_date);


--
-- Name: opir_raster_entry_integration_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_integration_idx ON opir_raster_entry USING btree (integration_index);


--
-- Name: opir_raster_entry_mission_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_mission_idx ON opir_raster_entry USING btree (mission);


--
-- Name: opir_raster_entry_number_of_bands_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_number_of_bands_idx ON opir_raster_entry USING btree (number_of_bands);


--
-- Name: opir_raster_entry_receive_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_receive_date_idx ON opir_raster_entry USING btree (receive_date);


--
-- Name: opir_raster_entry_scan_rate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_scan_rate_idx ON opir_raster_entry USING btree (scan_rate);


--
-- Name: opir_raster_entry_spatial_summation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_spatial_summation_idx ON opir_raster_entry USING btree (spatial_summation);


--
-- Name: opir_raster_entry_summed_scans_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_summed_scans_idx ON opir_raster_entry USING btree (summed_scans);


--
-- Name: opir_raster_entry_task_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_task_name_idx ON opir_raster_entry USING btree (task_name);


--
-- Name: opir_raster_entry_width_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_entry_width_idx ON opir_raster_entry USING btree (width);


--
-- Name: opir_raster_file_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_file_name_idx ON opir_raster_file USING btree (name);


--
-- Name: opir_raster_file_raster_entry_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_file_raster_entry_idx ON opir_raster_file USING btree (opir_raster_data_set_id);


--
-- Name: opir_raster_file_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opir_raster_file_type_idx ON opir_raster_file USING btree (type);


--
-- Name: raster_data_set_repository_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_data_set_repository_idx ON raster_data_set USING btree (repository_id);


--
-- Name: raster_entry_access_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_access_date_idx ON raster_entry USING btree (access_date);


--
-- Name: raster_entry_acquisition_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_acquisition_date_idx ON raster_entry USING btree (acquisition_date);


--
-- Name: raster_entry_be_number_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_be_number_idx ON raster_entry USING btree (be_number);


--
-- Name: raster_entry_class_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_class_name_idx ON raster_entry USING btree (class_name);


--
-- Name: raster_entry_country_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_country_code_idx ON raster_entry USING btree (country_code);


--
-- Name: raster_entry_entry_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_entry_id_idx ON raster_entry USING btree (entry_id);


--
-- Name: raster_entry_file_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_file_name_idx ON raster_entry_file USING btree (name);


--
-- Name: raster_entry_file_raster_entry_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_file_raster_entry_idx ON raster_entry_file USING btree (raster_entry_id);


--
-- Name: raster_entry_file_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_file_type_idx ON raster_entry_file USING btree (type);


--
-- Name: raster_entry_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_filename_idx ON raster_entry USING btree (filename);


--
-- Name: raster_entry_filetype_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_filetype_idx ON raster_entry USING btree (file_type);


--
-- Name: raster_entry_image_category_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_image_category_idx ON raster_entry USING btree (image_category);


--
-- Name: raster_entry_image_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_image_id_idx ON raster_entry USING btree (image_id);


--
-- Name: raster_entry_image_representation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_image_representation_idx ON raster_entry USING btree (image_representation);


--
-- Name: raster_entry_index_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_index_id_idx ON raster_entry USING btree (index_id);


--
-- Name: raster_entry_ingest_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_ingest_date_idx ON raster_entry USING btree (ingest_date);


--
-- Name: raster_entry_mission_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_mission_id_idx ON raster_entry USING btree (mission_id);


--
-- Name: raster_entry_niirs_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_niirs_idx ON raster_entry USING btree (niirs);


--
-- Name: raster_entry_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_product_id_idx ON raster_entry USING btree (product_id);


--
-- Name: raster_entry_raster_data_set_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_raster_data_set_idx ON raster_entry USING btree (raster_data_set_id);


--
-- Name: raster_entry_receive_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_receive_date_idx ON raster_entry USING btree (receive_date);


--
-- Name: raster_entry_release_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_release_id_idx ON raster_entry USING btree (release_id);


--
-- Name: raster_entry_security_classification_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_security_classification_idx ON raster_entry USING btree (security_classification);


--
-- Name: raster_entry_security_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_security_code_idx ON raster_entry USING btree (security_code);


--
-- Name: raster_entry_sensor_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_sensor_id_idx ON raster_entry USING btree (sensor_id);


--
-- Name: raster_entry_target_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_target_id_idx ON raster_entry USING btree (target_id);


--
-- Name: raster_entry_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_title_idx ON raster_entry USING btree (title);


--
-- Name: raster_entry_valid_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_entry_valid_model_idx ON raster_entry USING btree (valid_model);


--
-- Name: raster_file_format_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_file_format_idx ON raster_file USING btree (format);


--
-- Name: raster_file_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_file_name_idx ON raster_file USING btree (name);


--
-- Name: raster_file_raster_data_set_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_file_raster_data_set_idx ON raster_file USING btree (raster_data_set_id);


--
-- Name: raster_file_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX raster_file_type_idx ON raster_file USING btree (type);


--
-- Name: repository_base_dir_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX repository_base_dir_idx ON repository USING btree (repository_base_dir);


--
-- Name: video_data_set_end_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_end_date_idx ON video_data_set USING btree (end_date);


--
-- Name: video_data_set_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_filename_idx ON video_data_set USING btree (filename);


--
-- Name: video_data_set_index_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_index_id_idx ON video_data_set USING btree (index_id);


--
-- Name: video_data_set_repository_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_repository_idx ON video_data_set USING btree (repository_id);


--
-- Name: video_data_set_start_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_start_date_idx ON video_data_set USING btree (start_date);


--
-- Name: video_data_set_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_data_set_time_idx ON video_data_set USING btree (end_date, start_date);


--
-- Name: video_file_format_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_file_format_idx ON video_file USING btree (format);


--
-- Name: video_file_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_file_name_idx ON video_file USING btree (name);


--
-- Name: video_file_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_file_type_idx ON video_file USING btree (type);


--
-- Name: video_file_video_data_set_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX video_file_video_data_set_idx ON video_file USING btree (video_data_set_id);


--
-- Name: opir_raster_entry fk1243l097chqai6nghr3uc8wci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry
    ADD CONSTRAINT fk1243l097chqai6nghr3uc8wci FOREIGN KEY (raster_data_set_id) REFERENCES opir_raster_data_set(id);


--
-- Name: opir_raster_file fk1llaruojqfhehamf33rcpkfaf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_file
    ADD CONSTRAINT fk1llaruojqfhehamf33rcpkfaf FOREIGN KEY (opir_raster_data_set_id) REFERENCES opir_raster_data_set(id);


--
-- Name: workspace_info fk3sjrvs7sihi51xlgabxvwh0yy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workspace_info
    ADD CONSTRAINT fk3sjrvs7sihi51xlgabxvwh0yy FOREIGN KEY (namespace_info_id) REFERENCES namespace_info(id);


--
-- Name: triangulation_image fk4hmsalel6360gxauc2l7i07ur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation_image
    ADD CONSTRAINT fk4hmsalel6360gxauc2l7i07ur FOREIGN KEY (triangulation_images_id) REFERENCES triangulation(id);


--
-- Name: raster_file fk6hr6eqi9u47v2yrpe3qyj2p7d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_file
    ADD CONSTRAINT fk6hr6eqi9u47v2yrpe3qyj2p7d FOREIGN KEY (raster_data_set_id) REFERENCES raster_data_set(id);


--
-- Name: triangulation_image fk6k6r1ppfr13ruiw3ikmadl7a8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation_image
    ADD CONSTRAINT fk6k6r1ppfr13ruiw3ikmadl7a8 FOREIGN KEY (image_id) REFERENCES image(id);


--
-- Name: image_tie_point fk7jbelkse1htbgs57efc8qudpy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY image_tie_point
    ADD CONSTRAINT fk7jbelkse1htbgs57efc8qudpy FOREIGN KEY (tie_point_id) REFERENCES tie_point(id);


--
-- Name: raster_entry_file fk9q0ub6g8se73ylctxte6h7vrb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry_file
    ADD CONSTRAINT fk9q0ub6g8se73ylctxte6h7vrb FOREIGN KEY (raster_entry_id) REFERENCES raster_entry(id);


--
-- Name: raster_entry fkb4k7upcsbff9ba162011q8h0t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_entry
    ADD CONSTRAINT fkb4k7upcsbff9ba162011q8h0t FOREIGN KEY (raster_data_set_id) REFERENCES raster_data_set(id);


--
-- Name: triangulation_dem_generation fkbkh3marknxf4806ffy75m3sfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation_dem_generation
    ADD CONSTRAINT fkbkh3marknxf4806ffy75m3sfk FOREIGN KEY (dem_generation_id) REFERENCES dem_generation(id);


--
-- Name: raster_data_set fkbmmdl3f94maecv306o38bklqf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raster_data_set
    ADD CONSTRAINT fkbmmdl3f94maecv306o38bklqf FOREIGN KEY (repository_id) REFERENCES repository(id);


--
-- Name: triangulation fkd8d8cr2xo0kpd23r8hx63jvlo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation
    ADD CONSTRAINT fkd8d8cr2xo0kpd23r8hx63jvlo FOREIGN KEY (photo_block_id) REFERENCES photo_block(id);


--
-- Name: video_file fke629f3g4jkwe4fjlgad9p8kj4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_file
    ADD CONSTRAINT fke629f3g4jkwe4fjlgad9p8kj4 FOREIGN KEY (video_data_set_id) REFERENCES video_data_set(id);


--
-- Name: video_data_set fkggf8u9wjqwqwgnv2k4pec5s5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_data_set
    ADD CONSTRAINT fkggf8u9wjqwqwgnv2k4pec5s5c FOREIGN KEY (repository_id) REFERENCES repository(id);


--
-- Name: opir_raster_entry_file fkh0ut92hewx1ypux9jjua9dbj1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opir_raster_entry_file
    ADD CONSTRAINT fkh0ut92hewx1ypux9jjua9dbj1 FOREIGN KEY (opir_raster_entry_id) REFERENCES opir_raster_entry(id);


--
-- Name: triangulation_dem_generation fkivagvuxqf4tc3lsv0tl0uj35v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY triangulation_dem_generation
    ADD CONSTRAINT fkivagvuxqf4tc3lsv0tl0uj35v FOREIGN KEY (triangulation_dem_generations_id) REFERENCES triangulation(id);


--
-- Name: tie_point_generation_image fkkfpg4my98i228ixw271melldv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tie_point_generation_image
    ADD CONSTRAINT fkkfpg4my98i228ixw271melldv FOREIGN KEY (image_id) REFERENCES image(id);


--
-- Name: layer_info fkklp0o0fnh96nb79kex65cd5is; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY layer_info
    ADD CONSTRAINT fkklp0o0fnh96nb79kex65cd5is FOREIGN KEY (workspace_info_id) REFERENCES workspace_info(id);


--
-- Name: tie_point_generation fkm2j7ut7m49po16w6ahvu66yc1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tie_point_generation
    ADD CONSTRAINT fkm2j7ut7m49po16w6ahvu66yc1 FOREIGN KEY (photo_block_id) REFERENCES photo_block(id);


--
-- Name: image_tie_point fknu2c2r7y85st90taf3nh6amf9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY image_tie_point
    ADD CONSTRAINT fknu2c2r7y85st90taf3nh6amf9 FOREIGN KEY (image_tie_points_id) REFERENCES image(id);


--
-- Name: wmts_layer fkp7ggeuavmq0da7st87tb1ak0j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wmts_layer
    ADD CONSTRAINT fkp7ggeuavmq0da7st87tb1ak0j FOREIGN KEY (wmts_tile_matrix_set_id) REFERENCES wmts_tile_matrix_set(id);


--
-- Name: tie_point_generation_image fks7hl4my4knlrscrnrsh6mfiiq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tie_point_generation_image
    ADD CONSTRAINT fks7hl4my4knlrscrnrsh6mfiiq FOREIGN KEY (tie_point_generation_images_id) REFERENCES tie_point_generation(id);


--
-- Name: batch_job_execution_context job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: batch_job_execution_params job_exec_params_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: batch_step_execution job_exec_step_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(job_execution_id);


--
-- Name: batch_job_execution job_inst_exec_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES batch_job_instance(job_instance_id);


--
-- Name: batch_step_execution_context step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES batch_step_execution(step_execution_id);


--
-- Name: task_task_batch task_exec_batch_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_task_batch
    ADD CONSTRAINT task_exec_batch_fk FOREIGN KEY (task_execution_id) REFERENCES task_execution(task_execution_id);


--
-- Name: task_execution_params task_exec_params_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_execution_params
    ADD CONSTRAINT task_exec_params_fk FOREIGN KEY (task_execution_id) REFERENCES task_execution(task_execution_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

