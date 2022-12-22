--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-12-23 01:24:38

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
-- TOC entry 3477 (class 1262 OID 16405)
-- Name: hamburger; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE hamburger WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';


ALTER DATABASE hamburger OWNER TO postgres;

\connect hamburger

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
-- TOC entry 245 (class 1255 OID 25005)
-- Name: counticecek(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.counticecek() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update toplam_icecek set iceceksayi=iceceksayi+1;
return new;
end;
$$;


ALTER FUNCTION public.counticecek() OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 24992)
-- Name: countsiparis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.countsiparis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update toplamsiparis set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.countsiparis() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 25007)
-- Name: counttatli(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.counttatli() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update tatli_sayi set tatlisayi=tatlisayi+1;
return new;
end;
$$;


ALTER FUNCTION public.counttatli() OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 25013)
-- Name: hamburgercesitara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hamburgercesitara(hamburgerid integer) RETURNS TABLE(numara integer, adi character varying, fiyati integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "hamburger_secenek_id", "hamburger_secenegi", "hamburger_fiyat" FROM hamburger_secenekleri
                 WHERE "hamburger_secenek_id" = hamburgerId;
END;
$$;


ALTER FUNCTION public.hamburgercesitara(hamburgerid integer) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 24997)
-- Name: kazanc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kazanc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	toplam integer;
begin 
toplam:=(select sum(toplam_tutar) from siparis);
update toplam_kazanc set toplamkazanc = toplam;
return new;
end;
$$;


ALTER FUNCTION public.kazanc() OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 25009)
-- Name: kdvli(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kdvli(fiyat double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
begin
fiyat:=fiyat*0.08+fiyat;
return fiyat;
end;
$$;


ALTER FUNCTION public.kdvli(fiyat double precision) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 25012)
-- Name: sos_ekle(integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sos_ekle(IN p1 integer, IN p2 text)
    LANGUAGE sql
    AS $$
insert into sos (sos_id,sos_turu) values (p1,p2);
$$;


ALTER PROCEDURE public.sos_ekle(IN p1 integer, IN p2 text) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 25010)
-- Name: totalrecords(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalrecords() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM siparis;
   RETURN total;
END;
$$;


ALTER FUNCTION public.totalrecords() OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 25011)
-- Name: totalrecordssepet(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalrecordssepet() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM siparis_urunler;
   RETURN total;
END;
$$;


ALTER FUNCTION public.totalrecordssepet() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 24606)
-- Name: ekmek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ekmek (
    ekmek_id integer NOT NULL,
    ekmek_turu character varying(50)
);


ALTER TABLE public.ekmek OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24605)
-- Name: ekmek_ekmek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ekmek_ekmek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ekmek_ekmek_id_seq OWNER TO postgres;

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 211
-- Name: ekmek_ekmek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ekmek_ekmek_id_seq OWNED BY public.ekmek.ekmek_id;


--
-- TOC entry 210 (class 1259 OID 24598)
-- Name: et; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.et (
    et_id integer NOT NULL,
    pisme_turu character varying(50),
    et_turu character varying(50),
    gramaj character varying(50),
    gramaj_fiyat integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.et OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24597)
-- Name: et_et_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.et_et_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.et_et_id_seq OWNER TO postgres;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 209
-- Name: et_et_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.et_et_id_seq OWNED BY public.et.et_id;


--
-- TOC entry 220 (class 1259 OID 24643)
-- Name: fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fatura (
    fatura_no integer NOT NULL,
    fatura_tutari integer NOT NULL
);


ALTER TABLE public.fatura OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24642)
-- Name: fatura_fatura_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fatura_fatura_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fatura_fatura_no_seq OWNER TO postgres;

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 219
-- Name: fatura_fatura_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fatura_fatura_no_seq OWNED BY public.fatura.fatura_no;


--
-- TOC entry 234 (class 1259 OID 24869)
-- Name: hamburger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hamburger (
    hamburger_id integer NOT NULL,
    sos_id integer NOT NULL,
    et_id integer NOT NULL,
    ekmek_id integer NOT NULL,
    hamburger_secenek_id integer NOT NULL,
    hamburger_miktar integer NOT NULL
);


ALTER TABLE public.hamburger OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24868)
-- Name: hamburger_hamburger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hamburger_hamburger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hamburger_hamburger_id_seq OWNER TO postgres;

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 233
-- Name: hamburger_hamburger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hamburger_hamburger_id_seq OWNED BY public.hamburger.hamburger_id;


--
-- TOC entry 214 (class 1259 OID 24615)
-- Name: hamburger_secenekleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hamburger_secenekleri (
    hamburger_secenek_id integer NOT NULL,
    hamburger_secenegi character varying(50),
    hamburger_fiyat integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.hamburger_secenekleri OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24614)
-- Name: hamburger_secenekleri_hamburger_secenek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hamburger_secenekleri_hamburger_secenek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hamburger_secenekleri_hamburger_secenek_id_seq OWNER TO postgres;

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 213
-- Name: hamburger_secenekleri_hamburger_secenek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hamburger_secenekleri_hamburger_secenek_id_seq OWNED BY public.hamburger_secenekleri.hamburger_secenek_id;


--
-- TOC entry 216 (class 1259 OID 24625)
-- Name: icecek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icecek (
    icecek_id integer NOT NULL,
    icecek_ismi character varying(50),
    icecek_fiyat integer NOT NULL
);


ALTER TABLE public.icecek OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24624)
-- Name: icecek_icecek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.icecek_icecek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.icecek_icecek_id_seq OWNER TO postgres;

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 215
-- Name: icecek_icecek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.icecek_icecek_id_seq OWNED BY public.icecek.icecek_id;


--
-- TOC entry 222 (class 1259 OID 24650)
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    musteri_id integer NOT NULL,
    musteri_ad character varying(50),
    musteri_soyad character varying(50),
    telefon_no character varying(50),
    musteri_adres character varying(50)
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24649)
-- Name: musteri_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_musteri_id_seq OWNER TO postgres;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 221
-- Name: musteri_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_musteri_id_seq OWNED BY public.musteri.musteri_id;


--
-- TOC entry 230 (class 1259 OID 24709)
-- Name: odeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odeme (
    odeme_id integer NOT NULL,
    odeme_turu character varying(50) NOT NULL
);


ALTER TABLE public.odeme OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24708)
-- Name: odeme_odeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odeme_odeme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.odeme_odeme_id_seq OWNER TO postgres;

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 229
-- Name: odeme_odeme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.odeme_odeme_id_seq OWNED BY public.odeme.odeme_id;


--
-- TOC entry 232 (class 1259 OID 24767)
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    personel_id integer NOT NULL,
    personel_adi character varying(50)
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24766)
-- Name: personel_personel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_personel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_personel_id_seq OWNER TO postgres;

--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 231
-- Name: personel_personel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_personel_id_seq OWNED BY public.personel.personel_id;


--
-- TOC entry 238 (class 1259 OID 24948)
-- Name: siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparis (
    siparis_no integer NOT NULL,
    musteri_id integer NOT NULL,
    odeme_id integer NOT NULL,
    teslimat_id integer NOT NULL,
    personel_id integer NOT NULL,
    sube_id integer NOT NULL,
    toplam_tutar integer NOT NULL,
    kayit_no integer NOT NULL
);


ALTER TABLE public.siparis OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24947)
-- Name: siparis_siparis_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_siparis_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_siparis_no_seq OWNER TO postgres;

--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 237
-- Name: siparis_siparis_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_siparis_no_seq OWNED BY public.siparis.siparis_no;


--
-- TOC entry 236 (class 1259 OID 24896)
-- Name: siparis_urunler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparis_urunler (
    kayit_no integer NOT NULL,
    hamburger_id integer NOT NULL,
    icecek_id integer NOT NULL,
    tatli_id integer NOT NULL,
    fiyat integer
);


ALTER TABLE public.siparis_urunler OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24895)
-- Name: siparis_urunler_kayit_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.siparis_urunler_kayit_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.siparis_urunler_kayit_no_seq OWNER TO postgres;

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 235
-- Name: siparis_urunler_kayit_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.siparis_urunler_kayit_no_seq OWNED BY public.siparis_urunler.kayit_no;


--
-- TOC entry 228 (class 1259 OID 24678)
-- Name: sos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sos (
    sos_id integer NOT NULL,
    sos_turu character varying(50)
);


ALTER TABLE public.sos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24677)
-- Name: sos_sos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sos_sos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sos_sos_id_seq OWNER TO postgres;

--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 227
-- Name: sos_sos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sos_sos_id_seq OWNED BY public.sos.sos_id;


--
-- TOC entry 226 (class 1259 OID 24664)
-- Name: sube; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sube (
    sube_id integer NOT NULL,
    sube_ismi character varying(50),
    sube_telefon character varying(50),
    sube_adres character varying(50)
);


ALTER TABLE public.sube OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24663)
-- Name: sube_sube_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sube_sube_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sube_sube_id_seq OWNER TO postgres;

--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 225
-- Name: sube_sube_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sube_sube_id_seq OWNED BY public.sube.sube_id;


--
-- TOC entry 218 (class 1259 OID 24634)
-- Name: tatli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tatli (
    tatli_id integer NOT NULL,
    tatli_ismi character varying(50),
    tatli_fiyat integer NOT NULL
);


ALTER TABLE public.tatli OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 25002)
-- Name: tatli_sayi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tatli_sayi (
    tatlisayi integer
);


ALTER TABLE public.tatli_sayi OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24633)
-- Name: tatli_tatli_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tatli_tatli_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tatli_tatli_id_seq OWNER TO postgres;

--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 217
-- Name: tatli_tatli_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tatli_tatli_id_seq OWNED BY public.tatli.tatli_id;


--
-- TOC entry 224 (class 1259 OID 24657)
-- Name: teslimat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teslimat (
    teslimat_id integer NOT NULL,
    teslimat_turu character varying(50) NOT NULL
);


ALTER TABLE public.teslimat OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24656)
-- Name: teslimat_teslimat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teslimat_teslimat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teslimat_teslimat_id_seq OWNER TO postgres;

--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 223
-- Name: teslimat_teslimat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teslimat_teslimat_id_seq OWNED BY public.teslimat.teslimat_id;


--
-- TOC entry 241 (class 1259 OID 24999)
-- Name: toplam_icecek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplam_icecek (
    iceceksayi integer
);


ALTER TABLE public.toplam_icecek OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24994)
-- Name: toplam_kazanc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplam_kazanc (
    toplamkazanc integer
);


ALTER TABLE public.toplam_kazanc OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24989)
-- Name: toplamsiparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamsiparis (
    sayi integer
);


ALTER TABLE public.toplamsiparis OWNER TO postgres;

--
-- TOC entry 3261 (class 2604 OID 24609)
-- Name: ekmek ekmek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ekmek ALTER COLUMN ekmek_id SET DEFAULT nextval('public.ekmek_ekmek_id_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 24601)
-- Name: et et_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.et ALTER COLUMN et_id SET DEFAULT nextval('public.et_et_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 24646)
-- Name: fatura fatura_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura ALTER COLUMN fatura_no SET DEFAULT nextval('public.fatura_fatura_no_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 24872)
-- Name: hamburger hamburger_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger ALTER COLUMN hamburger_id SET DEFAULT nextval('public.hamburger_hamburger_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 24618)
-- Name: hamburger_secenekleri hamburger_secenek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger_secenekleri ALTER COLUMN hamburger_secenek_id SET DEFAULT nextval('public.hamburger_secenekleri_hamburger_secenek_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 24628)
-- Name: icecek icecek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek ALTER COLUMN icecek_id SET DEFAULT nextval('public.icecek_icecek_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 24653)
-- Name: musteri musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteri_musteri_id_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 24712)
-- Name: odeme odeme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme ALTER COLUMN odeme_id SET DEFAULT nextval('public.odeme_odeme_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 24770)
-- Name: personel personel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel ALTER COLUMN personel_id SET DEFAULT nextval('public.personel_personel_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 24951)
-- Name: siparis siparis_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis ALTER COLUMN siparis_no SET DEFAULT nextval('public.siparis_siparis_no_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 24899)
-- Name: siparis_urunler kayit_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis_urunler ALTER COLUMN kayit_no SET DEFAULT nextval('public.siparis_urunler_kayit_no_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 24681)
-- Name: sos sos_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sos ALTER COLUMN sos_id SET DEFAULT nextval('public.sos_sos_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 24667)
-- Name: sube sube_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sube ALTER COLUMN sube_id SET DEFAULT nextval('public.sube_sube_id_seq'::regclass);


--
-- TOC entry 3265 (class 2604 OID 24637)
-- Name: tatli tatli_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli ALTER COLUMN tatli_id SET DEFAULT nextval('public.tatli_tatli_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 24660)
-- Name: teslimat teslimat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat ALTER COLUMN teslimat_id SET DEFAULT nextval('public.teslimat_teslimat_id_seq'::regclass);


--
-- TOC entry 3279 (class 2606 OID 24613)
-- Name: ekmek ekmek_ekmek_turu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ekmek
    ADD CONSTRAINT ekmek_ekmek_turu_key UNIQUE (ekmek_turu);


--
-- TOC entry 3281 (class 2606 OID 24611)
-- Name: ekmek ekmek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ekmek
    ADD CONSTRAINT ekmek_pkey PRIMARY KEY (ekmek_id);


--
-- TOC entry 3277 (class 2606 OID 24604)
-- Name: et et_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.et
    ADD CONSTRAINT et_pkey PRIMARY KEY (et_id);


--
-- TOC entry 3295 (class 2606 OID 24648)
-- Name: fatura fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY (fatura_no);


--
-- TOC entry 3311 (class 2606 OID 24874)
-- Name: hamburger hamburger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger
    ADD CONSTRAINT hamburger_pkey PRIMARY KEY (hamburger_id);


--
-- TOC entry 3283 (class 2606 OID 24623)
-- Name: hamburger_secenekleri hamburger_secenekleri_hamburger_secenegi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger_secenekleri
    ADD CONSTRAINT hamburger_secenekleri_hamburger_secenegi_key UNIQUE (hamburger_secenegi);


--
-- TOC entry 3285 (class 2606 OID 24621)
-- Name: hamburger_secenekleri hamburger_secenekleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger_secenekleri
    ADD CONSTRAINT hamburger_secenekleri_pkey PRIMARY KEY (hamburger_secenek_id);


--
-- TOC entry 3287 (class 2606 OID 24632)
-- Name: icecek icecek_icecek_ismi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT icecek_icecek_ismi_key UNIQUE (icecek_ismi);


--
-- TOC entry 3289 (class 2606 OID 24630)
-- Name: icecek icecek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT icecek_pkey PRIMARY KEY (icecek_id);


--
-- TOC entry 3297 (class 2606 OID 24655)
-- Name: musteri musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY (musteri_id);


--
-- TOC entry 3307 (class 2606 OID 24714)
-- Name: odeme odeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT odeme_pkey PRIMARY KEY (odeme_id);


--
-- TOC entry 3309 (class 2606 OID 24772)
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (personel_id);


--
-- TOC entry 3315 (class 2606 OID 24953)
-- Name: siparis siparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_pkey PRIMARY KEY (siparis_no);


--
-- TOC entry 3313 (class 2606 OID 24901)
-- Name: siparis_urunler siparis_urunler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis_urunler
    ADD CONSTRAINT siparis_urunler_pkey PRIMARY KEY (kayit_no);


--
-- TOC entry 3303 (class 2606 OID 24683)
-- Name: sos sos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sos
    ADD CONSTRAINT sos_pkey PRIMARY KEY (sos_id);


--
-- TOC entry 3305 (class 2606 OID 24685)
-- Name: sos sos_sos_turu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sos
    ADD CONSTRAINT sos_sos_turu_key UNIQUE (sos_turu);


--
-- TOC entry 3301 (class 2606 OID 24669)
-- Name: sube sube_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sube
    ADD CONSTRAINT sube_pkey PRIMARY KEY (sube_id);


--
-- TOC entry 3291 (class 2606 OID 24639)
-- Name: tatli tatli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT tatli_pkey PRIMARY KEY (tatli_id);


--
-- TOC entry 3293 (class 2606 OID 24641)
-- Name: tatli tatli_tatli_ismi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT tatli_tatli_ismi_key UNIQUE (tatli_ismi);


--
-- TOC entry 3299 (class 2606 OID 24662)
-- Name: teslimat teslimat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat
    ADD CONSTRAINT teslimat_pkey PRIMARY KEY (teslimat_id);


--
-- TOC entry 3332 (class 2620 OID 24993)
-- Name: siparis counttrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER counttrig AFTER INSERT ON public.siparis FOR EACH ROW EXECUTE FUNCTION public.countsiparis();


--
-- TOC entry 3330 (class 2620 OID 25006)
-- Name: siparis icecektrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER icecektrig AFTER INSERT ON public.siparis FOR EACH ROW EXECUTE FUNCTION public.counticecek();


--
-- TOC entry 3329 (class 2620 OID 24998)
-- Name: siparis kazantrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kazantrig AFTER INSERT ON public.siparis FOR EACH ROW EXECUTE FUNCTION public.kazanc();


--
-- TOC entry 3331 (class 2620 OID 25008)
-- Name: siparis tatlitrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tatlitrig AFTER INSERT ON public.siparis FOR EACH ROW EXECUTE FUNCTION public.counttatli();


--
-- TOC entry 3318 (class 2606 OID 24885)
-- Name: hamburger hamburger_ekmek_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger
    ADD CONSTRAINT hamburger_ekmek_id_fkey FOREIGN KEY (ekmek_id) REFERENCES public.ekmek(ekmek_id);


--
-- TOC entry 3317 (class 2606 OID 24880)
-- Name: hamburger hamburger_et_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger
    ADD CONSTRAINT hamburger_et_id_fkey FOREIGN KEY (et_id) REFERENCES public.et(et_id);


--
-- TOC entry 3319 (class 2606 OID 24890)
-- Name: hamburger hamburger_hamburger_secenek_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger
    ADD CONSTRAINT hamburger_hamburger_secenek_id_fkey FOREIGN KEY (hamburger_secenek_id) REFERENCES public.hamburger_secenekleri(hamburger_secenek_id);


--
-- TOC entry 3316 (class 2606 OID 24875)
-- Name: hamburger hamburger_sos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hamburger
    ADD CONSTRAINT hamburger_sos_id_fkey FOREIGN KEY (sos_id) REFERENCES public.sos(sos_id);


--
-- TOC entry 3328 (class 2606 OID 24984)
-- Name: siparis siparis_kayit_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_kayit_no_fkey FOREIGN KEY (kayit_no) REFERENCES public.siparis_urunler(kayit_no);


--
-- TOC entry 3323 (class 2606 OID 24954)
-- Name: siparis siparis_musteri_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_musteri_id_fkey FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id);


--
-- TOC entry 3324 (class 2606 OID 24959)
-- Name: siparis siparis_odeme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_odeme_id_fkey FOREIGN KEY (odeme_id) REFERENCES public.odeme(odeme_id);


--
-- TOC entry 3326 (class 2606 OID 24969)
-- Name: siparis siparis_personel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_personel_id_fkey FOREIGN KEY (personel_id) REFERENCES public.personel(personel_id);


--
-- TOC entry 3327 (class 2606 OID 24974)
-- Name: siparis siparis_sube_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_sube_id_fkey FOREIGN KEY (sube_id) REFERENCES public.sube(sube_id);


--
-- TOC entry 3325 (class 2606 OID 24964)
-- Name: siparis siparis_teslimat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_teslimat_id_fkey FOREIGN KEY (teslimat_id) REFERENCES public.teslimat(teslimat_id);


--
-- TOC entry 3320 (class 2606 OID 24902)
-- Name: siparis_urunler siparis_urunler_hamburger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis_urunler
    ADD CONSTRAINT siparis_urunler_hamburger_id_fkey FOREIGN KEY (hamburger_id) REFERENCES public.hamburger(hamburger_id);


--
-- TOC entry 3321 (class 2606 OID 24907)
-- Name: siparis_urunler siparis_urunler_icecek_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis_urunler
    ADD CONSTRAINT siparis_urunler_icecek_id_fkey FOREIGN KEY (icecek_id) REFERENCES public.icecek(icecek_id);


--
-- TOC entry 3322 (class 2606 OID 24912)
-- Name: siparis_urunler siparis_urunler_tatli_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis_urunler
    ADD CONSTRAINT siparis_urunler_tatli_id_fkey FOREIGN KEY (tatli_id) REFERENCES public.tatli(tatli_id);


-- Completed on 2022-12-23 01:24:38

--
-- PostgreSQL database dump complete
--

