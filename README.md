# cf-ddns-mikrotik-dmz
# MikroTik + Cloudflare DDNS for NAT/DMZ Networks

This project provides a ready-to-use MikroTik RouterOS script for automatic Dynamic DNS (DDNS) updates using the Cloudflare API — specifically designed for networks **behind NAT** where the upstream router has **DMZ** enabled for the MikroTik.

## 🧠 Use Case

If your MikroTik router is behind a NAT (e.g., connected to a home router/modem) and that upstream device forwards **all ports (DMZ)** to your MikroTik, this script will help you keep a Cloudflare DNS record (A) updated with your current **public IP address**.

This is especially useful for:
- Accessing your MikroTik from outside your network
- Self-hosted services on dynamic IPs
- Replacing services like No-IP or DuckDNS with your **own domain**

---

## ⚙️ How It Works

1. The script fetches your current public IP from `https://api.ipify.org`
2. It retrieves your Cloudflare Zone ID and Record ID
3. It updates the specified DNS record (e.g. `router.yourdomain.com`) with your current IP

All done via the Cloudflare API using an **API Token** (not the global API key).

---

## 📦 Requirements

- A MikroTik router with internet access (RouterOS 6.45+ recommended)
- A domain name managed via [Cloudflare](https://cloudflare.com)
- A Cloudflare **API Token** with:
  - Zone → DNS → *Edit*
- A DNS `A` record already created for your subdomain (e.g. `router.example.com`)  
  *Ensure proxy mode is disabled (DNS Only)*

---

## 🚀 Setup Instructions

1. **Copy the script** from [`cloudflare-ddns.rsc`](cloudflare-ddns.rsc)
2. Open MikroTik Winbox or WebFig
3. Go to `System > Scripts`, add a new script:
   - Name: `cloudflare-ddns`
   - Paste the code
   - Make sure all policies (especially *read*, *write*, *policy*, *test*) are checked
4. Go to `System > Scheduler`, add a new entry:
   - Interval: `00:05:00` (every 5 minutes)
   - On Event:
     ```
     /system script run cloudflare-ddns
     ```

---

## 📄 Sample Script Variables

```rsc
:local cloudflareZoneId "ZONE_ID"
:local cloudflareAuthToken "API_TOKEN"
:local cloudflareRecordId "Your_record_ID" 
:local domain "router.example.com"
```

## ✍️ Author

**Alireza Kazerouni**  
- 🔗 [LinkedIn](https://www.linkedin.com/in/alirezakazerouni)  
- 📧 alirezakazerouni@gmail.com  
- 🐙 [GitHub](https://github.com/alireza-k7)
