SELECT 
  users.id AS user_id, 
  issues.id AS issue_id, 
  SUM(records.end_time -records.start_time) AS spent_time,
  MIN(records.start_time) AS start_time
FROM "users" 
INNER JOIN "records" ON "records"."user_id" = "users"."id" 
INNER JOIN "issues" ON "issues"."id" = "records"."issue_id" 
GROUP BY users.id, issues.id;
