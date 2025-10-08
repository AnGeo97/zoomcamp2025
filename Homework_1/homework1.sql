--Q3 1
SELECT COUNT(*)
FROM green_trip_data AS a
WHERE
    date(a.lpep_pickup_datetime) >= date('2019-10-01')
    AND date(a.lpep_dropoff_datetime) < date('2019-11-01')
    AND a.trip_distance <= 1;

--Q3 2
SELECT COUNT(*)
FROM green_trip_data AS a
WHERE
    date(a.lpep_pickup_datetime) >= date('2019-10-01')
    AND date(a.lpep_dropoff_datetime) < date('2019-11-01')
    AND a.trip_distance > 1
	AND a.trip_distance <=3;
	
--Q3 3
SELECT COUNT(*)
FROM green_trip_data AS a
WHERE
    date(a.lpep_pickup_datetime) >= date('2019-10-01')
    AND date(a.lpep_dropoff_datetime) < date('2019-11-01')
    AND a.trip_distance > 3
	AND a.trip_distance <=7;

--Q3 4
SELECT COUNT(*)
FROM green_trip_data AS a
WHERE
    date(a.lpep_pickup_datetime) >= date('2019-10-01')
    AND date(a.lpep_dropoff_datetime) < date('2019-11-01')
    AND a.trip_distance > 7
	AND a.trip_distance <=10;
	
--Q3 5
SELECT COUNT(*)
FROM green_trip_data AS a
WHERE
    date(a.lpep_pickup_datetime) >= date('2019-10-01')
    AND date(a.lpep_dropoff_datetime) < date('2019-11-01')
    AND a.trip_distance > 10;

--Q4 
SELECT a.lpep_pickup_datetime 
FROM green_trip_data AS a
WHERE a.trip_distance IN (SELECT MAX(trip_distance) FROM green_trip_data);

--Q5 
SELECT a.sum_total_amt,z."Zone"
FROM 
(
SELECT green_trip_data."PULocationID", sum(green_trip_data.total_amount) AS sum_total_amt
FROM green_trip_data
WHERE date(green_trip_data.lpep_pickup_datetime) = date('2019-10-18')
GROUP BY green_trip_data."PULocationID"
HAVING sum(green_trip_data.total_amount)>13000
) a 
JOIN zone_green_taxi z on a."PULocationID"=z."LocationID"  LIMIT 3;

--Q6
SELECT zone_green_taxi."Zone"
FROM public.green_trip_data LEFT JOIN zone_green_taxi on green_trip_data."DOLocationID"=zone_green_taxi."LocationID" where green_trip_data."PULocationID"=74 and 
date(green_trip_data.lpep_pickup_datetime) >=date('2019-10-01') AND date(green_trip_data.lpep_pickup_datetime) <=date('2019-10-31') 
order by green_trip_data."tip_amount" desc  limit 1;
