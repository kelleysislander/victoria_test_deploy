class TrafficConditionHistorical < ActiveRecord::Base
  
  paginates_per 41 # kaminari pagination
  
  attr_accessible :traffic_camera_id, :traffic_rating_id, :day_of_week, :time_of_day, :description
  
  validates_presence_of :traffic_camera_id, :traffic_rating_id, :day_of_week, :time_of_day
  
  belongs_to  :traffic_camera
  belongs_to  :traffic_rating
  
  validates_uniqueness_of :traffic_camera_id, :scope => [:day_of_week, :time_of_day], :message => "Day of Week, and Time of Day combination must be unique"
  
  DaysOfWeek =  [
                  [ 'Sunday',    0 ], 
                  [ 'Monday',    1 ], 
                  [ 'Tuesday',   2 ],
                  [ 'Wednesday', 3 ], 
                  [ 'Thursday',  4 ], 
                  [ 'Friday',    5 ], 
                  [ 'Saturday',  6 ]
                ]

  DayOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"] 
  
  HoursOfDay =  [
                  # ["6:00am", 600], 
                  # ["6:15am", 615], 
                  # ["6:30am", 630], 
                  # ["6:45am", 645], 
                  # ["7:00am", 700], 
                  # ["7:15am", 715], 
                  # ["7:30am", 730], 
                  ["7:45AM",  "07:45"],
                  ["8:00AM",  "08:00"], 
                  ["8:15AM",  "08:15"], 
                  ["8:30AM",  "08:30"], 
                  ["8:45AM",  "08:45"], 
                  ["9:00AM",  "09:00"], 
                  ["9:15AM",  "09:15"], 
                  ["9:30AM",  "09:30"], 
                  ["9:45AM",  "09:45"], 
                  ["10:00AM", "10:00"], 
                  ["10:15AM", "10:15"], 
                  ["10:30AM", "10:30"], 
                  ["10:45AM", "10:45"], 
                  ["11:00AM", "11:00"], 
                  ["11:15AM", "11:15"], 
                  ["11:30AM", "11:30"], 
                  ["11:45AM", "11:45"], 
                  ["12:00PM", "12:00"], 
                  ["12:15PM", "12:15"], 
                  ["12:30PM", "12:30"], 
                  ["12:45PM", "12:45"], 
                  ["1:00PM",  "13:00"], 
                  ["1:15PM",  "13:15"], 
                  ["1:30PM",  "13:30"], 
                  ["1:45PM",  "13:45"], 
                  ["2:00PM",  "14:00"], 
                  ["2:15PM",  "14:15"], 
                  ["2:30PM",  "14:30"], 
                  ["2:45PM",  "14:45"], 
                  ["3:00PM",  "15:00"], 
                  ["3:15PM",  "15:15"], 
                  ["3:30PM",  "15:30"], 
                  ["3:45PM",  "15:45"], 
                  ["4:00PM",  "16:00"], 
                  ["4:15PM",  "16:15"], 
                  ["4:30PM",  "16:30"], 
                  ["4:45PM",  "16:45"], 
                  ["5:00PM",  "17:00"], 
                  ["5:15PM",  "17:15"], 
                  ["5:30PM",  "17:30"], 
                  ["5:45PM",  "17:45"], 
                  ["6:00PM",  "18:00"]
                  # ["6:15am", 1815], 
                  # ["6:30am", 1830], 
                  # ["6:45am", 1845], 
                  # ["7:00pm", 1900], 
                  # ["7:15am", 1915], 
                  # ["7:30am", 1930], 
                  # ["7:45am", 1945], 
                  # ["8:00pm", 2000], 
                  # ["8:15am", 2015], 
                  # ["8:30am", 2030], 
                  # ["8:45am", 2045], 
                  # ["9:00pm", 2100], 
                  # ["9:15am", 2115], 
                  # ["9:30am", 2130], 
                  # ["9:45am", 2145], 
                  # ["10:00pm", 2200], 
                  # ["10:15am", 2215], 
                  # ["10:30am", 2230], 
                  # ["10:45am", 2245], 
                  # ["11:00pm", 2300], 
                  # ["11:15am", 2315], 
                  # ["11:30am", 2330], 
                  # ["11:45am", 2345], 
                  # ["12:00am", 2400], 
                  # ["12:15am", 15], 
                  # ["12:30am", 30], 
                  # ["12:45am", 45], 
                  # ["1:00am", 100], 
                  # ["1:15am", 115], 
                  # ["1:30am", 130], 
                  # ["1:45am", 145], 
                  # ["2:00am", 200], 
                  # ["2:15am", 215], 
                  # ["2:30am", 230], 
                  # ["2:45am", 245], 
                  # ["3:00am", 300], 
                  # ["3:15am", 315], 
                  # ["3:30am", 330], 
                  # ["3:45am", 345], 
                  # ["4:00am", 400], 
                  # ["4:15am", 415], 
                  # ["4:30am", 430], 
                  # ["4:45am", 445], 
                  # ["5:00am", 500],
                  # ["5:15am", 515], 
                  # ["5:30am", 530], 
                  # ["5:45am", 545]
                   
                ]
end

=begin

select 
  tch.*, 
  tc.report_date,
  DAYOFWEEK(tc.report_date) -1 as dow,
  DAYNAME(tc.report_date) as dayname
FROM traffic_condition_historicals tch
LEFT JOIN traffic_conditions tc ON 
  tc.traffic_camera_id = tch.traffic_camera_id AND 
  DAYOFWEEK(DATE(tc.report_date)) = tch.day_of_week + 1 AND
  TIME(tc.report_date) >=  ( SELECT MAX() )


SELECT 
  MAX(TIME(tc.report_date)) 
FROM traffic_conditions tc 
where 
  tc.traffic_camera_id = 1 AND 
  DAYOFWEEK(DATE(tc.report_date)) = 7 AND
  TIME(tc.report_date) <= '02:00:00'



select report_date, DAYOFWEEK(DATE(tc.report_date)) FROM traffic_conditions tc where tc.traffic_camera_id = 1


select DAYOFWEEK(DATE(tc.report_date)) from traffic_conditions tc;

select TIME(report_date), DAYOFWEEK(DATE(report_date)) - 1 from traffic_conditions;


SELECT DATE_FORMAT(CURDATE(), '%W');

select DAYNAME('2012-01-14');

SELECT DAYOFWEEK('2012-01-14'), DAYNAME('2012-01-14') ;

truncate table traffic_condition_historicals;

select DAYOFWEEK(tc.report_date) - 1 from traffic_conditions tc;

SELECT
    CASE @var
        WHEN 'xyz' THEN col1
        WHEN 'zyx' THEN col2
        ELSE col7
    END,
    CASE @var
        WHEN 'xyz' THEN col2
        WHEN 'zyx' THEN col3
        ELSE col8
    END
FROM Table


  CASE case_value
      WHEN when_value THEN statement_list
      [WHEN when_value THEN statement_list] ...
      [ELSE statement_list]
  END CASE

  Or:

  CASE
      WHEN search_condition THEN statement_list
      [WHEN search_condition THEN statement_list] ...
      [ELSE statement_list]
  END CASE



pluralize(messages.length, "new message")
from map.rb
>> RadiusDistance = Array.new(10) {|i| Array.new.push("#{i+1} miles",i+1)}
=> [["1 miles", 1], ["2 miles", 2], ["3 miles", 3], ["4 miles", 4], ["5 miles", 5], ["6 miles", 6], ["7 miles", 7], ["8 miles", 8], ["9 miles", 9], ["10 miles", 10]]

DaysOfWeek = Array.new(20) {|i| Array.new.push("#{i+1} #{pluralize( i+1, 'mile')}miles",i+1)}

[["1 mile", 1], ["2 miles", 2], ["3 miles", 3], ["4 miles", 4], ["5 miles", 5], ["6 miles", 6], ["7 miles", 7], ["8 miles", 8], ["9 miles", 9], ["10 miles", 10], ["11 miles", 11], ["12 miles", 12], ["13 miles", 13], ["14 miles", 14], ["15 miles", 15], ["16 miles", 16], ["17 miles", 17], ["18 miles", 18], ["19 miles", 19], ["20 miles", 20]]

=end

