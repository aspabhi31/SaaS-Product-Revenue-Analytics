# Cohort Retention Analysis

# 1. Create Monthly Cohort Table
SELECT 
    user_id,
    DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month
FROM users;

# 2. Create Activity Month
SELECT 
    e.user_id,
    DATE_FORMAT(e.event_date, '%Y-%m') AS activity_month
FROM events e
WHERE event_type = 'activate';

# 3. Cohort Retention Query (Core Logic)
SELECT 
    u_cohort.cohort_month,
    TIMESTAMPDIFF(MONTH,
                  STR_TO_DATE(CONCAT(u_cohort.cohort_month, '-01'), '%Y-%m-%d'),
                  STR_TO_DATE(CONCAT(activity.activity_month, '-01'), '%Y-%m-%d')
    ) AS month_number,
    COUNT(DISTINCT activity.user_id) AS active_users
FROM
(
    SELECT 
        user_id,
        DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month
    FROM users
) u_cohort
JOIN
(
    SELECT 
        user_id,
        DATE_FORMAT(event_date, '%Y-%m') AS activity_month
    FROM events
    WHERE event_type='activate'
) activity
ON u_cohort.user_id = activity.user_id
GROUP BY u_cohort.cohort_month, month_number
ORDER BY u_cohort.cohort_month, month_number;

# 4. Calculate Cohort Size
SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month,
    COUNT(*) AS cohort_size
FROM users
GROUP BY cohort_month
ORDER BY cohort_month;

# 5. Full Retention Percentage Query
SELECT 
    retention.cohort_month,
    retention.month_number,
    retention.active_users,
    cohort_sizes.cohort_size,
    
    ROUND(retention.active_users / cohort_sizes.cohort_size * 100, 2) 
    AS retention_percentage

FROM
(
    SELECT 
        u_cohort.cohort_month,
        TIMESTAMPDIFF(MONTH,
                      STR_TO_DATE(CONCAT(u_cohort.cohort_month, '-01'), '%Y-%m-%d'),
                      STR_TO_DATE(CONCAT(activity.activity_month, '-01'), '%Y-%m-%d')
        ) AS month_number,
        COUNT(DISTINCT activity.user_id) AS active_users
    FROM
    (
        SELECT 
            user_id,
            DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month
        FROM users
    ) u_cohort
    JOIN
    (
        SELECT 
            user_id,
            DATE_FORMAT(event_date, '%Y-%m') AS activity_month
        FROM events
        WHERE event_type='activate'
    ) activity
    ON u_cohort.user_id = activity.user_id
    GROUP BY u_cohort.cohort_month, month_number
) retention
JOIN
(
    SELECT 
        DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month,
        COUNT(*) AS cohort_size
    FROM users
    GROUP BY cohort_month
) cohort_sizes
ON retention.cohort_month = cohort_sizes.cohort_month
ORDER BY retention.cohort_month, retention.month_number;