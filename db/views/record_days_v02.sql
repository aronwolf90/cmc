SELECT (start_time + time_zone_seconds * interval '1 sec')::timestamp::date as day, user_id
FROM records
JOIN public.organizations ON organizations.name IN (current_schema())
GROUP BY 1, 2
