CREATE TABLE IF NOT EXISTS app.order
(
    id uuid NOT NULL CONSTRAINT order_pk PRIMARY KEY,
    name varchar(255)
);

CREATE TABLE "order" (
                         "id" UUID NOT NULL UNIQUE,
                         "name" VARCHAR(255),
                         PRIMARY KEY("id")
);

CREATE TABLE "line_item" (
                            "id" UUID NOT NULL UNIQUE,
                            "name" VARCHAR(255) NOT NULL,
                            "order_id" UUID NOT NULL,
                            PRIMARY KEY("id")
);

ALTER TABLE "line_item"
    ADD FOREIGN KEY("order_id") REFERENCES "order"("id")
        ON UPDATE NO ACTION ON DELETE SET NULL;