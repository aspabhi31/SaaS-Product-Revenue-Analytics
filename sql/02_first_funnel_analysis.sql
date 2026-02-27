# 1. Total Users
SELECT COUNT(*) AS total_users FROM users;

# 2. Activated Users
SELECT COUNT(DISTINCT user_id) AS activated_users
FROM events
WHERE event_type = 'activate';

# 3. Paid Users
SELECT COUNT(DISTINCT user_id) AS paid_users
FROM subscriptions;

# 4. Funnel Conversion
SELECT 
    (SELECT COUNT(*) FROM users) AS total_users,
    (SELECT COUNT(DISTINCT user_id) FROM events WHERE event_type='activate') AS activated_users,
    (SELECT COUNT(DISTINCT user_id) FROM subscriptions) AS paid_users;

