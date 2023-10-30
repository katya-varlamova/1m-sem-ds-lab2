\c tickets

CREATE TABLE ticket
(
    id            SERIAL PRIMARY KEY,
    ticket_uid    uuid UNIQUE NOT NULL,
    username      VARCHAR(80) NOT NULL,
    flight_number VARCHAR(20) NOT NULL,
    price         INT         NOT NULL,
    status        VARCHAR(20) NOT NULL
        CHECK (status IN ('PAID', 'CANCELED'))
);

INSERT INTO ticket (id, ticket_uid ,username, flight_number, price, status) VALUES
(1, '049161bb-badd-4fa8-9d90-87c9a82b0668', 'name', 'AFL031', 1500, 'PAID');

\c flights

CREATE TABLE flight
(
    id              SERIAL PRIMARY KEY,
    flight_number   VARCHAR(20)              NOT NULL,
    datetime        TIMESTAMP WITH TIME ZONE NOT NULL,
    from_airport_id INT REFERENCES airport (id),
    to_airport_id   INT REFERENCES airport (id),
    price           INT                      NOT NULL
);

INSERT INTO flight (id, flight_number, datetime, from_airport_id, to_airport_id, price) VALUES
(1, 'AFL031', '2021-10-08 20:00', 2, 1, 1500);



CREATE TABLE airport
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(255),
    city    VARCHAR(255),
    country VARCHAR(255)
);

INSERT INTO airport (id, name, city, country) VALUES
(1, 'Шереметьево', 'Москва', 'Россия');
INSERT INTO airport (id, name, city, country) VALUES
(2, 'Пулково', 'Санкт-Петербург', 'Россия');



\c privileges
CREATE TABLE privilege
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(80) NOT NULL UNIQUE,
    status   VARCHAR(80) NOT NULL DEFAULT 'BRONZE'
        CHECK (status IN ('BRONZE', 'SILVER', 'GOLD')),
    balance  INT
);
INSERT INTO privilege (id, username,status, balance) VALUES
(1, 'name', 'GOLD', 1500);

CREATE TABLE privilege_history
(
    id             SERIAL PRIMARY KEY,
    privilege_id   INT REFERENCES privilege (id),
    ticket_uid     uuid        NOT NULL,
    datetime       TIMESTAMP   NOT NULL,
    balance_diff   INT         NOT NULL,
    operation_type VARCHAR(20) NOT NULL
        CHECK (operation_type IN ('FILL_IN_BALANCE', 'DEBIT_THE_ACCOUNT'))
);

INSERT INTO privilege_history (privilege_id, ticket_uid, datetime, balance_diff, operation_type) VALUES
(1,
 'name',
 '049161bb-badd-4fa8-9d90-87c9a82b0668',
 '2021-10-08T19:59:19Z',
 1500);
