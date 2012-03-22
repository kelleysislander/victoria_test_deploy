SELECT
  now() as now,
  final.*
  FROM 
  (
    SELECT
      tch.report_date as tch_rep_date,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_camera_id ELSE tc.traffic_camera_id END as traffic_camera_id,
      tch.traffic_camera_name,
      tch.latitude,
      tch.longitude,
			tch.compass_point,
      tch.rating_description,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date       ELSE tc.report_date       END as report_date,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date_str   ELSE tc.report_date_str   END as report_date_str,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rec_type          ELSE tc.rec_type          END as source,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_rating_id ELSE tc.traffic_rating_id END as traffic_rating_id,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rating            ELSE tc.rating            END as rating,
      CASE WHEN tc.traffic_camera_id IS NULL THEN tch.alert_message     ELSE tc.alert_message     END as alert_message,
      tch.report_date_beg,
      tch.report_date_end,
      tch.url
    FROM
    (
    -- selects the most recent report_date for the current day_of_week per traffic_camera_id from traffic_condition_historicals
    SELECT 
      tch.traffic_camera_id,
      tc.name as traffic_camera_name,
      tc.latitude,
      tc.longitude,
      tch.traffic_rating_id,
      tr.rating,
      tr.description as rating_description,
			cp.name as compass_point,
      NULL as alert_message,
      TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) as report_date,
      DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') as report_date_str,
      -- midpoints based on tch.time_of_day
      -- DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
      -- DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
      -- midpoints based on NOW()
      DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', DATE_FORMAT(now(), '%T')), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
      DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', DATE_FORMAT(now(), '%T')), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
      tc.url,
      'h' as rec_type
    FROM traffic_condition_historicals tch 
    JOIN traffic_cameras tc ON tc.id = tch.traffic_camera_id
    JOIN traffic_ratings tr ON tr.id = tch.traffic_rating_id
		JOIN compass_points  cp ON cp.id = tc.compass_point_id 
    WHERE 
      tch.day_of_week + 1 = DAYOFWEEK( curdate()  ) AND
      tch.time_of_day = (SELECT MAX(time_of_day) FROM traffic_condition_historicals WHERE time_of_day <= DATE_FORMAT( now(), '%T'))
    GROUP BY tch.traffic_camera_id
    ORDER BY
    tch.traffic_camera_id
    ) tch
    -- and joins to the actual traffic_conditions based on traffic_camera_id and report_date_beg / report_date_end
    LEFT JOIN
    (
    SELECT
      tc.traffic_camera_id,
      c.name as traffic_camera_name,
      CASE WHEN tc.traffic_camera_id IS NULL 
        THEN tc.other_latitude ELSE c.latitude END as latitude,
      CASE WHEN tc.traffic_camera_id IS NULL
        THEN tc.other_longitude ELSE c.longitude END as longitude,
      tc.traffic_rating_id,
      tr.rating,
      tr.description as rating_description,
			cp.name as compass_point,
      tc.alert_message,
      CONVERT_TZ(tc.report_date,'+00:00','-6:00') as report_date,
      DATE_FORMAT(CONVERT_TZ(tc.report_date,'+00:00','-6:00'), '%Y-%m-%d %T') as report_date_str,
      'c' as rec_type
    FROM traffic_conditions tc
    LEFT JOIN traffic_cameras c ON c.id = tc.traffic_camera_id
    JOIN traffic_ratings tr ON tr.id = tc.traffic_rating_id
		JOIN compass_points  cp ON cp.id = c.compass_point_id 
    ) tc
    ON
      -- the actual taffic_conditions report_date must fall within 
      tc.report_date >= tch.report_date_beg AND tc.report_date < tch.report_date_end AND
      tc.traffic_camera_id = tch.traffic_camera_id
    ORDER BY
      tch.traffic_camera_id,
        CONVERT_TZ(tch.report_date,'+00:00','-6:00') DESC
) final
GROUP BY
  traffic_camera_id
ORDER BY
  traffic_camera_id;