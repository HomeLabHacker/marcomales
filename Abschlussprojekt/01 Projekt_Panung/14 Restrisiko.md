
Auch nach erfolgreicher Umsetzung der Netzwerksegmentierung kann das
identifizierte Informationssicherheitsrisiko nicht vollständig
beseitigt werden.

Die Segmentierung mit pfSense reduziert insbesondere die
Kommunikations- und Ausbreitungsmöglichkeiten zwischen Client-,
Server- und Management-Zone. Sie verhindert jedoch nicht die
Kompromittierung einzelner Systeme.

## Verbleibende Risiken

### Fehlkonfiguration der Firewall

Fehlerhafte oder zu weit gefasste Firewallregeln können dazu führen,
dass unerwünschte Kommunikationsbeziehungen zwischen den
Sicherheitszonen weiterhin möglich sind.

### Kompromittierung eines Servers

Die Netzwerksegmentierung verhindert nicht, dass ein Serversystem
beispielsweise durch eine Schwachstelle in einem freigegebenen Dienst
kompromittiert wird.

### Kompromittierung administrativer Konten oder Systeme

Wird ein administratives Konto oder ADM01 kompromittiert, können die
für die Administration vorgesehenen und bewusst freigegebenen
Kommunikationswege missbraucht werden.

### Missbrauch erlaubter Kommunikationswege

Auch notwendige und durch die Firewall zugelassene Dienste können
Schwachstellen enthalten oder für Angriffe genutzt werden.

### Schwachstellen innerhalb eines Netzwerksegments

Die zentrale pfSense-Firewall kontrolliert primär die Kommunikation
zwischen den definierten Sicherheitszonen. Angriffe zwischen Systemen
innerhalb derselben Zone werden dadurch nicht grundsätzlich verhindert.

## Bewertung des Restrisikos

Nach Abschluss der technischen Umsetzung und Wirksamkeitskontrolle
wird das ursprünglich identifizierte Risiko erneut bewertet.

Die tatsächliche Einstufung des Restrisikos erfolgt erst anhand der
Ergebnisse der Projektdurchführung und der durchgeführten Tests.

Weiterführende Maßnahmen zur zusätzlichen Reduzierung des Restrisikos
könnten beispielsweise eine stärkere Absicherung der Endsysteme,
zusätzliche hostbasierte Firewallregeln, Patch- und
Schwachstellenmanagement oder eine zentrale Sicherheitsüberwachung
umfassen.

Diese weiterführenden Maßnahmen werden im Rahmen des Projektes
betrachtet, sind jedoch aufgrund der Projektabgrenzung nicht Bestandteil
der technischen Umsetzung.