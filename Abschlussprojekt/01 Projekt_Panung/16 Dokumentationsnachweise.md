
Während der gesamten Projektdurchführung werden technische und
organisatorische Nachweise gesammelt.

Die Nachweise dienen der nachvollziehbaren Dokumentation des
Projektverlaufs und werden, soweit relevant, als Anlagen in die
Projektdokumentation aufgenommen.

## IST-Analyse

- [ ] Screenshot der ursprünglichen Hyper-V-Umgebung
- [ ] IST-Netzplan
- [ ] Übersicht der eingesetzten virtuellen Maschinen
- [ ] IP-Adressierung des IST-Zustandes
- [ ] relevante Hyper-V-Konfiguration
- [ ] Nachweise bestehender Kommunikationsmöglichkeiten
- [ ] Assetübersicht

## Schutzbedarf und Risikoanalyse

- [ ] Schutzbedarfsbewertung nach Vertraulichkeit, Integrität und Verfügbarkeit
- [ ] Begründung der Schutzbedarfseinstufungen
- [ ] Beschreibung des identifizierten Risikos
- [ ] Bewertung der Eintrittswahrscheinlichkeit
- [ ] Bewertung der möglichen Schadensauswirkung
- [ ] Risikobewertung vor Umsetzung der Maßnahme

## Planung des SOLL-Zustandes

- [ ] SOLL-Netzplan
- [ ] IP-Adresskonzept
- [ ] Definition der Sicherheitszonen CLIENT, SERVER und MGMT
- [ ] Kommunikationsmatrix
- [ ] geplante Firewall-Regelmatrix
- [ ] Begründung der gewählten Netzwerkarchitektur

## Technische Umsetzung

- [ ] Hyper-V-Switch-Konfiguration
- [ ] pfSense-Installation und Grundkonfiguration
- [ ] Zuordnung der pfSense-Netzwerkschnittstellen
- [ ] Konfiguration CLIENT-Zone
- [ ] Konfiguration SERVER-Zone
- [ ] Konfiguration MGMT-Zone
- [ ] pfSense-Firewallregeln
- [ ] relevante Screenshots der Implementierung
- [ ] Dokumentation aufgetretener Probleme und Lösungen

## Testphase

### VOR der Segmentierung

- [ ] Testergebnisse der definierten Kommunikationsbeziehungen
- [ ] Nachweis unerwünschter erreichbarer Dienste

### NACH der Segmentierung

- [ ] Funktionstests erforderlicher Verbindungen
- [ ] Sicherheitstests blockierter Verbindungen
- [ ] Testprotokoll
- [ ] Nachweise der pfSense-Regelwirkung
- [ ] ggf. Fehler und durchgeführte Korrekturen
- [ ] Wiederholung fehlgeschlagener Tests

## Projektabschluss

- [ ] Soll-Ist-Vergleich
- [ ] Risikobewertung nach Umsetzung
- [ ] Bewertung der Wirksamkeit
- [ ] Restrisikobewertung
- [ ] Zielerreichung
- [ ] Abweichungen vom ursprünglichen Projektplan
- [ ] Fazit
- [ ] Ausblick auf mögliche weiterführende Maßnahmen

---

## Ablagestruktur

Nachweise/
├── 01_IST/
├── 02_Risikoanalyse/
├── 03_SOLL-Konzept/
├── 04_pfSense/
├── 05_Hyper-V/
├── 06_Tests/
└── 07_Projektabschluss/