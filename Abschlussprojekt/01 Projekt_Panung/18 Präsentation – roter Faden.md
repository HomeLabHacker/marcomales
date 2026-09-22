
## Zielzeit

ca. 15–18 Minuten

---

## 1. Ausgangssituation und Projektziel

- kurze Vorstellung der virtualisierten Unternehmensumgebung
- Darstellung des IST-Netzes
- Problem der fehlenden Netzwerksegmentierung
- Projektziel

---

## 2. Schutzbedarf und Risiko

- unterschiedliche Schutzanforderungen von CLIENT, SERVER und MGMT
- betrachtete Schutzziele:
  - Vertraulichkeit
  - Integrität
  - Verfügbarkeit
- identifiziertes Informationssicherheitsrisiko
- Bewertung des Risikos vor Umsetzung

---

## 3. SOLL-Konzept

Darstellung der geplanten Sicherheitszonen:

CLIENT
SERVER
MGMT

pfSense als zentraler Kontrollpunkt zwischen den Sicherheitszonen.

- IP-Konzept
- Kommunikationsanforderungen
- geplantes Firewall-Regelwerk

---

## 4. Technische Umsetzung

- Umsetzung der Netzwerksegmente in Hyper-V
- Integration von pfSense
- Routing zwischen den Sicherheitszonen
- Umsetzung der Firewallregeln

Nur die für das Verständnis wesentlichen technischen Details zeigen.

---

## 5. Test und Wirksamkeitskontrolle

Gegenüberstellung ausgewählter Kommunikationsbeziehungen:

| Verbindung | IST | SOLL | Ergebnis |
|---|---|---|---|
| CL01 → DNS/DC01 | möglich | erlaubt | Projektwert |
| CL01 → RDP/DC01 | möglich | blockiert | Projektwert |
| CL01 → MGMT | möglich | blockiert | Projektwert |
| ADM01 → RDP/DC01 | möglich | erlaubt | Projektwert |

Die tatsächlichen Ergebnisse werden während der Projektdurchführung
eingetragen.

---

## 6. Ergebnis und Restrisiko

- IST-/SOLL-Vergleich
- erreichte Verbesserung
- erneute Risikobewertung
- verbleibendes Restrisiko
- mögliche weiterführende Maßnahmen
- Fazit