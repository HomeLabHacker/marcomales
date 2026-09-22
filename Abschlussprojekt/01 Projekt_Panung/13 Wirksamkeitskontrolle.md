
Nach Abschluss der technischen Implementierung wird überprüft, ob die
umgesetzte Netzwerksegmentierung und das pfSense-Regelwerk die zuvor
definierten Sicherheitsanforderungen erfüllen.

Hierzu werden die Ergebnisse der Testphase mit dem festgelegten
SOLL-Zustand verglichen.

Dabei wird insbesondere geprüft, ob:

- erforderliche Kommunikationsbeziehungen weiterhin funktionieren,
- nicht erforderliche Kommunikationsbeziehungen unterbunden werden,
- administrative Zugriffe auf die dafür vorgesehene Management-Zone
  beschränkt sind,
- die Kommunikation zwischen den Sicherheitszonen entsprechend der
  definierten Kommunikationsmatrix kontrolliert wird.

## Erneute Risikobewertung

Nach erfolgreicher Durchführung der Tests wird das ursprünglich
identifizierte Risiko erneut bewertet.

Dabei werden die Eintrittswahrscheinlichkeit und die möglichen
Auswirkungen unter Berücksichtigung der implementierten
Sicherheitsmaßnahmen betrachtet.

Die Risikobewertung vor und nach der Umsetzung wird gegenübergestellt.

| Bewertung | Vor Maßnahme | Nach Maßnahme |
|---|---|---|
| Eintrittswahrscheinlichkeit | während IST-Analyse bestimmen | nach Testphase bestimmen |
| Schadensauswirkung | während IST-Analyse bestimmen | nach Testphase bestimmen |
| Risikoeinstufung | während IST-Analyse bestimmen | nach Testphase bestimmen |

Die tatsächlichen Werte werden erst im Rahmen der Projektdurchführung
ermittelt und dokumentiert.

## Ziel der Wirksamkeitskontrolle

Ziel ist der nachvollziehbare Nachweis, dass die implementierte
Netzwerksegmentierung mit pfSense das identifizierte
Informationssicherheitsrisiko reduziert, ohne die für den Betrieb
erforderlichen Kommunikationsbeziehungen zu beeinträchtigen.

Ein verbleibendes Risiko wird als Restrisiko dokumentiert und im
anschließenden Projektabschnitt bewertet.