-- ================================================================
-- Tabela: dim_status (wymiar)
-- ================================================================
-- Cel: utworzenie tabeli (widoku) wymiaru z tabeli raw_erp_sales

CREATE OR ALTER VIEW dim_status AS
WITH clean_status AS
(SELECT DISTINCT
order_status
FROM raw_erp_sales)
SELECT
ROW_NUMBER() OVER(ORDER BY order_status) AS id_status,
order_status
FROM clean_status;

-- ================================================================
-- Tabela: dim_customer (wymiar)
-- ================================================================
-- Cel: utworzenie tabeli (widoku) wymiaru z tabeli raw_erp_sales

CREATE OR ALTER VIEW dim_customer AS
SELECT DISTINCT
customer_id
FROM raw_erp_sales;

-- ================================================================
-- Tabela: dim_campaign (wymiar)
-- ================================================================
-- Cel: utworzenie tabeli (widoku) wymiaru z tabeli raw_ga_sessions

CREATE OR ALTER VIEW dim_campaign AS
WITH clean_utm AS
(SELECT DISTINCT
utm_campaign
FROM raw_ga_sessions)
SELECT
ROW_NUMBER() OVER(ORDER BY utm_campaign) AS id_utm_campaign,
utm_campaign
FROM clean_utm;

-- ================================================================
-- Tabela: dim_traffic_source (wymiar)
-- ================================================================
-- Cel: utworzenie tabeli (widoku) wymiaru z tabeli raw_ga_sessions

CREATE OR ALTER VIEW dim_traffic_source AS 
WITH clean_traffic AS
(SELECT DISTINCT
traffic_source
FROM raw_ga_sessions)
SELECT
ROW_NUMBER() OVER(ORDER BY traffic_source) AS id_traffic_source,
traffic_source
FROM clean_traffic;

-- ================================================================
-- Tabela: fact_ga_sessions
-- ================================================================
-- Cel: utworzenie tabeli (widoku) faktu z tabeli raw_ga_sessions

CREATE OR ALTER VIEW fact_ga_sessions AS
SELECT
rgs.event_date,
dc.id_utm_campaign,
dts.id_traffic_source,
rgs.sessions_count,
rgs.ad_cost_pln
FROM raw_ga_sessions rgs
LEFT JOIN
dim_campaign dc
ON rgs.utm_campaign = dc.utm_campaign
LEFT JOIN dim_traffic_source dts
ON rgs.traffic_source = dts.traffic_source;

-- ================================================================
-- Tabela: fact_erp_sales
-- ================================================================
-- Cel: utworzenie tabeli (widoku) faktu z tabeli raw_erp_sales

CREATE OR ALTER VIEW fact_erp_sales AS
SELECT
res.order_id,
res.order_date,
dcc.id_utm_campaign,
dts.id_traffic_source,
dc.customer_id,
res.order_amount,
ds.id_status,
LOWER(res.user_notes) AS user_notes
FROM raw_erp_sales res
LEFT JOIN dim_customer dc ON res.customer_id = dc.customer_id
LEFT JOIN dim_status ds ON res.order_status = ds.order_status
LEFT JOIN dim_campaign dcc ON res.utm_campaign_raw = dcc.utm_campaign
LEFT JOIN dim_traffic_source dts ON res.traffic_source_raw = dts.traffic_source;