/*
This selects either the historical or the actila traffic_conditions records based on left joining from tch to tc by 
traffic_camera_id and the time range as defined by 7:30 on either side of the tch.report_date (interval is 15:00 to halp each way)
now = '2012-02-02 10:00:23'
*/
    SELECT
      now() as now,
      final.*
      FROM 
      (
        SELECT
          tch.report_date as tch_rep_date,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_camera_id ELSE tc.traffic_camera_id END as traffic_camera_id,
          tch.latitude,
          tch.longitude,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date       ELSE tc.report_date       END as report_date,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date_str   ELSE tc.report_date_str   END as report_date_str,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rec_type          ELSE tc.rec_type          END as source,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_rating_id ELSE tc.traffic_rating_id END as traffic_rating_id,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rating            ELSE tc.rating            END as rating,
          tch.report_date_beg,
          tch.report_date_end
        FROM
        (
          SELECT 
            tch.traffic_camera_id,
            c.latitude,
            c.longitude,
            tch.traffic_rating_id,
            tr.rating,
            TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) as report_date,
            NOW() as now,
            DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') as report_date_str,
            DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
            DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
            'h' as rec_type
          FROM traffic_condition_historicals tch
          JOIN traffic_cameras c ON c.id = tch.traffic_camera_id
          left JOIN traffic_ratings tr ON tr.id = tch.traffic_rating_id
          WHERE tch.day_of_week + 1 = DAYOFWEEK( curdate()  ) AND 
            TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) <= NOW()
          GROUP BY tch.traffic_camera_id 
          ORDER BY tch.traffic_camera_id, 
            TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) DESC
        ) tch
        LEFT JOIN
        (
        SELECT
          tc.traffic_camera_id,
          CASE WHEN tc.traffic_camera_id IS NULL 
            THEN tc.other_latitude ELSE c.latitude END as latitude,
          CASE WHEN tc.traffic_camera_id IS NULL
            THEN tc.other_longitude ELSE c.longitude END as longitude,
          tc.traffic_rating_id,
          tr.rating,
          CONVERT_TZ(tc.report_date,'+00:00','-06:00') as report_date,
          DATE_FORMAT(CONVERT_TZ(tc.report_date,'+00:00','-06:00'), '%Y-%m-%d %T') as report_date_str,
          'c' as rec_type
        FROM traffic_conditions tc
        LEFT JOIN traffic_cameras c ON c.id = tc.traffic_camera_id
        JOIN traffic_ratings tr ON tr.id = tc.traffic_rating_id ) tc
        ON 
          tc.report_date >= tch.report_date_beg AND tc.report_date < tch.report_date_end AND
          tc.traffic_camera_id = tch.traffic_camera_id
        ORDER BY
          tch.traffic_camera_id,
            CONVERT_TZ(tch.report_date,'+00:00','-06:00') DESC
    ) final
    WHERE final.report_date <= NOW() 
    GROUP BY
      traffic_camera_id;


-- select * from traffic_conditions;
-- select now()


/*


SELECT 
  tch.traffic_camera_id as tch_cam_id,
  tch.latitude as tch_lat,
  tch.longitude as tch_lng,
  tch.traffic_rating_id as tch_rating_id,
  tch.report_date as tch_report_date,
  tch.report_date_beg as tch_report_date_beg,
  tch.report_date_end as tch_report_date_end,
  tch.rec_type as tch_type,
  tc.traffic_camera_id as tc_cam_id,
  tc.report_date as tc_report_date,
  tc.traffic_rating_id as tc_rating_id
--  tc.report_date_beg as tc_report_date_beg,
--  tc.report_date_end as tc_report_date_end
FROM
(
  SELECT 
    tch.traffic_camera_id,
    c.latitude,
    c.longitude,
    tch.traffic_rating_id,
    TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) as report_date,
    DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
    DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
    'h' as rec_type
  FROM traffic_condition_historicals tch
  JOIN traffic_cameras c ON c.id = tch.traffic_camera_id
  WHERE tch.day_of_week + 1 = DAYOFWEEK(curdate()) ) tch

LEFT JOIN

(
SELECT
  tc.traffic_camera_id,
  CASE WHEN tc.traffic_camera_id IS NULL 
    THEN tc.other_latitude ELSE c.latitude END as latitude,
  CASE WHEN tc.traffic_camera_id IS NULL
    THEN tc.other_longitude ELSE c.longitude END as longitude,
  tc.traffic_rating_id,
  tdt.name as traffic_data_type,
  CONVERT_TZ(tc.report_date,'+00:00','-06:00') as report_date,
--  DATE_SUB(CONVERT_TZ(tc.report_date,'+00:00','-06:00'), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
--  DATE_ADD(CONVERT_TZ(tc.report_date,'+00:00','-06:00'), INTERVAL '7:30' MINUTE_SECOND) as report_date_end, 
  'c' as rec_type
FROM traffic_conditions tc
LEFT JOIN traffic_cameras c ON c.id = tc.traffic_camera_id
LEFT JOIN traffic_data_types tdt ON tdt.id = tc.traffic_data_type_id ) tc

ON 
  tc.report_date >= tch.report_date_beg AND tc.report_date < tch.report_date_end AND
  tc.traffic_camera_id = tch.traffic_camera_id
WHERE
  tch.traffic_camera_id = 1
ORDER BY
  tch.traffic_camera_id,
    CONVERT_TZ(tch.report_date,'+00:00','-06:00');




SELECT 
  tch.traffic_camera_id,
  c.latitude,
  c.longitude,
  tch.traffic_rating_id,
  'Historical' as traffic_data_type,
  TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) as report_date,
  DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
  DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
   'h' as rec_type
FROM traffic_condition_historicals tch
JOIN traffic_cameras c ON c.id = tch.traffic_camera_id
WHERE tch.day_of_week + 1 = DAYOFWEEK(curdate())

UNION ALL

SELECT
  tc.traffic_camera_id,
  CASE WHEN tc.traffic_camera_id IS NULL 
    THEN tc.other_latitude ELSE c.latitude END as latitude,
  CASE WHEN tc.traffic_camera_id IS NULL
    THEN tc.other_longitude ELSE c.longitude END as longitude,
  tc.traffic_rating_id,
  tdt.name as traffic_data_type,
  CONVERT_TZ(tc.report_date,'+00:00','-06:00') as report_date,
  DATE_SUB(CONVERT_TZ(tc.report_date,'+00:00','-06:00'), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
  DATE_ADD(CONVERT_TZ(tc.report_date,'+00:00','-06:00'), INTERVAL '7:30' MINUTE_SECOND) as report_date_end, 
  'c' as rec_type
FROM traffic_conditions tc
LEFT JOIN traffic_cameras c ON c.id = tc.traffic_camera_id
LEFT JOIN traffic_data_types tdt ON tdt.id = tc.traffic_data_type_id
ORDER BY
  traffic_camera_id, 
    report_date
*/
/*
  -- tch.day_of_week as tch_day_of_week,
  -- DAYOFWEEK(curdate()) as mysql_day_of_week,
  -- tch.time_of_day,
  -- YEAR(CURDATE()) as date_year,
  -- MONTH(CURDATE()) as date_month,
  -- DAYOFMONTH(curdate()) as day_of_month,
  -- TIME_FORMAT(CONCAT(tch.time_of_day,':00'),'%H:%i:00') AS time_part,
  -- CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', TIME_FORMAT(CONCAT(tch.time_of_day,':00'),'%H:%i:00')) as synth_date,
  -- DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', TIME_FORMAT(CONCAT(tch.time_of_day,':00'),'%H:%i:00')), '%Y-%m-%d %r') as report_date_utc_12,
  -- TIMESTAMP(DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', TIME_FORMAT(CONCAT(tch.time_of_day,':00'),'%H:%i:00')), '%Y-%m-%d %r')) as report_date_2,



select * from traffic_conditions
select * from traffic_data_types


select now()
SELect TIMESTAMP(curdate() || '01:45:00')
select * from traffic_condition_historicals

select * from traffic_cameras

select dayname(curdate())
select  dayofweek(curdate())
select  dayofmonth(curdate())

select timestamp('2012-01-31 07:45:00') as new_date

SELECT STR_TO_DATE('Wed Jun 17 01:06:00 PM 2009', '%W %M %d %T %Y')

SELECT DATE_FORMAT('2007-10-04 22:23:00', '%Y-%m-%d %r');

select * FROM traffic_condition_historicals
select traffic_camera_id, compass_point_id, CONVERT_TZ(report_date,'+00:00','-06:00') FROM traffic_conditions order by traffic_camera_id;

select timestamp('2012-01-31 11:45:08 AM')

select * FROM traffic_conditions

SELECT CONVERT_TZ('2004-01-01 13:40:00','+00:00','-06:00');
*/