--
Wstawianie wartości raw_erp_sales

INSERT INTO raw_erp_sales (order_id, order_date, utm_campaign_raw, traffic_source_raw, customer_id, order_amount, order_status, user_notes)
VALUES
(1001, '2026-03-12 10:15:00', 'black_friday_pre', 'google_cpc', 101, 349.00, 'Zakończone', 'Klient prosil o szybka wysylke'),
(1002, '2026-03-12 14:20:00', 'google_search_brand', 'google_cpc', 102, 120.50, 'Zakończone', 'OK'),
(1003, '2026-03-13 09:05:00', 'autumn_sale_2026', 'meta_ads', 103, 899.99, 'Anulowane', 'zwrot towaru - za duzy'),
(1004, '2026-03-15 11:40:00', 'black_friday_pre', 'meta_ads', 104, 450.00, 'Zakończone', 'Brak faktury w paczce - dopisać'),
(1005, '2026-04-02 16:11:00', '', 'direct', 105, 55.00, 'Zakończone', ''),
(1006, '2026-04-10 12:30:00', 'display_remarketing', 'google_cpc', 106, 1250.00, 'Zakończone', 'Test zamówienia pracowniczego'),
(1007, '2026-05-04 08:50:00', 'summer_clearance', 'newsletter', 107, 210.00, 'Zakończone', 'promocja majowa'),
(1008, '2026-05-12 15:15:00', 'autumn_sale_2026', 'meta_ads', 108, 430.00, 'W realizacji', '   '),
(1009, '2026-06-01 10:00:00', 'google_search_brand', 'google_cpc', 109, 650.00, 'Zakończone', 'Klient VIP'),
(1010, '2026-06-15 13:25:00', 'black_friday_pre', 'google_cpc', 110, 1150.00, 'Zakończone', 'Ok'),
(1011, '2026-07-01 11:10:00', 'summer_clearance', 'newsletter', 111, 320.00, 'Zakończone', 'rabat naliczony ręcznie'),
(1012, '2026-07-18 14:05:00', '', 'direct', 112, 89.00, 'Zakończone', 'brak uwag'),
(1013, '2026-08-05 09:30:00', 'autumn_sale_2026', 'meta_ads', 113, 760.00, 'Anulowane', 'Klient zrezygnował przed wysyłką'),
(1014, '2026-08-20 16:45:00', 'display_remarketing', 'google_cpc', 114, 410.00, 'Zakończone', 'Szybka płatność BLIK'),
(1015, '2026-09-02 10:20:00', 'google_search_brand', 'google_cpc', 115, 990.00, 'Zakończone', 'faktura na firmę'),
(1016, '2026-09-11 12:00:00', 'black_friday_pre', 'meta_ads', 116, 530.00, 'Zakończone', '   '),
(1017, '2026-10-01 08:15:00', 'summer_clearance', 'newsletter', 117, 150.00, 'Zakończone', 'OK'),
(1018, '2026-10-14 15:50:00', 'autumn_sale_2026', 'meta_ads', 118, 1200.00, 'Zakończone', 'Wysłać kurierem DPD'),
(1019, '2026-11-03 11:30:00', '', 'direct', 119, 299.00, 'W realizacji', 'PROSBA O KONTAKT'),
(1020, '2026-11-12 14:10:00', 'black_friday_pre', 'google_cpc', 120, 1850.00, 'Zakończone', 'Czarny piątek - duża paczka'),
(1021, '2026-11-13 09:12:00', 'black_friday_pre', 'google_cpc', 121, 440.00, 'Zakończone', 'OK'),
(1022, '2026-11-13 11:45:00', 'google_search_brand', 'google_cpc', 122, 129.00, 'Zakończone', 'Wszystko w porządku'),
(1023, '2026-11-14 16:20:00', 'autumn_sale_2026', 'meta_ads', 123, 750.00, 'W realizacji', 'Czeka na wpłatę'),
(1024, '2026-11-14 18:00:00', 'display_remarketing', 'google_cpc', 124, 310.00, 'Zakończone', 'Szybka wysyłka'),
(1025, '2026-11-15 08:30:00', '', 'direct', 125, 99.00, 'Zakończone', 'brak');

-- 
Wstawianie wartości raw_ga_sessions

INSERT INTO raw_ga_sessions (event_date, utm_campaign, traffic_source, sessions_count, ad_cost_pln)
VALUES
('2026-03-12', 'black_friday_pre', 'google_cpc', 450, 1200.00),
('2026-03-12', 'google_search_brand', 'google_cpc', 230, 800.50),
('2026-03-13', 'autumn_sale_2026', 'meta_ads', 620, 1500.00),
('2026-03-15', 'black_friday_pre', 'meta_ads', 310, 950.00),
('2026-04-02', 'no_campaign', 'direct', 150, 0.00),
('2026-04-10', 'display_remarketing', 'google_cpc', 890, 2400.00),
('2026-05-04', 'summer_clearance', 'newsletter', 420, 600.00),
('2026-05-12', 'autumn_sale_2026', 'meta_ads', 510, 1300.00),
('2026-06-01', 'google_search_brand', 'google_cpc', 340, 900.00),
('2026-06-15', 'black_friday_pre', 'google_cpc', 780, 2100.00),
('2026-07-01', 'summer_clearance', 'newsletter', 290, 450.00),
('2026-07-18', 'no_campaign', 'direct', 90, 0.00),
('2026-08-05', 'autumn_sale_2026', 'meta_ads', 430, 1100.00),
('2026-08-20', 'display_remarketing', 'google_cpc', 650, 1800.00),
('2026-09-02', 'google_search_brand', 'google_cpc', 380, 990.00),
('2026-09-11', 'black_friday_pre', 'meta_ads', 520, 1400.00),
('2026-10-01', 'summer_clearance', 'newsletter', 210, 300.00),
('2026-10-14', 'autumn_sale_2026', 'meta_ads', 840, 2200.00),
('2026-11-03', 'no_campaign', 'direct', 120, 0.00),
('2026-11-12', 'black_friday_pre', 'google_cpc', 1250, 3500.00),
('2026-11-13', 'black_friday_pre', 'google_cpc', 920, 2600.00),
('2026-11-13', 'google_search_brand', 'google_cpc', 310, 850.00),
('2026-11-14', 'autumn_sale_2026', 'meta_ads', 480, 1250.00),
('2026-11-14', 'display_remarketing', 'google_cpc', 540, 1500.00),
('2026-11-15', 'no_campaign', 'direct', 200, 0.00);