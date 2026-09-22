## Erstfassung Projektantrag

**Name, Vorname:**  
Marco Males

**Thema der Arbeit:**  
**Risikobasierte Konzeption und Umsetzung einer Netzwerksegmentierung mit pfSense in einer virtualisierten Unternehmensumgebung**

**Durchführungszeitraum:**  
21.09.2026 – 02.10.2026

### Beschreibung der Arbeit / Projektphasen

> Im Rahmen des Projektes wird die Netzwerksicherheit einer virtualisierten Unternehmensumgebung analysiert und verbessert. Die bestehende IST-Umgebung bildet eine kleine Unternehmensinfrastruktur mit einem Windows Server 2022 als Domänencontroller und DNS-Server, einem Windows-11-Client sowie einem administrativen Windows-11-Arbeitsplatz ab. Die Systeme befinden sich im Ausgangszustand in einer gemeinsamen, nicht ausreichend segmentierten Netzwerkstruktur.
> 
> Zu Beginn des Projektes wird der bestehende IST-Zustand erfasst und dokumentiert. Dabei werden die vorhandenen Systeme, Netzwerkstruktur und Kommunikationsbeziehungen betrachtet. Ergänzend erfolgt eine Schutzbedarfsbetrachtung hinsichtlich der Schutzziele Vertraulichkeit, Integrität und Verfügbarkeit. Darauf aufbauend wird das Informationssicherheitsrisiko bewertet, das sich aus der unzureichenden Trennung von Client-, Server- und Administrationssystemen ergibt.
> 
> Auf Grundlage der Analyse wird ein SOLL-Konzept für eine segmentierte Netzwerkarchitektur entwickelt. Hierbei werden getrennte Sicherheitszonen für Client-, Server- und Administrationssysteme vorgesehen. Die Kommunikation zwischen den Netzwerksegmenten soll zentral über eine pfSense-Firewall geführt und auf die für den Betrieb erforderlichen Kommunikationsbeziehungen beschränkt werden. Hierzu werden ein IP-Adresskonzept, eine Kommunikationsmatrix sowie das erforderliche Firewall-Regelwerk geplant.
> 
> Anschließend wird das entwickelte Sicherheitskonzept innerhalb der Microsoft-Hyper-V-Umgebung technisch umgesetzt. Die virtuellen Systeme werden den vorgesehenen Sicherheitszonen zugeordnet, pfSense als zentrale Firewall integriert und die geplanten Kommunikationsregeln implementiert.
> 
> Nach der Implementierung erfolgt eine Test- und Qualitätssicherungsphase. Anhand zuvor definierter Funktions- und Sicherheitstests wird überprüft, ob notwendige Dienste – insbesondere DNS und erforderliche Active-Directory-Kommunikation – weiterhin funktionieren und gleichzeitig nicht erforderliche beziehungsweise administrative Kommunikationswege zwischen den Sicherheitszonen unterbunden werden.
> 
> Abschließend werden IST- und SOLL-Zustand gegenübergestellt, die Wirksamkeit der umgesetzten Netzwerksegmentierung bewertet und das verbleibende Restrisiko dokumentiert. Die während des Projektes erstellten technischen und organisatorischen Nachweise werden in der Projektdokumentation zusammengeführt.

### Projektabgrenzung

> Das Projekt beschränkt sich auf die Analyse, Konzeption, Implementierung und Wirksamkeitsprüfung der Netzwerksegmentierung innerhalb der virtualisierten Testumgebung. Die vollständige Einführung eines Informationssicherheitsmanagementsystems, die Herstellung einer ISO/IEC-27001-Zertifizierungsreife, umfassendes Security-Monitoring, ein Backup-Konzept sowie Penetrationstests sind nicht Bestandteil des Projektes.


# Antrag Version 1.1
##die genaue aufstellung des virtuellen Netzes wurde durch virtuelle Netzwerkumgebung getauscht
![[Projektantrag_Marco_Males_Version_1.1.pdf]]

# Version 2.0 
##hinzufügen einer Timeline
![[Projektantrag_Marco_Males_Version_2.0.pdf]]