PGDMP     3            
        {            crypt    15.3    15.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24578    crypt    DATABASE     �   CREATE DATABASE crypt WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Chinese (Simplified)_China.936';
    DROP DATABASE crypt;
                crypt    false            �            1259    24580    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    salt_and_hashed_password character varying(250) NOT NULL,
    email_address character varying(250) NOT NULL
);
    DROP TABLE public.users;
       public         heap    crypt    false            �            1259    24579    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          crypt    false    215            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          crypt    false    214            e           2604    24583    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          crypt    false    214    215    215            �          0    24580    users 
   TABLE DATA           V   COPY public.users (id, username, salt_and_hashed_password, email_address) FROM stdin;
    public          crypt    false    215   �
       �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 28, true);
          public          crypt    false    214            g           2606    24585    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            crypt    false    215            �   �  x�]V˶����ϲl�5�r&�dC!����_��	�;3Y*�JU�!�#����%��w���L4���~��n�>��Y���Ŕl͖�#����V� d�)�4�f����Xv��ň��������8|�Ohs�L����Ad{v����e��~��1dh�B"ɮ@q�EYR,Y�
�`CW8�P�l3��X7Z'� �zD��1wϣ�Aw��G�^��������<�Qp�'�[4�9h� HAJ��/L�y�	+�W|u蓱���p.�ō)����8N�<��ڝ�S��mk�(��������SˉK�� +���~O!V�FH�TS���҃�`V6|Zn�0T�:LS���# #�o)5��n[cȡeB��A��y�P(��/�o�3�36�*a��2��G��� ������ԅ�_���q�� (H�b[��Z�%:19V�\8�"�͆ 5d��uJ���(�Rb�11A�HD��MqHi=���N�2o�6,��\���_�iY^����fI!�,g�Ur-�%�1X(�M�M��J%���k�?f�l�<T(y�x�c�4��{7_�*�'����R
�؂�F�D�N-A2� GBL����B$j�l+���r������_�!�i�o�DĂ��j�j�X�}���Qr���㪐k���n#��J��b�3�f�)uI\kjsۂwb�y�L)���5U�tʿ��"E�i{��b�:v�<��eZ�غ��<�i*r6��F_�+`a�Q佴�*��u[4eH9���(U�[�o82o&�]CU�y������-�MO��!�~�����<�OM�;c4��߫4�9խ�y�K"N1��}�*�5~<���TY��f#��ޝ��q��8�.�w��g�����XV�&&��5�"��[���Y�x�T�<MV4���PU��2���❫�ze�y<ĥj���q?���\�T���[q�W^6��O߻�4ӂ��jl�`@��:G�(����S�4q����C��~*9��vV�8��=��t��7�:�Y�ʃ!��j�	\��d�XR�,�	��@u�˨~v��x����W8��.�~~<��۵8��m��֦�&2�c[ΕDWD9���DV5K.I0i�J-�Y�B���JS%��" ~�1���Uz�rM��F>�����f
���sM]K_#@�kO��ې���Z�7��1�*9dC�e���Þa�9%t���ti�G{���;5�^#�ï��fua-=[՜Ʉ�0�Y��#Wօ�[�TIJjsiS�O���)�"�E��ʦ�W�����[���|�<-����a�n�ށ�4���dMqmVm6���%�N��,I-�R��:���'�_� ��ɠ~�7��އ!����w�`��0s^�xZB�Ik�e�Ej㥆*�k�ޔ�j�MLV[�W�f]Hy���߿___�Y�"�     