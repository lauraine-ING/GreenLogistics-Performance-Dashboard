-- ============================================================
-- 1. ERSTELLUNG DER DIMENSIONSTABELLEN (DIM TABLES)
-- ============================================================

-- Dimensionstabelle: Fahrzeuge
CREATE TABLE Dim_Vehicles (
    Vehicle_ID INT PRIMARY KEY,
    Vehicle_Name VARCHAR(50),
    Engine_Type VARCHAR(20), -- Diesel, Electric, Hybrid
    CO2_Factor_Per_KM FLOAT,  -- Gramm CO2 pro Kilometer
    Maintenance_Cost_Per_KM FLOAT -- Geschätzte Kosten in € pro Kilometer
);

-- Dimensionstabelle: Geografie (Logistik-Hubs)
CREATE TABLE Dim_Geography (
    Hub_ID INT PRIMARY KEY,
    Hub_City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50)
);

-- ============================================================
-- 2. ERSTELLUNG DER FAKTENTABELLE (FACT TABLE)
-- ============================================================

-- Faktentabelle: Lieferungen
CREATE TABLE Fact_Deliveries (
    Delivery_ID INT PRIMARY KEY,
    Delivery_Date DATE,
    Vehicle_ID INT,
    Hub_ID INT,
    Distance_KM FLOAT,
    Delivery_Status VARCHAR(20), -- On-Time, Delayed, Cancelled
    Revenue FLOAT,
    FOREIGN KEY (Vehicle_ID) REFERENCES Dim_Vehicles(Vehicle_ID),
    FOREIGN KEY (Hub_ID) REFERENCES Dim_Geography(Hub_ID)
);

-- ============================================================
-- 3. EINFÜGEN DER TESTDATEN (KONSISTENTE BUSINESS-LOGIK)
-- ============================================================

-- Einfügen der Fahrzeuge (Beispiele mit realistischen CO2-Werten)
INSERT INTO Dim_Vehicles VALUES (1, 'Mercedes Sprinter Diesel', 'Diesel', 260.0, 0.15);
INSERT INTO Dim_Vehicles VALUES (2, 'Renault Kangoo E-Tech', 'Electric', 0.0, 0.05);
INSERT INTO Dim_Vehicles VALUES (3, 'Ford Transit Hybrid', 'Hybrid', 130.0, 0.10);
INSERT INTO Dim_Vehicles VALUES (4, 'Iveco Daily Diesel', 'Diesel', 280.0, 0.18);
INSERT INTO Dim_Vehicles VALUES (5, 'Nissan Townstar EV', 'Electric', 0.0, 0.04);

-- Einfügen der deutschen Logistik-Hubs
INSERT INTO Dim_Geography VALUES (101, 'Berlin', 'North-East', 'Germany');
INSERT INTO Dim_Geography VALUES (102, 'Munich', 'Bavaria', 'Germany');
INSERT INTO Dim_Geography VALUES (103, 'Frankfurt', 'Hesse', 'Germany');
INSERT INTO Dim_Geography VALUES (104, 'Hamburg', 'North', 'Germany');

-- Einfügen einer Stichprobe von Lieferungen
-- Format: ID, Date, Vehicle_ID, Hub_ID, Distance_KM, Status, Revenue
INSERT INTO Fact_Deliveries VALUES (1001, '2026-06-01', 1, 101, 45.5, 'On-Time', 150.0);
INSERT INTO Fact_Deliveries VALUES (1002, '2026-06-01', 2, 101, 12.0, 'On-Time', 80.0);
INSERT INTO Fact_Deliveries VALUES (1003, '2026-06-02', 4, 102, 120.0, 'Delayed', 340.0);
INSERT INTO Fact_Deliveries VALUES (1004, '2026-06-02', 3, 103, 35.0, 'On-Time', 110.0);
INSERT INTO Fact_Deliveries VALUES (1005, '2026-06-03', 5, 104, 18.5, 'On-Time', 95.0);
INSERT INTO Fact_Deliveries VALUES (1006, '2026-06-03', 1, 102, 85.0, 'On-Time', 220.0);
INSERT INTO Fact_Deliveries VALUES (1007, '2026-06-04', 2, 103, 15.0, 'Delayed', 75.0);
INSERT INTO Fact_Deliveries VALUES (1008, '2026-06-04', 4, 101, 140.0, 'On-Time', 410.0);
INSERT INTO Fact_Deliveries VALUES (1009, '2026-06-05', 3, 104, 60.0, 'Cancelled', 0.0);
INSERT INTO Fact_Deliveries VALUES (1010, '2026-06-05', 5, 102, 22.0, 'On-Time', 105.0);