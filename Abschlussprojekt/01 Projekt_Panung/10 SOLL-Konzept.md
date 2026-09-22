Auf Grundlage der IST-Analyse soll die bestehende Netzwerkstruktur
in drei voneinander getrennte Sicherheitszonen segmentiert werden.

Die Kommunikation zwischen den Netzwerksegmenten wird zentral über
die pfSense-Firewall FW01 geführt und durch definierte Firewallregeln
kontrolliert.

## Geplantes Zielbild

                         WAN
                          |
                       +--+--+
                       | FW01 |
                       |pfSense|
                       +--+---+
                          |
              +-----------+-----------+
              |           |           |
           CLIENT       SERVER       MGMT
              |           |           |
            CL01        DC01        ADM01


## Geplante Netzwerkstruktur

| Sicherheitszone | Netzwerk | Funktion |
|---|---|---|
| CLIENT | 10.10.10.0/24 | Arbeitsplatzsysteme |
| SERVER | 10.10.20.0/24 | zentrale Serverdienste |
| MGMT | 10.10.30.0/24 | administrative Systeme |

### CLIENT-Zone

Die CLIENT-Zone enthält normale Arbeitsplatzsysteme.

CL01 wird dieser Zone zugeordnet.

Zugriffe aus diesem Netz auf andere Sicherheitszonen sollen auf
die für den Betrieb erforderlichen Dienste beschränkt werden.

### SERVER-Zone

Die SERVER-Zone enthält zentrale Serversysteme.

DC01 wird dieser Zone zugeordnet und stellt unter anderem
Active Directory und DNS bereit.

### MGMT-Zone

Die MGMT-Zone ist für administrative Systeme vorgesehen.

ADM01 wird dieser Zone zugeordnet. Administrative Zugriffe auf
Server und Firewall sollen grundsätzlich aus dieser Zone erfolgen.

## Zentrale Firewall

FW01 wird mit pfSense betrieben und bildet den zentralen
Kontrollpunkt zwischen den Sicherheitszonen.

Die Kommunikation zwischen CLIENT, SERVER und MGMT soll nicht
direkt, sondern ausschließlich über FW01 erfolgen.

Die Firewallregeln werden nach dem Prinzip erstellt:

> Nur für den Betrieb erforderliche Kommunikationsbeziehungen
> werden explizit zugelassen. Nicht erforderliche Kommunikation
> zwischen den Sicherheitszonen wird unterbunden.

## Hinweis zur Projektplanung

Die grundlegende Zielarchitektur mit den drei Sicherheitszonen und
pfSense als zentraler Firewall ist Bestandteil des Projektziels.

Die konkreten Kommunikationsanforderungen, Firewallregeln und
technischen Detailkonfigurationen werden auf Grundlage der
IST-Analyse und der daraus abgeleiteten Anforderungen während
der Projektplanung festgelegt.