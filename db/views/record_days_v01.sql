SELECT start_time::timestamp::date as day, user_id
FROM records GROUP BY 1, 2
