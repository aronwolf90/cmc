SELECT records.start_time::timestamp::date as day, board_lists.project_id
FROM records
JOIN issues ON issues.id = records.issue_id
JOIN board_lists ON board_lists.id = issues.board_list_id
GROUP BY 1, 2
