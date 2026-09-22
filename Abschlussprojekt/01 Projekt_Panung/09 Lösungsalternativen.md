
Zur Umsetzung der geplanten Netzwerksegmentierung werden verschiedene
technische Lösungsansätze betrachtet.

## Variante A – Segmentierung mit pfSense und mehreren virtuellen Netzwerken

Die einzelnen Sicherheitsbereiche werden über separate virtuelle
Hyper-V-Switches voneinander getrennt.

pfSense übernimmt als zentrale Firewall das Routing und die Kontrolle
der Kommunikation zwischen den Netzwerksegmenten.

**Vorteile:**
- klare Trennung der Sicherheitszonen
- zentrale Verwaltung der Firewallregeln
- Kommunikation zwischen den Netzen kontrollierbar
- gute Nachvollziehbarkeit
- übersichtliche technische Umsetzung

**Nachteile:**
- zusätzliche virtuelle Firewall erforderlich
- höherer Konfigurationsaufwand
- zentrale Firewall stellt einen kritischen Infrastrukturpunkt dar

---

## Variante B – Segmentierung mittels VLANs und pfSense

Die Sicherheitsbereiche werden durch VLANs logisch voneinander getrennt.
pfSense übernimmt das Routing und die Filterung zwischen den VLANs.

**Vorteile:**
- gute Skalierbarkeit
- praxisnahe Unternehmensarchitektur
- mehrere logische Netze über gemeinsame Infrastruktur möglich
- zentrale Kontrolle durch pfSense

**Nachteile:**
- höhere Konfigurationskomplexität
- VLAN-Konfiguration muss auf allen beteiligten Komponenten
  korrekt abgestimmt werden
- für die kleine Projektumgebung möglicherweise unnötig komplex

---

## Variante C – Segmentierung mit pfSense und zusätzlichen hostbasierten Firewallregeln

Zusätzlich zur Netzwerksegmentierung über pfSense werden die
hostbasierten Firewalls der einzelnen Systeme zur weiteren
Einschränkung der Kommunikation eingesetzt.

**Vorteile:**
- zusätzliche Sicherheitsebene
- Schutz auch innerhalb eines Netzwerksegmentes
- Defense-in-Depth-Ansatz

**Nachteile:**
- höherer Administrationsaufwand
- komplexeres Regelwerk
- erschwerte Fehlersuche
- größerer Test- und Dokumentationsaufwand

---

# Bewertungskriterien

Die Lösungsvarianten werden anhand folgender Kriterien bewertet:

- Sicherheitsgewinn
- Implementierungsaufwand
- Administrationsaufwand
- Wartbarkeit
- Skalierbarkeit
- Nachvollziehbarkeit
- Kosten
- technische Umsetzbarkeit innerhalb des Projektzeitraums

Die Bewertung erfolgt im Rahmen einer Nutzwertanalyse.
