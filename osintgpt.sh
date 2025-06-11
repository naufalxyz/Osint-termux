#!/bin/bash

# OSINT Bash Tools - Versi Mantap (Non-GUI CLI Only)
# By Ayang Hacker 💻💋

LOG_FILE="osint_log.txt"

log_result() {
    echo -e "\n[$(date)] $1" >> $LOG_FILE
}

banner() {
    echo "================================================"
    echo "         OSINT GPT - Termux CLI Edition"
    echo "        🔍 For Educational Use Only 🔍"
    echo "================================================"
}

install_tools() {
    echo "[+] Installing tools..."
    pkg update -y
    pkg install -y nmap curl wget whois git python openssl
    pip install requests beautifulsoup4
    log_result "Tools installed"
}

port_scan() {
    read -p "Target IP/Domain: " target
    nmap -sS -Pn -T4 $target
    log_result "Port scan on $target"
}

dns_lookup() {
    read -p "Domain: " domain
    echo "--- A Record ---"
    nslookup $domain
    echo "--- MX Record ---"
    nslookup -type=MX $domain
    echo "--- NS Record ---"
    nslookup -type=NS $domain
    log_result "DNS lookup on $domain"
}

whois_lookup() {
    read -p "Domain: " domain
    whois $domain
    log_result "WHOIS lookup on $domain"
}

web_info() {
    read -p "Website URL: " url
    echo "--- Headers ---"
    curl -I "$url"
    echo "--- Title & Meta ---"
    curl -s "$url" | grep -Eo '<title>.*</title>|<meta[^>]+>'
    echo "--- Robots.txt ---"
    curl -s "$url/robots.txt"
    echo "--- Sitemap.xml ---"
    curl -s "$url/sitemap.xml" | head -20
    log_result "Web info for $url"
}

http_status() {
    read -p "URL: " url
    curl -L -s -o /dev/null -w "Final URL: %{url_effective}\nStatus: %{http_code}\nTime: %{time_total}s\n" "$url"
    log_result "Checked HTTP status for $url"
}

subdomain_check() {
    read -p "Domain: " domain
    subdomains=(www mail ftp admin test dev api blog shop secure vpn remote portal)
    for sub in "${subdomains[@]}"; do
        if nslookup "$sub.$domain" >/dev/null 2>&1; then
            echo "[+] Found: $sub.$domain"
        fi
    done
    log_result "Subdomain check for $domain"
}

create_wordlist() {
    read -p "Base word: " base
    wordlist_file="wordlist_$base.txt"
    echo $base > $wordlist_file
    echo ${base}123 >> $wordlist_file
    echo ${base}2025 >> $wordlist_file
    echo ${base}_pass >> $wordlist_file
    echo admin${base} >> $wordlist_file
    echo test${base} >> $wordlist_file
    cat $wordlist_file
    log_result "Wordlist created with base $base"
}

ip_geolocation() {
    read -p "IP address: " ip
    curl -s "http://ip-api.com/json/$ip" | python3 -m json.tool
    log_result "Geo info for $ip"
}

email_breach() {
    read -p "Email: " email
    curl -s "https://hpb-api.now.sh/api/v1/$email" | python3 -m json.tool
    log_result "Email breach checked for $email"
}

reverse_ip() {
    read -p "IP address: " ip
    curl -s "https://api.hackertarget.com/reverseiplookup/?q=$ip"
    log_result "Reverse IP lookup on $ip"
}

wayback_snapshot() {
    read -p "Domain: " domain
    curl -s "http://web.archive.org/cdx/search/cdx?url=$domain&output=json&fl=timestamp,original&collapse=urlkey" | head -10
    log_result "Wayback snapshot check for $domain"
}

ssl_expiry() {
    read -p "Domain (tanpa https://): " domain
    echo | openssl s_client -servername $domain -connect "$domain:443" 2>/dev/null | openssl x509 -noout -dates
    log_result "SSL expiry check for $domain"
}

main_menu() {
    while true; do
        banner
        echo "1. Install Tools"
        echo "2. Port Scan"
        echo "3. Website Info"
        echo "4. DNS Lookup"
        echo "5. WHOIS Lookup"
        echo "6. HTTP Status Check"
        echo "7. Subdomain Check"
        echo "8. Create Wordlist"
        echo "9. IP Geolocation"
        echo "10. Email Breach Check"
        echo "11. Reverse IP Lookup"
        echo "12. Wayback Snapshot"
        echo "13. SSL Expiry Check"
        echo "0. Exit"
        echo "================================================"
        read -p "Choose option: " opt

        case $opt in
            1) install_tools ;;
            2) port_scan ;;
            3) web_info ;;
            4) dns_lookup ;;
            5) whois_lookup ;;
            6) http_status ;;
            7) subdomain_check ;;
            8) create_wordlist ;;
            9) ip_geolocation ;;
            10) email_breach ;;
            11) reverse_ip ;;
            12) wayback_snapshot ;;
            13) ssl_expiry ;;
            0) echo "Goodbye!"; exit ;;
            *) echo "Invalid option!" ;;
        esac

        echo -e "\nPress Enter to return to menu..."
        read
        clear
    done
}

main_menu
