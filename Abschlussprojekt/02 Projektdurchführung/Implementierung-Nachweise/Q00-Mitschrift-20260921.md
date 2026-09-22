![[Pasted image 20260921122726.png]]# vSW-MGMT anlegen

Im Hyper-V-Manager:
	1. Manager für virtuelle Switches öffnen
	2. Neuer virtueller Netzwerkswitch - Privat auswählen
	   ![[Pasted image 20260921093859.png]]
	3. Virtuelle Switch erstellen Anklicken![[Pasted image 20260921093936.png]]
	4. Name vergeben: vSW-MGMT
	   ![[Pasted image 20260921094051.png]]
	5. Mit OK speichern

# pfsene-V-erstellen

Name: pfsense
Generation: Generation 2
Arbetisspeicher: 4096 MB
Dynamischer Arbeitsspeicher Deaktivieren
Netzwerkverbindungen: vSW-IST-LAN
Neue virtuelle Festplatte : 32 GB pfsense.vhdx
Installationsmedium: .iso Datei als virtuelle CD eingelesen
![[Pasted image 20260921102246.png]]
Klicke links auf **Sicherheit**, entferne den Haken bei **„Sicheren Start aktivieren“** und klicke auf **Übernehmen**. Die VM noch nicht starten.

klicke Auf netzwerkkarte und dann vSW-IST-LAN Aussuchen und bestätigen, die VM noch nicht Starten
![[Pasted image 20260921102702.png]]

### Nächster Schritt: CLIENT-Adapter hinzufügen

1. Links **Hardware hinzufügen** auswählen.
2. **Netzwerkkarte → Hinzufügen** anklicken.
3. Als virtuellen Switch **`vSW-Client`** auswählen.
4. Auf **Übernehmen** klicken.

### Nächster Schritt: Server-Adapter hinzufügen

1. Links **Hardware hinzufügen** auswählen.
2. **Netzwerkkarte → Hinzufügen** anklicken.
3. Als virtuellen Switch **`vSW-Server`** auswählen.
4. Auf **Übernehmen** klicken.

### Nächster Schritt: MGMT-Adapter hinzufügen

1. Links **Hardware hinzufügen** auswählen.
2. **Netzwerkkarte → Hinzufügen** anklicken.
3. Als virtuellen Switch **`vSW-MGMT`** auswählen.
4. Auf **Übernehmen** klicken.

![[Pasted image 20260921102937.png]]

Adapter eindeutig erfasst:

```
```PS C:\WINDOWS\system32> Get-VMNetworkAdapter -VMName 'pfsense' |
>>     Select-Object Name, SwitchName, MacAddress |
>>     Format-Table -AutoSize
```

```
Name          SwitchName  MacAddress
----          ----------  ----------
Netzwerkkarte vSW-IST-LAN 000000000000
Netzwerkkarte vSW-Client  000000000000
Netzwerkkarte vSW-Server  000000000000
Netzwerkkarte vSW-MGMT    000000000000
```

Da die Adapter haben eine MAC-Adresse bekommen:

```
PS C:\WINDOWS\system32> Get-VMNetworkAdapter -VMName 'pfsense' |
>>     Select-Object Name, SwitchName, MacAddress |
>>     Format-Table -AutoSize
```

```
Name          SwitchName  MacAddress
----          ----------  ----------
Netzwerkkarte vSW-IST-LAN 00155D02E245
Netzwerkkarte vSW-Client  00155D02E246
Netzwerkkarte vSW-Server  00155D02E247
Netzwerkkarte vSW-MGMT    00155D02E248
```

Nun können wir anhand der MAC-Adressen die Schnittstellen der PFsense zuordnen:
![[Pasted image 20260921104548.png]]

Daraus ergibt sich:

```
hn0 = vSW-IST-LAN
hn1 = vSW-Client
hn2 = vSW-Server
hn3 = vSW-MGMT
```

Betätige hn0 als WAN mit OK
![[Pasted image 20260921104831.png]]

Danach müssen wir hn1 - hn3 noch unterbringen:
![[Pasted image 20260921104936.png]]

Install CE wählen und mit okay bestätigen:
![[Pasted image 20260921105245.png]]

Continue wählen und mit okay bestätigen
![[Pasted image 20260921105442.png]]

mit okay bestätigen:
![[Pasted image 20260921105520.png]]

mit okay bestätigen;
![[Pasted image 20260921105554.png]]

erneut mit okay bestätigen:
![[Pasted image 20260921105620.png]]

Lass **„Current Stable Version (2.9.0)“** ausgewählt und bestätige mit **OK**. Der Installer bietet diese Version als aktuellen stabilen Stand an.
![[Pasted image 20260921105733.png]]

Die Installation wird ausgeführt
Zum Schluss den Reboot durchführen.

![[Pasted image 20260921111931.png]]
Die Pfsense ist gestartet.

## Inteface einrichten
Mit ```2``` in die Konfiguration der IP adresse starten dann das Passende Interface ausfählen ```hn3```

DHCP mit nein n beantworten und eine statische IP adresse vergeben ```10.10.30.1```
Präfixlänge ```24``` upstream frei lassen und mit enter bestätigen. DHCPv6 deaktivieren und keine ipv6 adresse vergeben.
DCHP Server auf lan mit n bestätigen
weboberfläche auf HTTP umstellen mit n damit es bei https bleibt.

somit hn3 auf das netz 10.10.30.0/24 eingestellt


Mit ```1``` in das Menu Assign Interfaces gehen
![[Pasted image 20260921113415.png]]

```should VLANs be set up now?``` mit ```n ``` bestätigen.

WAN mit hn0
LAN mit hn3
optional mit hn1
zweite optional mit hn2 
ausfüllen.

Do you want to proced mit y bestätigen.

## Interface hn1 einrichten
Mit ```2``` in die Konfiguration der IP adresse starten dann das Passende Interface ausfählen ```hn1```

DHCP mit nein n beantworten und eine statische IP adresse vergeben ```10.10.10.1```
Präfixlänge ```24``` upstream frei lassen und mit enter bestätigen. DHCPv6 deaktivieren und keine ipv6 adresse vergeben.
DCHP Server auf lan mit n bestätigen
weboberfläche auf HTTP umstellen mit n damit es bei https bleibt.

Somit wurde **hn1 (CLIENT)** auf `10.10.10.1/24` eingestellt.

## Interface hn2 einrichten
Mit ```2``` in die Konfiguration der IP adresse starten dann das Passende Interface ausfählen ```hn2```

DHCP mit nein n beantworten und eine statische IP adresse vergeben ```10.10.20.1```
Präfixlänge ```24``` upstream frei lassen und mit enter bestätigen. DHCPv6 deaktivieren und keine ipv6 adresse vergeben.
DCHP Server auf lan mit n bestätigen
weboberfläche auf HTTP umstellen mit n damit es bei https bleibt.

Somit wurde **hn2 (SERVER)** auf `10.10.20.1/24` eingestellt.

## IPv6 auf Wan abschalten
Auf WAN ist weiterhin eine IPv6-Adresse per DHCPv6 sichtbar.

1. Wähle **`2 – Set interface(s) IP address`**.
2. Wähle **WAN**.
3. **IPv4 über DHCP:** `y` – bleibt wie vereinbart.
4. **IPv6 über DHCP6:** `n`.
5. Bei einer manuellen IPv6-Adresse: **leer lassen und Enter**.

Fazit:
Die Installation von pfSense CE 2.9.0 und die grundlegende Schnittstellenkonfiguration wurden abgeschlossen. WAN bezieht seine IPv4-Adresse per DHCP. Die internen Schnittstellen besitzen die geplanten statischen IPv4-Adressen. Die Windows-Systeme und die vorgesehenen Firewallregeln werden anschließend eingerichtet. Eine vollständige IPv6-Sperre ist damit noch nicht nachgewiesen.

# ADM01 in vSW-MGMT und 10.10.30.10/24 einstellen:

Im Hyper-V Manager, den ADM01 aussuchen und unter Einstellungen, Netzwerkkarten, den virtuellen Switch sVW-MGMt auswählen und vSW-IST-LAN entfernen.

wir starten **ADM01** und melden uns zunächst als **`PROJEKT\Administrator`** an.

Öffne:

**Einstellungen → Netzwerk und Internet → Ethernet → IP-Zuweisung → Bearbeiten**

Wähle **Manuell**, aktiviere **IPv4** und trage ein:

|Feld|Wert|
|---|---|
|IP-Adresse|`10.10.30.10`|
|Subnetzmaske|`255.255.255.0`|
|Falls stattdessen Präfixlänge gefragt ist|`24`|
|Gateway|`10.10.30.1`|
|Bevorzugter DNS|`10.10.20.10`|
|Alternativer DNS|Leer|
Kontrolle der Konfiguration über Powershell:
```
PS C:\WINDOWS\system32> hostname
>> Get-NetIPConfiguration
>> Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 | Select-Object IPAddress, PrefixLength, PrefixOrigin
>> Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4
ADM01


InterfaceAlias       : Ethernet
InterfaceIndex       : 7
InterfaceDescription : Microsoft Hyper-V Network Adapter
NetProfile.Name      : Netzwerk 2
IPv4Address          : 10.10.30.10
IPv6DefaultGateway   :
IPv4DefaultGateway   : 10.10.30.1
DNSServer            : 10.10.20.10


IPAddress    : 10.10.30.10
PrefixLength : 24
PrefixOrigin : Manual


Caption                    :
Description                :
ElementName                : Ethernet
InstanceID                 :
CommunicationStatus        :
DetailedStatus             :
HealthState                :
InstallDate                :
Name                       : 7
OperatingStatus            :
OperationalStatus          :
PrimaryStatus              :
Status                     :
StatusDescriptions         :
AvailableRequestedStates   :
EnabledDefault             : 2
EnabledState               : 5
OtherEnabledState          :
RequestedState             : 12
TimeOfLastStateChange      :
TransitioningToState       : 12
CreationClassName          :
SystemCreationClassName    :
SystemName                 : 2
AccessContext              : 0
AccessInfo                 :
InfoFormat                 :
OtherAccessContext         :
OtherInfoFormatDescription :
AddressFamily              : 2
InterfaceAlias             : Ethernet
InterfaceIndex             : 7
ServerAddresses            : {10.10.20.10}
PSComputerName             :
Address                    : {10.10.20.10}



```

```
PS C:\WINDOWS\system32> Test-NetConnection 10.10.30.1 -Port 443 |
>>     Select-Object RemoteAddress, RemotePort, TcpTestSucceeded

RemoteAddress RemotePort TcpTestSucceeded
------------- ---------- ----------------
10.10.30.1           443             True
```

Nach der Umstellung konnte ADM01 eine TCP-Verbindung zur pfSense-Adresse `10.10.30.1` auf Port 443 herstellen. `Test-NetConnection` meldete `TcpTestSucceeded: True`.

Die Weboberfläche wurde von ADM01 unter `https://10.10.30.1` aufgerufen. Die Anmeldung mit dem voreingestelltem Administrationskonto war erfolgreich.

Der pfSense-Einrichtungsassistent wurde über ADM01 unter `https://10.10.30.1` geöffnet.

![[Pasted image 20260921122628.png]]

Klicke auf 'Next' und fülle im nächsten Schritt die Felder aus:

Wert
**Hostname** `pfsense`
**Domain** `ad.projekt.test`
**Primary DNS Server**
`192.168.2.1`
**Secondary DNS Server** Leer lassen
**Override DNS*** **Haken entfernen**

Der vollständige Gerätename lautet damit **`pfsense.ad.projekt.test`**. Das bewirkt keinen Beitritt zur Windows-Domäne.

**Wichtig:** Der eingeblendete Hinweis betrifft den DNS Resolver. Damit pfSense tatsächlich den Router für externe DNS-Anfragen nutzt, prüfen wir dessen Weiterleitungsmodus nach dem Assistenten gesondert.

Klicke Auf 'Next' und fülle die Nächste Seite aus:
**Time server hostname** `2.pfsense.pool.ntp.org`
**Timezone** `Europe/Berlin`

Als Zeitquelle wurde `2.pfsense.pool.ntp.org` und als Zeitzone `Europe/Berlin` eingestellt.

Klicke auf 'Next'

