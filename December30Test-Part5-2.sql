PGDMP     4    ,                 y            December30Part5db2    13.1    13.1 #    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16678    December30Part5db2    DATABASE     p   CREATE DATABASE "December30Part5db2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Hebrew_Israel.1252';
 $   DROP DATABASE "December30Part5db2";
                postgres    false            �            1259    16716    actors    TABLE     Z   CREATE TABLE public.actors (
    id bigint NOT NULL,
    name text,
    birthdate date
);
    DROP TABLE public.actors;
       public         heap    postgres    false            �            1259    16741    actors_id_seq    SEQUENCE     v   CREATE SEQUENCE public.actors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.actors_id_seq;
       public          postgres    false    202            �           0    0    actors_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.actors_id_seq OWNED BY public.actors.id;
          public          postgres    false    204            �            1259    16679    genres    TABLE     F   CREATE TABLE public.genres (
    id bigint NOT NULL,
    name text
);
    DROP TABLE public.genres;
       public         heap    postgres    false            �            1259    16744    genres_id_seq    SEQUENCE     v   CREATE SEQUENCE public.genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.genres_id_seq;
       public          postgres    false    200            �           0    0    genres_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;
          public          postgres    false    205            �            1259    16687    movies    TABLE     r   CREATE TABLE public.movies (
    id bigint NOT NULL,
    name text,
    release_date date,
    genre_id bigint
);
    DROP TABLE public.movies;
       public         heap    postgres    false            �            1259    16724    movies_actors    TABLE     h   CREATE TABLE public.movies_actors (
    id bigint NOT NULL,
    movie_id bigint,
    actor_id bigint
);
 !   DROP TABLE public.movies_actors;
       public         heap    postgres    false            �            1259    16747    movies_id_seq    SEQUENCE     v   CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.movies_id_seq;
       public          postgres    false    201            �           0    0    movies_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;
          public          postgres    false    206            7           2604    16743 	   actors id    DEFAULT     f   ALTER TABLE ONLY public.actors ALTER COLUMN id SET DEFAULT nextval('public.actors_id_seq'::regclass);
 8   ALTER TABLE public.actors ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    202            5           2604    16746 	   genres id    DEFAULT     f   ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);
 8   ALTER TABLE public.genres ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    200            6           2604    16749 	   movies id    DEFAULT     f   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    201            �          0    16716    actors 
   TABLE DATA           5   COPY public.actors (id, name, birthdate) FROM stdin;
    public          postgres    false    202   �$       �          0    16679    genres 
   TABLE DATA           *   COPY public.genres (id, name) FROM stdin;
    public          postgres    false    200   �%       �          0    16687    movies 
   TABLE DATA           B   COPY public.movies (id, name, release_date, genre_id) FROM stdin;
    public          postgres    false    201   �%       �          0    16724    movies_actors 
   TABLE DATA           ?   COPY public.movies_actors (id, movie_id, actor_id) FROM stdin;
    public          postgres    false    203   E&       �           0    0    actors_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.actors_id_seq', 5, true);
          public          postgres    false    204            �           0    0    genres_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.genres_id_seq', 4, true);
          public          postgres    false    205            �           0    0    movies_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.movies_id_seq', 5, true);
          public          postgres    false    206            ?           2606    16723    actors actors_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public            postgres    false    202            9           2606    16686    genres genres_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public            postgres    false    200            A           2606    16730 (   movies_actors movies_actors_actor_id_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT movies_actors_actor_id_key UNIQUE (actor_id);
 R   ALTER TABLE ONLY public.movies_actors DROP CONSTRAINT movies_actors_actor_id_key;
       public            postgres    false    203            E           2606    16728     movies_actors movies_actors_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT movies_actors_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.movies_actors DROP CONSTRAINT movies_actors_pkey;
       public            postgres    false    203            ;           2606    16696    movies movies_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_name_key;
       public            postgres    false    201            =           2606    16694    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    201            B           1259    16751 &   movies_actors_actor_id_movie_id_uindex    INDEX     u   CREATE UNIQUE INDEX movies_actors_actor_id_movie_id_uindex ON public.movies_actors USING btree (actor_id, movie_id);
 :   DROP INDEX public.movies_actors_actor_id_movie_id_uindex;
       public            postgres    false    203    203            C           1259    16750    movies_actors_movie_id_uindex    INDEX     b   CREATE UNIQUE INDEX movies_actors_movie_id_uindex ON public.movies_actors USING btree (movie_id);
 1   DROP INDEX public.movies_actors_movie_id_uindex;
       public            postgres    false    203            H           2606    16736 )   movies_actors movies_actors_actor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT movies_actors_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actors(id);
 S   ALTER TABLE ONLY public.movies_actors DROP CONSTRAINT movies_actors_actor_id_fkey;
       public          postgres    false    203    202    2879            G           2606    16731 )   movies_actors movies_actors_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movies_actors
    ADD CONSTRAINT movies_actors_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 S   ALTER TABLE ONLY public.movies_actors DROP CONSTRAINT movies_actors_movie_id_fkey;
       public          postgres    false    203    201    2877            F           2606    16697    movies movies_genre_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id);
 E   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_genre_id_fkey;
       public          postgres    false    200    2873    201            �   �   x��A
�0����)r��Iڴu�"]7f�&�P�2�������=�H���Ev��=���� 1��*�[ķ����{��s�2�\#&��p�5�;�sԗ�X'�Z�=��ܨ	"�,Ն�����#%�      �   3   x�3�N��M��2���/*�/�2�t��MM��2��(���I-����� ��      �   k   x��;�0���]6z��*
��4�$�29?v;���������A�����Ф<)#L"��7�]G�jInՏ�*^l�{�3�d<ʾ�ʋ2���D����      �   (   x�3�4�4�bN. �4�2�4�4�2�4�4����� LZ2     