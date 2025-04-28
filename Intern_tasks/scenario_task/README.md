🛠️ Troubleshooting Case: Internal Web Dashboard Unreachable

📋 Scenario Description

The internal company dashboard (internal.example.com) suddenly became unreachable for multiple users.

Symptoms observed:

- "Host not found" DNS errors.
- Service appears to be up and running on the server side.

Our task was to troubleshoot the issue, verify each layer, and restore full connectivity, which will be illustrated in the following sections.
==========================================================
1. 🧩 DNS Resolution Check

We verified the DNS resolution against:

- /etc/resolv.conf configured DNS
- Google's public DNS (8.8.8.8)

==========================================================
2. 🧪 Service Reachability Diagnosis

We tested if the web service is reachable via network tools:

- ping
- curl
- telnet
- ss
==========================================================
3. 🛠️ Fixes Applied
✅ /etc/hosts Entry
Manually added an entry to bypass DNS temporarily:

- sudo nano /etc/hosts
# Added:
- 192.168.2.61 internal.example.com
=======
✅ Service Check and Restart
Restarted the internal web service to make sure it is listening on port 80:

- sudo systemctl restart apache2
==========================================================
4. ⚡ Bonus: Persistent DNS Settings
Edited /etc/systemd/resolved.conf to set internal DNS:

- sudo nano /etc/systemd/resolved.conf
# Set:
- DNS=192.168.2.61
- FallbackDNS=8.8.8.8
#restarted the DNS resolver
- sudo systemctl restart systemd-resolved
==========================================================
📚 Important Notes

- Always check /etc/hosts first for internal domains.

- Ensure the service is not only running but also listening on the correct IP/port.

- If internal DNS is unreliable, a hosts entry can temporarily save the situation.
======================== End ==============================

