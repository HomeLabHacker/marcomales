
Als Projektergebnis soll eine auf Grundlage der IST-Analyse konzipierte
und technisch umgesetzte Netzwerksegmentierung innerhalb der
virtualisierten Unternehmensumgebung entstehen.

Ausgehend von der Schutzbedarfs- und Risikobetrachtung wird das
Informationssicherheitsrisiko der unzureichenden Trennung von Client-,
Server- und Administrationssystemen betrachtet.

Zur Risikobehandlung wird ein segmentiertes SOLL-Konzept mit getrennten
CLIENT-, SERVER- und MGMT-Zonen umgesetzt. Eine zentrale pfSense-Firewall
kontrolliert dabei die Kommunikation zwischen den Sicherheitszonen
anhand definierter Kommunikationsanforderungen.

Durch Funktions- und Sicherheitstests wird anschließend überprüft, ob
erforderliche Kommunikationsbeziehungen weiterhin funktionieren und
nicht erforderliche bzw. administrative Zugriffe zwischen den
Sicherheitszonen wirksam unterbunden werden.

Abschließend werden der IST- und SOLL-Zustand gegenübergestellt, die
Wirksamkeit der umgesetzten Sicherheitsmaßnahme bewertet und das
verbleibende Restrisiko dokumentiert.

## Erwarteter Mehrwert

Das Projektergebnis besteht somit nicht ausschließlich in der
Installation und Konfiguration einer Firewall, sondern in einem
nachvollziehbaren risikobasierten Vorgehen:

IST-Analyse
→ Schutzbedarfsbetrachtung
→ Risikobewertung
→ SOLL-Konzept
→ technische Umsetzung
→ Wirksamkeitsprüfung
→ Restrisikobewertung