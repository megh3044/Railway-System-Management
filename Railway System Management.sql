CREATE DATABASE railway_system;
USE railway_system;

DROP TABLE IF EXISTS user_login;
CREATE TABLE user_login (
    user_id VARCHAR(255) PRIMARY KEY,
    user_password TEXT,
    first_name TEXT,
    last_name TEXT,
    sign_up_on DATE,
    email_id TEXT,
    user_type ENUM('admin', 'passenger') NOT NULL DEFAULT 'passenger'
);

DROP TABLE IF EXISTS passenger;
CREATE TABLE passenger (
    passenger_id VARCHAR(255) PRIMARY KEY,
    user_password TEXT,
    first_name TEXT,
    last_name TEXT,
    sign_up_on DATE,
    email_id TEXT,
    contact TEXT
);

DROP TABLE IF EXISTS   
 train_type;
CREATE TABLE train_type (
    train_type_id VARCHAR(255) PRIMARY KEY,
    train_type TEXT,
    coaches_count TEXT,
    passenger_strength TEXT,
    train_count DATE
);

DROP TABLE IF EXISTS stations;
CREATE TABLE stations (
    station_id VARCHAR(255) PRIMARY KEY,
    station_name TEXT,
    city TEXT,
    state TEXT
);

DROP TABLE IF EXISTS train_details;
CREATE TABLE train_details (
    train_id VARCHAR(255) PRIMARY KEY,
    train_type_id VARCHAR(255),
    source_station_id VARCHAR(255),
    destination_station_id VARCHAR(255),
    duration_minutes INT,
    journey_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    journey_end TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    passenger_strength INT,
    is_available BOOLEAN,
    waitlist_count INT DEFAULT 0,
    FOREIGN KEY (train_type_id) REFERENCES train_type (train_type_id),
    FOREIGN KEY (source_station_id) REFERENCES stations (station_id),
    FOREIGN KEY (destination_station_id) REFERENCES stations (station_id)   

);

DROP TABLE IF EXISTS journey;
CREATE TABLE journey (
    journey_id VARCHAR(255) PRIMARY KEY,
    passenger_id VARCHAR(255),
    train_id VARCHAR(255),
    booking_id TEXT,
    payment_id TEXT,
    payment_status TEXT,
    paid_on TIMESTAMP DEFAULT NULL,
    booking_status TEXT,
    booked_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seat_alloted TEXT,
    meal_booked BOOLEAN,
    booking_date DATE NOT NULL DEFAULT CURRENT_DATE,
    cancellation_reason TEXT,
    feedback TEXT,
    FOREIGN KEY (passenger_id) REFERENCES passenger (passenger_id),
    FOREIGN KEY (train_id) REFERENCES train_details (train_id)
);

DROP TABLE IF EXISTS train_routes;
CREATE TABLE train_routes (
    row_id SERIAL PRIMARY KEY,
    route_id VARCHAR(255),
    train_id VARCHAR(255),
    station_id VARCHAR(255),
    order_number INT,
    halt_duration_minutes INT,
    estimated_arrival TIME,
    estimated_departure TIME,
    FOREIGN KEY (train_id) REFERENCES train_details (train_id),
    FOREIGN KEY (station_id) REFERENCES stations (station_id)
);

DROP TABLE IF EXISTS ticket_details;
CREATE TABLE ticket_details (
    ticket_id VARCHAR(255) PRIMARY KEY,
    journey_id VARCHAR(255),
    passenger_name TEXT,
    seat_number TEXT,
    fare DECIMAL(10, 2),
    FOREIGN KEY (journey_id) REFERENCES journey (journey_id)
);

DROP TABLE IF EXISTS train_schedule;
CREATE TABLE train_schedule (
    schedule_id VARCHAR(255) PRIMARY KEY,
    train_id VARCHAR(255),
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    departure_time TIME,
    arrival_time TIME,
    FOREIGN KEY (train_id) REFERENCES train_details (train_id)
);

