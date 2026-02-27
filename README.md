# SaaS Product & Revenue Analytics  
### End-to-End Funnel, Retention & LTV Analysis Using MySQL

---

## 1. Executive Summary

This project simulates a subscription-based SaaS product and performs comprehensive product and revenue analytics to evaluate:

- Funnel performance  
- User retention behavior  
- Monetization efficiency  
- Channel-level revenue contribution  
- Customer lifetime value (LTV)  

Using MySQL, realistic user lifecycle behavior (activation, subscription, churn) was modeled and key product KPIs were derived to generate actionable business insights.

The analysis identifies revenue drivers, conversion bottlenecks, and long-term customer value dynamics.

---

## 2. Business Problem

A SaaS product team wants to understand:

- Where users drop off in the acquisition funnel  
- Which acquisition channels generate the highest-value customers  
- Whether retention patterns are sustainable  
- If monetization supports long-term profitability  

This project answers these questions using structured SQL-based analysis.

---

## 3. Data Model

### Tables Used

- **users** – User information and acquisition channel  
- **events** – Activation and engagement activity  
- **subscriptions** – Paid plan enrollments  
- **payments** – Monthly recurring revenue records  
- **churn_status** – Customer churn indicator  

User behavior was probabilistically simulated using MySQL’s `RAND()` function to replicate realistic SaaS lifecycle patterns.

---

## 4. Funnel Analysis

### Funnel Stages

1. Signups  
2. Activated Users  
3. Paid Subscriptions  

### Key Metrics

- Activation Rate ≈ 70%  
- Paid Conversion Rate ≈ 17%  
- Largest drop-off: Activation → Subscription  

**Insight:**  
Onboarding effectively activates users, but monetization conversion presents optimization opportunities.

---

## 5. Cohort Retention Analysis

Users were grouped into monthly cohorts based on signup date. Retention was measured across Month 0–3.

### Observed Retention Pattern

- Month 1 Retention ≈ 60%  
- Month 2 Retention ≈ 40%  
- Month 3 Retention ≈ 30%  

**Insight:**  
Retention follows a natural decay curve typical of SaaS products. Engagement and lifecycle marketing initiatives could improve long-term retention.

---

## 6. Revenue Analytics

### 6.1 Monthly Recurring Revenue (MRR)

Tracked month-over-month subscription revenue to assess growth trends and revenue consistency.

### 6.2 Average Revenue Per User (ARPU)

Calculated as:

ARPU = Total Revenue / Total Paying Users

ARPU reflects monetization strength across subscription tiers.

### 6.3 Churn Rate

- Monthly churn ≈ 10%

Churn directly impacts revenue stability and LTV.

### 6.4 Customer Lifetime Value (LTV)

Estimated using:

LTV = ARPU / Churn Rate

**Estimated LTV: ₹13,155.62**

**Interpretation:**  
Each customer contributes approximately ₹13.1K in lifetime revenue under current churn assumptions. This defines the upper limit for Customer Acquisition Cost (CAC) to maintain profitability.

---

## 7. Acquisition Channel Performance

Channel-level segmentation revealed differentiated monetization behavior.

### Key Observations

- Referral drives the highest number of paying users.  
- Paid Ads generates the highest ARPU.  
- Paid Ads contributes the highest overall revenue.  

### Strategic Implication

- Referral is an efficient volume driver.  
- Paid Ads attracts higher-value customers.  
- A balanced acquisition strategy could optimize both scale and monetization.

---

## 8. Strategic Recommendations

1. Scale referral programs to increase high-conversion acquisition.  
2. Refine Paid Ads targeting to further attract premium-tier customers.  
3. Optimize activation-to-paid transition to improve overall funnel efficiency.  
4. Implement retention initiatives to reduce churn below 10%.  
5. Continuously monitor ARPU by plan and acquisition channel.  

---

## 9. Technical Implementation

- MySQL  
- Multi-table joins  
- Aggregations and KPI calculations  
- Cohort modeling  
- Revenue trend analysis  
- Probabilistic data simulation  

---

## 10. Skills Demonstrated

- Product Analytics  
- Funnel Optimization  
- Revenue Modeling  
- Cohort Retention Analysis  
- KPI Framework Development  
- Business Insight Translation  
- Data-Driven Strategic Thinking  

---

## 11. Project Outcome

This project replicates real-world SaaS analytics workflows and demonstrates the ability to:

- Transform raw transactional data into executive-level KPIs  
- Identify growth levers across acquisition, retention, and monetization  
- Deliver structured, data-backed business recommendations  

---
