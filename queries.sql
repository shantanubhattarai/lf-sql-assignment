-- e

SELECT passengers.*, flight_passengers.flight_number FROM passengers 
INNER JOIN flight_passengers 
ON passengers.ref_no = flight_passengers.passenger_code
WHERE flight_number = 'LA3456';

-- f

SELECT flights.*, freight_types.type_of_freight FROM flights
INNER JOIN freight_types
ON freight_types.freight_flight_number = flights.flight_number
WHERE type_of_freight = 'Medical Supplies';

-- g

SELECT passengers.*, flight_passengers.flight_number, flight_passengers.baggage_check FROM passengers 
INNER JOIN flight_passengers 
ON passengers.ref_no = flight_passengers.passenger_code
WHERE flight_number = 'LA3456' AND flight_passengers.baggage_check = 'n';

-- h

SELECT 
	flights.flight_number, 
	flights.pilot, 
	flight_schedule.departure_time, 
	flight_schedule.arrival_time, 
	flight_schedule.flight_date,
	flight_schedule.destination 
FROM flights 
INNER JOIN flight_schedule
ON flight_schedule.flight_number = flights.flight_number
WHERE flight_schedule.destination = 'Shannon'
UNION ALL
SELECT private_light_flights.s_no, 
	private_light_flights.pilot, 
	private_light_flights.time_of_departure, 
	NULL, 
	private_light_flights.date_of_departure,
	private_light_flights.destination
FROM private_light_flights
WHERE private_light_flights.destination = 'Shannon'
;

-- i 

SELECT
 (
 	SELECT COUNT(*) 
 	FROM flight_schedule 
 	WHERE EXTRACT(MONTH FROM flight_date) = '03' AND EXTRACT(YEAR FROM flight_date) = '2016'
 	) + (
 	SELECT COUNT(*) 
 	FROM private_light_flights 
 	WHERE EXTRACT(MONTH FROM date_of_departure) = '03' AND EXTRACT(YEAR FROM date_of_departure) = '2016'
 	)
 as flights_on_march_2016;

-- j

UPDATE flight_schedule 
SET departure_time = '18:00', 
arrival_time = '18:00' + flight_schedule.arrival_time - flight_schedule.departure_time 
WHERE flight_number = 'GF456';

-- k

UPDATE private_light_flights
SET pilot = 'Paul Stow'
WHERE s_no = 'C786';

-- l
BEGIN TRANSACTION;
	UPDATE flight_schedule 
	SET destination = 'Lydd' 
	WHERE EXTRACT(MONTH FROM flight_date) = '01' AND EXTRACT(YEAR FROM flight_date) = '2016' AND destination = 'Le Touquet';

	UPDATE private_light_flights 
	SET destination = 'Lydd' 
	WHERE EXTRACT(MONTH FROM date_of_departure) = '01' AND EXTRACT(YEAR FROM date_of_departure) = '2016' AND destination = 'Le Touquet';
COMMIT;
-- m

UPDATE passengers SET nationality = 'French' WHERE customer_name = 'Chaz Smith';

-- n

DELETE FROM private_light_flights WHERE date_of_departure = '2016-01-03';