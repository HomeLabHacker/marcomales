
**Projekt:** Risikobasierte Konzeption und Umsetzung einer Netzwerksegmentierung mit pfSense in einer virtualisierten Netzwerkumgebung  
**Verfasser:** Marco Males  
**Stand:** 17.09.2026  
**Status:** Qualitative Bewertung und geplante Risikobehandlung; Umsetzung und Wirksamkeitsprüfung ausstehend

## 1. Ziel und Untersuchungsrahmen

Die Risikoanalyse verbindet die nachgewiesene [IST-Struktur](<02 IST-Analyse.md>) mit den in [03 Schutzbedarf](<03 Schutzbedarf.md>) begründeten Anforderungen an Vertraulichkeit, Integrität und Verfügbarkeit. Sie untersucht ausgewählte Ursachen, mögliche Ereignisse und betriebliche Folgen im Modell eines kleinen Bürounternehmens mit zentralem AD und DNS. Aus der Bewertung werden Anforderungen an das SOLL-Konzept und spätere Prüfungen abgeleitet.

Es werden fünf Themen mit sechs getrennten Szenarien betrachtet. R01 und R02 beziehen sich auf bestehende Abhängigkeiten und Kommunikationsmöglichkeiten. R03, R04, R05a und R05b bewerten mögliche Fehler beziehungsweise neue Abhängigkeiten der geplanten Lösung. Sie sind keine bereits festgestellten pfSense-Schwachstellen.

Die vorsorglich angelegte pfSense-VM übernimmt im nachgewiesenen IST keine Routing- oder Filterfunktion. Für die SOLL-Szenarien wird angenommen, dass sie künftig der einzige Router zwischen CLIENT, SERVER und Management ist. Eine zweite Firewall ist nicht vorgesehen.

### Abgrenzung der Laborplattform

Hyper-V dient zur Nachbildung der Unternehmensstruktur. Aus der gemeinsamen Unterbringung der Test-VMs auf MALES-IT wird nicht abgeleitet, dass sämtliche Arbeitsplätze des modellierten Unternehmens auf einem einzigen Host laufen. Ein gemeinsamer Host-Hardwareausfall wird deshalb nicht als zusätzlicher betrieblicher Risikofall bewertet. Die technische Abhängigkeit der Laborumgebung bleibt bestehen. Die Hostbewertung in Kapitel 03 ist in diesem Sinne als Bewertung des technischen Trägers der Testumgebung zu lesen.

Die Analyse ist eine projektbezogene Auswahl und keine vollständige Risikoanalyse aller Unternehmensprozesse. Es werden weder konkrete finanzielle Schadenssummen noch reale Angriffshäufigkeiten behauptet.

## 2. Grundlagen, Annahmen und Bewertungsmethode

### 2.1 Nachgewiesene Grundlagen

- DC01 stellt AD DS und DNS bereit. Ein zweiter DC mit DNS ist in der aufgenommenen Umgebung nicht vorhanden.
- CL01, ADM01 und DC01 befinden sich im gemeinsamen IPv4-Netz 192.168.2.0/24. Die aktiven Adapter sind mit vSW-IST-LAN verbunden.
- CL01 und ADM01 erreichen DC01 über die geprüften TCP-Ports 53, 88, 389, 445 und – nach Aktivierung des Dienstes – 3389.
- Interne DNS- und AD-SRV-Abfragen wurden erfolgreich dokumentiert. IPv6 ist aktiv; die DNS-Antworten enthalten auch IPv6-Adressen.
- Administrative Tests wurden unter anderem auf CL01 durchgeführt. Ein Diebstahl von Zugangsdaten oder eine tatsächliche Kompromittierung ist nicht nachgewiesen.
- Die Anmeldenachweise A01–A04 betreffen ADM01: adm.weber konnte sich anmelden, lschmidt wurde abgewiesen. Sie belegen keine administrative Berechtigung auf DC01.

Grundlagen sind die Primärnachweise im Quellenverzeichnis. Erfolgreiche TCP-Verbindungen belegen Erreichbarkeit, keine vollständige Dienstfunktion und keine unberechtigte Anmeldung.

### 2.2 Ergänzende Modellannahmen

| ID | Annahme beziehungsweise Festlegung | Aussagegrenze |
|---|---|---|
| A01 | Mehrere Mitarbeiter benötigen zentrale AD-/DNS-Funktionen; mehrstündige Unterbrechungen können wesentliche Büroabläufe beeinträchtigen. | Betriebliche Modellannahme; keine erhobenen Umsatz- oder Ausfallzahlen. |
| A02 | Updates auf DC01 werden ohne vorherige Prüfung in einer separaten Testumgebung installiert. | Das tatsächliche Updateverfahren wurde nicht erhoben. |
| A03 | Während der Bürozeiten ist ein IT-Mitarbeiter vor Ort und reagiert auf Störungen. | Keine zugesicherte Wiederherstellungszeit; Anwesenheit verhindert keinen Updatefehler. |
| A04 | Im Angriffsszenario werden CL01 und ein für die jeweiligen AD-/DNS-Änderungen ausreichend berechtigtes Konto kompromittiert. | Angenommene Voraussetzungen, kein belegter Vorfall. Lokale CL01-Administratorrechte allein genügen nicht. |
| A05 | Bei Einrichtung oder Änderung kann sich die Bearbeitung zu stark auf IPv4 konzentrieren beziehungsweise eine erforderliche Freigabe übersehen werden. | Arbeitshypothese für Konfigurationsrisiken, keine belegte Fehlerstatistik. |
| A06 | Interne IT und externer Dienstleister arbeiten zusammen. Eine zweite Person prüft und bestätigt relevante Änderungen anhand des Netzplans. | Geplantes Vier-Augen-Prinzip; Zusammenarbeit allein ist noch kein Prüfnachweis. |
| A07 | pfSense übernimmt im SOLL allein das Routing zwischen den drei Segmenten. | Geplante Abhängigkeit; im IST nicht wirksam. Internetfolgen gelten nur bei Führung des Internetverkehrs über pfSense. |
| A08 | Vollständige softwarebedingte Ausfälle der pfSense-VM werden für die qualitative Bewertung als selten angenommen. | Unsichere Arbeitsannahme ohne Betriebs- und Störungshistorie. |

### 2.3 Kategorien und Bezugsrahmen

Das Schadensausmaß beschreibt die Folgen des jeweiligen Szenarios. Es orientiert sich an den Kategorien des Schutzbedarfs, ist jedoch keine automatische Übernahme eines Systemwertes.

| Schadensausmaß | Projektbezogene Bedeutung |
|---|---|
| Normal | Begrenzte Folgen, die organisatorisch mit vertretbarem Aufwand aufgefangen werden können. |
| Hoch | Erhebliche Beeinträchtigung zentraler Dienste oder wesentlicher Arbeitsabläufe; gegebenenfalls finanzielle Schäden. |
| Sehr hoch | Existenzbedrohende oder katastrophale Folgen. Für die betrachteten Fälle nicht ausreichend begründet. |

Die Eintrittswahrscheinlichkeit wird qualitativ als niedrig, mittel oder hoch eingeschätzt. Niedrig bedeutet unter den genannten Annahmen selten erwartet, mittel plausibel möglich und hoch häufig beziehungsweise deutlich zu erwarten. Es bestehen keine statistischen Schwellenwerte. Alle Einstufungen sind unsichere Modellbewertungen.

Für Betriebs- und Angriffsszenarien dient ein Jahr als Betrachtungshorizont. Bei R03, R04 und R05a bezieht sich die Einschätzung auf die geplante Einrichtung beziehungsweise eine relevante Änderung. Diese unterschiedlichen Bezugsrahmen werden offengelegt: Die Risikoklassen dienen zur Behandlungspriorisierung, nicht zur Berechnung eines jährlichen Gesamtschadens. R03 bewertet die unbeabsichtigte Freigabe mit möglichem schweren Missbrauch, nicht die nachgewiesene Wahrscheinlichkeit eines vollständigen Angriffs.

### 2.4 Projektbezogene Risikomatrix

| Eintrittswahrscheinlichkeit / Schadensausmaß | Normal | Hoch | Sehr hoch |
|---|---|---|---|
| Niedrig | Niedrig | Mittel | Hoch |
| Mittel | Mittel | Hoch | Hoch |
| Hoch | Mittel | Hoch | Sehr hoch |

Die Matrix ist eine im Projekt erarbeitete Festlegung und keine vorgegebene BSI-Matrix. Die Klassen werden nicht als Zahlen multipliziert. Hohe und sehr hohe Risiken erfordern vorrangige Behandlung beziehungsweise eine begründete Entscheidung vor Freigabe; mittlere Risiken erfordern ebenfalls Maßnahmenprüfung und eine ausdrückliche Entscheidung über das Verbleibende. Keine Klasse bedeutet automatisch Risikoakzeptanz.

## 3. Risikoszenarien und Behandlung

### R01 – DC01-Ausfall durch fehlerhaftes Update

**Ursache und Ereignis:** Ein fehlerhaftes Update führt dazu, dass DC01 nach einem Neustart nicht ordnungsgemäß startet. AD DS und DNS stehen nicht zur Verfügung. A02 beschreibt das angenommene Updateverfahren.

**Verstärkender Umstand:** Beide Dienste sind auf einem System gebündelt; ein zweiter DC mit DNS zur Übernahme fehlt.

**Folgen:** CL01 und ADM01 können DNS nicht mehr über DC01 abfragen. Benutzer ohne zwischengespeicherte Domänenanmeldedaten können sich nicht mit ihrem Domänenkonto anmelden. Anwendungen mit Bedarf an aktueller Domänenauthentifizierung oder interner Namensauflösung sind eingeschränkt. Bestehende Sitzungen enden nicht automatisch, unabhängige Anwendungen können weiter nutzbar sein. Unter A01 sind erhebliche Arbeitsunterbrechungen und finanzielle Folgen möglich.

**Bewertung:** Hauptschutzziel Verfügbarkeit; Schadensausmaß **hoch**. Eintrittswahrscheinlichkeit **mittel** als Arbeitsannahme: Ohne vorherige Prüfung können Unverträglichkeiten erst auf DC01 auffallen, aber nicht jeder Updatefehler verursacht einen vollständigen Ausfall. Häufigkeitsdaten fehlen. Risikoklasse **hoch**.

**Behandlung:** Dokumentation des Risikos und Empfehlung gesonderter Maßnahmen zur Updateprüfung und geprüften Wiederherstellung. Ein zweiter DC mit DNS ist eine mögliche zusätzliche betriebliche Maßnahme. Die Anwesenheit eines IT-Mitarbeiters kann die Reaktionszeit verkürzen, belegt aber keine schnelle Wiederherstellung.

**Projektgrenze und Restrisiko:** Netzwerksegmentierung verhindert diesen Ausfall nicht. Eine wirksame Reduzierung wird im Projekt nicht behauptet; die Bewertung bleibt **hoch**. Umsetzung zusätzlicher Maßnahmen und Entscheidung über das verbleibende Risiko sind offen. Außerhalb des Projektumfangs bedeutet nicht akzeptiert.

### R02 – Unberechtigter administrativer Zugriff von CL01 auf DC01

**Ursache und Ereignis:** Ein Angreifer kontrolliert CL01 und erlangt zusätzlich ein ausreichend berechtigtes Konto. Über den im IST erreichbaren RDP-Dienst versucht er, administrative Änderungen auf DC01 vorzunehmen.

**Begünstigende Umstände:** Der direkte Netzwerkweg ist nachgewiesen. CL01 wurde auch administrativ genutzt. Netzwerk-Erreichbarkeit, Kontoberechtigung und tatsächliche Kompromittierung sind getrennte Voraussetzungen; ein offener Port allein genügt nicht.

**Folgen:** Unberechtigt angelegte Konten und veränderte Berechtigungen können dauerhaften Zugriff ermöglichen. Manipulierte DNS-Einträge können Zugriffe umleiten oder Dienste stören. Datenoffenlegung, Datenänderungen und erhebliche betriebliche Schäden sind möglich. Existenzbedrohende Zahlungsschäden werden nicht unterstellt: DNS-Manipulation allein verleiht keine Zahlungsberechtigung und umgeht keine Zertifikatsprüfung.

**Bewertung:** Hauptschutzziel Integrität, zusätzlich Vertraulichkeit und gegebenenfalls Verfügbarkeit. Schadensausmaß **hoch**, Eintrittswahrscheinlichkeit **niedrig**, Risikoklasse **mittel**. Die niedrige Einschätzung beruht auf A04 und bleibt unsicher. Die beiden Voraussetzungen sind nicht zwingend unabhängig: Administrative Nutzung auf einem kompromittierten Client kann den Zugriff auf administrative Sitzungen begünstigen. Es wird keine rechnerische Multiplikation unabhängiger Wahrscheinlichkeiten vorgenommen.

**Behandlung – reduzieren:**

- CLIENT, SERVER und Management trennen; direkten RDP-Zugriff aus CLIENT auf DC01 blockieren.
- RDP auf DC01 ausschließlich von ADM01 zulassen. Erforderliche Kontoberechtigungen separat festlegen; adm.weber erhält durch diese Netzfreigabe keine zusätzlichen Rechte.
- Benötigte AD-/DNS-Verbindungen gezielt in der Kommunikationsmatrix definieren. Die bisherigen fünf TCP-Porttests bilden keine vollständige AD-Freigabeliste.
- Keine eingehenden Internetverbindungen oder Portweiterleitungen auf ADM01. ADM01 erhält auch keinen direkten Internetzugang. Andere Management-Rechner erhalten ausschließlich ausdrücklich erforderliche Internetverbindungen.
- Updates für ADM01 aus offiziellen Quellen auf einem freigegebenen Rechner beziehen, digitale Signaturen prüfen, über ein dafür vorgesehenes und auf Schadsoftware geprüftes Wechselmedium übertragen und regelmäßig in Wartungsfenstern manuell installieren. Durchführung und Ergebnis dokumentieren. Manuelle Installation allein bedeutet keine höhere Sicherheit.

**Restrisiko:** Ein kompromittierter ADM01 mit geeigneten Zugangsdaten kann den erlaubten Verwaltungsweg missbrauchen. Andere erlaubte Dienste und übertragene Dateien bleiben mögliche Angriffswege. Schadensausmaß weiterhin **hoch**, Zielbewertung vorläufig **mittel**. Die grobe Matrix zeigt bei bereits niedrig angesetzter Wahrscheinlichkeit keinen notwendigen Klassenwechsel trotz eingeschränktem Angriffsweg. Diese Grenze liegt an der dreistufigen Skala selbst: Eine Verbesserung unterhalb von „niedrig" kann sie nicht abbilden, auch wenn der Angriffsweg faktisch enger wird.

### R03 – Unvollständige Zugriffsbeschränkung durch IPv6

**Ursache und Ereignis:** Bei der Segmentierung wird CL01 → DC01 über RDP nur für IPv4 gesperrt. Übersehenes IPv6-Routing und passende Freigaben lassen denselben Dienst weiterhin erreichbar. Aktives IPv6 im IST allein beweist diesen späteren Verbindungsweg nicht.

**Folgen:** Die vorgesehene RDP-Beschränkung ist unvollständig. Bei zusätzlicher erfolgreicher Anmeldung mit ausreichenden Berechtigungen sind dieselben Manipulationen wie bei R02 möglich.

**Bewertung:** Hauptschutzziel Integrität, weitere Folgen wie R02. Schadensausmaß **hoch**. Wahrscheinlichkeit einer unvollständigen Filterkonfiguration **mittel** unter A05; Risikoklasse **hoch** als vorsorgliche Bewertung der möglichen Exposition. Die Wahrscheinlichkeit des gesamten Angriffserfolgs ist damit nicht bestimmt. R02 und R03 überschneiden sich und dürfen nicht als unabhängige Schadenssummen addiert werden.

**Behandlung – reduzieren:** Die festgelegte Anforderung „IPv6: Deny All" im SOLL ausdrücklich umsetzen, beide Verkehrsrichtungen berücksichtigen und die Sperrwirkung prüfen. Die Firewall kann nur Verkehr sperren, der sie durchläuft. Für Verkehr innerhalb desselben Segments und die vorgesehenen Windows-Kontrollen ist die Abgrenzung im SOLL-Konzept festzulegen. Änderungen werden dokumentiert, geprüft und durch Wiederholung relevanter Sperrtests abgesichert.

**Restrisiko:** Fehlerhafte Änderungen können den Verbindungsweg wieder öffnen. Änderungsnachweise zeigen Konfigurationsänderungen; Verbindungslogs zeigen erlaubte oder blockierte Versuche. Logging ohne Auswertung verhindert keinen Fehler. Ziel ist eine **niedrige** Wahrscheinlichkeit unbemerkter Freigaben bei weiterhin **hohem** Schadensausmaß, entsprechend **mittel**. Diese Zielbewertung muss nach Umsetzung begründet werden.

### R04 – Blockierung erforderlicher DNS-Kommunikation

**Ursache und Ereignis:** Eine zu restriktive Firewallregel blockiert erforderliche DNS-Anfragen von CL01 an DC01. Betrachtet wird eine dienstbezogene Fehlkonfiguration, keine vollständige falsche Segmentzuordnung.

**Folgen:** Interne Namen können ohne verwendbare zwischengespeicherte Einträge nicht aufgelöst werden. Davon abhängige Anwendungen und Ressourcen sind eingeschränkt oder nicht erreichbar. Erwartbar sind DNS-Fehler oder Zeitüberschreitungen, nicht HTTP 404 als unmittelbare DNS-Fehlermeldung.

**Bewertung:** Hauptschutzziel Verfügbarkeit; Schadensausmaß **hoch**, sofern wesentliche modellierte Büroabläufe betroffen sind. Wahrscheinlichkeit vor gezielter Prüfung **mittel** unter A05; Risikoklasse **hoch**. Die Blockierung eines unwichtigen Einzelziels würde diese Schadensbewertung allein nicht rechtfertigen.

**Behandlung – reduzieren:** Benötigte DNS-Verbindungen einschließlich der erforderlichen Transportprotokolle gezielt freigeben. Interne Host- und AD-SRV-Abfragen aus der IST-Aufnahme vor Freigabe wiederholen. Eine beliebige externe Webseite ersetzt diese Prüfung nicht. Fehler korrigieren und dieselben Tests erneut durchführen.

**Fehlersuche:** Betriebszustand und Adapter von DC01, IP-Konfiguration, Gateway, DNS-Ziel, Netzwerkweg, Firewalllogs und DNS-Dienst prüfen. Ein fehlgeschlagener Ping beweist keinen Serverausfall, da ICMP ebenfalls blockiert sein kann.

**Restrisiko:** Spätere Regeländerungen können erneut blockieren. Tests verhindern nicht den ursprünglichen Konfigurationsfehler, sondern sollen dessen unbemerkte Freigabe verhindern. Zielbewertung für eine nach Freigabe verbleibende Blockierung: Wahrscheinlichkeit **niedrig**, Schadensausmaß **hoch**, Klasse **mittel**, vorbehaltlich nachvollziehbarer Prüf- und Änderungskontrollen.

### R05a – Fehlerhafte Schnittstellenzuordnung an pfSense

**Ursache und Ereignis:** Bei Einrichtung oder Änderung werden Schnittstellen beziehungsweise Segmente falsch zugeordnet. Die Kommunikation zwischen CLIENT, SERVER und Management wird unterbrochen.

**Folgen:** CL01 und ADM01 erreichen DC01 nicht mehr; DNS, neue Domänenauthentifizierungen und administrative Verbindungen über Segmentgrenzen fallen aus. DC01 läuft weiter und kann innerhalb seines eigenen Segments grundsätzlich erreichbar bleiben. Anders als R04 betrifft das Szenario mehrere Kommunikationsbeziehungen gleichzeitig.

**Bewertung:** Hauptschutzziel Verfügbarkeit; Schadensausmaß **hoch**. Eine Wahrscheinlichkeit vor zusätzlichen Kontrollen wurde nicht abschließend festgelegt; die Ausgangsrisikoklasse bleibt deshalb **offen**. Die gemeinsam begründete Einstufung **niedrig** berücksichtigt bereits das geplante Vier-Augen-Prinzip und gehört zur Zielbewertung nach Kontrolle.

**Behandlung – reduzieren:** Interne IT und Dienstleister gleichen Schnittstellen, Segmentnamen und IP-Netze mit dem Netzplan ab. Eine zweite Person bestätigt die Zuordnung. Vor Freigabe werden DNS-Funktion, erlaubtes RDP von ADM01 und gesperrtes RDP von CL01 geprüft.

Vor Änderungen wird die funktionierende Konfiguration extern gesichert und ein unabhängiger Konsolenzugang bereitgehalten. Scheitern die Prüfungen, erfolgt keine Freigabe. Bei nicht im Wartungsfenster behebbaren Fehlern wird zum gesicherten Stand zurückgekehrt und erneut getestet. Bei der Ersteinrichtung ohne funktionierenden Vorgängerstand bleibt die neue Umgebung bis zur Korrektur ungefreigegeben.

**Restrisiko:** Übersehene Fehler trotz Kontrolle und spätere Änderungen bleiben möglich. Zielbewertung: Wahrscheinlichkeit **niedrig**, Schadensausmaß **hoch**, Klasse **mittel**. Die Aussage gilt unter A06 und setzt nachgewiesene Prüfung voraus.

### R05b – Softwarebedingter Ausfall der pfSense-VM

**Ursache und Ereignis:** Ein Softwarefehler führt zum Absturz der pfSense-VM. Das Routing zwischen den Segmenten steht bis zum Wiederanlauf beziehungsweise zur Wiederherstellung nicht zur Verfügung. Ein dauerhafter Datenverlust wird nicht unterstellt.

**Verstärkender Umstand:** Nach A07 fehlt eine zweite Firewall zur automatischen Übernahme.

**Folgen:** Segmentübergreifende Kommunikation, DNS-/AD-Zugriffe auf DC01 und administrative Verbindungen sind unterbrochen. Ein über pfSense geführter Internetzugang fällt ebenfalls aus. Kommunikation innerhalb eines Segments bleibt grundsätzlich möglich, soweit keine ausgefallenen Dienste über Segmentgrenzen benötigt werden.

**Bewertung:** Hauptschutzziel Verfügbarkeit; Schadensausmaß **hoch**, Wahrscheinlichkeit **niedrig** unter A08, Risikoklasse **mittel**. Diese Wahrscheinlichkeit ist eine unsichere Arbeitsannahme. Das Vier-Augen-Prinzip der Einrichtung verhindert keinen späteren Softwareabsturz.

**Behandlung – reduzieren:** Erreichbarkeit und Funktion überwachen, unabhängigen Konsolenzugang vorhalten, Konfiguration regelmäßig und nach freigegebenen Änderungen extern sichern, Wiederanlauf und Wiederherstellung dokumentieren und prüfen. Updates werden kontrolliert durchgeführt. Eine redundante Firewall bleibt eine mögliche spätere Erweiterung außerhalb der vorgesehenen Umsetzung.

**Störungsablauf:** Verfügbare Fehlermeldungen sichern, Zustand über die Konsole prüfen, kontrollierten Wiederanlauf versuchen und bei Bedarf das vorbereitete Wiederherstellungsverfahren anwenden. Danach erlaubte und gesperrte Verbindungen prüfen und Ausfalldauer sowie Maßnahmen dokumentieren.

**Restrisiko:** Die zentrale Ausfallabhängigkeit bleibt bestehen. Überwachung und Wiederherstellungsvorbereitung können die Ausfalldauer begrenzen, ohne jeden Ausfall zu verhindern. Vorläufig weiterhin **mittel** bei niedrig angenommener Wahrscheinlichkeit und hohem Schadensausmaß; keine zugesicherte Wiederherstellungszeit.

## 4. Zusammenfassendes Risikoregister

| ID | Betrachtungsstand | Hauptschutzziel | Wahrscheinlichkeit vor zusätzlichen Kontrollen | Schaden | Ausgangsklasse | Behandlung | Ziel / verbleibende Klasse |
|---|---|---|---|---|---|---|---|
| R01 | IST-Abhängigkeit | Verfügbarkeit | Mittel | Hoch | Hoch | Gesonderte Maßnahmen empfehlen; keine Reduzierung durch Segmentierung | Hoch, unbehandelt durch Projektmaßnahme |
| R02 | IST-Angriffsweg | Integrität | Niedrig | Hoch | Mittel | Reduzieren | Mittel, vorläufig |
| R03 | SOLL-Fehlkonfiguration | Integrität | Mittel für unvollständige Filterung | Hoch | Hoch | Reduzieren | Mittel, bedingt durch Prüfung |
| R04 | SOLL-Fehlkonfiguration | Verfügbarkeit | Mittel | Hoch | Hoch | Reduzieren | Mittel für unbemerkte Blockierung nach Prüfung |
| R05a | SOLL-Fehlkonfiguration | Verfügbarkeit | Noch offen | Hoch | Offen | Reduzieren | Mittel nach Vier-Augen-Prüfung, vorläufig |
| R05b | SOLL-Betriebsabhängigkeit | Verfügbarkeit | Niedrig | Hoch | Mittel | Reduzieren | Mittel, vorläufig |

Die Zielwerte sind keine gemessenen Restrisiken. Insbesondere R04 unterscheidet das Auftreten eines Konfigurationsfehlers von dessen unbemerktem Fortbestehen nach Freigabe. R05a besitzt noch keine vollständige Ausgangsbewertung. Eine pauschale Aussage, alle Risiken seien abschließend bewertet oder reduziert, ist deshalb nicht zulässig.

## 5. Geplante Wirksamkeitsnachweise

Die folgenden Kennungen sind neue Planungskennungen, keine bereits ausgeführten Tests. Die vorhandenen IST-Tests werden mit den im SOLL gültigen Adressen wiederholt. Alte und neue Adressen sind eindeutig einander zuzuordnen.

| Prüf-ID | Bezug | Geplante Prüfung | Erwartetes Ergebnis / Nachweis |
|---|---|---|---|
| P01 | R02 | CL01 → DC01, TCP 3389 über IPv4 | Kein Verbindungsaufbau; zugehöriger Blockeintrag in pfSense. |
| P02 | R02, R05a | ADM01 → DC01, RDP | Verbindung und Anmeldung mit separat berechtigtem Konto erfolgreich. |
| P03 | R03 | CL01 → DC01 über konkrete IPv6-Adresse, TCP 3389; ergänzend Gegenrichtung und weitere beanspruchte Sperrwege | Kein unerlaubter Aufbau; bei Prüfung der pfSense-Regel ein zugehöriger Blockeintrag. |
| P04 | R04, R05a | Interne Host- und AD-SRV-Abfragen von CL01 über DC01 | Antworten mit den vorgesehenen SOLL-Einträgen. |
| P05 | R05a | Abgleich Schnittstellen und Netzplan durch zweite Person | Richtige Zuordnung, dokumentierte Bestätigung, P01/P02/P04 bestanden. |
| P06 | R05b | Angekündigtes kontrolliertes Herunterfahren und Wiederstarten der pfSense-VM | Unterbrechung und Wiederanlauf dokumentiert; danach P01–P04 erneut erfolgreich im jeweiligen Soll-Ergebnis. |

### Aussagegrenzen und Dokumentationsregeln

- Ein negativer Verbindungstest allein beweist keine Firewallwirkung. Zieladresse, Dienstbereitschaft und Netzwerkweg müssen zur Prüfaussage passen. Fehlt IPv6-Routing, ist fehlende Erreichbarkeit nachgewiesen, jedoch nicht automatisch das Verwerfen durch pfSense.
- Ein einzelner IPv6-RDP-Test beweist kein vollständiges „Deny All" für sämtliche Protokolle und Wege. Regelprüfung und weitere Tests sind nach dem tatsächlichen Umfang der SOLL-Anforderung festzulegen. Gegenrichtung bedeutet nicht automatisch Internetverkehr; Quell- und Zielsegment werden einzeln genannt.
- DNS-Abfragen belegen ausgewählte Funktionen. Ein TCP-53-Test allein belegt keine UDP-DNS-Funktion. Auch erfolgreiche DNS-Abfragen belegen keine vollständige AD-Funktion.
- P06 prüft eine kontrollierte Unterbrechung und den Wiederanlauf, nicht alle Absturzursachen und nicht automatisch die Wiederherstellung aus einer Sicherung.
- Pro Test werden Start und Ende mit Zeitzone, Quelle, Zieladresse, Protokoll/Port oder Abfrage, erwartetes und tatsächliches Ergebnis, relevante Konfigurationsversion und Nachweisdatei erfasst. Für Logzuordnungen müssen Zeitbasis und beteiligte Systeme nachvollziehbar sein.
- Screenshots ergänzen Rohdaten und Logs. Die vorhandenen Bilder A01–A04 bleiben Nachweise der Anmeldebeschränkung auf ADM01, keine neuen pfSense-Nachweise.

Für R01 wird keine Wirkung der Segmentierung getestet oder behauptet. Eine zusätzliche Wiederherstellungsprüfung wäre separat zu planen.

## 6. Verantwortlichkeiten und Freigabe

Die folgende Verteilung ist eine Vereinbarung für das Modellszenario, keine erhobene Vertragsregelung:

| Aufgabe | Zuständigkeit |
|---|---|
| Änderungen koordinieren, veranlassen und dokumentieren | Interne IT |
| Konfiguration und Fehleranalyse unterstützen | Externer IT-Dienstleister gemeinsam mit interner IT |
| Relevante Zuordnungen und Regeln gegenprüfen | Zweite fachkundige Person; dokumentiertes Vier-Augen-Prinzip |
| Funktionstests und Sperrtests nach relevanten Änderungen | Interne IT mit Unterstützung des Dienstleisters |
| Überwachung, Konfigurationssicherungen und Störungsreaktion | Interne IT; Dienstleister unterstützt Diagnose und Wiederherstellung |
| Verbleibende betriebliche Risiken akzeptieren oder weitere Behandlung verlangen | Zuständige Unternehmensleitung auf Grundlage der IT-Bewertung |

Vor einer Freigabe sind Testergebnisse und offene Abweichungen zu prüfen. Nicht bestandene Abnahmetests führen zur Fehlerbehebung oder zum Rückfall auf einen funktionsfähigen Stand. Risikoakzeptanzen sind mit Entscheidung, Zuständigkeit, Datum und gegebenenfalls Bedingungen festzuhalten. Eine solche Akzeptanz liegt hier noch nicht vor.

## 7. Ergebnis und Übergang zum SOLL-Konzept

Die Analyse begründet die Beschränkung administrativer Netzwerkwege, eine ausdrückliche Behandlung von IPv6 sowie Funktions- und Sperrtests vor der Freigabe. Sie zeigt zugleich die Grenzen der Maßnahme: Ein updatebedingter DC01-Ausfall bleibt bestehen, und die zentrale pfSense schafft eine neue Abhängigkeit der Kommunikation zwischen den Segmenten.

Im [SOLL-Konzept](<06 SOLL-Konzept 1.0.md>) sind daraus die Netz- und Schnittstellenzuordnung, dauerhafte Zieladressierung, vollständige Kommunikationsmatrix, Regelrichtungen, administrative Berechtigungen, IPv6-Behandlung und der unabhängige Wiederherstellungszugang auszuarbeiten. ADM01 darf nicht allein aufgrund seines Namens oder seiner Netzfreigabe als auf DC01 administrativ berechtigt gelten.

**Vor Abschluss der Bewertung verbleiben:**

1. Ausgangswahrscheinlichkeit für R05a begründet festlegen.
2. Modellannahmen bei neuen Erkenntnissen überprüfen, insbesondere Updateverfahren und Wiederherstellbarkeit.
3. Geplante Maßnahmen tatsächlich umsetzen und ihre Wirkung nachweisen.
4. Zielbewertungen anschließend bestätigen oder anpassen und verbleibende Risiken zur Entscheidung vorlegen.

## 8. Quellen- und Nachweisverzeichnis

Die technischen IST-Aussagen stützen sich auf die folgenden Projektunterlagen. Szenarien, Matrix, Wahrscheinlichkeiten und Maßnahmenentscheidungen wurden mit Marco Males im begleitenden Projektdialog erarbeitet und in diesem Dokument als eigene Projektbewertungen festgehalten. Sie sind keine extern belegten Schadens- oder Häufigkeitsstatistiken. Für dieses Kapitel wurde keine externe Normmatrix übernommen.

| Quelle | Dokument / Nachweis | Verwendung |
|---|---|---|
| Q01 | [02 IST-Analyse](<02 IST-Analyse.md>) | Technischer Ausgangszustand, Änderungen während der Erhebung und Aussagegrenzen. |
| Q02 | [03 Schutzbedarf](<03 Schutzbedarf.md>) | Modellszenario und begründete Schutzzielanforderungen; Laborabgrenzung siehe Abschnitt 1 dieses Dokuments. |
| Q03 | [CL01-TCP-Ergebnisse](<10 Nachweise/IST-CL01-20260915-173330/TCP-Ergebnisse.csv>) und [ADM01-TCP-Ergebnisse](<10 Nachweise/IST-ADM01-20260915-173809/TCP-Ergebnisse.csv>) | Erreichbarkeit von DC01, insbesondere TCP 3389; Erhebung 15.09.2026. |
| Q04 | [CL01-Rohprotokoll](<10 Nachweise/IST-CL01-20260915-173330/Rohprotokoll.txt>) und [ADM01-Rohprotokoll](<10 Nachweise/IST-ADM01-20260915-173809/Rohprotokoll.txt>) | Netzparameter, Testkontext und administrative Nutzung. |
| Q05 | [Ergänzter CL01-DNS-Nachweis](<10 Nachweise/IST-CL01-DNS-20260915-194153.txt>) | Interne Host- und SRV-Auflösung sowie IPv6-Antworten; 15.09.2026, 19:41:55–19:41:56 Uhr, UTC+02:00. |
| Q06 | [Hyper-V-Topologie](<10 Nachweise/IST-HyperV-20260915-174507.txt>) | Aktiver gemeinsamer Switch und fehlende Anbindung der vorbereiteten pfSense-VM. |
| Q07 | [A01: lokale Anmeldung erlaubt](<A01 - Lokale Anmeldung adm.weber.png>), [A02: lokale Anmeldung abgewiesen](<A02 - Lokale Anmeldung lschmidt.png>) | Bereits bestehende kontobasierte Kontrolle auf ADM01. |
| Q08 | [A03: Remoteanmeldung erlaubt](<A03 - RDP CL01 -ADM01 adm.weber.png>), [A04: Remoteanmeldung abgewiesen](<A04 - RDP CL01 - ADM01 lschmidt.png>) | Remoteanmeldekontrolle auf ADM01; kein Nachweis einer RDP-Berechtigung auf DC01. |
| Q09 | Projektdialog mit Marco Males, redaktionell übernommen am 17.09.2026 | Annahmen A01–A08, R01–R05b, Projektmatrix, Maßnahmen und Zuständigkeiten; im vorliegenden Dokument nachvollziehbar festgehalten. |

Bei Weitergabe sind die verlinkte IST-Dokumentation und der zugehörige Ordner `10 Nachweise` mitzuführen. Neue SOLL-Nachweise sind erst nach Durchführung zu ergänzen; vorhandene historische Nachweise werden nicht überschrieben.
