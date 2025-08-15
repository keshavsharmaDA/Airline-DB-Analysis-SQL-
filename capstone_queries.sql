
-- 1. Format booking date as yyyy-mmm-dd
SELECT book_ref, strftime('%Y-%b-%d', book_date) AS formatted_date, total_amount
FROM bookings;

-- 2. Least used seats
SELECT seat_no, COUNT(*) AS usage_count
FROM boarding_passes
GROUP BY seat_no
ORDER BY usage_count ASC
LIMIT 5;

-- 3. Highest and lowest paying passengers per booking date
SELECT b.book_date, t.passenger_name, b.total_amount
FROM bookings b
JOIN tickets t ON b.book_ref = t.book_ref
WHERE b.total_amount = (SELECT MAX(total_amount) FROM bookings)
   OR b.total_amount = (SELECT MIN(total_amount) FROM bookings);

-- 4. Count tickets without boarding passes
SELECT COUNT(*) AS tickets_without_boarding
FROM tickets
WHERE ticket_no NOT IN (SELECT ticket_no FROM boarding_passes);

-- 5. Longest flights
SELECT flight_no, departure_airport, arrival_airport, distance_km
FROM flights
ORDER BY distance_km DESC
LIMIT 3;

-- 6. Morning flights (depart before 12 PM)
SELECT flight_no, departure_airport, arrival_airport, departure_time
FROM flights
WHERE strftime('%H', departure_time) < '12';

-- 7. Non-stop journeys (direct flights)
SELECT flight_no, departure_airport, arrival_airport, distance_km
FROM flights
WHERE distance_km > 0; -- assuming all flights in table are direct
