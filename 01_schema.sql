-- ================================
-- Tabela: raw_erp_sales
-- ================================
CREATE TABLE raw_erp_sales (
order_id INTEGER PRIMARY KEY,
order_date DATETIME2,
utm_campaign_raw NVARCHAR(100),
traffic_source_raw NVARCHAR(100),
customer_id INTEGER,
order_amount DECIMAL(10,2),
order_status NVARCHAR(50),
user_notes NVARCHAR(255));

-- ===============================
-- Tabela: raw_ga_sessions
-- ===============================
CREATE TABLE raw_ga_sessions (
event_date DATE,
utm_campaign NVARCHAR(100),
traffic_source NVARCHAR(100),
sessions_count INTEGER,
ad_cost_pln DECIMAL(10,2));