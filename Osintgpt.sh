#!/bin/bash

# OSINT Bash Tools untuk Termux
# Educational purposes only

LOG_FILE="osint_log.txt"

echo "================================================"
echo "         OSINT Bash Tools - Termux"
echo "         For Educational Use Only"
echo "================================================"

log_result() {
    echo -e "\n[$(date)] $1" >> $LOG_FILE
}

# Function untuk instalasi tools
install_tools() {
    echo "[+] Installing required tools..."
    pkg update -y
    pkg install -y nmap curl wget whois git python dialog
    pip install requests beautifulsoup4
    echo "[+] Installation complete!"
    log_result "Tools installed"
}

# Function untuk email breach check
email_breach() {
    read -p "Enter email address: " email
    echo "[+] Checking for breaches on $email..."
    result=$(curl -s "https://hpb-api.now.sh/api/v1/$email")
    echo -e "$result" | python3 -m json.tool
    log_result "Email breach checked for $email"
}

# Function untuk port scanning (legal targets only)
port_scan() {
    read -p "Enter target IP/domain: " target
    echo "[+] Scanning common ports on $target"
    nmap -sS -O $target
    log_result "Port scan on $target"
}

# Function untuk website info
web_info() {
    read -p "Enter website URL: " url
    echo "[+] Getting website information for $url"
    echo "--- Headers ---"
    curl -I "$url"
    echo -e "\n--- Robots.txt ---"
    curl -s "$url/robots.txt"
    echo -e "\n--- Sitemap ---"
    curl -s "$url/sitemap.xml" | head -20
    log_result "Website info gathered for $url"
}

# Function untuk DNS lookup
dns_lookup() {
    read -p "Enter domain: " domain
    echo "[+] DNS information for $domain"
    echo "--- A Records ---"
    nslookup $domain
    echo -e "\n--- MX Records ---"
    nslookup -type=MX $domain
    echo -e "\n--- NS Records ---"
    nslookup -type=NS $domain
    log_result "DNS lookup on $domain"
}

# Function untuk whois lookup
whois_lookup() {
    read -p "Enter domain: " domain
    echo "[+] WHOIS information for $domain"
    whois $domain
    log_result "WHOIS lookup on $domain"
}

# Function untuk check HTTP status
http_status() {
    read -p "Enter URL: " url
    echo "[+] HTTP status for $url"
    curl -o /dev/null -s -w "HTTP Status: %{http_code}\nTime Total: %{time_total}s\nSize: %{size_download} bytes\n" "$url"
    log_result "HTTP status checked for $url"
}

# Function untuk subdomain brute force
subdomain_check() {
    read -p "Enter domain: " domain
    echo "[+] Checking common subdomains for $domain"
    subdomains=("www" "mail" "ftp" "admin" "test" "dev" "api" "blog" "shop" "secure" "vpn" "remote" "portal")
    for sub in "${subdomains[@]}"; do
        if nslookup "$sub.$domain" >/dev/null 2>&1; then
            echo "[+] Found: $sub.$domain"
            log_result "Found subdomain: $sub.$domain"
        fi
    done
}

# Function untuk create wordlist
create_wordlist() {
    echo "[+] Creating custom wordlist..."
    read -p "Enter base word: " base
    wordlist_file="custom_wordlist.txt"
    echo $base > $wordlist_file
    echo ${base}123 >> $wordlist_file
    echo ${base}2024 >> $wordlist_file
    echo ${base}admin >> $wordlist_file
    echo admin${base} >> $wordlist_file
    echo test${base} >> $wordlist_file
    echo ${base}test >> $wordlist_file
    echo "[+] Wordlist saved to $wordlist_file"
    cat $wordlist_file
    log_result "Custom wordlist created with base: $base"
}

# Function untuk IP geolocation
ip_geolocation() {
    read -p "Enter IP address: " ip
    echo "[+] Getting geolocation for $ip"
    curl -s "http://ip-api.com/json/$ip" | python3 -m json.tool
    log_result "IP geolocation for $ip"
}

# GUI wrapper with dialog
gui_menu() {
    while true; do
        CHOICE=$(dialog --clear --title "OSINT Termux Toolkit" \
            --menu "Select an option:" 20 60 12 \
            1 "Install Required Tools" \
            2 "Port Scan" \
            3 "Website Information" \
            4 "DNS Lookup" \
            5 "WHOIS Lookup" \
            6 "HTTP Status Check" \
            7 "Subdomain Check" \
            8 "Create Wordlist" \
            9 "IP Geolocation" \
            10 "Email Breach Check" \
            0 "Exit" 3>&1 1>&2 2>&3)

        case $CHOICE in
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
            0) clear; echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option!" ;;
        esac
    done
}

# Menu utama (fallback CLI kalau dialog tidak tersedia)
if command -v dialog &>/dev/null; then
    gui_menu
else
    echo -e "\n[!] GUI not available. Using CLI menu."
    while true; do
        echo "================================================"
        echo "Select OSINT tool:"
        echo "1. Install Required Tools"
        echo "2. Port Scan"
        echo "3. Website Information"#!/bin/bash

# OSINT Bash Tools untuk Termux
# Educational purposes only

LOG_FILE="osint_log.txt"

echo "================================================"
echo "         OSINT Bash Tools - Termux"
echo "         For Educational Use Only"
echo "================================================"

log_result() {
    echo -e "\n[$(date)] $1" >> $LOG_FILE
}

# Function untuk instalasi tools
install_tools() {
    echo "[+] Installing required tools..."
    pkg update -y
    pkg install -y nmap curl wget whois git python dialog
    pip install requests beautifulsoup4
    echo "[+] Installation complete!"
    log_result "Tools installed"
}

# Function untuk email breach check
email_breach() {
    read -p "Enter email address: " email
    echo "[+] Checking for breaches on $email..."
    result=$(curl -s "https://hpb-api.now.sh/api/v1/$email")
    echo -e "$result" | python3 -m json.tool
    log_result "Email breach checked for $email"
}

# Function untuk port scanning (legal targets only)
port_scan() {
    read -p "Enter target IP/domain: " target
    echo "[+] Scanning common ports on $target"
    nmap -sS -O $target
    log_result "Port scan on $target"
}

# Function untuk website info
web_info() {
    read -p "Enter website URL: " url
    echo "[+] Getting website information for $url"
    echo "--- Headers ---"
    curl -I "$url"
    echo -e "\n--- Robots.txt ---"
    curl -s "$url/robots.txt"
    echo -e "\n--- Sitemap ---"
    curl -s "$url/sitemap.xml" | head -20
    log_result "Website info gathered for $url"
}

# Function untuk DNS lookup
dns_lookup() {
    read -p "Enter domain: " domain
    echo "[+] DNS information for $domain"
    echo "--- A Records ---"
    nslookup $domain
    echo -e "\n--- MX Records ---"
    nslookup -type=MX $domain
    echo -e "\n--- NS Records ---"
    nslookup -type=NS $domain
    log_result "DNS lookup on $domain"
}

# Function untuk whois lookup
whois_lookup() {
    read -p "Enter domain: " domain
    echo "[+] WHOIS information for $domain"
    whois $domain
    log_result "WHOIS lookup on $domain"
}

# Function untuk check HTTP status
http_status() {
    read -p "Enter URL: " url
    echo "[+] HTTP status for $url"
    curl -o /dev/null -s -w "HTTP Status: %{http_code}\nTime Total: %{time_total}s\nSize: %{size_download} bytes\n" "$url"
    log_result "HTTP status checked for $url"
}

# Function untuk subdomain brute force
subdomain_check() {
    read -p "Enter domain: " domain
    echo "[+] Checking common subdomains for $domain"
    subdomains=("www" "mail" "ftp" "admin" "test" "dev" "api" "blog" "shop" "secure" "vpn" "remote" "portal")
    for sub in "${subdomains[@]}"; do
        if nslookup "$sub.$domain" >/dev/null 2>&1; then
            echo "[+] Found: $sub.$domain"
            log_result "Found subdomain: $sub.$domain"
        fi
    done
}

# Function untuk create wordlist
create_wordlist() {
    echo "[+] Creating custom wordlist..."
    read -p "Enter base word: " base
    wordlist_file="custom_wordlist.txt"
    echo $base > $wordlist_file
    echo ${base}123 >> $wordlist_file
    echo ${base}2024 >> $wordlist_file
    echo ${base}admin >> $wordlist_file
    echo admin${base} >> $wordlist_file
    echo test${base} >> $wordlist_file
    echo ${base}test >> $wordlist_file
    echo "[+] Wordlist saved to $wordlist_file"
    cat $wordlist_file
    log_result "Custom wordlist created with base: $base"
}

# Function untuk IP geolocation
ip_geolocation() {
    read -p "Enter IP address: " ip
    echo "[+] Getting geolocation for $ip"
    curl -s "http://ip-api.com/json/$ip" | python3 -m json.tool
    log_result "IP geolocation for $ip"
}

# GUI wrapper with dialog
gui_menu() {
    while true; do
        CHOICE=$(dialog --clear --title "OSINT Termux Toolkit" \
            --menu "Select an option:" 20 60 12 \
            1 "Install Required Tools" \
            2 "Port Scan" \
            3 "Website Information" \
            4 "DNS Lookup" \
            5 "WHOIS Lookup" \
            6 "HTTP Status Check" \
            7 "Subdomain Check" \
            8 "Create Wordlist" \
            9 "IP Geolocation" \
            10 "Email Breach Check" \
            0 "Exit" 3>&1 1>&2 2>&3)

        case $CHOICE in
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
            0) clear; echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option!" ;;
        esac
    done
}

# Menu utama (fallback CLI kalau dialog tidak tersedia)
if command -v dialog &>/dev/null; then
    gui_menu
else
    echo -e "\n[!] GUI not available. Using CLI menu."
    while true; do
        echo "================================================"
        echo "Select OSINT tool:"
        echo "1. Install Required Tools"
        echo "2. Port Scan"
        echo "3. Website Information"
        echo "4. DNS Lookup"
        echo "5. WHOIS Lookup"
        echo "6. HTTP Status Check"
        echo "7. Subdomain Check"
        echo "8. Create Custom Wordlist"
        echo "9. IP Geolocation"
        echo "10. Email Breach Check"
        echo "0. Exit"
        echo "================================================"
        read -p "Choose option: " choice
        case $choice in
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
            0) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option!" ;;
        esac
    done
fi￼Enter
