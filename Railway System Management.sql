CREATE database railway_system;
use railway_system;

DROP TABLE IF EXISTS railway_system.user_login;
CREATE TABLE IF NOT EXISTS railway_system.user_login (
    user_id VARCHAR(255) PRIMARY KEY,
    user_password TEXT,
    first_name TEXT,
    last_name TEXT,
    sign_up_on DATE,
    email_id TEXT
);

DROP TABLE IF EXISTS railway_system.passenger;
CREATE TABLE IF NOT EXISTS railway_system.passenger (
    passenger_id VARCHAR(255) PRIMARY KEY,
    user_password TEXT,
    first_name TEXT,
    last_name TEXT,
    sign_up_on DATE,
    email_id TEXT,
    contact TEXT
);

DROP TABLE IF EXISTS railway_system.train_type;
CREATE TABLE IF NOT EXISTS railway_system.train_type (
    train_type_id VARCHAR(255) PRIMARY KEY,
    train_type TEXT,
    coaches_count TEXT,
    passenger_strength TEXT,
    train_count DATE
);

DROP TABLE IF EXISTS railway_system.stations;
CREATE TABLE IF NOT EXISTS railway_system.stations (
    station_id VARCHAR(255) PRIMARY KEY,
    station_name TEXT,
    city TEXT,
    state TEXT
);

DROP TABLE IF EXISTS railway_system.train_details;
CREATE TABLE IF NOT EXISTS railway_system.train_details (
    train_id VARCHAR(255) PRIMARY KEY,
    train_type_id VARCHAR(255),
    source_station_id VARCHAR(255),
    destination_station_id VARCHAR(255),
    duration_minutes INT,
    journey_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Default to current timestamp
    journey_end TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- Default to current timestamp
    passenger_strength INT,
    is_available BOOLEAN,
    FOREIGN KEY (train_type_id) REFERENCES railway_system.train_type (train_type_id),
    FOREIGN KEY (source_station_id) REFERENCES railway_system.stations (station_id),
    FOREIGN KEY (destination_station_id) REFERENCES railway_system.stations (station_id)
);

DROP TABLE IF EXISTS railway_system.journey;
CREATE TABLE IF NOT EXISTS railway_system.journey (
    journey_id VARCHAR(255) PRIMARY KEY,
    passenger_id VARCHAR(255),
    train_id VARCHAR(255),
    booking_id TEXT,
    payment_id TEXT,
    payment_status TEXT,
    paid_on TIMESTAMP DEFAULT NULL,    -- Explicitly setting default to NULL
    booking_status TEXT,
    booked_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set default to current timestamp
    seat_alloted TEXT,
    meal_booked BOOLEAN,
    FOREIGN KEY (passenger_id) REFERENCES railway_system.passenger (passenger_id),
    FOREIGN KEY (train_id) REFERENCES railway_system.train_details (train_id)
);

DROP TABLE IF EXISTS railway_system.train_routes;
CREATE TABLE IF NOT EXISTS railway_system.train_routes (
    row_id SERIAL PRIMARY KEY,
    route_id VARCHAR(255),
    train_id VARCHAR(255),
    station_id VARCHAR(255),
    order_number INT,
    halt_duration_minutes INT,
    estimated_arrival TIME,
    estimated_departure TIME,
    FOREIGN KEY (train_id) REFERENCES railway_system.train_details (train_id),
    FOREIGN KEY (station_id) REFERENCES railway_system.stations (station_id)
);