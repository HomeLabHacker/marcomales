# 05 Entscheidungsmatrix

**Projekt:** Risikobasierte Konzeption und Umsetzung einer Netzwerksegmentierung mit pfSense in einer virtualisierten Netzwerkumgebung  
**Verfasser:** Marco Males  
**Stand:** 17.09.2026  
**Status:** Konzeptentscheidung; technische Umsetzung und Wirksamkeitsnachweise stehen aus

## 1. Ziel und Entscheidungsrahmen

Auf Grundlage der [IST-Analyse](<02 IST-Analyse - Final.md>), der [Schutzbedarfsbetrachtung](<03 Schutzbedarf.md>) und der [Risikoanalyse](<04_Risikoanalyse.md>) werden drei Sicherheitskonzepte verglichen. Ziel ist eine nachvollziehbare Auswahl unter Berücksichtigung von Sicherheitswirkung, Betriebsfähigkeit, Prüfbarkeit sowie Umsetzungs- und Wartungsaufwand.

Die Netzwerksegmentierung mit pfSense ist nach Bestätigung des Projektverfassers eine verbindliche Vorgabe des Projektantrags. Die Entscheidungsmatrix dient deshalb der Auswahl des Umsetzungskonzepts innerhalb dieser Vorgabe. Sie bildet keine nachträgliche Produktauswahl zwischen unterschiedlichen Firewallherstellern ab.

Hyper-V ist die Plattform zur Nachbildung des Bürounternehmensmodells. Die Entscheidung setzt keine gemeinsame Virtualisierung sämtlicher Arbeitsplätze in einem realen Unternehmen voraus.

**Ergebnis:** Variante B – Segmentierung mit zentraler pfSense – wird ausgewählt. Sie erfüllt die verbindliche Vorgabe und erzielt unter den zulässigen Varianten mit **3,35 von 5 Punkten** den höchsten Nutzwert.

## 2. Betrachtete Lösungsvarianten

| Variante | Konzept | Abgrenzung |
|---|---|---|
| **A – Bestehendes Netz mit verschärften Windows-Firewallregeln** | Gemeinsames Netzwerk beibehalten; unerwünschte Zugriffe durch gezielte Regeln auf den Windows-Systemen einschränken. | Keine Netzwerksegmentierung und keine zusätzliche zentrale Filterinstanz. Die Variante dient als Vergleich zur Bewertung des Mehrwerts und Aufwands einer Segmentierung. |
| **B – Segmentierung mit zentraler pfSense** | CLIENT, SERVER und Management trennen; Kommunikation zwischen den Segmenten zentral durch pfSense filtern. | Bestehende Windows-Firewalls bleiben aktiv. Zusätzliche, gezielt mit pfSense doppelt durchgesetzte Projektregeln auf den Windows-Systemen sind kein Bestandteil dieses Konzepts. |
| **C – Segmentierung mit pfSense und ergänzenden Windows-Firewallregeln** | Segmentierung wie B; zusätzliche, abgestimmte Regeln auf den Windows-Systemen begrenzen dieselben relevanten Zugriffe auch am Ziel. | Beispielsweise beschränken sowohl pfSense als auch die Windows-Firewall auf DC01 den RDP-Zugriff auf ADM01. Beide Ebenen werden ausdrücklich gemeinsam eingerichtet und geprüft. |

Für alle Varianten bleiben geeignete Benutzerberechtigungen erforderlich. Eine Netzwerkfreigabe verleiht keine administrativen Rechte. Variante B bedeutet insbesondere nicht, die Windows-Firewalls abzuschalten. Erforderliche Anpassungen zur normalen Dienstfunktion sind von einer zusätzlichen, gezielt redundanten Schutzebene nach C zu unterscheiden.

Die Bewertung unterstellt korrekt umgesetzte Regeln. Weder die Anzahl der Firewalls noch die bloße Trennung in Subnetze garantieren für sich eine wirksame Zugriffsbeschränkung.

## 3. Prüfung der verbindlichen Mindestanforderung

Vor der abschließenden Auswahl wird geprüft, ob eine Variante die vorgegebene **Netzwerksegmentierung mit pfSense** erfüllt. Diese Bedingung kann nicht durch Punkte für geringeren Aufwand ausgeglichen werden.

| Variante | Mindestanforderung erfüllt? | Bedeutung für die Auswahl |
|---|---|---|
| A | Nein | Bleibt Vergleichsvariante; nicht als Projektlösung auswählbar. |
| B | Ja | Zulässige Variante. |
| C | Ja | Zulässige Variante. |

**Transparenz des Entscheidungsablaufs:** Die Gewichtung und Punkte wurden gemeinsam erarbeitet. Dabei erreichte A zunächst den höchsten rechnerischen Wert. Anschließend wurde die bereits bestehende Projektvorgabe ausdrücklich als verbindlich bestätigt und als Zulässigkeitsbedingung angewendet. Die Punkte wurden daraufhin nicht verändert. Es wird nicht behauptet, A sei im fachlichen Vergleich generell ungeeignet; sie erfüllt den festgelegten Projektumfang nicht.

## 4. Kriterien und Gewichtung

Die Gewichtung wurde vor der Punktevergabe festgelegt und für alle Varianten unverändert verwendet. Sie ist eine projektbezogene Ermessensentscheidung, keine BSI-Vorgabe.

| Kriterium | Gewicht | Bewertungsgegenstand | Begründung |
|---|---:|---|---|
| **Sicherheitswirkung** | **35 %** | Einschränkung unerlaubter Zugriffe und zusätzliche Begrenzung bei einer einzelnen fehlerhaften Regel. | Sicherheit ist das Hauptziel. R02 beschreibt unberechtigten administrativen Zugriff; R03 zeigt die Bedeutung vollständiger Filterung. |
| **Betriebsfähigkeit und Prüfbarkeit** | **25 %** | Zuverlässige Nutzbarkeit benötigter Dienste sowie eindeutige Prüfung erlaubter und gesperrter Verbindungen. | AD, DNS und berechtigte Verwaltung müssen funktionieren. R04 und R05a zeigen mögliche Betriebsunterbrechungen durch Fehlkonfigurationen. |
| **Umsetzungsaufwand** | **20 %** | Erstmalige Einrichtung, Abstimmung, Tests und Dokumentation. | Die Lösung muss innerhalb des auf 80 Stunden begrenzten Gesamtprojekts umsetzbar sein. |
| **Wartungsaufwand** | **20 %** | Wiederkehrende Pflege, Regeländerungen, Sicherungen und Prüfungen im Betrieb. | Interne IT und Dienstleister müssen die Lösung dauerhaft nachvollziehbar betreuen können. |
| **Gesamt** | **100 %** | | |

Sicherheitswirkung und Betriebsfähigkeit/Prüfbarkeit erhalten zusammen 60 %. Umsetzungs- und Wartungsaufwand erhalten zusammen 40 %, um Realisierbarkeit und langfristige Betreuung zu berücksichtigen. Die genaue Verteilung ist qualitativ begründet, nicht statistisch abgeleitet.

### Abgrenzung der Kriterien

Der Umsetzungsaufwand betrifft die einmalige Projektdurchführung, der Wartungsaufwand die spätere regelmäßige Betreuung. Bei Betriebsfähigkeit und Prüfbarkeit wird insbesondere betrachtet, wie eindeutig die Funktion und die Ursache einer Blockierung festgestellt werden können.

Zwischen Prüfbarkeit und Wartung bestehen dennoch Überschneidungen: Mehrere Regelebenen können sowohl die Fehlerzuordnung als auch spätere Änderungen erschweren. Dieser Zusammenhang begrenzt die Unabhängigkeit der Kriterien und kann komplexere Varianten mehrfach belasten. Die gemeinsam festgelegten Bewertungen werden offengelegt und nicht als objektive Messwerte dargestellt.

## 5. Punkteskala und Berechnung

| Punkte | Bedeutung |
|---:|---|
| 1 | Kriterium nur unzureichend erfüllt |
| 2 | Mit deutlichen Einschränkungen erfüllt |
| 3 | Ausreichend erfüllt |
| 4 | Gut erfüllt |
| 5 | Sehr gut erfüllt |

Bei Umsetzungs- und Wartungsaufwand gilt: **Weniger Aufwand erhält mehr Punkte.** Fünf Punkte bedeuten eine sehr günstige Bewertung im betrachteten Vergleich, nicht Aufwandfreiheit oder absolute Sicherheit.

Der Nutzwert wird berechnet als:

**Gesamtwert = Sicherheit × 0,35 + Betrieb/Prüfbarkeit × 0,25 + Umsetzung × 0,20 + Wartung × 0,20.**

Die maximal erreichbare Punktzahl beträgt 5. Die Rechnung dient zur transparenten Zusammenführung qualitativer Einschätzungen. Hundertstelstellen entstehen durch die Gewichtung und sind keine entsprechende Messgenauigkeit.

## 6. Begründung der Einzelbewertungen

### 6.1 Sicherheitswirkung – 35 %

| Variante | Punkte | Begründung |
|---|---:|---|
| A | 2 | Gezielte Windows-Firewallregeln können unerlaubte Zugriffe auch im gemeinsamen Netz beschränken. Eine unabhängige Filterung zwischen Sicherheitszonen fehlt jedoch. Fehlerhafte oder deaktivierte Regeln am Ziel können den vorgesehenen Schutz aufheben. |
| B | 4 | Getrennte Segmente und zentrale Regeln begrenzen die Kommunikation zwischen CLIENT, SERVER und Management. Eine zu weit gefasste zentrale Regel kann weiterhin unerwünschte Zugriffe ermöglichen. Verkehr innerhalb eines Segments wird nicht grundsätzlich durch pfSense geführt. |
| C | 5 | Ergänzende Regeln auf den Windows-Systemen können bei einer zu weit gefassten pfSense-Regel weiter begrenzen. Die Bewertung setzt die korrekte Abstimmung beider Ebenen voraus. Ein kompromittierter ADM01 mit geeigneten Zugangsdaten bleibt ein Restrisiko. |

Die hohe Bewertung von C bedeutet keinen maximalen oder vollständigen Schutz. Internetverkehr wird durch pfSense nur kontrolliert, soweit er tatsächlich über sie geführt wird; im Mittelpunkt dieses Vergleichs steht die interne Zugriffsbeschränkung.

### 6.2 Betriebsfähigkeit und Prüfbarkeit – 25 %

| Variante | Punkte | Begründung |
|---|---:|---|
| A | 4 | Die Netzstruktur bleibt bestehen. Erlaubte und gesperrte Verbindungen lassen sich gezielt prüfen; zur Ursachenanalyse sind die jeweiligen Windows-Regeln und Protokolle zu betrachten. |
| B | 3 | Zentrale Firewalllogs unterstützen die Prüfung. Zusätzliche Schnittstellen-, Routing- und Regelkonfigurationen schaffen weitere Abhängigkeiten und mögliche Fehlerursachen für benötigte Dienste. |
| C | 2 | Bei einer unerwarteten Blockierung müssen gegebenenfalls beide Filterebenen untersucht werden. Die Zuordnung der Ursache wird aufwendiger; abgestimmte Regeln und dokumentierte Tests können dies abmildern. |

Diese Werte sind Planungsbewertungen. Eine tatsächlich höhere Fehlerhäufigkeit von B oder C wurde nicht gemessen. Insbesondere C kann mit geeigneter Dokumentation gut betrieben werden; die niedrigere Punktzahl beschreibt den erwarteten Aufwand zur eindeutigen Prüfung im vorliegenden Projekt.

### 6.3 Umsetzungsaufwand – 20 %

| Variante | Punkte | Begründung |
|---|---:|---|
| A | 5 | Die bestehende Netzstruktur bleibt erhalten. Der Aufwand konzentriert sich auf Windows-Firewallregeln, Tests und Dokumentation; zusätzliche Segmente und pfSense entfallen. |
| B | 3 | pfSense, Schnittstellen, Segmente, IP-Konfigurationen, Routing und zentrale Regeln werden eingerichtet, geprüft und dokumentiert. Dafür wird ein mittlerer relativer Aufwand angesetzt. |
| C | 2 | Zusätzlich zu B werden gezielte Windows-Regeln eingerichtet und mit der zentralen Filterung abgestimmt. Beide Ebenen müssen gemeinsam getestet und dokumentiert werden. |

Die Bewertung enthält keine gemessenen Stundenwerte je Variante. Die spätere Detailplanung muss die gewählte Lösung innerhalb des Gesamtbudgets konkretisieren.

### 6.4 Wartungsaufwand – 20 %

| Variante | Punkte | Begründung |
|---|---:|---|
| A | 4 | In der kleinen Modellumgebung bleibt die zusätzliche Pflege auf Windows-Firewallregeln begrenzt. Der tatsächliche Aufwand hängt davon ab, ob die Verwaltung zentral, etwa über Gruppenrichtlinien, oder lokal erfolgt. Dies ist noch nicht abschließend festgelegt. |
| B | 3 | Die zentrale Regelverwaltung erleichtert Änderungen der segmentübergreifenden Kommunikation. pfSense selbst, Konfigurationssicherungen und wiederkehrende Prüfungen erzeugen zusätzliche Pflegeaufgaben. Die Windows-Grundabsicherung bleibt bestehen. |
| C | 2 | Die Regeln beider Ebenen müssen dauerhaft zusammenpassen. Änderungen an Kommunikationsanforderungen können Anpassungen und Prüfungen an pfSense und Windows erfordern. |

## 7. Gewichtete Entscheidungsmatrix

In den Variantenfeldern steht jeweils **Punktzahl → gewichteter Beitrag**.

| Kriterium | Gewicht | A | B | C |
|---|---:|---:|---:|---:|
| Sicherheitswirkung | 35 % | 2 → 0,70 | 4 → 1,40 | 5 → 1,75 |
| Betriebsfähigkeit und Prüfbarkeit | 25 % | 4 → 1,00 | 3 → 0,75 | 2 → 0,50 |
| Umsetzungsaufwand | 20 % | 5 → 1,00 | 3 → 0,60 | 2 → 0,40 |
| Wartungsaufwand | 20 % | 4 → 0,80 | 3 → 0,60 | 2 → 0,40 |
| **Gesamtwert** | **100 %** | **3,50** | **3,35** | **3,05** |
| Rechnerischer Rang ohne Mindestanforderung | | 1 | 2 | 3 |
| Mindestanforderung erfüllt | | Nein | Ja | Ja |
| **Rang der zulässigen Varianten** | | Nicht auswählbar | **1** | **2** |

A hat rechnerisch den höchsten Nutzwert, erfüllt aber die verbindliche Segmentierungsvorgabe nicht. Unter den zulässigen Varianten liegt B um **0,30 Punkte** vor C. Der zusätzliche Sicherheitsnutzen von C wird durch die ungünstigeren Einschätzungen in den anderen Kriterien übertroffen.

## 8. Sensitivitätsprüfung

Zur Prüfung der Stabilität werden die Punkte unverändert gelassen und nur die Gewichte variiert. Verglichen werden die zulässigen Varianten B und C.

| Sicherheit / Betrieb / Umsetzung / Wartung | B | C | Ergebnis |
|---|---:|---:|---|
| **35 / 25 / 20 / 20 %** – festgelegt | **3,35** | **3,05** | B liegt 0,30 Punkte vorn. |
| 40 / 20 / 20 / 20 % | 3,40 | 3,20 | B liegt 0,20 Punkte vorn. |
| 45 / 20 / 20 / 15 % | 3,45 | 3,35 | B liegt 0,10 Punkte vorn. |
| 50 / 20 / 15 / 15 % | 3,50 | 3,50 | Gleichstand. |

C erhält bei Sicherheit einen Punkt mehr, bei jedem anderen Kriterium einen Punkt weniger als B. Deshalb entsteht bei 50 % Sicherheitsgewicht Gleichstand; oberhalb von 50 % gewinnt C, sofern alle Punkte unverändert bleiben und die Gewichte insgesamt 100 % ergeben.

**Ergebnis:** Die Auswahl von B ist gegenüber den untersuchten moderaten Gewichtsänderungen stabil. Diese Aussage gilt nicht automatisch für veränderte Punktebewertungen. Eine andere Einschätzung der Prüfbarkeit oder eine stärker zentralisierte Verwaltung könnte das Ergebnis beeinflussen. Es wurden keine Punkte nachträglich angepasst, um eine bestimmte Variante gewinnen zu lassen.

## 9. Auswahlentscheidung und Folgen für das Projekt

**Variante B – Netzwerksegmentierung mit zentraler pfSense – wird als Umsetzungskonzept ausgewählt.** Sie erfüllt die verbindliche Projektvorgabe und erreicht unter den zulässigen Varianten den höchsten Nutzwert. Gegenüber C wird der geringere Abstimmungs-, Umsetzungs- und Pflegeaufwand bei weiterhin guter geplanter Sicherheitswirkung bevorzugt.

Für das [SOLL-Konzept](<06 SOLL-Konzept 1.0.md>) folgen daraus:

1. CLIENT, SERVER und Management werden technisch getrennt und über pfSense kontrolliert verbunden.
2. Erforderliche Verbindungen werden in einer Kommunikationsmatrix festgelegt; direkte RDP-Verbindungen von CLIENT zu DC01 werden blockiert, der vorgesehene Verwaltungszugang auf ADM01 beschränkt.
3. Die IPv6-Anforderung wird ausdrücklich umgesetzt und hinsichtlich Regelwirkung und tatsächlichem Netzwerkweg geprüft. Windows-seitige Maßnahmen aus dieser Anforderung bleiben Teil der weiteren Planung; sie bedeuten nicht automatisch, dass sämtliche zentralen Zugriffsregeln zusätzlich wie bei C auf jedem Zielsystem nachgebildet werden.
4. Bestehende Windows-Firewalls und Anmeldebeschränkungen bleiben aktiv. Zusätzliche Windows-Regeln zur unabhängigen doppelten Durchsetzung der segmentübergreifenden Projektregeln sind nicht als regulärer Umfang von B eingeplant.
5. Zulässige Verbindungen und Sperren werden durch Vorher-/Nachher-Tests sowie passende Protokolle nachgewiesen.
6. Änderungen, Konfigurationssicherungen, Rückfallplan und Verantwortlichkeiten werden entsprechend der Risikoanalyse konkretisiert.

### Grenzen der Entscheidung

Die Entscheidungsmatrix belegt keine bereits erreichte Risikoreduzierung. Die Wirkung muss nach der Umsetzung überprüft werden. R01 – updatebedingter Ausfall von DC01 – wird durch B nicht wesentlich behandelt. Die zentrale pfSense-Abhängigkeit aus R05b bleibt bestehen. Auch der Missbrauch eines kompromittierten ADM01 mit ausreichend berechtigten Zugangsdaten bleibt möglich.

Die Auswahl von B ist keine pauschale Akzeptanz aller Restrisiken. Verbleibende Risiken sind nach den Prüfungen zu bewerten und der im Modell zuständigen Unternehmensleitung zur Entscheidung vorzulegen. Bei neuen Anforderungen, unzureichenden Testergebnissen oder geänderten Rahmenbedingungen ist die Konzeptentscheidung erneut zu prüfen.

## 10. Quellen- und Entscheidungsgrundlagen

| Quelle | Verwendung |
|---|---|
| [02 IST-Analyse – Final](<02 IST-Analyse - Final.md>) einschließlich dort verlinkter Primärnachweise | Bestehende Netzstruktur, Erreichbarkeit und vorhandene Anmeldekontrollen. |
| [03 Schutzbedarf](<03 Schutzbedarf.md>) | Schutzzielanforderungen und Bürounternehmensmodell. |
| [04 Risikoanalyse](<04_Risikoanalyse.md>) | Risiken R01–R05b, Maßnahmen, Prüfanforderungen und verbleibende Abhängigkeiten. |
| [00 Projektziel](<00 Projektziel.md>) | Entscheidungsweg von IST und Schutzbedarf über Lösungsalternativen zur Umsetzung und Wirksamkeitsprüfung. |
| Gemeinsame Erarbeitung mit Marco Males im Projektdialog; dokumentiert am 17.09.2026 | Varianten, Gewichtung, Einzelbewertungen, Bestätigung der verbindlichen pfSense-Segmentierung und Auswahl von B. |

Die Einzelpunkte sind qualitative Projektbewertungen und keine Herstellerangaben oder empirischen Vergleichsmessungen. Für diese Matrix wurde keine externe Normgewichtung übernommen. Die Vorgabe aus dem Projektantrag wurde vom Projektverfasser bestätigt; der Antrag wurde für dieses Kapitel nicht erneut als Originaldatei geprüft. Die Sensitivitätswerte ergeben sich rechnerisch aus den dokumentierten Punkten und Gewichten.
