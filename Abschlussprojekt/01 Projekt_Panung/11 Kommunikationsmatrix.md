
Auf Grundlage des geplanten Soll-Konzeptes werden die zulässigen
Kommunikationsbeziehungen zwischen den Sicherheitszonen definiert.

Grundsätzlich gilt das Prinzip:

> Kommunikation zwischen den Sicherheitszonen wird nur zugelassen,
> wenn sie für den vorgesehenen Betrieb erforderlich ist.

## Geplante Soll-Anforderungen

| Quelle | Ziel | Dienst/Funktion | Soll |
|---|---|---|---|
| CL01 | DC01 | DNS | Erlaubt |
| CL01 | DC01 | erforderliche Active-Directory-Dienste | Erlaubt |
| CL01 | DC01 | RDP | Blockiert |
| CL01 | MGMT | administrative Zugriffe | Blockiert |
| ADM01 | DC01 | RDP | Erlaubt |
| ADM01 | DC01 | administrative Dienste | Erlaubt |
| ADM01 | FW01 | pfSense-Webadministration | Erlaubt |
| SERVER | MGMT | initiierte Verbindungen | grundsätzlich blockiert |
| CLIENT | MGMT | initiierte Verbindungen | blockiert |

## Detailplanung

Die für den Betrieb tatsächlich erforderlichen Protokolle und Ports
werden während der Projektplanung ermittelt und anschließend in ein
konkretes pfSense-Regelwerk überführt.

Dabei wird insbesondere geprüft, welche Kommunikation für
Active Directory, DNS und die Administration tatsächlich erforderlich ist.

Nicht erforderliche Kommunikationsbeziehungen zwischen den
Sicherheitszonen werden durch die pfSense-Firewall unterbunden.

Die endgültige Kommunikationsmatrix bildet anschließend die Grundlage
für die Implementierung und die spätere Wirksamkeitsprüfung.