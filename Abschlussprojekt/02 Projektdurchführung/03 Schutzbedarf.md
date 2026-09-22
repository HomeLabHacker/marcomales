# 03 Schutzbedarfsbetrachtung

**Projekt:** Risikobasierte Konzeption und Umsetzung einer Netzwerksegmentierung mit pfSense in einer virtualisierten Netzwerkumgebung  
**Verfasser:** Marco Males  
**Stand:** 17.09.2026  
**Status:** Schutzbedarfsfeststellung der bestehenden IST-Umgebung im bestätigten Modellszenario

## 1. Ziel und Abgrenzung

Auf Grundlage der abgeschlossenen [IST-Aufnahme](<02 IST-Analyse - Final.md>) wird bestimmt, welche Anforderungen an Vertraulichkeit, Integrität und Verfügbarkeit der Informationen, Dienste und Systeme bestehen. Bewertet werden die möglichen Schäden bei einer Verletzung dieser Schutzziele. Eintrittswahrscheinlichkeiten, Angriffsszenarien und Restrisiken werden erst in der anschließenden Risikoanalyse behandelt.

Die Betrachtung ist eine projektbezogene, vereinfachte Schutzbedarfsfeststellung in Anlehnung an die BSI-Methodik. Sie ist keine vollständige Umsetzung des IT-Grundschutzes und kein Zertifizierungsnachweis. Die Kategorien und Ableitung vom Prozess auf die unterstützenden Systeme orientieren sich am BSI-Standard 200-2, Abschnitt 8.2.[^B1]

### 1.1 Betrachtete Objekte

Bewertet werden die im aufgenommenen Zustand tatsächlich genutzten Informationen, Funktionen und ihre technischen Träger:

- zentrale Identitäts- und Berechtigungsverwaltung sowie DNS auf DC01;
- Arbeitsplatznutzung auf CL01 einschließlich der dokumentierten administrativen Tests;
- bestehende administrative Nutzung von ADM01;
- der gemeinsame Hyper-V-Host MALES-IT;
- der aktive virtuelle Switch vSW-IST-LAN und die darüber geführte Kommunikation;
- vorhandene Konfigurationsdaten und Projektnachweise.

### 1.2 Vorbereitete Komponenten ohne aktive Funktion

Die pfSense-VM wurde vorsorglich angelegt. Sie ist laut IST-Aufnahme nicht mit einem virtuellen Switch verbunden und übernimmt weder Routing noch Filterung für die untersuchten Systeme. Deshalb wird sie **nicht als aktive Firewall in die Schutzbedarfsmatrix aufgenommen**. Gleiches gilt für die bislang ungenutzten privaten Switches vSW-Client und vSW-Server: Ihnen wird keine bereits bestehende Segmentierungsfunktion zugeschrieben.[^I1]

Das bloße Vorhandensein dieser vorbereiteten Objekte erfordert keine Löschung und verändert die hier betrachteten Funktionsabhängigkeiten nicht. Ihre künftige Rolle wird erst im SOLL-Konzept bewertet. Die historische IST-Aufnahme bleibt unverändert.

## 2. Bewertungsgrundlage und Annahmen

### 2.1 Nachgewiesener technischer Ausgangspunkt

- DC01 stellt AD DS und DNS bereit; CL01 und ADM01 nutzen ihn als IPv4-DNS-Server.
- Die Windows-Systeme befinden sich im gemeinsamen Netz 192.168.2.0/24.
- ADM01 ist für lokale und Remote-Anmeldungen durch die vorgesehenen Konten beschränkt; die Tests mit adm.weber und lschmidt belegen die Funktion für diese beiden Konten.
- Die direkte Mitgliedschaft von adm.weber in Domänen-Admins wurde entfernt. Die darüber hinausgehenden Verwaltungsrechte dieses Kontos wurden nicht vollständig erhoben.
- Auf CL01 und ADM01 wurden Tests unter PROJEKT\Administrator ausgeführt. Die Rolle „normaler Arbeitsplatz“ beschreibt deshalb nicht jede während der Aufnahme tatsächlich ausgeführte Tätigkeit.
- Mehrere virtuelle Systeme teilen denselben Hyper-V-Host MALES-IT. Ein Ausfall dieses Hosts kann mehrere Rollen gleichzeitig betreffen.[^I1]

### 2.2 Bestätigtes Modellszenario und ergänzende Bewertungsannahmen

Als Bewertungsgrundlage wurde am 16.09.2026 das **Modell eines kleinen Bürounternehmens mit zentralem AD/DNS** bestätigt. Die technische Laborumgebung bildet dieses Szenario nach. Die folgenden Konkretisierungen sind **ergänzende Bewertungsannahmen und keine erhobenen Unternehmensfakten**:

| ID  | Annahme                                                                                                                                                                                                             | Bedeutung                                                                                                      |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| M01 | CL01 steht stellvertretend für gewöhnliche Büroarbeit mit begrenzt sensiblen Arbeitsdaten. Besonders schutzwürdige Fachverfahren sind nicht unterstellt.                                                            | Normale Büroarbeit erhält zunächst normalen Schutzbedarf.                                                      |
| M02 | Mehrere Arbeitsplätze benötigen die zentrale Identitäts- und Namensverwaltung. Es gibt im Modell keinen nachgewiesenen zweiten DC/DNS-Server.                                                                       | Ein länger anhaltender zentraler Ausfall beeinträchtigt mehrere Arbeitsabläufe beträchtlich.                   |
| M03 | Administrationssitzungen und Konfigurationsdaten ermöglichen Änderungen an zentralen Diensten.                                                                                                                      | Vertraulichkeit und Integrität der Administration werden hoch bewertet.                                        |
| M04 | Ein kurzzeitiger Ausfall eines einzelnen Arbeitsplatzes ist organisatorisch überbrückbar. Für die Bewertung von ADM01 wird angenommen, dass ein Ausfall zeitweise über andere kontrollierte Administrationsmöglichkeiten aufgefangen werden kann; deren Eignung ist nicht abschließend nachgewiesen. | Verfügbarkeit von CL01 und ADM01 zunächst normal; bei fehlendem Ersatzweg für kritische Aufgaben neu bewerten. |
| M05 | Keine lebenswichtigen, existenzkritischen oder vergleichbar katastrophalen Schadensfolgen sind belegt.                                                                                                              | „Sehr hoch“ wird derzeit keinem Zielobjekt zugewiesen.                                                         |

Die Bewertung betrifft die **nachgebildeten betrieblichen Funktionen**. Es wird nicht behauptet, dass der Ausfall der privaten Test-VMs tatsächlich einen Unternehmensschaden verursacht. Echte Zugangsdaten bleiben unabhängig vom Laborcharakter schutzwürdig.

Es werden keine unbelegten Eurobeträge, gesetzlichen Schadensgrenzen, Wiederanlaufzeiten oder zugesicherten Verfügbarkeiten angenommen. Verbindliche zeitliche Toleranzen sind aus dem bestätigten Szenario abzuleiten.

## 3. Kategorien und Bewertungsregeln

### 3.1 Schutzziele

| Schutzziel          | Leitfrage                                                                                                    |
| ------------------- | ------------------------------------------------------------------------------------------------------------ |
| Vertraulichkeit (V) | Welche Folgen hat es, wenn Unberechtigte Informationen, Zugangsmittel oder Sitzungsinhalte erhalten?         |
| Integrität (I)      | Welche Folgen haben unberechtigte oder fehlerhafte Änderungen an Daten, Berechtigungen oder Konfigurationen? |
| Verfügbarkeit (A)   | Welche Folgen hat es, wenn Informationen, Dienste oder Verwaltungsfunktionen nicht rechtzeitig nutzbar sind? |

### 3.2 Einheitliche Schutzbedarfskategorien

Das BSI unterscheidet normal, hoch und sehr hoch. In diesem Projekt werden sie qualitativ wie folgt verwendet:[^B1]

| Kategorie | Projektbezogene Einordnung                                                                                                                                               |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Normal    | Die Folgen bleiben begrenzt und können mit vertretbarem organisatorischem Aufwand aufgefangen werden.                                                                    |
| Hoch      | Es sind erhebliche betriebliche Auswirkungen möglich, beispielsweise eine breite Beeinträchtigung zentraler Dienste oder missbräuchliche Kontrolle über mehrere Systeme. |
| Sehr hoch | Es wären existenzbedrohende oder katastrophale Folgen zu erwarten; solche Folgen sind im gewählten Modell nicht belegt.                                                  |

Für ADM01 wird die Verfügbarkeit unter M04 als **normal** eingestuft. Kann ein zeitkritischer Ausfall der Administrationsfunktion nicht vertretbar überbrückt werden, ist die Einstufung **hoch** erforderlich. Die Kategorie „mittel“ aus der Vorplanung wird nicht verwendet; maßgeblich ist die begründete Zuordnung zu den drei einheitlichen Kategorien.[^P1]

### 3.3 Ableitung und Trennung von der Risikobewertung

Der Schutzbedarf wird zuerst für Informationen und Funktionen betrachtet und anschließend je Schutzziel auf die davon abhängigen Systeme übertragen. Dabei wird grundsätzlich die höchste relevante Anforderung übernommen; gemeinsame Abhängigkeiten werden mitbetrachtet.[^B1]

Ein offener Port, eine fehlende Segmentierung oder eine bekannte Schwachstelle macht den Schutzbedarf nicht automatisch hoch. Diese Befunde beeinflussen die nachfolgende Risikobewertung. Ebenso sinkt der Schutzbedarf nicht allein deshalb, weil eine Firewall oder Anmeldesperre eingerichtet wurde: Die möglichen Schäden bleiben der Maßstab.

## 4. Informationen und Funktionen

Die folgenden Einstufungen sind eigene Ableitungen aus M01–M05 und keine pauschalen BSI-Vorgaben für bestimmte Gerätetypen.

| ID  | Information / Funktion                                            | V      | I      | A      | Schadensbegründung im Modell                                                                                                                                                    |
| --- | ----------------------------------------------------------------- | ------ | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| F01 | Gewöhnliche Büroarbeit und Arbeitsdaten eines einzelnen Benutzers | Normal | Normal | Normal | Offenlegung, Veränderung oder Ausfall betreffen unter M01 überwiegend einen begrenzten Arbeitsbereich.                                                                          |
| F02 | Zentrale Identitäten, Authentisierung und Berechtigungsverwaltung | Hoch   | Hoch   | Hoch   | Zugangsmittel können weitreichenden Missbrauch ermöglichen; veränderte Berechtigungen wirken auf mehrere Systeme; Ausfall beeinträchtigt zentrale Anmelde- und Zugriffsabläufe. |
| F03 | Interne Namensauflösung                                           | Normal | Hoch   | Hoch   | Gewöhnliche Hostnamen sind im Modell nicht für sich hoch vertraulich; manipulierte Zuordnungen oder ein zentraler Ausfall können jedoch mehrere abhängige Dienste betreffen.    |
| F04 | Privilegierte Administration und deren Zugangsmittel              | Hoch   | Hoch   | Normal | Offenlegung oder Manipulation kann Kontrolle über zentrale Systeme ermöglichen. Zeitweiser Ausfall ist nur unter M04 überbrückbar.                                              |
| F05 | Nachweisdateien und Projektdokumentation                          | Normal | Hoch   | Normal | Die Dateien enthalten interne technische Angaben; ihre unbemerkte Änderung kann die Ergebnisbewertung verfälschen. Zeitweiliger Nichtzugriff ist im Modell tolerierbar.         |

Die Bewertung F02 bedeutet nicht, dass bei jedem DC-Ausfall jede bereits bestehende Anmeldung sofort endet. Maßgeblich ist die angenommene Beeinträchtigung zentraler, von DC/DNS abhängiger Abläufe bei einem anhaltenden Ausfall.

Die Nachweisdateien liegen im dokumentierten Projektordner auf dem Host beziehungsweise im OneDrive-Pfad. Daraus wird weder ein geprüftes Backup noch eine erfolgreiche Wiederherstellung abgeleitet. Enthalten spätere Nachweise Kennwörter oder andere besonders sensible Informationen, ist F05 hinsichtlich Vertraulichkeit neu zu bewerten; solche Geheimnisse sollen nicht in Screenshots aufgenommen werden.

## 5. Abgeleiteter Schutzbedarf der Systeme

### 5.1 Übersicht

| Aktives IST-Objekt | Vertraulichkeit | Integrität | Verfügbarkeit | Ableitung |
|---|---|---|---|---|
| DC01 – AD DS und DNS | Hoch | Hoch | Hoch | F02/F03; zentrale Identitäts- und Namensverwaltung |
| CL01 – erfasste Nutzung einschließlich Administrationskonto | Hoch | Hoch | Normal | F01/F04; tatsächliche administrative Nutzung während der IST-Aufnahme |
| ADM01 – administrative Nutzung im erfassten Zustand | Hoch | Hoch | Normal | F04; Verfügbarkeitsannahme M04 |
| Hyper-V-Host MALES-IT | Hoch | Hoch | Hoch | Gemeinsamer technischer Träger von DC01, CL01 und ADM01 |
| vSW-IST-LAN und aktive Kommunikationsverbindungen | Hoch | Hoch | Hoch | Übertragung und Bereitstellung der zentralen und administrativen Kommunikation |

Die Tabellenwerte gelten unter M01–M05. Die reine Büroarbeitsfunktion F01 bleibt normal bewertet; für den erfassten CL01-Gesamtzustand werden zusätzlich die höheren Anforderungen der tatsächlich ausgeführten administrativen Tätigkeit berücksichtigt. Eine geplante Firewall ist in dieser Tabelle nicht enthalten.

Ein übergreifender Maximalwert würde den unterschiedlichen Anforderungen je Schutzziel nicht gerecht; deshalb werden die drei Werte getrennt weiterverwendet.

### 5.2 DC01

**Vertraulichkeit: hoch.** Der Domänencontroller verarbeitet sicherheitsrelevante Identitäts- und Authentisierungsinformationen. Deren Missbrauch kann über einen einzelnen Arbeitsplatz hinausreichen. Die Einstufung ergibt sich aus F02, nicht allein aus öffentlich beziehungsweise intern abfragbaren DNS-Namen.

**Integrität: hoch.** Unberechtigte Änderungen an Konten, Gruppen, Richtlinien oder DNS-Zuordnungen können Zugriffe umleiten, Berechtigungen verändern und mehrere Systeme beeinflussen.

**Verfügbarkeit: hoch.** Im Modell hängen mehrere Abläufe von einem zentralen AD-/DNS-System ab. Ein anhaltender Ausfall hat daher größere Auswirkungen als der Ausfall eines einzelnen Arbeitsplatzes. Ein redundanter Betrieb ist nicht nachgewiesen.

### 5.3 CL01

Die gewöhnliche Arbeitsplatzfunktion F01 wird unter M01 mit **normal / normal / normal** bewertet. Der dokumentierte IST umfasst jedoch Tests unter PROJEKT\Administrator und administrative Remotezugriffe. Für diese im IST nachgewiesene Nutzung werden Vertraulichkeit und Integrität **hoch** angesetzt: Eine kompromittierte Arbeitsumgebung könnte administrative Eingaben oder Sitzungen beeinträchtigen. Ein tatsächlicher Diebstahl von Anmeldedaten oder deren dauerhafte Speicherung wurde damit nicht nachgewiesen.

Diese Einstufung behauptet keine dauerhafte administrative Nutzung von CL01 im Unternehmen. Sie erfasst die dokumentierte Nutzung während der Aufnahme. Bei einer später veränderten tatsächlichen Nutzung ist die Ableitung erneut zu prüfen. Die Verfügbarkeit bleibt unter der Annahme eines überbrückbaren Einzelarbeitsplatzausfalls normal.

### 5.4 ADM01

Die dokumentierte Nutzung von ADM01 umfasst administrative Sitzungen, darunter eine frühere erfolgreiche RDP-Anmeldung auf DC01 mit damals bestehender Domänen-Adminmitgliedschaft. Für die dabei verarbeiteten administrativen Informationen und Eingaben bestehen hohe Anforderungen an Vertraulichkeit und Integrität. Die Entfernung von adm.weber aus Domänen-Admins begrenzt dessen bekannte Gruppenmitgliedschaft, definiert aber noch keine vollständige Verwaltungsrolle. Die Bewertung stützt sich auf diese dokumentierte administrative Nutzung und M03. Sie schreibt adm.weber nach der Entfernung aus Domänen-Admins keine unbestätigten zusätzlichen Rechte zu.

Die Verfügbarkeit wird unter M04 normal bewertet. Ist ADM01 tatsächlich der einzige zulässige und zeitkritisch benötigte Verwaltungszugang ohne vertretbaren Ersatz, muss die Bewertung angehoben werden. Die Testnachweise A01–A04 belegen Zugriffskontrolle für zwei Konten; sie ersetzen keine Schadensbewertung.

### 5.5 Hyper-V-Host und Netzstruktur

Der Host bündelt mehrere virtuelle Systeme. Eingriffe in VM-Konfiguration, virtuelle Datenträger oder Switchzuordnungen können mehrere Schutzobjekte betreffen. Seine Integrität und Verfügbarkeit übernehmen daher mindestens die hohen Anforderungen der zentralen Dienste. Vertraulichkeit wird hoch angesetzt, weil die Virtualisierungsplattform Zugriffsmöglichkeiten auf die darauf verarbeiteten Informationen und Administrationsvorgänge bietet.

Für die virtuelle Netzstruktur gelten hohe Anforderungen an die Integrität ihrer Konfiguration und an die Verfügbarkeit der zentralen Kommunikation. Die hohe Vertraulichkeitsanforderung betrifft die zu schützenden Übertragungen und Verwaltungsinformationen; sie bedeutet nicht, dass jeder Switchname oder jedes einzelne Datenpaket hoch vertraulich ist. Die Einstufung bildet die höchste relevante Anforderung der betrachteten aktiven Kommunikation ab. Einzelne Verbindungen können abweichende Anforderungen haben; eine vollständige Einzelverbindungsbewertung wurde hier nicht vorgenommen.

Der Host wird als relevante Abhängigkeit berücksichtigt. Daraus entsteht keine Erweiterung des Projektumfangs zu einem vollständigen Host-Härtungs-, Backup- oder Hochverfügbarkeitsprojekt.

## 6. Abhängigkeiten und Folgerungen

| Abhängigkeit | Bedeutung |
|---|---|
| Arbeitsabläufe → AD DS / DNS → DC01 | Die Bedeutung zentraler Dienste ergibt sich aus den abhängigen Funktionen. |
| Virtuelle Systeme → Hyper-V-Host | Ein Hostproblem kann mehrere Rollen gemeinsam beeinträchtigen. |
| Administration → ADM01 beziehungsweise tatsächlich genutzter Arbeitsplatz | Hohe Anforderungen folgen der administrativen Nutzung, nicht nur dem Rechnernamen. |
| Kommunikation von CL01/ADM01 mit DC01 → vSW-IST-LAN | Der aktive gemeinsame Switch trägt die untersuchten Verbindungen bereits im IST. |

Es wird kein zusätzlicher Sprung auf „sehr hoch“ allein wegen der Anzahl der VMs vorgenommen. Dafür fehlen belegte existenzkritische Folgen. Konkrete Abhängigkeiten und Schäden bleiben entscheidend.

Aus der Bewertung ergeben sich folgende schutzbedarfsbezogene Anforderungen, ohne eine konkrete technische Lösung vorwegzunehmen:

1. Zugangsmittel und Inhalte administrativer Sitzungen sind vor unberechtigter Kenntnisnahme zu schützen.
2. Änderungen an Konten, Berechtigungen, DNS- und Virtualisierungskonfiguration müssen berechtigt und nachvollziehbar sein.
3. Die benötigte zentrale Identitäts- und Namensverwaltung muss im Rahmen der betrieblichen Anforderungen verfügbar bleiben.
4. Die Vertraulichkeit und Integrität erforderlicher Kommunikation ist für die im IST verwendeten IP-Protokolle zu berücksichtigen.
5. Technische Nachweise müssen ihren Inhalt und die Zuordnung zu den beobachteten Ergebnissen zuverlässig behalten.

Welche Maßnahmen diese Anforderungen erfüllen sollen, wird nach der Risikoanalyse in der Konzeption entschieden. Schutzbedarf, konkrete Schwachstellen und Auswahl von Sicherheitsmaßnahmen sind getrennte Arbeitsschritte.

## 7. Ergebnis und Übergang zur Risikoanalyse

Unter dem bestätigten Modell weisen **DC01, MALES-IT und die aktive Netzstruktur** hohe Anforderungen an alle drei Schutzziele auf. Für **ADM01** sowie für **CL01 während der dokumentierten administrativen Nutzung** stehen Vertraulichkeit und Integrität im Vordergrund; die Verfügbarkeit wird unter der ausdrücklich genannten Überbrückungsannahme als normal bewertet.

Die Feststellung bezieht sich ausschließlich auf den aufgenommenen IST und die darin verarbeiteten Informationen. Die vorbereitete, nicht angebundene pfSense-VM erhält keine Einstufung als zentrale Firewall. Es wird weder ein bestehender Schutz durch diese VM noch eine Abhängigkeit der Dienste von ihr angenommen.

Die Bewertung ist eine eigene fachliche Ableitung aus dem bestätigten Bürounternehmensmodell und den Annahmen M01–M05. Sie ist nicht allein aus den Gerätenamen oder aus offenen Ports abgeleitet. Insbesondere bleibt die Einstufung der Verfügbarkeit von ADM01 von der angenommenen Überbrückbarkeit abhängig. Konkrete Ausfalltoleranzen und Datenarten sind bei neuen Erkenntnissen nachzuführen.

Die anschließende **04 Risikoanalyse** ordnet den betrachteten Schutzobjekten Gefährdungen, Schwachstellen, mögliche Schäden und Eintrittswahrscheinlichkeiten zu. Erst danach werden im **06 SOLL-Konzept** geeignete Maßnahmen und gegebenenfalls neue Komponenten bewertet. Die bereits benannte Anforderung „IPv6: Deny All“ bleibt dort eine Planungsentscheidung und ist kein Bestandteil der hier ermittelten Schutzbedarfskategorien.

## 8. Quellenverzeichnis

[^I1]: **Projektinterne Primärgrundlage:** [02 IST-Analyse – Final](<02 IST-Analyse - Final.md>), Erhebungsstand 15.–16.09.2026, mit zugehörigen Rohprotokollen und Anmeldenachweisen. Grundlage für Systeme, Rollen, Netzstruktur, administrative Nutzung und bestehende Zugriffskontrollen.

[^P1]: **Projektinterne Vorplanung:** [07 Schutzbedarfsbetrachtung](<../01 Projekt_Panung/07 Schutzbedarfsbetrachtung.md>) und [03 Abgrenzung](<../01 Projekt_Panung/03 Abgrenzung.md>). Die vorläufigen Werte wurden anhand des ausdrücklich benannten Modells präzisiert; eine vollständige ISMS-/Grundschutzumsetzung, Backupentwicklung und Hochverfügbarkeit bleiben außerhalb des technischen Projektumfangs.

[^B1]: **Bundesamt für Sicherheit in der Informationstechnik:** [BSI-Standard 200-2 – IT-Grundschutz-Methodik](https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Grundschutz/BSI_Standards/standard_200_2.pdf?__blob=publicationFile), Abschnitt 8.2, insbesondere Schutzbedarfskategorien und Ableitung des Schutzbedarfs. Recherche am 16.09.2026 anhand der von der Suchmaschine erschlossenen BSI-Inhalte; der direkte PDF-Abruf war nicht verfügbar. Die konkreten Modellannahmen und Einstufungen dieses Kapitels sind eigene projektbezogene Bewertungen.

