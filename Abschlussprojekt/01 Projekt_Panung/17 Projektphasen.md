## Phase 1 – Analyse

Ziel der Analysephase ist die Erfassung und Bewertung des bestehenden
IST-Zustandes der virtualisierten Unternehmensumgebung.

- Projektumfeld und Projektgrenzen erfassen
- vorhandene Systeme und Netzwerkstruktur dokumentieren
- IST-Netzplan erstellen
- bestehende Kommunikationsbeziehungen untersuchen
- relevante Assets identifizieren
- Schutzbedarf hinsichtlich Vertraulichkeit, Integrität und
  Verfügbarkeit betrachten
- Informationssicherheitsrisiko der unzureichenden
  Netzwerksegmentierung bewerten

**Ergebnis der Phase:**
Dokumentierter IST-Zustand einschließlich Schutzbedarfs- und
Risikobetrachtung.

---

## Phase 2 – Konzeption

Auf Grundlage der IST-Analyse wird das technische SOLL-Konzept für
die Netzwerksegmentierung entwickelt.

- Sicherheitsanforderungen aus der IST-Analyse ableiten
- CLIENT-, SERVER- und MGMT-Zone definieren
- IP-Adresskonzept erstellen
- Hyper-V-Netzwerkstruktur planen
- pfSense in die geplante Netzwerkarchitektur integrieren
- erforderliche Kommunikationsbeziehungen ermitteln
- Kommunikationsmatrix erstellen
- Firewall-Regelwerk planen
- SOLL-Netzplan erstellen

**Ergebnis der Phase:**
Dokumentiertes SOLL-Konzept für das segmentierte Netzwerk.

---

## Phase 3 – Implementierung

Das entwickelte SOLL-Konzept wird innerhalb der Hyper-V-Umgebung
technisch umgesetzt.

- virtuelle Hyper-V-Netzwerke erstellen bzw. anpassen
- CLIENT-, SERVER- und MGMT-Zone implementieren
- pfSense als zentrale Firewall integrieren
- Netzwerkschnittstellen und Routing konfigurieren
- virtuelle Systeme den vorgesehenen Sicherheitszonen zuordnen
- geplante Firewallregeln implementieren
- notwendige Kommunikationsbeziehungen freigeben
- nicht erforderliche Kommunikationsbeziehungen unterbinden
- Umsetzung fortlaufend dokumentieren

**Ergebnis der Phase:**
Technisch umgesetzte Netzwerksegmentierung mit pfSense als zentraler
Firewall zwischen den Sicherheitszonen.

---

## Phase 4 – Test und Qualitätssicherung

Die implementierte Netzwerksegmentierung wird anhand der zuvor
definierten Testfälle überprüft.

### Funktionstests

- DNS- und erforderliche AD-Kommunikation prüfen
- administrative Zugriffe aus der MGMT-Zone prüfen
- Erreichbarkeit notwendiger Dienste überprüfen

### Sicherheitstests

- unerlaubten RDP-Zugriff aus der CLIENT-Zone prüfen
- Zugriff der CLIENT-Zone auf die MGMT-Zone prüfen
- Zugriff auf die pfSense-Administration prüfen
- weitere nicht freigegebene Kommunikationsbeziehungen testen

### Fehlerbehandlung

- Abweichungen vom erwarteten Ergebnis dokumentieren
- Fehlerursachen analysieren
- Konfiguration gegebenenfalls korrigieren
- betroffene Tests wiederholen

**Ergebnis der Phase:**
Nachweis über die Funktionsfähigkeit und Wirksamkeit der
implementierten Sicherheitsmaßnahme.

---

## Phase 5 – Bewertung

Die Projektergebnisse werden aus Sicht der Informationssicherheit
bewertet.

- Testergebnisse auswerten
- IST- und SOLL-Zustand gegenüberstellen
- Wirksamkeit der Netzwerksegmentierung bewerten
- ursprüngliches Risiko erneut bewerten
- verbleibendes Restrisiko dokumentieren
- Zielerreichung bewerten
- mögliche weiterführende Maßnahmen aufzeigen

**Ergebnis der Phase:**
Nachvollziehbare Bewertung der erreichten Risikoreduktion und des
verbleibenden Restrisikos.

---

## Phase 6 – Projektabschluss und Dokumentation

Die während des gesamten Projektes fortlaufend erstellte
Dokumentation wird abschließend zusammengeführt und geprüft.

- Projektverlauf final dokumentieren
- Abweichungen vom ursprünglichen Projektplan dokumentieren
- technische Nachweise aufbereiten
- IST- und SOLL-Netzpläne einbinden
- Testprotokolle aufbereiten
- Anhänge zusammenstellen
- Quellen und Verzeichnisse prüfen
- Projektdokumentation finalisieren

**Ergebnis der Phase:**
Abgabefertiger Projektbericht einschließlich praxisbezogener Anlagen.

> Die Projektdokumentation erfolgt projektbegleitend und wird nicht
> ausschließlich am Ende des Projektes erstellt.