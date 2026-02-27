CREATE DATABASE saas_product_analytics;
USE saas_product_analytics;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    signup_date DATE,
    acquisition_channel VARCHAR(50),
    country VARCHAR(50),
    device_type VARCHAR(20)
);

CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_type VARCHAR(50),
    event_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan_type VARCHAR(20),
    subscription_start DATE,
    subscription_end DATE,
    monthly_price DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE churn_status (
    user_id INT PRIMARY KEY,
    churn_date DATE,
    churn_flag BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO users (signup_date, acquisition_channel, country, device_type)
SELECT
    DATE('2024-01-01') + INTERVAL FLOOR(RAND()*180) DAY,
    ELT(FLOOR(1 + RAND()*3), 'Organic', 'Paid Ads', 'Referral'),
    ELT(FLOOR(1 + RAND()*3), 'India', 'USA', 'UK'),
    ELT(FLOOR(1 + RAND()*2), 'Mobile', 'Desktop')
FROM
    (SELECT 1 FROM information_schema.tables LIMIT 10000) AS temp;
    
INSERT INTO events (user_id, event_type, event_date)
SELECT user_id, 'signup', signup_date
FROM users;

INSERT INTO events (user_id, event_type, event_date)
SELECT user_id,
       'activate',
       signup_date + INTERVAL FLOOR(RAND()*7) DAY
FROM users
WHERE RAND() < 0.7;

INSERT INTO subscriptions (user_id, plan_type, subscription_start, subscription_end, monthly_price)
SELECT user_id,
       ELT(FLOOR(1 + RAND()*3), 'Basic', 'Pro', 'Enterprise'),
       signup_date + INTERVAL FLOOR(RAND()*14) DAY,
       signup_date + INTERVAL 30 DAY,
       ELT(FLOOR(1 + RAND()*3), 499, 999, 1999)
FROM users
WHERE RAND() < 0.25;  

INSERT INTO payments (user_id, payment_date, amount)
SELECT user_id, subscription_start, monthly_price
FROM subscriptions;  

INSERT INTO churn_status (user_id, churn_date, churn_flag)
SELECT user_id,
       subscription_end,
       CASE WHEN RAND() < 0.1 THEN TRUE ELSE FALSE END
FROM subscriptions;

DELETE FROM events;
DELETE FROM subscriptions;
DELETE FROM payments;
DELETE FROM churn_status;
DELETE FROM users;

CREATE TABLE numbers (n INT);

INSERT INTO numbers (n)
VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

INSERT INTO numbers (n)
SELECT a.n + b.n*10
FROM numbers a, numbers b;

INSERT INTO numbers (n)
SELECT a.n + b.n*100
FROM numbers a, numbers b
WHERE a.n < 100 AND b.n < 10;

SELECT COUNT(*) FROM numbers;

INSERT INTO users (signup_date, acquisition_channel, country, device_type)
SELECT
    DATE('2024-01-01') + INTERVAL FLOOR(RAND()*180) DAY,
    ELT(FLOOR(1 + RAND()*3), 'Organic', 'Paid Ads', 'Referral'),
    ELT(FLOOR(1 + RAND()*3), 'India', 'USA', 'UK'),
    ELT(FLOOR(1 + RAND()*2), 'Mobile', 'Desktop')
FROM numbers a
CROSS JOIN numbers b
LIMIT 10000;

SELECT COUNT(*) FROM users;

INSERT INTO events (user_id, event_type, event_date)
SELECT user_id, 'signup', signup_date
FROM users;

INSERT INTO events (user_id, event_type, event_date)
SELECT user_id,
       'activate',
       signup_date + INTERVAL FLOOR(RAND()*7) DAY
FROM users
WHERE RAND() < 0.7;

SELECT COUNT(DISTINCT user_id) 
FROM events 
WHERE event_type='activate';

INSERT INTO subscriptions (user_id, plan_type, subscription_start, subscription_end, monthly_price)
SELECT e.user_id,
       ELT(FLOOR(1 + RAND()*3), 'Basic', 'Pro', 'Enterprise'),
       e.event_date + INTERVAL FLOOR(RAND()*5) DAY,
       e.event_date + INTERVAL 30 DAY,
       ELT(FLOOR(1 + RAND()*3), 499, 999, 1999)
FROM events e
WHERE e.event_type = 'activate'
AND RAND() < 0.25;

SELECT COUNT(*) FROM subscriptions;

INSERT INTO payments (user_id, payment_date, amount)
SELECT user_id, subscription_start, monthly_price
FROM subscriptions;

INSERT INTO churn_status (user_id, churn_date, churn_flag)
SELECT user_id,
       subscription_end,
       CASE WHEN RAND() < 0.1 THEN TRUE ELSE FALSE END
FROM subscriptions;

SELECT 
    (SELECT COUNT(*) FROM users) AS total_users,
    (SELECT COUNT(DISTINCT user_id) FROM events WHERE event_type='activate') AS activated_users,
    (SELECT COUNT(*) FROM subscriptions) AS paid_users;
    
INSERT INTO events (user_id, event_type, event_date)
SELECT 
    e.user_id,
    'activate',
    e.event_date + INTERVAL 30 DAY
FROM events e
WHERE e.event_type = 'activate'
AND RAND() < 0.6; 

INSERT INTO events (user_id, event_type, event_date)
SELECT 
    e.user_id,
    'activate',
    e.event_date + INTERVAL 60 DAY
FROM events e
WHERE e.event_type = 'activate'
AND RAND() < 0.4;  

INSERT INTO events (user_id, event_type, event_date)
SELECT 
    e.user_id,
    'activate',
    e.event_date + INTERVAL 90 DAY
FROM events e
WHERE e.event_type = 'activate'
AND RAND() < 0.3; 