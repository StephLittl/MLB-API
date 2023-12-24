--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.10 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: batters; Type: TABLE; Schema: public; Owner: mlb_user
--

CREATE TABLE public.batters (
    player_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    age integer,
    team character varying(100),
    g integer,
    pa integer,
    ab integer,
    r integer,
    h integer,
    twob integer,
    threeb integer,
    hr integer,
    rbi integer,
    bb integer,
    ibb integer,
    so integer,
    hbp integer,
    sh integer,
    sf integer,
    gdp integer,
    sb integer,
    cs integer,
    ba double precision,
    obp double precision,
    slg double precision,
    ops double precision,
    mlbid integer
);


ALTER TABLE public.batters OWNER TO mlb_user;

--
-- Name: batters_player_id_seq; Type: SEQUENCE; Schema: public; Owner: mlb_user
--

CREATE SEQUENCE public.batters_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.batters_player_id_seq OWNER TO mlb_user;

--
-- Name: batters_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mlb_user
--

ALTER SEQUENCE public.batters_player_id_seq OWNED BY public.batters.player_id;


--
-- Name: game_pitches; Type: TABLE; Schema: public; Owner: mlb_user
--

CREATE TABLE public.game_pitches (
    player_game_id integer NOT NULL,
    game_pk integer,
    batter integer,
    pitcher integer,
    home_team character varying(10),
    away_team character varying(10),
    inning integer,
    top_bot character varying(3),
    pitch_type character varying(10),
    balls integer,
    strikes integer,
    hit_location double precision,
    pitch_number integer,
    on_first double precision,
    on_second double precision,
    on_third double precision,
    home_score integer,
    away_score integer,
    post_home_score integer,
    post_away_score integer,
    launch_speed double precision,
    launch_angle double precision,
    hit_distance_sc double precision,
    g_date date
);


ALTER TABLE public.game_pitches OWNER TO mlb_user;

--
-- Name: game_pitches_player_game_id_seq; Type: SEQUENCE; Schema: public; Owner: mlb_user
--

CREATE SEQUENCE public.game_pitches_player_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_pitches_player_game_id_seq OWNER TO mlb_user;

--
-- Name: game_pitches_player_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mlb_user
--

ALTER SEQUENCE public.game_pitches_player_game_id_seq OWNED BY public.game_pitches.player_game_id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: mlb_user
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    team character varying(10),
    home boolean,
    opponent character varying(10),
    result character varying(10),
    pa integer,
    ab integer,
    r integer,
    h integer,
    twob integer,
    threeb integer,
    hr integer,
    rbi integer,
    bb integer,
    ibb integer,
    so integer,
    hbp integer,
    sh integer,
    sf integer,
    roe integer,
    gdp integer,
    sb integer,
    cs integer,
    ba double precision,
    obp double precision,
    slg double precision,
    ops double precision,
    lob integer,
    numplayers integer,
    thr character(1),
    oppstart character varying(40),
    g_date date
);


ALTER TABLE public.games OWNER TO mlb_user;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: mlb_user
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO mlb_user;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mlb_user
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: pitchers; Type: TABLE; Schema: public; Owner: mlb_user
--

CREATE TABLE public.pitchers (
    player_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    age integer,
    team character varying(100),
    g integer,
    gs integer,
    w integer,
    l integer,
    sv integer,
    ip double precision,
    h integer,
    r integer,
    er integer,
    bb integer,
    so integer,
    hr integer,
    hbp integer,
    era double precision,
    ab integer,
    twob integer,
    threeb integer,
    ibb integer,
    gdp integer,
    sf integer,
    sb integer,
    cs integer,
    po integer,
    bf integer,
    pit integer,
    str double precision,
    stl double precision,
    sts double precision,
    gb_slash_fb double precision,
    ld double precision,
    pu double precision,
    whip double precision,
    babip double precision,
    sonine double precision,
    so_slash_w double precision,
    mlbid bigint
);


ALTER TABLE public.pitchers OWNER TO mlb_user;

--
-- Name: pitchers_player_id_seq; Type: SEQUENCE; Schema: public; Owner: mlb_user
--

CREATE SEQUENCE public.pitchers_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pitchers_player_id_seq OWNER TO mlb_user;

--
-- Name: pitchers_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mlb_user
--

ALTER SEQUENCE public.pitchers_player_id_seq OWNED BY public.pitchers.player_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: mlb_user
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    team character varying(10),
    age character varying(10),
    ab integer,
    pa integer,
    h integer,
    oneb integer,
    twob integer,
    threeb integer,
    hr integer,
    r integer,
    rbi integer,
    bb integer,
    ibb integer,
    so integer,
    hbp integer,
    sf integer,
    sh integer,
    gdp integer,
    sb integer,
    cs integer,
    avg double precision,
    bbpct double precision,
    kpct double precision,
    obp double precision,
    slg double precision,
    ops double precision
);


ALTER TABLE public.teams OWNER TO mlb_user;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: mlb_user
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO mlb_user;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mlb_user
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: batters player_id; Type: DEFAULT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.batters ALTER COLUMN player_id SET DEFAULT nextval('public.batters_player_id_seq'::regclass);


--
-- Name: game_pitches player_game_id; Type: DEFAULT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.game_pitches ALTER COLUMN player_game_id SET DEFAULT nextval('public.game_pitches_player_game_id_seq'::regclass);


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: pitchers player_id; Type: DEFAULT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.pitchers ALTER COLUMN player_id SET DEFAULT nextval('public.pitchers_player_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Name: batters batters_pkey; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.batters
    ADD CONSTRAINT batters_pkey PRIMARY KEY (player_id);


--
-- Name: game_pitches game_pitches_pkey; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.game_pitches
    ADD CONSTRAINT game_pitches_pkey PRIMARY KEY (player_game_id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: pitchers pitchers_pkey; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.pitchers
    ADD CONSTRAINT pitchers_pkey PRIMARY KEY (player_id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: batters unique_batter; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.batters
    ADD CONSTRAINT unique_batter UNIQUE (mlbid);


--
-- Name: pitchers unique_pitchers; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.pitchers
    ADD CONSTRAINT unique_pitchers UNIQUE (mlbid);


--
-- Name: teams unique_teams; Type: CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT unique_teams UNIQUE (team);


--
-- Name: game_pitches batter_exists; Type: FK CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.game_pitches
    ADD CONSTRAINT batter_exists FOREIGN KEY (batter) REFERENCES public.batters(mlbid);


--
-- Name: games opponent_constraint; Type: FK CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT opponent_constraint FOREIGN KEY (opponent) REFERENCES public.teams(team);


--
-- Name: game_pitches pitcher_exists; Type: FK CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.game_pitches
    ADD CONSTRAINT pitcher_exists FOREIGN KEY (pitcher) REFERENCES public.pitchers(mlbid);


--
-- Name: games team_constraint; Type: FK CONSTRAINT; Schema: public; Owner: mlb_user
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT team_constraint FOREIGN KEY (team) REFERENCES public.teams(team);


--
-- PostgreSQL database dump complete
--

