CREATE DATABASE lf_airlines;
\c lf_airlines;

CREATE TABLE IF NOT EXISTS passengers (
	ref_no varchar(255) primary key,
	customer_name varchar(255),
	address text,
	sex varchar(11),
	nationality varchar(255),
	date_of_birth date,
	passport_number varchar(255)
);

CREATE TABLE IF NOT EXISTS flights(
	flight_number varchar(255) primary key,
	airline varchar(255),
	pilot varchar(255),
	type varchar(255)
);

CREATE TABLE IF NOT EXISTS flight_schedule(
	flight_number varchar(255),
	destination text,
	departure_time time,
	arrival_time time,
	flight_date date,
	CONSTRAINT fk_flight FOREIGN KEY(flight_number) REFERENCES flights(flight_number)
);

CREATE TABLE IF NOT EXISTS flight_passengers(
	flight_number varchar(255) NOT NULL,
	passenger_code varchar(255) NOT NULL,
	baggage_check boolean,
	passenger_check boolean,
	CONSTRAINT fk_passenger FOREIGN KEY(passenger_code) REFERENCES passengers(ref_no),
	CONSTRAINT fk_flight FOREIGN KEY(flight_number) REFERENCES flights(flight_number),
	PRIMARY KEY(flight_number, passenger_code)
);

CREATE TABLE IF NOT EXISTS passenger_baggage(
	passenger_code varchar(255),
	baggage_label_number varchar(255),
	CONSTRAINT fk_passenger FOREIGN KEY(passenger_code) REFERENCES passengers(ref_no)
);

CREATE TABLE IF NOT EXISTS private_light_flights(
	s_no varchar(255),
	type_of_craft varchar(255),
	pilot varchar(255),
	date_of_departure date,
	time_of_departure time,
	destination varchar(255)
);

CREATE TABLE IF NOT EXISTS freight_types(
	freight_flight_number varchar(255),
	type_of_freight varchar(255),
	CONSTRAINT fk_freight_flight FOREIGN KEY(freight_flight_number) REFERENCES flights(flight_number)
);