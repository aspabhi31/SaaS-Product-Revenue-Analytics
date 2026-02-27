# 1. MRR (Monthly Recurring Revenue)
SELECT 
    DATE_FORMAT(subscription_start, '%Y-%m') AS revenue_month,
    SUM(monthly_price) AS MRR
FROM subscriptions
GROUP BY revenue_month
ORDER BY revenue_month;

# 2. ARPU (Average Revenue Per User)

# Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payments;

# Total Paid Users
SELECT COUNT(DISTINCT user_id) AS paid_users
FROM subscriptions;

# ARPU Calculation
SELECT 
    ROUND(
        (SELECT SUM(amount) FROM payments) /
        (SELECT COUNT(DISTINCT user_id) FROM subscriptions)
    ,2) AS ARPU;

# 3. Monthly ARPU
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month,
    ROUND(SUM(p.amount) / COUNT(DISTINCT p.user_id), 2) AS monthly_ARPU
FROM payments p
GROUP BY revenue_month
ORDER BY revenue_month; 

# 4. Churn Rate
SELECT 
    COUNT(*) AS total_subscribers,
    SUM(churn_flag) AS churned_users,
    ROUND(SUM(churn_flag) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM churn_status; 

# 5. LTV (Customer Lifetime Value)
SELECT 
    ROUND(
        (
            (SELECT SUM(amount) FROM payments) /
            (SELECT COUNT(DISTINCT user_id) FROM subscriptions)
        ) 
        /
        (
            (SELECT SUM(churn_flag) FROM churn_status) /
            (SELECT COUNT(*) FROM churn_status)
        )
    ,2) AS LTV_estimate;   
    
# 6. Revenue by Acquisition Channel
 SELECT 
    u.acquisition_channel,
    COUNT(DISTINCT s.user_id) AS paid_users,
    SUM(p.amount) AS total_revenue,
    ROUND(SUM(p.amount) / COUNT(DISTINCT s.user_id), 2) AS ARPU_by_channel
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
JOIN payments p ON u.user_id = p.user_id
GROUP BY u.acquisition_channel
ORDER BY total_revenue DESC;   