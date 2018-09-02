SELECT (start_time + time_zone_seconds * interval '1 sec')::timestamp::date as day, board_lists.project_id
FROM records
JOIN issues ON issues.id = records.issue_id
JOIN board_lists ON board_lists.id = issues.board_list_id
JOIN public.organizations ON organizations.name IN (current_schema())
GROUP BY 1, 2
