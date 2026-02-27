# Proper Funnel Drop-Off Analysis

# 1. Clean Funnel Summary Query
SELECT
    total_users,
    activated_users,
    paid_users,
    
    ROUND(activated_users / total_users * 100, 2) AS activation_rate_pct,
    ROUND(paid_users / activated_users * 100, 2) AS paid_conversion_pct,
    ROUND(paid_users / total_users * 100, 2) AS overall_conversion_pct

FROM
(
    SELECT
        (SELECT COUNT(*) FROM users) AS total_users,
        (SELECT COUNT(DISTINCT user_id) 
         FROM events 
         WHERE event_type = 'activate') AS activated_users,
        (SELECT COUNT(DISTINCT user_id) 
         FROM subscriptions) AS paid_users
) AS funnel;

# 2. Add Drop-Off %
SELECT
    total_users - activated_users AS dropoff_signup_to_activation,
    ROUND((total_users - activated_users) / total_users * 100, 2) AS dropoff_signup_pct
FROM
(
    SELECT
        (SELECT COUNT(*) FROM users) AS total_users,
        (SELECT COUNT(DISTINCT user_id) 
         FROM events 
         WHERE event_type = 'activate') AS activated_users
) AS stage;

# 3. Channel-wise Conversion
SELECT
    u.acquisition_channel,
    COUNT(DISTINCT u.user_id) AS total_users,
    COUNT(DISTINCT e.user_id) AS activated_users,
    COUNT(DISTINCT s.user_id) AS paid_users,
    
    ROUND(COUNT(DISTINCT e.user_id) / COUNT(DISTINCT u.user_id) * 100, 2) AS activation_rate_pct,
    ROUND(COUNT(DISTINCT s.user_id) / COUNT(DISTINCT u.user_id) * 100, 2) AS paid_conversion_pct

FROM users u
LEFT JOIN events e 
    ON u.user_id = e.user_id 
    AND e.event_type = 'activate'
LEFT JOIN subscriptions s 
    ON u.user_id = s.user_id
GROUP BY u.acquisition_channel;