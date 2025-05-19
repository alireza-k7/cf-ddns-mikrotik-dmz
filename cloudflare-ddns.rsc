# =========================================================
# Cloudflare DDNS Update Script for MikroTik
# Author: Alireza Kazerouni
# GitHub: https://github.com/alireza-k7
# LinkedIn: https:/www.linkedin.com/in/alirezakazerouni
# Email: alirezakazerouni@gmail.com
# Version: 1.0
# =========================================================

:local cloudflareZoneId "ZONE_ID"
:local cloudflareAuthToken "API_TOKEN"
:local cloudflareRecordId "Your_record_ID" 
:local domain "router.example.com"

# Get public IP from external service
:local publicIP [/tool fetch url="https://api.ipify.org/" as-value output=user]
:set publicIP ($publicIP->"data")

# Log the current public IP
:log info "Current public IP: $publicIP"

# API call to Cloudflare to update DNS - Setting proxied to false for DNS Only mode
:local cloudflareData "{\"type\":\"A\",\"name\":\"$domain\",\"content\":\"$publicIP\",\"ttl\":120,\"proxied\":false}"

:log info "Sending update to Cloudflare with DNS Only mode..."

/tool fetch http-method=put \
  url="https://api.cloudflare.com/client/v4/zones/$cloudflareZoneId/dns_records/$cloudflareRecordId" \
  http-header-field="Authorization: Bearer $cloudflareAuthToken,Content-Type: application/json" \
  http-data="$cloudflareData" \
  as-value output=user

:log info "Update request sent for IP: $publicIP (DNS Only mode)"
