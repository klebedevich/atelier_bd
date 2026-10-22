SET client_encoding = 'UTF8';

-- 1. ENUM-типы
CREATE TYPE order_status AS ENUM (
    'Принят',
    'В работе',
    'Готов',
    'Выдан',
    'Отменён'
);

CREATE TYPE garment_type AS ENUM (
    'Пальто',
    'Пиджак',
    'Брюки',
    'Юбка',
    'Платье',
    'Рубашка',
    'Жакет',
    'Блуза',
    'Пальто зимнее',
    'Костюм'
);

CREATE TYPE cut_style_type AS ENUM (
    'Приталенный',
    'Прямой',
    'Свободный',
    'Классический',
    'Расклешённый'
);

CREATE TYPE applicability_type AS ENUM (
    'Основная',
    'Подкладочная',
    'Прокладочная',
    'Отделочная'
);

-- 2. Таблицы

CREATE TABLE atelier (
    atelier_id SERIAL       PRIMARY KEY,
    address    VARCHAR(200) NOT NULL,
    phone      VARCHAR(15)  NOT NULL
);

CREATE TABLE client (
    client_id  SERIAL       PRIMARY KEY,
    surname    VARCHAR(40)  NOT NULL,
    name       VARCHAR(15)  NOT NULL,
    patronymic VARCHAR(20),
    phone      VARCHAR(15)  NOT NULL,
    email      VARCHAR(320),
    birth_date DATE         NOT NULL
);

CREATE TABLE atelier_client (
    client_id  INT NOT NULL REFERENCES client(client_id)   ON DELETE CASCADE,
    atelier_id INT NOT NULL REFERENCES atelier(atelier_id) ON DELETE CASCADE,
    PRIMARY KEY (client_id, atelier_id)
);

CREATE TABLE administrator (
    admin_id   SERIAL       PRIMARY KEY,
    surname    VARCHAR(40)  NOT NULL,
    name       VARCHAR(15)  NOT NULL,
    patronymic VARCHAR(20),
    phone      VARCHAR(15)  NOT NULL,
    email      VARCHAR(320) NOT NULL,
    birth_date DATE         NOT NULL,
    atelier_id INT          NOT NULL REFERENCES atelier(atelier_id)
);

CREATE TABLE tailor (
    tailor_id  SERIAL       PRIMARY KEY,
    surname    VARCHAR(40)  NOT NULL,
    name       VARCHAR(15)  NOT NULL,
    patronymic VARCHAR(20),
    phone      VARCHAR(15)  NOT NULL,
    email      VARCHAR(320),
    birth_date DATE         NOT NULL,
    atelier_id INT          NOT NULL REFERENCES atelier(atelier_id)
);

CREATE TABLE "order" (
    order_id        SERIAL        PRIMARY KEY,
    order_date      DATE          NOT NULL,
    completion_date DATE,
    status          order_status  NOT NULL DEFAULT 'Принят',
    total_cost      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    client_id       INT           NOT NULL REFERENCES client(client_id),
    tailor_id       INT           NOT NULL REFERENCES tailor(tailor_id),
    admin_id        INT           NOT NULL REFERENCES administrator(admin_id)
);

CREATE TABLE garment (
    garment_id   SERIAL         PRIMARY KEY,
    product_type garment_type   NOT NULL,
    cut_style    cut_style_type NOT NULL,
    order_id     INT            NOT NULL REFERENCES "order"(order_id),
    tailor_id    INT            NOT NULL REFERENCES tailor(tailor_id)
);

CREATE TABLE fabric (
    fabric_id     SERIAL             PRIMARY KEY,
    article       VARCHAR(20)        NOT NULL,
    manufacturer  VARCHAR(60)        NOT NULL,
    composition   VARCHAR(75)        NOT NULL,
    meters_used   DECIMAL(10,2)      NOT NULL,
    color         VARCHAR(25)        NOT NULL,
    applicability applicability_type NOT NULL DEFAULT 'Основная'
);

CREATE TABLE fabric_garment (
    garment_id INT NOT NULL REFERENCES garment(garment_id) ON DELETE CASCADE,
    fabric_id  INT NOT NULL REFERENCES fabric(fabric_id)   ON DELETE CASCADE,
    PRIMARY KEY (garment_id, fabric_id)
);

CREATE TABLE accessories (
    accessory_id  SERIAL      PRIMARY KEY,
    type          VARCHAR(30) NOT NULL,
    material      VARCHAR(40) NOT NULL,
    manufacturer  VARCHAR(60) NOT NULL,
    article       VARCHAR(20) NOT NULL,
    quantity_used INT         NOT NULL
);

CREATE TABLE accessories_garment (
    garment_id   INT NOT NULL REFERENCES garment(garment_id)      ON DELETE CASCADE,
    accessory_id INT NOT NULL REFERENCES accessories(accessory_id) ON DELETE CASCADE,
    PRIMARY KEY (garment_id, accessory_id)
);
