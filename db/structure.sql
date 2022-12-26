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
-- Name: payment_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_method AS ENUM (
    'credit_card',
    'paypal',
    'bank_transfer'
);


--
-- Name: project_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_type AS ENUM (
    'contest',
    'one_to_one'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: abandoned_cart_discounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.abandoned_cart_discounts (
    id bigint NOT NULL,
    discount_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: abandoned_cart_discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.abandoned_cart_discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: abandoned_cart_discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.abandoned_cart_discounts_id_seq OWNED BY public.abandoned_cart_discounts.id;


--
-- Name: abandoned_cart_reminders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.abandoned_cart_reminders (
    id bigint NOT NULL,
    name character varying,
    step integer,
    minutes_to_reminder integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: abandoned_cart_reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.abandoned_cart_reminders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: abandoned_cart_reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.abandoned_cart_reminders_id_seq OWNED BY public.abandoned_cart_reminders.id;


--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_type character varying,
    author_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: additional_design_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.additional_design_prices (
    id integer NOT NULL,
    quantity integer NOT NULL,
    amount_cents integer DEFAULT 0 NOT NULL,
    amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_id bigint
);


--
-- Name: additional_design_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.additional_design_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: additional_design_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.additional_design_prices_id_seq OWNED BY public.additional_design_prices.id;


--
-- Name: additional_screen_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.additional_screen_prices (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    amount_cents integer DEFAULT 0 NOT NULL,
    amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: additional_screen_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.additional_screen_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: additional_screen_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.additional_screen_prices_id_seq OWNED BY public.additional_screen_prices.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
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
    view_only boolean
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


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
-- Name: bottle_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bottle_packaging_measurements (
    id integer NOT NULL,
    label_width character varying,
    label_height character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bottle_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bottle_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bottle_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bottle_packaging_measurements_id_seq OWNED BY public.bottle_packaging_measurements.id;


--
-- Name: brand_dnas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brand_dnas (
    id bigint NOT NULL,
    bold_or_refined integer DEFAULT 5 NOT NULL,
    detailed_or_clean integer DEFAULT 5 NOT NULL,
    handcrafted_or_minimalist integer DEFAULT 5 NOT NULL,
    low_income_or_high_income integer DEFAULT 5 NOT NULL,
    masculine_or_premium integer DEFAULT 5 NOT NULL,
    outmoded_actual integer DEFAULT 5 NOT NULL,
    serious_or_playful integer DEFAULT 5 NOT NULL,
    stand_out_or_not_from_the_crowd integer DEFAULT 5 NOT NULL,
    traditional_or_modern integer DEFAULT 5 NOT NULL,
    value_or_premium integer DEFAULT 5 NOT NULL,
    youthful_or_mature integer DEFAULT 5 NOT NULL,
    target_country_codes character varying[] DEFAULT '{}'::character varying[],
    brand_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: brand_dnas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.brand_dnas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brand_dnas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.brand_dnas_id_seq OWNED BY public.brand_dnas.id;


--
-- Name: brand_examples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brand_examples (
    id bigint NOT NULL,
    project_id bigint,
    example_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: brand_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.brand_examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brand_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.brand_examples_id_seq OWNED BY public.brand_examples.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brands (
    id bigint NOT NULL,
    name character varying,
    slogan character varying,
    additional_text text,
    description text,
    background_story text,
    where_it_is_used text,
    what_is_special text,
    company_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    visible boolean DEFAULT true NOT NULL
);


--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: can_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.can_packaging_measurements (
    id integer NOT NULL,
    height character varying,
    volume character varying,
    diameter character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: can_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.can_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: can_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.can_packaging_measurements_id_seq OWNED BY public.can_packaging_measurements.id;


--
-- Name: card_box_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_box_packaging_measurements (
    id integer NOT NULL,
    side_depth character varying,
    front_width character varying,
    front_height character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: card_box_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_box_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_box_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_box_packaging_measurements_id_seq OWNED BY public.card_box_packaging_measurements.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    god boolean DEFAULT false NOT NULL,
    opt_out boolean DEFAULT false NOT NULL,
    stripe_customer character varying,
    is_last_charge_successful boolean,
    company_id bigint,
    is_owner boolean DEFAULT false NOT NULL,
    preferred_payment_method public.payment_method,
    payment_method_id character varying,
    credit_card_number character varying,
    credit_card_provider character varying
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    company_name character varying,
    address1 text,
    address2 text,
    city character varying,
    country_code character varying,
    state_name character varying,
    zip character varying,
    phone character varying,
    vat character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: competitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.competitors (
    id integer NOT NULL,
    name character varying,
    website character varying,
    comment character varying,
    rate integer,
    brand_id bigint
);


--
-- Name: competitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.competitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: competitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.competitors_id_seq OWNED BY public.competitors.id;


--
-- Name: database_dumps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.database_dumps (
    id bigint NOT NULL,
    file character varying,
    original_filename character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: database_dumps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.database_dumps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: database_dumps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.database_dumps_id_seq OWNED BY public.database_dumps.id;


--
-- Name: designer_client_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.designer_client_blocks (
    designer_id integer NOT NULL,
    client_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_reason integer,
    block_custom_reason character varying
);


--
-- Name: designer_experiences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.designer_experiences (
    id bigint NOT NULL,
    designer_id bigint,
    product_category_id bigint,
    experience integer,
    state character varying DEFAULT 'draft'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: designer_experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.designer_experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: designer_experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.designer_experiences_id_seq OWNED BY public.designer_experiences.id;


--
-- Name: designer_ndas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.designer_ndas (
    id integer NOT NULL,
    designer_id integer NOT NULL,
    nda_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: designer_ndas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.designer_ndas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: designer_ndas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.designer_ndas_id_seq OWNED BY public.designer_ndas.id;


--
-- Name: designers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.designers (
    id integer NOT NULL,
    display_name character varying,
    first_name character varying,
    last_name character varying,
    country_code character varying,
    gender integer,
    experience_english integer,
    portfolio_uploaded boolean DEFAULT false NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address1 character varying,
    address2 character varying,
    city character varying,
    state_name character varying,
    zip character varying,
    phone character varying,
    portfolio_link character varying,
    max_active_spots_count integer,
    age integer,
    date_of_birth date,
    discarded_at timestamp without time zone,
    description text,
    languages jsonb,
    visible boolean DEFAULT false NOT NULL,
    badge character varying,
    average_response_time integer,
    reviews_count integer DEFAULT 0 NOT NULL,
    hero_image_id bigint,
    average_rating numeric(3,2),
    one_to_one_available boolean DEFAULT true NOT NULL,
    one_to_one_allowed boolean DEFAULT false NOT NULL
);


--
-- Name: designers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.designers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: designers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.designers_id_seq OWNED BY public.designers.id;


--
-- Name: designs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.designs (
    id integer NOT NULL,
    uploaded_file_id integer NOT NULL,
    rating integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    spot_id integer NOT NULL,
    unread boolean DEFAULT true NOT NULL,
    eliminate_reason integer,
    eliminate_custom_reason character varying
);


--
-- Name: designs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.designs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: designs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.designs_id_seq OWNED BY public.designs.id;


--
-- Name: direct_conversation_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.direct_conversation_messages (
    id integer NOT NULL,
    user_id integer,
    design_id integer,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    seconds_since_last_message integer
);


--
-- Name: direct_conversation_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.direct_conversation_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: direct_conversation_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.direct_conversation_messages_id_seq OWNED BY public.direct_conversation_messages.id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discounts (
    id integer NOT NULL,
    code character varying NOT NULL,
    discount_type integer NOT NULL,
    value integer NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    used_num integer DEFAULT 0 NOT NULL,
    max_num integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discounts_id_seq OWNED BY public.discounts.id;


--
-- Name: earnings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.earnings (
    id integer NOT NULL,
    designer_id integer NOT NULL,
    project_id integer NOT NULL,
    state character varying,
    amount integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: earnings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.earnings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: earnings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.earnings_id_seq OWNED BY public.earnings.id;


--
-- Name: existing_designs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.existing_designs (
    id integer NOT NULL,
    comment character varying,
    project_id bigint
);


--
-- Name: existing_designs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.existing_designs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: existing_designs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.existing_designs_id_seq OWNED BY public.existing_designs.id;


--
-- Name: faq_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faq_groups (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: faq_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faq_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faq_groups_id_seq OWNED BY public.faq_groups.id;


--
-- Name: faq_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faq_items (
    id integer NOT NULL,
    name character varying NOT NULL,
    answer text NOT NULL,
    faq_group_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: faq_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faq_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faq_items_id_seq OWNED BY public.faq_items.id;


--
-- Name: featured_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.featured_images (
    id bigint NOT NULL,
    project_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: featured_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.featured_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: featured_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.featured_images_id_seq OWNED BY public.featured_images.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    subject character varying NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: inspirations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inspirations (
    id integer NOT NULL,
    comment character varying,
    project_id bigint
);


--
-- Name: inspirations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inspirations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inspirations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inspirations_id_seq OWNED BY public.inspirations.id;


--
-- Name: label_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.label_packaging_measurements (
    id integer NOT NULL,
    label_width character varying,
    label_height character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: label_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.label_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.label_packaging_measurements_id_seq OWNED BY public.label_packaging_measurements.id;


--
-- Name: logins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logins (
    id bigint NOT NULL,
    user_id bigint,
    ip character varying,
    origin character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    origin_2 character varying
);


--
-- Name: logins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- Name: nda_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nda_prices (
    id integer NOT NULL,
    nda_type integer NOT NULL,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: nda_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nda_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nda_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nda_prices_id_seq OWNED BY public.nda_prices.id;


--
-- Name: ndas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ndas (
    id integer NOT NULL,
    value text,
    nda_type integer DEFAULT 0 NOT NULL,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    brand_id bigint,
    start_date timestamp without time zone,
    expiry_date timestamp without time zone,
    paid boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: ndas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ndas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ndas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ndas_id_seq OWNED BY public.ndas.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    project_id integer NOT NULL,
    payment_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    payment_type integer,
    payment_intent_id character varying,
    charge_id character varying,
    total_price_paid_cents integer DEFAULT 0 NOT NULL,
    nda_price_paid_cents integer DEFAULT 0 NOT NULL,
    vat_price_paid_cents integer DEFAULT 0 NOT NULL,
    discount_amount_saved_cents integer DEFAULT 0 NOT NULL,
    processing_fee_cents integer DEFAULT 0 NOT NULL,
    processing_fee_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    processing_fee_vat_cents integer DEFAULT 0 NOT NULL,
    processing_fee_vat_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    paid_for integer DEFAULT 0 NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: payout_min_amounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payout_min_amounts (
    id integer NOT NULL,
    amount integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payout_min_amounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payout_min_amounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payout_min_amounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payout_min_amounts_id_seq OWNED BY public.payout_min_amounts.id;


--
-- Name: payouts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payouts (
    id integer NOT NULL,
    designer_id integer,
    payout_id character varying,
    amount integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    country character varying,
    payout_method character varying,
    iban character varying,
    swift character varying,
    first_name character varying,
    last_name character varying,
    address1 character varying,
    address2 character varying,
    city character varying,
    state character varying,
    phone character varying,
    paypal_email character varying,
    payout_state character varying,
    paypal_batch_id character varying
);


--
-- Name: payouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payouts_id_seq OWNED BY public.payouts.id;


--
-- Name: plastic_pack_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plastic_pack_packaging_measurements (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: plastic_pack_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plastic_pack_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plastic_pack_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plastic_pack_packaging_measurements_id_seq OWNED BY public.plastic_pack_packaging_measurements.id;


--
-- Name: portfolio_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portfolio_images (
    id integer NOT NULL,
    uploaded_file_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: portfolio_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.portfolio_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: portfolio_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.portfolio_images_id_seq OWNED BY public.portfolio_images.id;


--
-- Name: portfolio_images_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portfolio_images_lists (
    portfolio_image_id bigint NOT NULL,
    portfolio_list_id bigint NOT NULL
);


--
-- Name: portfolio_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portfolio_lists (
    id integer NOT NULL,
    list_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: portfolio_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.portfolio_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: portfolio_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.portfolio_lists_id_seq OWNED BY public.portfolio_lists.id;


--
-- Name: portfolio_works; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portfolio_works (
    id integer NOT NULL,
    description text,
    designer_id integer,
    index integer DEFAULT 0 NOT NULL,
    product_category_id bigint
);


--
-- Name: portfolio_works_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.portfolio_works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: portfolio_works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.portfolio_works_id_seq OWNED BY public.portfolio_works.id;


--
-- Name: pouch_packaging_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pouch_packaging_measurements (
    id integer NOT NULL,
    width character varying,
    height character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pouch_packaging_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pouch_packaging_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pouch_packaging_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pouch_packaging_measurements_id_seq OWNED BY public.pouch_packaging_measurements.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    full_name character varying
);


--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying,
    key character varying,
    price_cents integer DEFAULT 0 NOT NULL,
    product_category_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    short_name character varying,
    brand_name_hint character varying,
    brand_additional_text_hint character varying,
    brand_background_story_hint character varying DEFAULT 'Your background story'::character varying,
    product_text_label character varying,
    product_text_hint character varying DEFAULT 'You can also copy and paste your text here, that way line breaks are preserved.'::character varying,
    tip_and_tricks_url character varying,
    what_is_it_for_label character varying,
    what_is_it_for_hint character varying,
    contest_design_stage_expire_days integer DEFAULT 10 NOT NULL,
    contest_finalist_stage_expire_days integer DEFAULT 5 NOT NULL,
    files_stage_expire_days integer DEFAULT 3 NOT NULL,
    review_files_stage_expire_days integer DEFAULT 10 NOT NULL,
    reservation_expire_days integer DEFAULT 1 NOT NULL,
    product_size_label character varying,
    product_size_hint character varying,
    active boolean DEFAULT true,
    one_to_one_price_cents integer DEFAULT 0 NOT NULL,
    one_to_one_price_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    one_to_one_design_stage_expire_days integer DEFAULT 10 NOT NULL,
    one_to_one_finalist_stage_expire_days integer DEFAULT 10 NOT NULL,
    layout_version integer DEFAULT 1 NOT NULL,
    stripe_product_id character varying
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: project_additional_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_additional_documents (
    id integer NOT NULL,
    comment character varying,
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_additional_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_additional_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_additional_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_additional_documents_id_seq OWNED BY public.project_additional_documents.id;


--
-- Name: project_brand_examples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_brand_examples (
    id integer NOT NULL,
    example_type integer NOT NULL,
    project_id integer,
    brand_example_id integer
);


--
-- Name: project_brand_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_brand_examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_brand_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_brand_examples_id_seq OWNED BY public.project_brand_examples.id;


--
-- Name: project_brief_components; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_brief_components (
    id bigint NOT NULL,
    attribute_name character varying,
    component_name character varying,
    "position" integer,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_brief_components_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_brief_components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_brief_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_brief_components_id_seq OWNED BY public.project_brief_components.id;


--
-- Name: project_builder_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_builder_questions (
    id bigint NOT NULL,
    "position" integer,
    attribute_name character varying,
    component_name character varying,
    props json,
    validations json,
    project_builder_step_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mandatory boolean DEFAULT false NOT NULL
);


--
-- Name: project_builder_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_builder_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_builder_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_builder_questions_id_seq OWNED BY public.project_builder_questions.id;


--
-- Name: project_builder_steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_builder_steps (
    id bigint NOT NULL,
    path character varying,
    name character varying,
    description text,
    authentication_required boolean DEFAULT false NOT NULL,
    form_name character varying,
    "position" integer,
    product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mandatory_for_one_to_one_project boolean DEFAULT false NOT NULL,
    mandatory_for_existing_brand boolean DEFAULT false NOT NULL,
    component_name character varying
);


--
-- Name: project_builder_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_builder_steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_builder_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_builder_steps_id_seq OWNED BY public.project_builder_steps.id;


--
-- Name: project_colors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_colors (
    id integer NOT NULL,
    hex character varying,
    project_id integer
);


--
-- Name: project_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_colors_id_seq OWNED BY public.project_colors.id;


--
-- Name: project_source_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_source_files (
    id integer NOT NULL,
    designer_id integer,
    project_id integer
);


--
-- Name: project_source_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_source_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_source_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_source_files_id_seq OWNED BY public.project_source_files.id;


--
-- Name: project_stock_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_stock_images (
    id bigint NOT NULL,
    comment character varying,
    project_id bigint,
    stock_image_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_stock_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_stock_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_stock_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_stock_images_id_seq OWNED BY public.project_stock_images.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying,
    state character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ideas_or_special_requirements text,
    upgrade_package boolean DEFAULT false NOT NULL,
    description character varying,
    normalized_price integer,
    packaging_measurements_type character varying,
    packaging_measurements_id integer,
    what_to_design character varying,
    design_type integer,
    back_business_card_details character varying,
    front_business_card_details character varying,
    compliment character varying,
    letter_head character varying,
    colors_comment character varying,
    design_stage_started_at timestamp without time zone,
    finalist_stage_started_at timestamp without time zone,
    review_files_stage_started_at timestamp without time zone,
    spots_count integer DEFAULT 0,
    files_stage_started_at timestamp without time zone,
    normalized_type_price integer,
    discount_id integer,
    discount_amount_cents integer DEFAULT 0 NOT NULL,
    discount_amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    max_spots_count integer DEFAULT 3 NOT NULL,
    abandoned_cart_reminder_step character varying,
    designer_discount_amount_cents integer DEFAULT 0 NOT NULL,
    design_stage_expires_at timestamp without time zone,
    finalist_stage_expires_at timestamp without time zone,
    files_stage_expires_at timestamp without time zone,
    review_files_stage_expires_at timestamp without time zone,
    brand_dna_id bigint,
    product_id bigint,
    creator_id bigint,
    product_text text,
    stock_images_exist integer DEFAULT 0 NOT NULL,
    what_is_it_for text,
    product_size character varying,
    block_designer_available boolean DEFAULT true NOT NULL,
    eliminate_designer_available boolean DEFAULT true NOT NULL,
    manual_product_category_id bigint,
    current_step_id bigint,
    discoverable boolean DEFAULT true NOT NULL,
    project_type public.project_type DEFAULT 'contest'::public.project_type NOT NULL,
    discarded_at timestamp without time zone,
    max_screens_count integer DEFAULT 1 NOT NULL,
    source_files_shared boolean DEFAULT false NOT NULL,
    additional_days integer DEFAULT 0 NOT NULL,
    visible boolean DEFAULT false NOT NULL,
    debrief text,
    referrer character varying,
    new_colors jsonb DEFAULT '[]'::jsonb NOT NULL,
    stripe_session_id character varying
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
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    designer_comment character varying NOT NULL,
    designer_rating integer DEFAULT 0 NOT NULL,
    design_id integer NOT NULL,
    client_id integer NOT NULL,
    overall_rating integer DEFAULT 0 NOT NULL,
    overall_comment character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    visible boolean DEFAULT true NOT NULL,
    designer_comment_answer text,
    overall_comment_answer text
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: spots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spots (
    id integer NOT NULL,
    designer_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying,
    reserved_state_started_at timestamp without time zone
);


--
-- Name: spots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.spots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.spots_id_seq OWNED BY public.spots.id;


--
-- Name: start_notification_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.start_notification_requests (
    id integer NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: start_notification_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.start_notification_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: start_notification_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.start_notification_requests_id_seq OWNED BY public.start_notification_requests.id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testimonials (
    id bigint NOT NULL,
    header character varying NOT NULL,
    body text NOT NULL,
    rating integer DEFAULT 1 NOT NULL,
    credential character varying NOT NULL,
    company character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.testimonials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- Name: uploaded_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uploaded_files (
    id integer NOT NULL,
    entity_type character varying,
    entity_id integer,
    file character varying,
    type character varying NOT NULL,
    original_filename character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: uploaded_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uploaded_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploaded_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uploaded_files_id_seq OWNED BY public.uploaded_files.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    provider character varying DEFAULT 'email'::character varying NOT NULL,
    uid character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
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
    email character varying,
    tokens json,
    state character varying DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    last_seen_at timestamp without time zone,
    notify_projects_updates boolean DEFAULT true,
    notify_messages_received boolean DEFAULT true,
    notify_news boolean DEFAULT true,
    inform_on_email character varying,
    discarded_at timestamp without time zone
);


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
-- Name: vat_rates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vat_rates (
    id integer NOT NULL,
    country_name character varying NOT NULL,
    country_code character varying NOT NULL,
    percent numeric(5,2) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: vat_rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vat_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vat_rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vat_rates_id_seq OWNED BY public.vat_rates.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_type character varying NOT NULL,
    item_id integer NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: abandoned_cart_discounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abandoned_cart_discounts ALTER COLUMN id SET DEFAULT nextval('public.abandoned_cart_discounts_id_seq'::regclass);


--
-- Name: abandoned_cart_reminders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abandoned_cart_reminders ALTER COLUMN id SET DEFAULT nextval('public.abandoned_cart_reminders_id_seq'::regclass);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: additional_design_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_design_prices ALTER COLUMN id SET DEFAULT nextval('public.additional_design_prices_id_seq'::regclass);


--
-- Name: additional_screen_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_screen_prices ALTER COLUMN id SET DEFAULT nextval('public.additional_screen_prices_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: bottle_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bottle_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.bottle_packaging_measurements_id_seq'::regclass);


--
-- Name: brand_dnas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_dnas ALTER COLUMN id SET DEFAULT nextval('public.brand_dnas_id_seq'::regclass);


--
-- Name: brand_examples id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_examples ALTER COLUMN id SET DEFAULT nextval('public.brand_examples_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: can_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.can_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.can_packaging_measurements_id_seq'::regclass);


--
-- Name: card_box_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_box_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.card_box_packaging_measurements_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: competitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitors ALTER COLUMN id SET DEFAULT nextval('public.competitors_id_seq'::regclass);


--
-- Name: database_dumps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.database_dumps ALTER COLUMN id SET DEFAULT nextval('public.database_dumps_id_seq'::regclass);


--
-- Name: designer_experiences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_experiences ALTER COLUMN id SET DEFAULT nextval('public.designer_experiences_id_seq'::regclass);


--
-- Name: designer_ndas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_ndas ALTER COLUMN id SET DEFAULT nextval('public.designer_ndas_id_seq'::regclass);


--
-- Name: designers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designers ALTER COLUMN id SET DEFAULT nextval('public.designers_id_seq'::regclass);


--
-- Name: designs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designs ALTER COLUMN id SET DEFAULT nextval('public.designs_id_seq'::regclass);


--
-- Name: direct_conversation_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_conversation_messages ALTER COLUMN id SET DEFAULT nextval('public.direct_conversation_messages_id_seq'::regclass);


--
-- Name: discounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts ALTER COLUMN id SET DEFAULT nextval('public.discounts_id_seq'::regclass);


--
-- Name: earnings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.earnings ALTER COLUMN id SET DEFAULT nextval('public.earnings_id_seq'::regclass);


--
-- Name: existing_designs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existing_designs ALTER COLUMN id SET DEFAULT nextval('public.existing_designs_id_seq'::regclass);


--
-- Name: faq_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_groups ALTER COLUMN id SET DEFAULT nextval('public.faq_groups_id_seq'::regclass);


--
-- Name: faq_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_items ALTER COLUMN id SET DEFAULT nextval('public.faq_items_id_seq'::regclass);


--
-- Name: featured_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.featured_images ALTER COLUMN id SET DEFAULT nextval('public.featured_images_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: inspirations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspirations ALTER COLUMN id SET DEFAULT nextval('public.inspirations_id_seq'::regclass);


--
-- Name: label_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.label_packaging_measurements_id_seq'::regclass);


--
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- Name: nda_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nda_prices ALTER COLUMN id SET DEFAULT nextval('public.nda_prices_id_seq'::regclass);


--
-- Name: ndas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ndas ALTER COLUMN id SET DEFAULT nextval('public.ndas_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: payout_min_amounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payout_min_amounts ALTER COLUMN id SET DEFAULT nextval('public.payout_min_amounts_id_seq'::regclass);


--
-- Name: payouts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payouts ALTER COLUMN id SET DEFAULT nextval('public.payouts_id_seq'::regclass);


--
-- Name: plastic_pack_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plastic_pack_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.plastic_pack_packaging_measurements_id_seq'::regclass);


--
-- Name: portfolio_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_images ALTER COLUMN id SET DEFAULT nextval('public.portfolio_images_id_seq'::regclass);


--
-- Name: portfolio_lists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_lists ALTER COLUMN id SET DEFAULT nextval('public.portfolio_lists_id_seq'::regclass);


--
-- Name: portfolio_works id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_works ALTER COLUMN id SET DEFAULT nextval('public.portfolio_works_id_seq'::regclass);


--
-- Name: pouch_packaging_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pouch_packaging_measurements ALTER COLUMN id SET DEFAULT nextval('public.pouch_packaging_measurements_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: project_additional_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_additional_documents ALTER COLUMN id SET DEFAULT nextval('public.project_additional_documents_id_seq'::regclass);


--
-- Name: project_brand_examples id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brand_examples ALTER COLUMN id SET DEFAULT nextval('public.project_brand_examples_id_seq'::regclass);


--
-- Name: project_brief_components id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brief_components ALTER COLUMN id SET DEFAULT nextval('public.project_brief_components_id_seq'::regclass);


--
-- Name: project_builder_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_builder_questions ALTER COLUMN id SET DEFAULT nextval('public.project_builder_questions_id_seq'::regclass);


--
-- Name: project_builder_steps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_builder_steps ALTER COLUMN id SET DEFAULT nextval('public.project_builder_steps_id_seq'::regclass);


--
-- Name: project_colors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_colors ALTER COLUMN id SET DEFAULT nextval('public.project_colors_id_seq'::regclass);


--
-- Name: project_source_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_source_files ALTER COLUMN id SET DEFAULT nextval('public.project_source_files_id_seq'::regclass);


--
-- Name: project_stock_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_stock_images ALTER COLUMN id SET DEFAULT nextval('public.project_stock_images_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: spots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spots ALTER COLUMN id SET DEFAULT nextval('public.spots_id_seq'::regclass);


--
-- Name: start_notification_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.start_notification_requests ALTER COLUMN id SET DEFAULT nextval('public.start_notification_requests_id_seq'::regclass);


--
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- Name: uploaded_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploaded_files ALTER COLUMN id SET DEFAULT nextval('public.uploaded_files_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vat_rates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vat_rates ALTER COLUMN id SET DEFAULT nextval('public.vat_rates_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: abandoned_cart_discounts abandoned_cart_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abandoned_cart_discounts
    ADD CONSTRAINT abandoned_cart_discounts_pkey PRIMARY KEY (id);


--
-- Name: abandoned_cart_reminders abandoned_cart_reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abandoned_cart_reminders
    ADD CONSTRAINT abandoned_cart_reminders_pkey PRIMARY KEY (id);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: additional_design_prices additional_design_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_design_prices
    ADD CONSTRAINT additional_design_prices_pkey PRIMARY KEY (id);


--
-- Name: additional_screen_prices additional_screen_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_screen_prices
    ADD CONSTRAINT additional_screen_prices_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bottle_packaging_measurements bottle_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bottle_packaging_measurements
    ADD CONSTRAINT bottle_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: brand_dnas brand_dnas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_dnas
    ADD CONSTRAINT brand_dnas_pkey PRIMARY KEY (id);


--
-- Name: brand_examples brand_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_examples
    ADD CONSTRAINT brand_examples_pkey PRIMARY KEY (id);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: can_packaging_measurements can_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.can_packaging_measurements
    ADD CONSTRAINT can_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: card_box_packaging_measurements card_box_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_box_packaging_measurements
    ADD CONSTRAINT card_box_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: competitors competitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitors
    ADD CONSTRAINT competitors_pkey PRIMARY KEY (id);


--
-- Name: database_dumps database_dumps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.database_dumps
    ADD CONSTRAINT database_dumps_pkey PRIMARY KEY (id);


--
-- Name: designer_experiences designer_experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_experiences
    ADD CONSTRAINT designer_experiences_pkey PRIMARY KEY (id);


--
-- Name: designer_ndas designer_ndas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_ndas
    ADD CONSTRAINT designer_ndas_pkey PRIMARY KEY (id);


--
-- Name: designers designers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designers
    ADD CONSTRAINT designers_pkey PRIMARY KEY (id);


--
-- Name: designs designs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designs
    ADD CONSTRAINT designs_pkey PRIMARY KEY (id);


--
-- Name: direct_conversation_messages direct_conversation_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_conversation_messages
    ADD CONSTRAINT direct_conversation_messages_pkey PRIMARY KEY (id);


--
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: earnings earnings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.earnings
    ADD CONSTRAINT earnings_pkey PRIMARY KEY (id);


--
-- Name: existing_designs existing_designs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existing_designs
    ADD CONSTRAINT existing_designs_pkey PRIMARY KEY (id);


--
-- Name: faq_groups faq_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_groups
    ADD CONSTRAINT faq_groups_pkey PRIMARY KEY (id);


--
-- Name: faq_items faq_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_items
    ADD CONSTRAINT faq_items_pkey PRIMARY KEY (id);


--
-- Name: featured_images featured_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.featured_images
    ADD CONSTRAINT featured_images_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: inspirations inspirations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspirations
    ADD CONSTRAINT inspirations_pkey PRIMARY KEY (id);


--
-- Name: label_packaging_measurements label_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label_packaging_measurements
    ADD CONSTRAINT label_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: logins logins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_pkey PRIMARY KEY (id);


--
-- Name: nda_prices nda_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nda_prices
    ADD CONSTRAINT nda_prices_pkey PRIMARY KEY (id);


--
-- Name: ndas ndas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ndas
    ADD CONSTRAINT ndas_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: payout_min_amounts payout_min_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payout_min_amounts
    ADD CONSTRAINT payout_min_amounts_pkey PRIMARY KEY (id);


--
-- Name: payouts payouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payouts
    ADD CONSTRAINT payouts_pkey PRIMARY KEY (id);


--
-- Name: plastic_pack_packaging_measurements plastic_pack_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plastic_pack_packaging_measurements
    ADD CONSTRAINT plastic_pack_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: portfolio_images portfolio_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_images
    ADD CONSTRAINT portfolio_images_pkey PRIMARY KEY (id);


--
-- Name: portfolio_lists portfolio_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_lists
    ADD CONSTRAINT portfolio_lists_pkey PRIMARY KEY (id);


--
-- Name: portfolio_works portfolio_works_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_works
    ADD CONSTRAINT portfolio_works_pkey PRIMARY KEY (id);


--
-- Name: pouch_packaging_measurements pouch_packaging_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pouch_packaging_measurements
    ADD CONSTRAINT pouch_packaging_measurements_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: project_additional_documents project_additional_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_additional_documents
    ADD CONSTRAINT project_additional_documents_pkey PRIMARY KEY (id);


--
-- Name: project_brand_examples project_brand_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brand_examples
    ADD CONSTRAINT project_brand_examples_pkey PRIMARY KEY (id);


--
-- Name: project_brief_components project_brief_components_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brief_components
    ADD CONSTRAINT project_brief_components_pkey PRIMARY KEY (id);


--
-- Name: project_builder_questions project_builder_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_builder_questions
    ADD CONSTRAINT project_builder_questions_pkey PRIMARY KEY (id);


--
-- Name: project_builder_steps project_builder_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_builder_steps
    ADD CONSTRAINT project_builder_steps_pkey PRIMARY KEY (id);


--
-- Name: project_colors project_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_colors
    ADD CONSTRAINT project_colors_pkey PRIMARY KEY (id);


--
-- Name: project_source_files project_source_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_source_files
    ADD CONSTRAINT project_source_files_pkey PRIMARY KEY (id);


--
-- Name: project_stock_images project_stock_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_stock_images
    ADD CONSTRAINT project_stock_images_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: spots spots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (id);


--
-- Name: start_notification_requests start_notification_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.start_notification_requests
    ADD CONSTRAINT start_notification_requests_pkey PRIMARY KEY (id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: uploaded_files uploaded_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploaded_files
    ADD CONSTRAINT uploaded_files_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vat_rates vat_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vat_rates
    ADD CONSTRAINT vat_rates_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_abandoned_cart_discounts_on_discount_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_abandoned_cart_discounts_on_discount_id ON public.abandoned_cart_discounts USING btree (discount_id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_additional_design_prices_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_additional_design_prices_on_product_id ON public.additional_design_prices USING btree (product_id);


--
-- Name: index_additional_screen_prices_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_additional_screen_prices_on_product_id ON public.additional_screen_prices USING btree (product_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_brand_dnas_on_brand_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_brand_dnas_on_brand_id ON public.brand_dnas USING btree (brand_id);


--
-- Name: index_brand_examples_on_example_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_brand_examples_on_example_id ON public.brand_examples USING btree (example_id);


--
-- Name: index_brand_examples_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_brand_examples_on_project_id ON public.brand_examples USING btree (project_id);


--
-- Name: index_brands_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_brands_on_company_id ON public.brands USING btree (company_id);


--
-- Name: index_clients_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_on_company_id ON public.clients USING btree (company_id);


--
-- Name: index_clients_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_on_user_id ON public.clients USING btree (user_id);


--
-- Name: index_competitors_on_brand_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_competitors_on_brand_id ON public.competitors USING btree (brand_id);


--
-- Name: index_designer_client_blocks_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_client_blocks_on_client_id ON public.designer_client_blocks USING btree (client_id);


--
-- Name: index_designer_client_blocks_on_client_id_and_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_designer_client_blocks_on_client_id_and_designer_id ON public.designer_client_blocks USING btree (client_id, designer_id);


--
-- Name: index_designer_client_blocks_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_client_blocks_on_designer_id ON public.designer_client_blocks USING btree (designer_id);


--
-- Name: index_designer_experiences_on_designer_and_product_category; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_designer_experiences_on_designer_and_product_category ON public.designer_experiences USING btree (designer_id, product_category_id);


--
-- Name: index_designer_experiences_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_experiences_on_designer_id ON public.designer_experiences USING btree (designer_id);


--
-- Name: index_designer_experiences_on_product_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_experiences_on_product_category_id ON public.designer_experiences USING btree (product_category_id);


--
-- Name: index_designer_ndas_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_ndas_on_designer_id ON public.designer_ndas USING btree (designer_id);


--
-- Name: index_designer_ndas_on_designer_id_and_nda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_designer_ndas_on_designer_id_and_nda_id ON public.designer_ndas USING btree (designer_id, nda_id);


--
-- Name: index_designer_ndas_on_nda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designer_ndas_on_nda_id ON public.designer_ndas USING btree (nda_id);


--
-- Name: index_designers_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designers_on_discarded_at ON public.designers USING btree (discarded_at);


--
-- Name: index_designers_on_hero_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designers_on_hero_image_id ON public.designers USING btree (hero_image_id);


--
-- Name: index_designers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designers_on_user_id ON public.designers USING btree (user_id);


--
-- Name: index_designs_on_spot_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designs_on_spot_id ON public.designs USING btree (spot_id);


--
-- Name: index_designs_on_uploaded_file_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_designs_on_uploaded_file_id ON public.designs USING btree (uploaded_file_id);


--
-- Name: index_direct_conversation_messages_on_design_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_direct_conversation_messages_on_design_id ON public.direct_conversation_messages USING btree (design_id);


--
-- Name: index_direct_conversation_messages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_direct_conversation_messages_on_user_id ON public.direct_conversation_messages USING btree (user_id);


--
-- Name: index_discounts_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_discounts_on_code ON public.discounts USING btree (code);


--
-- Name: index_discounts_on_discount_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discounts_on_discount_type ON public.discounts USING btree (discount_type);


--
-- Name: index_earnings_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_earnings_on_designer_id ON public.earnings USING btree (designer_id);


--
-- Name: index_earnings_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_earnings_on_project_id ON public.earnings USING btree (project_id);


--
-- Name: index_earnings_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_earnings_on_state ON public.earnings USING btree (state);


--
-- Name: index_existing_designs_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_existing_designs_on_project_id ON public.existing_designs USING btree (project_id);


--
-- Name: index_faq_groups_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_faq_groups_on_name ON public.faq_groups USING btree (name);


--
-- Name: index_faq_items_on_faq_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_faq_items_on_faq_group_id ON public.faq_items USING btree (faq_group_id);


--
-- Name: index_faq_items_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_faq_items_on_name ON public.faq_items USING btree (name);


--
-- Name: index_featured_images_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_featured_images_on_project_id ON public.featured_images USING btree (project_id);


--
-- Name: index_feedbacks_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feedbacks_on_email ON public.feedbacks USING btree (email);


--
-- Name: index_inspirations_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inspirations_on_project_id ON public.inspirations USING btree (project_id);


--
-- Name: index_logins_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logins_on_user_id ON public.logins USING btree (user_id);


--
-- Name: index_ndas_on_brand_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ndas_on_brand_id ON public.ndas USING btree (brand_id);


--
-- Name: index_ndas_on_nda_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ndas_on_nda_type ON public.ndas USING btree (nda_type);


--
-- Name: index_payments_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_project_id ON public.payments USING btree (project_id);


--
-- Name: index_payouts_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payouts_on_designer_id ON public.payouts USING btree (designer_id);


--
-- Name: index_payouts_on_payout_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payouts_on_payout_state ON public.payouts USING btree (payout_state);


--
-- Name: index_portfolio_images_on_uploaded_file_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_portfolio_images_on_uploaded_file_id ON public.portfolio_images USING btree (uploaded_file_id);


--
-- Name: index_portfolio_works_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_portfolio_works_on_designer_id ON public.portfolio_works USING btree (designer_id);


--
-- Name: index_portfolio_works_on_product_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_portfolio_works_on_product_category_id ON public.portfolio_works USING btree (product_category_id);


--
-- Name: index_products_on_product_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_product_category_id ON public.products USING btree (product_category_id);


--
-- Name: index_project_additional_documents_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_additional_documents_on_project_id ON public.project_additional_documents USING btree (project_id);


--
-- Name: index_project_brand_examples_on_brand_example_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_brand_examples_on_brand_example_id ON public.project_brand_examples USING btree (brand_example_id);


--
-- Name: index_project_brand_examples_on_example_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_brand_examples_on_example_type ON public.project_brand_examples USING btree (example_type);


--
-- Name: index_project_brand_examples_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_brand_examples_on_project_id ON public.project_brand_examples USING btree (project_id);


--
-- Name: index_project_brief_components_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_brief_components_on_product_id ON public.project_brief_components USING btree (product_id);


--
-- Name: index_project_builder_questions_on_project_builder_step_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_builder_questions_on_project_builder_step_id ON public.project_builder_questions USING btree (project_builder_step_id);


--
-- Name: index_project_builder_steps_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_builder_steps_on_product_id ON public.project_builder_steps USING btree (product_id);


--
-- Name: index_project_colors_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_colors_on_project_id ON public.project_colors USING btree (project_id);


--
-- Name: index_project_source_files_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_source_files_on_designer_id ON public.project_source_files USING btree (designer_id);


--
-- Name: index_project_source_files_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_source_files_on_project_id ON public.project_source_files USING btree (project_id);


--
-- Name: index_project_stock_images_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_stock_images_on_project_id ON public.project_stock_images USING btree (project_id);


--
-- Name: index_project_stock_images_on_stock_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_project_stock_images_on_stock_image_id ON public.project_stock_images USING btree (stock_image_id);


--
-- Name: index_projects_on_brand_dna_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_brand_dna_id ON public.projects USING btree (brand_dna_id);


--
-- Name: index_projects_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_creator_id ON public.projects USING btree (creator_id);


--
-- Name: index_projects_on_current_step_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_current_step_id ON public.projects USING btree (current_step_id);


--
-- Name: index_projects_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_discarded_at ON public.projects USING btree (discarded_at);


--
-- Name: index_projects_on_discount_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_discount_id ON public.projects USING btree (discount_id);


--
-- Name: index_projects_on_manual_product_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_manual_product_category_id ON public.projects USING btree (manual_product_category_id);


--
-- Name: index_projects_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_name ON public.projects USING btree (name);


--
-- Name: index_projects_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_product_id ON public.projects USING btree (product_id);


--
-- Name: index_projects_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_state ON public.projects USING btree (state);


--
-- Name: index_prt_imgs_lsts_on_prt_img_id_and_prt_lst_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prt_imgs_lsts_on_prt_img_id_and_prt_lst_id ON public.portfolio_images_lists USING btree (portfolio_image_id, portfolio_list_id);


--
-- Name: index_prt_imgs_lsts_on_prt_lst_id_and_prt_img_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prt_imgs_lsts_on_prt_lst_id_and_prt_img_id ON public.portfolio_images_lists USING btree (portfolio_list_id, portfolio_image_id);


--
-- Name: index_reviews_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_client_id ON public.reviews USING btree (client_id);


--
-- Name: index_reviews_on_design_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_reviews_on_design_id ON public.reviews USING btree (design_id);


--
-- Name: index_spots_on_designer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_spots_on_designer_id ON public.spots USING btree (designer_id);


--
-- Name: index_spots_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_spots_on_project_id ON public.spots USING btree (project_id);


--
-- Name: index_start_notification_requests_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_start_notification_requests_on_email ON public.start_notification_requests USING btree (email);


--
-- Name: index_uploaded_files_on_entity_type_and_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploaded_files_on_entity_type_and_entity_id ON public.uploaded_files USING btree (entity_type, entity_id);


--
-- Name: index_users_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_discarded_at ON public.users USING btree (discarded_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_state ON public.users USING btree (state);


--
-- Name: index_users_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_uid_and_provider ON public.users USING btree (uid, provider);


--
-- Name: index_vat_rates_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vat_rates_on_country_code ON public.vat_rates USING btree (country_code);


--
-- Name: index_vat_rates_on_country_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vat_rates_on_country_name ON public.vat_rates USING btree (country_name);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: packaging_measurements_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX packaging_measurements_index ON public.projects USING btree (packaging_measurements_type, packaging_measurements_id);


--
-- Name: designers fk_rails_00ecb183d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designers
    ADD CONSTRAINT fk_rails_00ecb183d7 FOREIGN KEY (hero_image_id) REFERENCES public.featured_images(id);


--
-- Name: projects fk_rails_03ec10b0d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_03ec10b0d3 FOREIGN KEY (creator_id) REFERENCES public.clients(id);


--
-- Name: project_source_files fk_rails_08caced007; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_source_files
    ADD CONSTRAINT fk_rails_08caced007 FOREIGN KEY (designer_id) REFERENCES public.designers(id);


--
-- Name: reviews fk_rails_09c661230e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_09c661230e FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: designer_ndas fk_rails_0d5ebd60b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_ndas
    ADD CONSTRAINT fk_rails_0d5ebd60b2 FOREIGN KEY (designer_id) REFERENCES public.designers(id);


--
-- Name: clients fk_rails_21c421fd41; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_rails_21c421fd41 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: projects fk_rails_21e11c2480; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_21e11c2480 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: project_additional_documents fk_rails_22c7c7c0ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_additional_documents
    ADD CONSTRAINT fk_rails_22c7c7c0ca FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: direct_conversation_messages fk_rails_240f5fccd1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_conversation_messages
    ADD CONSTRAINT fk_rails_240f5fccd1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: portfolio_works fk_rails_369abbdf5e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_works
    ADD CONSTRAINT fk_rails_369abbdf5e FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id);


--
-- Name: additional_design_prices fk_rails_3a0b478dfe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_design_prices
    ADD CONSTRAINT fk_rails_3a0b478dfe FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: project_brand_examples fk_rails_416b02997f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brand_examples
    ADD CONSTRAINT fk_rails_416b02997f FOREIGN KEY (brand_example_id) REFERENCES public.uploaded_files(id);


--
-- Name: brand_examples fk_rails_432d41ba5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_examples
    ADD CONSTRAINT fk_rails_432d41ba5c FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_stock_images fk_rails_4827494184; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_stock_images
    ADD CONSTRAINT fk_rails_4827494184 FOREIGN KEY (stock_image_id) REFERENCES public.uploaded_files(id);


--
-- Name: spots fk_rails_4909d5c130; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT fk_rails_4909d5c130 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: brands fk_rails_56bab4888f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT fk_rails_56bab4888f FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: faq_items fk_rails_56dd26aae2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_items
    ADD CONSTRAINT fk_rails_56dd26aae2 FOREIGN KEY (faq_group_id) REFERENCES public.faq_groups(id);


--
-- Name: designs fk_rails_6083605ebd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designs
    ADD CONSTRAINT fk_rails_6083605ebd FOREIGN KEY (uploaded_file_id) REFERENCES public.uploaded_files(id);


--
-- Name: reviews fk_rails_703d0f77a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_703d0f77a5 FOREIGN KEY (design_id) REFERENCES public.designs(id);


--
-- Name: projects fk_rails_75c2765c6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_75c2765c6b FOREIGN KEY (manual_product_category_id) REFERENCES public.product_categories(id);


--
-- Name: logins fk_rails_767ed2de2b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT fk_rails_767ed2de2b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: designer_experiences fk_rails_7dd42e440c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_experiences
    ADD CONSTRAINT fk_rails_7dd42e440c FOREIGN KEY (designer_id) REFERENCES public.designers(id);


--
-- Name: direct_conversation_messages fk_rails_870b526e39; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_conversation_messages
    ADD CONSTRAINT fk_rails_870b526e39 FOREIGN KEY (design_id) REFERENCES public.designs(id);


--
-- Name: competitors fk_rails_89890717bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.competitors
    ADD CONSTRAINT fk_rails_89890717bd FOREIGN KEY (brand_id) REFERENCES public.brands(id);


--
-- Name: designers fk_rails_8b001e9a6f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designers
    ADD CONSTRAINT fk_rails_8b001e9a6f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: featured_images fk_rails_8b62d4f05d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.featured_images
    ADD CONSTRAINT fk_rails_8b62d4f05d FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: additional_screen_prices fk_rails_8d5f06c77f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.additional_screen_prices
    ADD CONSTRAINT fk_rails_8d5f06c77f FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: portfolio_works fk_rails_afb06e3c32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portfolio_works
    ADD CONSTRAINT fk_rails_afb06e3c32 FOREIGN KEY (designer_id) REFERENCES public.designers(id);


--
-- Name: project_colors fk_rails_b03cd8d8f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_colors
    ADD CONSTRAINT fk_rails_b03cd8d8f1 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: brand_examples fk_rails_b15e1ce224; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_examples
    ADD CONSTRAINT fk_rails_b15e1ce224 FOREIGN KEY (example_id) REFERENCES public.uploaded_files(id);


--
-- Name: designer_ndas fk_rails_b66961d733; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_ndas
    ADD CONSTRAINT fk_rails_b66961d733 FOREIGN KEY (nda_id) REFERENCES public.ndas(id);


--
-- Name: existing_designs fk_rails_bc7713f925; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existing_designs
    ADD CONSTRAINT fk_rails_bc7713f925 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: projects fk_rails_bff25527e5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_bff25527e5 FOREIGN KEY (brand_dna_id) REFERENCES public.brand_dnas(id);


--
-- Name: spots fk_rails_c06c800676; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT fk_rails_c06c800676 FOREIGN KEY (designer_id) REFERENCES public.designers(id);


--
-- Name: designer_experiences fk_rails_ca80f2599d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designer_experiences
    ADD CONSTRAINT fk_rails_ca80f2599d FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id);


--
-- Name: inspirations fk_rails_cb4822058a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspirations
    ADD CONSTRAINT fk_rails_cb4822058a FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: ndas fk_rails_ceee7477e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ndas
    ADD CONSTRAINT fk_rails_ceee7477e9 FOREIGN KEY (brand_id) REFERENCES public.brands(id);


--
-- Name: project_brand_examples fk_rails_d4ca6e6783; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_brand_examples
    ADD CONSTRAINT fk_rails_d4ca6e6783 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: brand_dnas fk_rails_d52a9ff339; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brand_dnas
    ADD CONSTRAINT fk_rails_d52a9ff339 FOREIGN KEY (brand_id) REFERENCES public.brands(id);


--
-- Name: project_source_files fk_rails_d58268b5bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_source_files
    ADD CONSTRAINT fk_rails_d58268b5bb FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_stock_images fk_rails_d9cc403e5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_stock_images
    ADD CONSTRAINT fk_rails_d9cc403e5f FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: clients fk_rails_db0f958971; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_rails_db0f958971 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: products fk_rails_efe167855e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_efe167855e FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id);


--
-- Name: projects fk_rails_f64f1d118a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_f64f1d118a FOREIGN KEY (discount_id) REFERENCES public.discounts(id);


--
-- Name: projects fk_rails_fa13870fe0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_fa13870fe0 FOREIGN KEY (current_step_id) REFERENCES public.project_builder_steps(id);


--
-- Name: designs fk_rails_fae85d2084; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.designs
    ADD CONSTRAINT fk_rails_fae85d2084 FOREIGN KEY (spot_id) REFERENCES public.spots(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20160930054312'),
('20160930054318'),
('20161004173628'),
('20161011095240'),
('20161013091540'),
('20161019145712'),
('20161031124532'),
('20161101150959'),
('20161111110828'),
('20161111110911'),
('20161115140659'),
('20161116093712'),
('20161116093757'),
('20161118153225'),
('20161124165627'),
('20161202132048'),
('20161205132202'),
('20161205132305'),
('20161222154121'),
('20161223104811'),
('20161223104834'),
('20161227084529'),
('20161227152823'),
('20161228093741'),
('20161230084437'),
('20170104051028'),
('20170105133912'),
('20170106135910'),
('20170110093334'),
('20170110133029'),
('20170111055439'),
('20170111130121'),
('20170111132020'),
('20170111133340'),
('20170111134145'),
('20170111140744'),
('20170111141719'),
('20170113082541'),
('20170113084909'),
('20170116114316'),
('20170116144914'),
('20170117063924'),
('20170119082522'),
('20170119142048'),
('20170123073131'),
('20170123074134'),
('20170123082927'),
('20170124143213'),
('20170126132142'),
('20170126133711'),
('20170126144528'),
('20170201115943'),
('20170203092900'),
('20170203115235'),
('20170203125513'),
('20170207030033'),
('20170207075805'),
('20170210150125'),
('20170211070051'),
('20170211073246'),
('20170214032632'),
('20170214074400'),
('20170214105926'),
('20170214122255'),
('20170214133314'),
('20170215151514'),
('20170216082911'),
('20170216102754'),
('20170216104450'),
('20170217075236'),
('20170217085004'),
('20170217144029'),
('20170220140840'),
('20170220150544'),
('20170221141522'),
('20170221150801'),
('20170222150955'),
('20170224081101'),
('20170302052629'),
('20170302102428'),
('20170302144127'),
('20170306072317'),
('20170306151908'),
('20170307103958'),
('20170309111927'),
('20170314081947'),
('20170314091706'),
('20170328134716'),
('20170329064800'),
('20170331090430'),
('20170404100130'),
('20170410082056'),
('20170411145645'),
('20170414135113'),
('20170418101254'),
('20170424072013'),
('20170424072014'),
('20170424072015'),
('20170424155533'),
('20170424155940'),
('20170503130503'),
('20170514085852'),
('20170514085853'),
('20170515145558'),
('20170516144528'),
('20170608080921'),
('20170615111303'),
('20170616124102'),
('20170818124338'),
('20170821064114'),
('20170928153130'),
('20170928153409'),
('20170928153650'),
('20171129154857'),
('20171130140514'),
('20171207141231'),
('20171220141744'),
('20171228091523'),
('20171228154043'),
('20171229102827'),
('20180116091834'),
('20180116165710'),
('20180201091754'),
('20180216134135'),
('20180713161021'),
('20180723135750'),
('20180726082610'),
('20180726111705'),
('20180730155923'),
('20180803092907'),
('20180808153117'),
('20180814101547'),
('20180816133443'),
('20190322144250'),
('20190402104011'),
('20190404113613'),
('20190408131329'),
('20190409121806'),
('20190409131926'),
('20190409132907'),
('20190409140037'),
('20190409140050'),
('20190409185028'),
('20190409193018'),
('20190410124138'),
('20190410141115'),
('20190410142323'),
('20190410151904'),
('20190411092012'),
('20190411093506'),
('20190411095219'),
('20190426103041'),
('20190513145005'),
('20190520152044'),
('20190524145115'),
('20190604154336'),
('20190610144929'),
('20190627102031'),
('20190627104556'),
('20190628121147'),
('20190820091424'),
('20190823093527'),
('20190823151125'),
('20190903121853'),
('20190904153403'),
('20190909103445'),
('20190918114629'),
('20190920132314'),
('20190923174623'),
('20190924143152'),
('20190925145558'),
('20190925155917'),
('20190930114726'),
('20190930163009'),
('20190930174534'),
('20191008142009'),
('20191010112548'),
('20191011102035'),
('20191015140233'),
('20191018144815'),
('20191022120342'),
('20191028101243'),
('20191105114114'),
('20191121132034'),
('20191121132042'),
('20191125105720'),
('20191125141022'),
('20191126105312'),
('20191203162928'),
('20191203162942'),
('20191203171247'),
('20191218145936'),
('20191220150856'),
('20191224100325'),
('20200120201310'),
('20200121160653'),
('20200122130729'),
('20200201090056'),
('20200206160931'),
('20200221064438'),
('20200221184251'),
('20200303195323'),
('20200313201116'),
('20200319202810'),
('20200504170010'),
('20200508150112'),
('20200612131122'),
('20200630193940'),
('20200707140954'),
('20200715130756'),
('20200819113103'),
('20200901185454'),
('20200907202142'),
('20200914082719'),
('20200914194925'),
('20200922211108'),
('20200928113841'),
('20201007160710'),
('20201022071829'),
('20201029152656'),
('20201112140203'),
('20201120142037'),
('20201126103107');


