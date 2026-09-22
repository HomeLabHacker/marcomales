Im Rahmen der IST-Analyse werden die drei grundlegenden Schutzziele
der Informationssicherheit betrachtet:

## Vertraulichkeit

Informationen und Systeme sollen ausschließlich durch berechtigte
Personen und Systeme zugänglich sein.

**Bezug zum Projekt:**
Durch die fehlende Netzwerksegmentierung können Systeme
Kommunikationswege zu Bereichen besitzen, auf die sie für ihre
eigentliche Funktion keinen Zugriff benötigen.

Die geplante Segmentierung und das pfSense-Regelwerk sollen diese
Kommunikationsmöglichkeiten gezielt einschränken.

---

## Integrität

Informationen und Systeme sollen vor unberechtigter oder
unbeabsichtigter Veränderung geschützt werden.

**Bezug zum Projekt:**
Kann ein kompromittierter Client administrative Dienste oder
Serversysteme erreichen, besteht das Risiko einer unberechtigten
Manipulation.

Durch die Trennung von Client-, Server- und Management-Netz sowie
die Einschränkung der Kommunikation soll dieses Risiko reduziert werden.

---

## Verfügbarkeit

Informationen, Systeme und Dienste sollen für berechtigte Benutzer
zum erforderlichen Zeitpunkt verfügbar sein.

**Bezug zum Projekt:**
Fehlkonfigurationen der Firewall oder der Netzwerksegmentierung
können notwendige Kommunikationsbeziehungen unterbrechen.

Daher wird nach der Implementierung durch definierte Funktionstests
überprüft, ob erforderliche Dienste trotz der eingeführten
Sicherheitsmaßnahmen weiterhin erreichbar sind.

---
## Vorläufige Betrachtung

| Asset | Vertraulichkeit | Integrität | Verfügbarkeit |
|---|---|---|---|
| CL01 | normal | normal | normal |
| DC01 | hoch | hoch | hoch |
| ADM01 | hoch | hoch | mittel |
| Netzwerk/Firewall | hoch | hoch | hoch |

WICHTIG:

Die endgültige Bewertung und Begründung erfolgt während der
Projektdurchführung.