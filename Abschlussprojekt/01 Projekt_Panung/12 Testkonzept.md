
Zur Überprüfung der Wirksamkeit der umgesetzten Netzwerksegmentierung
werden definierte Kommunikationsbeziehungen vor und nach der
Implementierung getestet.

Ziel der Tests ist der Nachweis, dass

1. erforderliche Kommunikationsbeziehungen weiterhin funktionieren und
2. nicht erforderliche bzw. administrative Kommunikationsbeziehungen
   zwischen den Sicherheitszonen unterbunden werden.

---

## 12.1 Test des IST-Zustandes

Vor der Implementierung der Netzwerksegmentierung wird dokumentiert,
welche Kommunikationsbeziehungen zwischen CL01, DC01 und ADM01
technisch möglich sind.

Die Ergebnisse dienen als Referenz für den späteren Soll-Ist-Vergleich.

---

## 12.2 Test des SOLL-Zustandes

Nach der Implementierung der Netzwerksegmentierung und des
pfSense-Regelwerks werden die definierten Tests erneut durchgeführt.

### Funktionstests

| ID | Quelle | Ziel | Funktion | Erwartetes Ergebnis |
|---|---|---|---|---|
| T01 | CL01 | DC01 | DNS-Auflösung | Erlaubt |
| T02 | CL01 | DC01 | erforderliche AD-Kommunikation | Erlaubt |
| T03 | ADM01 | DC01 | RDP-Administration | Erlaubt |
| T04 | ADM01 | FW01 | pfSense-Webadministration | Erlaubt |

### Sicherheitstests

| ID | Quelle | Ziel | Funktion | Erwartetes Ergebnis |
|---|---|---|---|---|
| T05 | CL01 | DC01 | RDP | Blockiert |
| T06 | CL01 | MGMT | Zugriff auf Management-Netz | Blockiert |
| T07 | CL01 | FW01 | pfSense-Webadministration | Blockiert |
| T08 | SERVER | MGMT | nicht freigegebene Verbindung | Blockiert |

---

## 12.3 Testdurchführung

Für jeden Test werden dokumentiert:

- Test-ID
- Datum und Uhrzeit
- Quelle und Ziel
- getesteter Dienst bzw. Port
- verwendetes Testverfahren
- erwartetes Ergebnis
- tatsächliches Ergebnis
- Status: bestanden / nicht bestanden
- gegebenenfalls erforderliche Korrekturmaßnahmen

---

## 12.4 Bewertung

Ein Test gilt als bestanden, wenn das tatsächliche Ergebnis mit dem
zuvor definierten Soll-Ergebnis übereinstimmt.

Fehlgeschlagene Tests werden analysiert. Notwendige Änderungen an der
Netzwerk- oder Firewallkonfiguration werden dokumentiert und der
betroffene Test anschließend wiederholt.

Die Gesamtergebnisse der Testphase dienen als Grundlage für die
Bewertung der Wirksamkeit der implementierten Sicherheitsmaßnahme und
die anschließende Bewertung des verbleibenden Restrisikos.