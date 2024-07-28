-- tabla pokemon
CREATE TABLE public.pokemon
(
    id_pokemon integer NOT NULL DEFAULT nextval('pokemon_id_pokemon_seq'::regclass),
    nombre character varying COLLATE pg_catalog."default",
    tipo character varying COLLATE pg_catalog."default",
    habilidad character varying COLLATE pg_catalog."default",
    estadistica integer,
    CONSTRAINT pokemon_pkey PRIMARY KEY (id_pokemon)
)

--tabla entrenador
CREATE TABLE public.entrenador
(
    id_entrenador integer NOT NULL DEFAULT nextval('entrenador_id_entrenador_seq'::regclass),
    nombre character varying COLLATE pg_catalog."default",
    edad integer,
    sexo character varying COLLATE pg_catalog."default",
    CONSTRAINT entrenador_pkey PRIMARY KEY (id_entrenador)
)

	-- tabla pokemon entrenador
CREATE TABLE public.pokemon_entrenador
(
    id_pokemon integer NOT NULL,
    id_entrenador integer NOT NULL,
    CONSTRAINT pokemon_entrenador_pkey PRIMARY KEY (id_pokemon, id_entrenador),
    CONSTRAINT pokemon_entrenador_id_entrenador_fkey FOREIGN KEY (id_entrenador)
        REFERENCES public.entrenador (id_entrenador) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pokemon_entrenador_id_pokemon_fkey FOREIGN KEY (id_pokemon)
        REFERENCES public.pokemon (id_pokemon) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

-- tabla batalla
CREATE TABLE public.batalla
(
    id_batalla integer NOT NULL,
    entrenador_1 integer,
    entrenador_2 integer,
    entrenador_ganador_id integer,
    entrenador_perdedor_id integer,
    CONSTRAINT batalla_pkey PRIMARY KEY (id_batalla),
    CONSTRAINT batalla_entrenador_1_fkey FOREIGN KEY (entrenador_1)
        REFERENCES public.entrenador (id_entrenador) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT batalla_entrenador_2_fkey FOREIGN KEY (entrenador_2)
        REFERENCES public.entrenador (id_entrenador) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_batalla_entrenador_ganador FOREIGN KEY (entrenador_ganador_id)
        REFERENCES public.entrenador (id_entrenador) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT fk_batalla_entrenador_perdedor FOREIGN KEY (entrenador_perdedor_id)
        REFERENCES public.entrenador (id_entrenador) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
)

-- crud pokemon
	
-- crear un nuevo pokemon
insert into pokemon (nombre, tipo, habilidad, estadistica)
values ('salamence', 'dragon','garra dragon', 218)

-- ver todos los pokemones
 select * from pokemon
 order by id_pokemon asc 

-- actualizar un pokemon
UPDATE public.pokemon
	SET nombre= 'pikachu'
	WHERE id_pokemon= 1;

-- Eliminar un pokemon
DELETE FROM public.pokemon
	WHERE id_pokemon=1;

--eliminar un entrenador
DELETE FROM public.entrenador
	WHERE id_entrenador=1;

--ver todos los entrenadores con sus pokemones (id y nombres)
SELECT 
    e.id_entrenador,
    e.nombre AS entrenador_nombre,
    p.id_pokemon,
    p.nombre AS pokemon_nombre
FROM 
    entrenador e
JOIN 
    pokemon_entrenador pe ON e.id_entrenador = pe.id_entrenador
JOIN 
    pokemon p ON pe.id_pokemon = p.id_pokemon;


-- ver solo los id de esta tabla
select * from pokemon_entrenador

-- ver la batalla completa

Select 
b.id_batalla,
e1.nombre as entrenador_1_nombre,
p1.nombre as pokemon_entrenador_1,
e2.nombre as entrenador_2_nombre,
p2.nombre as pokemon_entrenador_2,
e3.nombre as entrenador_ganador_nombre,
e4.nombre as entrenador_perdedor_nombre

from batalla b 

left join 
entrenador e1 on b.entrenador_1=e1.id_entrenador

left join
pokemon_entrenador ep1 on e1.id_entrenador = ep1.id_entrenador

left join
pokemon p1 on ep1.id_pokemon= p1.id_pokemon

left join
entrenador e2 on b.entrenador_2=e2.id_entrenador

left join
pokemon_entrenador ep2 on e2.id_entrenador = ep2.id_entrenador

left join
pokemon p2 on ep2.id_pokemon= p2.id_pokemon

left join 
entrenador e3 on b.entrenador_ganador_id=e3.id_entrenador

left join 
entrenador e4 on b.entrenador_perdedor_id=e4.id_entrenador





