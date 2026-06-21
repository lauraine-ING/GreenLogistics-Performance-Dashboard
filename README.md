# 🌍 GreenLogistics Performance & CO2 Dashboard

## 📊 Projektübersicht
Dieses Power BI-Dashboard dient als Entscheidungshilfe für das Logistikmanagement eines E-Commerce-Unternehmens. Ziel ist es, die Zustellungsperformance auf der „letzten Meile“ (Last Mile Delivery) zu optimieren, Kosten zu senken und gleichzeitig die CO₂-Emissionen gemäß den europäischen CSRD-Richtlinien (Corporate Sustainability Reporting Directive) zu überwachen.

## 🛠️ Tech Stack & Architektur
* **Datenbank:** PostgreSQL (Tabellenstruktur und Datenbefüllung komplett in SQL mit deutscher Kommentierung).
* **Datenmodellierung:** Sternschema (Star Schema / 1:N-Beziehungen), optimiert für performante BI-Abfragen.
* **Analysen & Berechnungen:** Fortgeschrittene DAX-Measures für betriebliche und ökologische Kennzahlen.
* **Versionskontrolle:** Power BI-Projektformat (`.pbip`) für eine saubere, textbasierte Git-Verfolgung (JSON/TMAML).

## 📐 Datenmodell (Sternschema)
Das Modell trennt transaktionale Fakten strikt von den Stammdaten-Dimensionen, um maximale Abfrageeffizienz zu gewährleisten:
* **Faktentabelle:** `fact_deliveries` (Umsatz, Distanz, Lieferstatus, IDs).
* **Dimensionen:** * `Dim_Vehicles` (Antriebsart wie Diesel/Elektro, Emissionsfaktoren, Wartungskosten).
  * `Dim_Geography` (Logistik-Hubs in Deutschland wie Berlin, München, Hamburg, Frankfurt).
  * `Dim_Date` (Dedizierte Kalendertabelle, erstellt in DAX für Time-Intelligence-Analysen).

## 🧮 Demonstrierte DAX-Measures
Um fortgeschrittene DAX-Kenntnisse zu demonstrieren, wurden die Kennzahlen mit Variablen (`VAR`) und tabellenübergreifenden Iteratoren strukturiert:

### 1. Gesamte CO₂-Emissionen (Tabellenübergreifende Berechnung)
*Berechnet den CO₂-Ausstoß dynamisch basierend auf der gefahrenen Strecke und dem spezifischen Emissionsfaktor des genutzten Fahrzeugtyps (Gramm in Kilogramm umgewandelt).*
```dax
Total_CO2_KG = 
SUMX(
    Fact_Deliveries,
    Fact_Deliveries[distance_km] * RELATED(Dim_Vehicles[co2_factor_per_km])
) / 1000
<img width="1156" height="652" alt="image" src="https://github.com/user-attachments/assets/d93b8282-6848-4db2-a8e4-e8ca3f43fd41" />
