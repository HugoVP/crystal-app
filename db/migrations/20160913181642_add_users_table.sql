-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users (
    id         uuid NOT NULL,
    username   character varying(255) NOT NULL,
    password   character varying(255) NOT NULL,
    firstname  character varying(255) NOT NULL,
    middlename character varying(255) NOT NULL,
    lastname   character varying(255) NOT NULL,
    photo      uuid UNIQUE NOT NULL,
    role       character varying(255) DEFAULT 'RESOURCES'::character varying NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id),
    ADD CONSTRAINT users_role_check CHECK ((
        (role)::text = ANY (ARRAY[
            ('BUILDINGS'::character varying)::text,
            ('MANAGEMENT'::character varying)::text,
            ('MACHINERIES'::character varying)::text,
            ('RESOURCES'::character varying)::text,
            ('WAREHOUSE'::character varying)::text
        ])
    ));

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE IF EXISTS users CASCADE;
