#!/bin/bash

################################################################################
# Hymapper - Nmap Made Easy for Beginners
# Creator: Dhype7
# Description: A beginner-friendly CLI tool to simplify Nmap scanning
################################################################################

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Global variables
TARGET_IP=""
TARGET_PORT=""
SCAN_COMMAND=""
CSV_MODE="OFF"
CSV_FILE=""
OUTPUT_DIR="$HOME/hymapper_scans"
################################################################################
# Display Functions
################################################################################

show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "═══════════════════════════════════════════════════════════════════"
    echo "██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ██████╗ ███████╗██████╗ "
    echo "██║  ██║╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
    echo "███████║ ╚████╔╝ ██╔████╔██║███████║██████╔╝██████╔╝█████╗  ██████╔╝"
    echo "██╔══██║  ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗"
    echo "██║  ██║   ██║   ██║ ╚═╝ ██║██║  ██║██║     ██║     ███████╗██║  ██║"
    echo "╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝"
    echo "═══════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}           Nmap Made Easy for Beginners${NC}"
    echo -e "${GREEN}                  Creator: Dhype7${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
    
    # Show CSV status
    if [ "$CSV_MODE" = "ON" ]; then
        echo -e "${GREEN}CSV Export: ${BOLD}ENABLED${NC} ${WHITE}→ $OUTPUT_DIR/${NC}"
    fi
    echo ""
}

show_menu() {
    echo -e "${BOLD}${WHITE}Please select an option:${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Standard Scans (40 pre-configured scans)"
    echo -e "${GREEN}[2]${NC} Host Discovery (Find live hosts on network)"
    echo -e "${GREEN}[3]${NC} Build Your Own Scan (Custom flags)"
    echo -e "${GREEN}[4]${NC} View Flag Descriptions"
    echo -e "${GREEN}[5]${NC} About Hymapper"
    echo -e "${GREEN}[6]${NC} NSE Scripts Guide (Learn & use Nmap scripts)"
    echo -e "${CYAN}[7]${NC} Change Target"
    
    # CSV Toggle option
    if [ "$CSV_MODE" = "OFF" ]; then
        echo -e "${MAGENTA}[8]${NC} Enable CSV Export ${WHITE}(Save scan results to file)${NC}"
    else
        echo -e "${MAGENTA}[8]${NC} Disable CSV Export ${GREEN}(Currently ON)${NC}"
    fi
    echo -e "${MAGENTA}[9]${NC} View CSV Files  ${WHITE}(Manage saved scans)${NC}"
    
    echo -e "${RED}[0]${NC} Exit"
    echo ""
}

################################################################################
# Input Functions
################################################################################

get_target_input() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Target Configuration ═══${NC}\n"
    
    # Get IP address
    while true; do
        echo -e "${CYAN}Enter target (IP, hostname, subnet, or range):${NC}"
        echo -e "${YELLOW}Examples:${NC}"
        echo -e "  ${WHITE}192.168.1.1${NC}         - Single IP"
        echo -e "  ${WHITE}192.168.1.0/24${NC}      - Subnet (CIDR)"
        echo -e "  ${WHITE}192.168.1.1-50${NC}      - Range"
        echo -e "  ${WHITE}scanme.nmap.org${NC}     - Hostname"
        read -p "> " TARGET_IP
        
        if [ -z "$TARGET_IP" ]; then
            echo -e "${RED}Error: Target cannot be empty!${NC}\n"
            continue
        fi
        
        # Accept various formats: IP, subnet, range, hostname
        if [[ $TARGET_IP =~ ^[0-9a-zA-Z./\-]+$ ]] || [[ $TARGET_IP =~ ^[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?)*$ ]]; then
            echo -e "${GREEN}✓ Target set: $TARGET_IP${NC}\n"
            break
        else
            echo -e "${RED}Error: Invalid target format!${NC}\n"
        fi
    done
    
    # Get optional port
    echo -e "${CYAN}Enter specific port(s) (optional, press Enter to skip):${NC}"
    echo -e "${YELLOW}Examples: 80, 80-443, 22,80,443${NC}"
    read -p "> " TARGET_PORT
    
    if [ ! -z "$TARGET_PORT" ]; then
        echo -e "${GREEN}✓ Port(s) set: $TARGET_PORT${NC}\n"
    else
        echo -e "${YELLOW}No specific port set (will use scan defaults)${NC}\n"
    fi
    
    sleep 1
}

################################################################################
# Standard Scans Functions
################################################################################

show_standard_scans() {
    while true; do
        show_banner
        echo -e "${YELLOW}${BOLD}═══ Standard Scans ═══${NC}\n"
        echo -e "${CYAN}Target: ${WHITE}$TARGET_IP${NC}"
        if [ ! -z "$TARGET_PORT" ]; then
            echo -e "${CYAN}Port(s): ${WHITE}$TARGET_PORT${NC}"
        fi
        echo ""
        
        echo -e "${RED}${BOLD}PRO SCANS (Most Comprehensive)${NC}"
        echo -e "${RED}[1]${NC}  Aggressive Scan with OS Detection"
        echo -e "${RED}[2]${NC}  Full TCP Port Scan with Service Detection"
        echo -e "${RED}[3]${NC}  Comprehensive Vulnerability Scan"
        echo -e "${RED}[4]${NC}  Stealth SYN Scan with Script Scanning"
        echo -e "${RED}[5]${NC}  Full UDP and TCP Combined Scan"
        echo -e "${RED}[6]${NC}  Intense Scan with All Probes"
        echo -e "${RED}[7]${NC}  Comprehensive Exploit Detection"
        echo -e "${RED}[8]${NC}  Full Port Range with Max Scripts"
        echo ""
        
        echo -e "${YELLOW}${BOLD}⚡ GOOD SCANS (Balanced)${NC}"
        echo -e "${YELLOW}[9]${NC}  Service Version Detection"
        echo -e "${YELLOW}[10]${NC} OS Detection with Traceroute"
        echo -e "${YELLOW}[11]${NC} Top 1000 Ports Fast Scan"
        echo -e "${YELLOW}[12]${NC} Default Script Scan"
        echo -e "${YELLOW}[13]${NC} TCP SYN Scan with OS Detection"
        echo -e "${YELLOW}[14]${NC} Version Intense with Scripts"
        echo -e "${YELLOW}[15]${NC} Stealth Scan with Service Detection"
        echo -e "${YELLOW}[16]${NC} Network Discovery and Analysis"
        echo ""
        
        echo -e "${BLUE}${BOLD}MID SCANS (Standard)${NC}"
        echo -e "${BLUE}[17]${NC} Basic Port Scan"
        echo -e "${BLUE}[18]${NC} TCP Connect Scan"
        echo -e "${BLUE}[19]${NC} Service and Version Detection"
        echo -e "${BLUE}[20]${NC} Top 100 Ports Quick Scan"
        echo -e "${BLUE}[21]${NC} UDP Top Ports Scan"
        echo -e "${BLUE}[22]${NC} ACK Scan for Firewall Detection"
        echo -e "${BLUE}[23]${NC} FIN Scan (Stealthy Alternative)"
        echo -e "${BLUE}[24]${NC} NULL Scan for Firewall Bypass"
        echo ""
        
        echo -e "${GREEN}${BOLD}FAST SCANS (Quick)${NC}"
        echo -e "${GREEN}[25]${NC} Ping Scan (Host Discovery)"
        echo -e "${GREEN}[26]${NC} Quick Scan Top 20 Ports"
        echo -e "${GREEN}[27]${NC} Fast SYN Scan"
        echo -e "${GREEN}[28]${NC} Single Port Quick Check"
        echo -e "${GREEN}[29]${NC} Fast TCP Connect"
        echo -e "${GREEN}[30]${NC} Rapid Host Discovery"
        echo -e "${GREEN}[31]${NC} Top 10 Ports Lightning Fast"
        echo -e "${GREEN}[32]${NC} Quick Web Ports Scan"
        echo ""
        
        echo -e "${WHITE}${BOLD}BASIC SCANS (Beginner Friendly)${NC}"
        echo -e "${WHITE}[33]${NC} Simple Scan (Default)"
        echo -e "${WHITE}[34]${NC} Check if Host is Up"
        echo -e "${WHITE}[35]${NC} List Open Ports"
        echo -e "${WHITE}[36]${NC} Scan Common Ports"
        echo -e "${WHITE}[37]${NC} Basic Service Detection"
        echo -e "${WHITE}[38]${NC} Polite Scan (Slow and Careful)"
        echo -e "${WHITE}[39]${NC} Top 50 Ports Basic"
        echo -e "${WHITE}[40]${NC} Simple Web Server Check"
        echo ""
        
        echo -e "${MAGENTA}[41]${NC} Show Descriptions for All Scans"
        echo -e "${CYAN}[0]${NC}  Back to Main Menu"
        echo ""
        
        read -p "Select scan type: " scan_choice
        
        case $scan_choice in
            # PRO SCANS (1-8)
            1) execute_scan "nmap -A -T4" "Aggressive Scan with OS Detection" ;;
            2) execute_scan "nmap -p- -sV -T4" "Full TCP Port Scan with Service Detection" ;;
            3) execute_scan "nmap -sV --script vuln" "Comprehensive Vulnerability Scan" ;;
            4) execute_scan "nmap -sS -sC -T4" "Stealth SYN Scan with Script Scanning" ;;
            5) execute_scan "nmap -sU -sT -p-" "Full UDP and TCP Combined Scan" ;;
            6) execute_scan "nmap -A -sV --version-intensity 9 -T4" "Intense Scan with All Probes" ;;
            7) execute_scan "nmap -sV --script exploit,vuln -T4" "Comprehensive Exploit Detection" ;;
            8) execute_scan "nmap -p- -A -sC --script discovery,auth -T4" "Full Port Range with Max Scripts" ;;
            
            # GOOD SCANS (9-16)
            9) execute_scan "nmap -sV" "Service Version Detection" ;;
            10) execute_scan "nmap -O --traceroute" "OS Detection with Traceroute" ;;
            11) execute_scan "nmap --top-ports 1000 -T4" "Top 1000 Ports Fast Scan" ;;
            12) execute_scan "nmap -sC" "Default Script Scan" ;;
            13) execute_scan "nmap -sS -O" "TCP SYN Scan with OS Detection" ;;
            14) execute_scan "nmap -sV --version-intensity 7 -sC" "Version Intense with Scripts" ;;
            15) execute_scan "nmap -sS -sV -T3" "Stealth Scan with Service Detection" ;;
            16) execute_scan "nmap -sn --traceroute -PE -PP -PM" "Network Discovery and Analysis" ;;
            
            # MID SCANS (17-24)
            17) execute_scan "nmap" "Basic Port Scan" ;;
            18) execute_scan "nmap -sT" "TCP Connect Scan" ;;
            19) execute_scan "nmap -sV -sC" "Service and Version Detection" ;;
            20) execute_scan "nmap --top-ports 100" "Top 100 Ports Quick Scan" ;;
            21) execute_scan "nmap -sU --top-ports 20" "UDP Top Ports Scan" ;;
            22) execute_scan "nmap -sA" "ACK Scan for Firewall Detection" ;;
            23) execute_scan "nmap -sF" "FIN Scan (Stealthy Alternative)" ;;
            24) execute_scan "nmap -sN" "NULL Scan for Firewall Bypass" ;;
            
            # FAST SCANS (25-32)
            25) execute_scan "nmap -sn" "Ping Scan (Host Discovery)" ;;
            26) execute_scan "nmap --top-ports 20 -T5" "Quick Scan Top 20 Ports" ;;
            27) execute_scan "nmap -sS -T5" "Fast SYN Scan" ;;
            28) execute_scan "nmap -p 80" "Single Port Quick Check" ;;
            29) execute_scan "nmap -sT -T5 --top-ports 10" "Fast TCP Connect" ;;
            30) execute_scan "nmap -sn -T5 -n" "Rapid Host Discovery" ;;
            31) execute_scan "nmap --top-ports 10 -T5 -n" "Top 10 Ports Lightning Fast" ;;
            32) execute_scan "nmap -p 80,443,8080,8443 -T5" "Quick Web Ports Scan" ;;
            
            # BASIC SCANS (33-40)
            33) execute_scan "nmap -F" "Simple Scan (Default)" ;;
            34) execute_scan "nmap -sn -T4" "Check if Host is Up" ;;
            35) execute_scan "nmap --open" "List Open Ports" ;;
            36) execute_scan "nmap -p 21,22,23,25,53,80,443,445,3389" "Scan Common Ports" ;;
            37) execute_scan "nmap -sV -F" "Basic Service Detection" ;;
            38) execute_scan "nmap -T2" "Polite Scan (Slow and Careful)" ;;
            39) execute_scan "nmap --top-ports 50" "Top 50 Ports Basic" ;;
            40) execute_scan "nmap -p 80,443 -sV" "Simple Web Server Check" ;;
            
            41) show_scan_descriptions ;;
            0) return ;;
            *) 
                echo -e "${RED}Invalid option! Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

execute_scan() {
    local base_command="$1"
    local scan_name="$2"
    
    # Build full command
    local full_command="$base_command $TARGET_IP"
    
    # Add port if specified
    if [ ! -z "$TARGET_PORT" ] && [[ ! $base_command =~ "-p" ]] && [[ ! $base_command =~ "top-ports" ]] && [[ ! $base_command =~ "-sn" ]]; then
        full_command="$base_command -p $TARGET_PORT $TARGET_IP"
    fi
    
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Executing Scan ═══${NC}\n"
    echo -e "${CYAN}Scan Type: ${WHITE}$scan_name${NC}"
    echo -e "${CYAN}Command:   ${WHITE}$full_command${NC}\n"
    echo -e "${GREEN}Starting scan...${NC}\n"
    echo "═══════════════════════════════════════════════════════════════════"
    
    # Execute the scan
    eval $full_command
    
    echo ""
    echo "═══════════════════════════════════════════════════════════════════"
    echo -e "\n${GREEN}Scan completed!${NC}\n"
    
    read -p "Press Enter to continue..."
}

show_scan_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ All 40 Standard Scans with Commands ═══${NC}\n"
    echo -e "${WHITE}Press SPACE to scroll down, Q to quit the descriptions${NC}\n"
    
    (
    echo -e "${RED}${BOLD}PRO SCANS (Most Comprehensive):${NC}"
    echo -e "${RED}[1]${NC} Aggressive Scan with OS Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -A -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} OS detection, version detection, script scanning, and traceroute"
    echo ""
    echo -e "${RED}[2]${NC} Full TCP Port Scan with Service Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -p- -sV -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Scans all 65535 TCP ports with service version detection"
    echo ""
    echo -e "${RED}[3]${NC} Comprehensive Vulnerability Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sV --script vuln <target>"
    echo -e "    ${WHITE}Description:${NC} Uses NSE scripts to detect common vulnerabilities"
    echo ""
    echo -e "${RED}[4]${NC} Stealth SYN Scan with Script Scanning"
    echo -e "    ${CYAN}Command:${NC} nmap -sS -sC -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} SYN scan with default NSE scripts for enumeration"
    echo ""
    echo -e "${RED}[5]${NC} Full UDP and TCP Combined Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sU -sT -p- <target>"
    echo -e "    ${WHITE}Description:${NC} Scans all UDP and TCP ports (very slow)"
    echo ""
    echo -e "${RED}[6]${NC} Intense Scan with All Probes"
    echo -e "    ${CYAN}Command:${NC} nmap -A -sV --version-intensity 9 -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Maximum version detection intensity with aggressive options"
    echo ""
    echo -e "${RED}[7]${NC} Comprehensive Exploit Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sV --script exploit,vuln -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Runs exploit and vulnerability detection scripts"
    echo ""
    echo -e "${RED}[8]${NC} Full Port Range with Max Scripts"
    echo -e "    ${CYAN}Command:${NC} nmap -p- -A -sC --script discovery,auth -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Complete port scan with discovery and authentication scripts"
    echo ""
    
    echo -e "${YELLOW}${BOLD}⚡ GOOD SCANS (Balanced):${NC}"
    echo -e "${YELLOW}[9]${NC} Service Version Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sV <target>"
    echo -e "    ${WHITE}Description:${NC} Identifies service versions on open ports"
    echo ""
    echo -e "${YELLOW}[10]${NC} OS Detection with Traceroute"
    echo -e "    ${CYAN}Command:${NC} nmap -O --traceroute <target>"
    echo -e "    ${WHITE}Description:${NC} Detects operating system and network path"
    echo ""
    echo -e "${YELLOW}[11]${NC} Top 1000 Ports Fast Scan"
    echo -e "    ${CYAN}Command:${NC} nmap --top-ports 1000 -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Scans the most common 1000 ports quickly"
    echo ""
    echo -e "${YELLOW}[12]${NC} Default Script Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sC <target>"
    echo -e "    ${WHITE}Description:${NC} Runs safe and informative NSE scripts"
    echo ""
    echo -e "${YELLOW}[13]${NC} TCP SYN Scan with OS Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sS -O <target>"
    echo -e "    ${WHITE}Description:${NC} Stealth scan with operating system detection"
    echo ""
    echo -e "${YELLOW}[14]${NC} Version Intense with Scripts"
    echo -e "    ${CYAN}Command:${NC} nmap -sV --version-intensity 7 -sC <target>"
    echo -e "    ${WHITE}Description:${NC} Intense version detection combined with default scripts"
    echo ""
    echo -e "${YELLOW}[15]${NC} Stealth Scan with Service Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sS -sV -T3 <target>"
    echo -e "    ${WHITE}Description:${NC} Balanced stealth and service identification"
    echo ""
    echo -e "${YELLOW}[16]${NC} Network Discovery and Analysis"
    echo -e "    ${CYAN}Command:${NC} nmap -sn --traceroute -PE -PP -PM <target>"
    echo -e "    ${WHITE}Description:${NC} Advanced host discovery with multiple probe types"
    echo ""
    
    echo -e "${BLUE}${BOLD}MID SCANS (Standard):${NC}"
    echo -e "${BLUE}[17]${NC} Basic Port Scan"
    echo -e "    ${CYAN}Command:${NC} nmap <target>"
    echo -e "    ${WHITE}Description:${NC} Default nmap scan (top 1000 ports)"
    echo ""
    echo -e "${BLUE}[18]${NC} TCP Connect Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sT <target>"
    echo -e "    ${WHITE}Description:${NC} Complete TCP handshake scan (more detectable)"
    echo ""
    echo -e "${BLUE}[19]${NC} Service and Version Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sV -sC <target>"
    echo -e "    ${WHITE}Description:${NC} Combines service detection with scripts"
    echo ""
    echo -e "${BLUE}[20]${NC} Top 100 Ports Quick Scan"
    echo -e "    ${CYAN}Command:${NC} nmap --top-ports 100 <target>"
    echo -e "    ${WHITE}Description:${NC} Quick scan of 100 most common ports"
    echo ""
    echo -e "${BLUE}[21]${NC} UDP Top Ports Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sU --top-ports 20 <target>"
    echo -e "    ${WHITE}Description:${NC} Scans 20 most common UDP ports"
    echo ""
    echo -e "${BLUE}[22]${NC} ACK Scan for Firewall Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sA <target>"
    echo -e "    ${WHITE}Description:${NC} Determines firewall rules and filtered ports"
    echo ""
    echo -e "${BLUE}[23]${NC} FIN Scan (Stealthy Alternative)"
    echo -e "    ${CYAN}Command:${NC} nmap -sF <target>"
    echo -e "    ${WHITE}Description:${NC} Sends packets with FIN flag, evades some firewalls"
    echo ""
    echo -e "${BLUE}[24]${NC} NULL Scan for Firewall Bypass"
    echo -e "    ${CYAN}Command:${NC} nmap -sN <target>"
    echo -e "    ${WHITE}Description:${NC} Sends packets with no flags, stealthy technique"
    echo ""
    
    echo -e "${GREEN}${BOLD}FAST SCANS (Quick):${NC}"
    echo -e "${GREEN}[25]${NC} Ping Scan (Host Discovery)"
    echo -e "    ${CYAN}Command:${NC} nmap -sn <target>"
    echo -e "    ${WHITE}Description:${NC} Only checks if host is alive (no port scan)"
    echo ""
    echo -e "${GREEN}[26]${NC} Quick Scan Top 20 Ports"
    echo -e "    ${CYAN}Command:${NC} nmap --top-ports 20 -T5 <target>"
    echo -e "    ${WHITE}Description:${NC} Very quick scan of 20 most common ports"
    echo ""
    echo -e "${GREEN}[27]${NC} Fast SYN Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -sS -T5 <target>"
    echo -e "    ${WHITE}Description:${NC} Aggressive timing stealth scan"
    echo ""
    echo -e "${GREEN}[28]${NC} Single Port Quick Check"
    echo -e "    ${CYAN}Command:${NC} nmap -p 80 <target>"
    echo -e "    ${WHITE}Description:${NC} Quick check of port 80 (HTTP)"
    echo ""
    echo -e "${GREEN}[29]${NC} Fast TCP Connect"
    echo -e "    ${CYAN}Command:${NC} nmap -sT -T5 --top-ports 10 <target>"
    echo -e "    ${WHITE}Description:${NC} Quick TCP connect to top 10 ports"
    echo ""
    echo -e "${GREEN}[30]${NC} Rapid Host Discovery"
    echo -e "    ${CYAN}Command:${NC} nmap -sn -T5 -n <target>"
    echo -e "    ${WHITE}Description:${NC} Fastest host discovery, no DNS resolution"
    echo ""
    echo -e "${GREEN}[31]${NC} Top 10 Ports Lightning Fast"
    echo -e "    ${CYAN}Command:${NC} nmap --top-ports 10 -T5 -n <target>"
    echo -e "    ${WHITE}Description:${NC} Ultra-fast scan of top 10 ports"
    echo ""
    echo -e "${GREEN}[32]${NC} Quick Web Ports Scan"
    echo -e "    ${CYAN}Command:${NC} nmap -p 80,443,8080,8443 -T5 <target>"
    echo -e "    ${WHITE}Description:${NC} Fast check of common web server ports"
    echo ""
    
    echo -e "${WHITE}${BOLD}BASIC SCANS (Beginner Friendly):${NC}"
    echo -e "${WHITE}[33]${NC} Simple Scan (Default)"
    echo -e "    ${CYAN}Command:${NC} nmap -F <target>"
    echo -e "    ${WHITE}Description:${NC} Fast scan mode (100 most common ports)"
    echo ""
    echo -e "${WHITE}[34]${NC} Check if Host is Up"
    echo -e "    ${CYAN}Command:${NC} nmap -sn -T4 <target>"
    echo -e "    ${WHITE}Description:${NC} Verify if target is online"
    echo ""
    echo -e "${WHITE}[35]${NC} List Open Ports"
    echo -e "    ${CYAN}Command:${NC} nmap --open <target>"
    echo -e "    ${WHITE}Description:${NC} Show only open ports from scan"
    echo ""
    echo -e "${WHITE}[36]${NC} Scan Common Ports"
    echo -e "    ${CYAN}Command:${NC} nmap -p 21,22,23,25,53,80,443,445,3389 <target>"
    echo -e "    ${WHITE}Description:${NC} Scans FTP, SSH, HTTP, HTTPS, SMB, RDP, etc."
    echo ""
    echo -e "${WHITE}[37]${NC} Basic Service Detection"
    echo -e "    ${CYAN}Command:${NC} nmap -sV -F <target>"
    echo -e "    ${WHITE}Description:${NC} Fast scan with service detection"
    echo ""
    echo -e "${WHITE}[38]${NC} Polite Scan (Slow and Careful)"
    echo -e "    ${CYAN}Command:${NC} nmap -T2 <target>"
    echo -e "    ${WHITE}Description:${NC} Slower scan to avoid detection"
    echo ""
    echo -e "${WHITE}[39]${NC} Top 50 Ports Basic"
    echo -e "    ${CYAN}Command:${NC} nmap --top-ports 50 <target>"
    echo -e "    ${WHITE}Description:${NC} Beginner-friendly scan of 50 common ports"
    echo ""
    echo -e "${WHITE}[40]${NC} Simple Web Server Check"
    echo -e "    ${CYAN}Command:${NC} nmap -p 80,443 -sV <target>"
    echo -e "    ${WHITE}Description:${NC} Check HTTP/HTTPS ports with version detection"
    echo ""
    echo ""
    echo -e "${YELLOW}═══════════════════════════════════════════════${NC}"
    echo -e "${WHITE}Press ${YELLOW}Q${WHITE} to quit the descriptions${NC}"
    echo -e "${YELLOW}═══════════════════════════════════════════════${NC}"
    echo ""
    ) | less -R
    
    # Alternative if less doesn't work
    if [ $? -ne 0 ]; then
        read -p "Press Enter to continue..."
    fi
}

################################################################################
# Source Module Files
################################################################################

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source modules if they exist
if [ -f "$SCRIPT_DIR/custom_scan_builder.sh" ]; then
    source "$SCRIPT_DIR/custom_scan_builder.sh"
fi

if [ -f "$SCRIPT_DIR/flag_categories.sh" ]; then
    source "$SCRIPT_DIR/flag_categories.sh"
fi

if [ -f "$SCRIPT_DIR/descriptions.sh" ]; then
    source "$SCRIPT_DIR/descriptions.sh"
fi

################################################################################
# CSV Export Functions
################################################################################

toggle_csv_mode() {
    if [ "$CSV_MODE" = "OFF" ]; then
        CSV_MODE="ON"
        
        # Create output directory if it doesn't exist
        mkdir -p "$OUTPUT_DIR"
        
        # Generate filename with timestamp
        timestamp=$(date +"%Y%m%d_%H%M%S")
        CSV_FILE="$OUTPUT_DIR/hymapper_scan_${timestamp}.csv"
        
        # Create CSV header
        echo "Timestamp,Target,Scan_Type,IP_Address,Port,Protocol,State,Service,Version,Hostname,Latency_ms,Additional_Info" > "$CSV_FILE"
        
        echo -e "\n${GREEN}✓ CSV Export enabled!${NC}"
        echo -e "${WHITE}Output directory: ${CYAN}$OUTPUT_DIR${NC}"
        echo -e "${WHITE}Current file: ${CYAN}$(basename $CSV_FILE)${NC}"
        echo -e "${YELLOW}All scan results will be saved automatically.${NC}\n"
        sleep 2
    else
        CSV_MODE="OFF"
        echo -e "\n${YELLOW}CSV Export disabled.${NC}"
        if [ -f "$CSV_FILE" ]; then
            echo -e "${WHITE}Last file saved: ${CYAN}$CSV_FILE${NC}"
            echo -e "${GREEN}$(wc -l < "$CSV_FILE") lines written.${NC}\n"
        fi
        sleep 2
    fi
}

save_to_csv() {
    if [ "$CSV_MODE" = "ON" ]; then
        local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        local target="$1"
        local scan_type="$2"
        local ip="$3"
        local port="${4:-N/A}"
        local protocol="${5:-N/A}"
        local state="${6:-N/A}"
        local service="${7:-N/A}"
        local version="${8:-N/A}"
        local hostname="${9:-N/A}"
        local latency="${10:-N/A}"
        local additional="${11:-N/A}"
        
        # Clean fields (remove commas and quotes)
        ip=$(echo "$ip" | tr -d ',')
        service=$(echo "$service" | tr -d ',')
        version=$(echo "$version" | tr -d ',' | tr -d '"')
        hostname=$(echo "$hostname" | tr -d ',')
        additional=$(echo "$additional" | tr -d ',')
        
        # Append to CSV
        echo "$timestamp,$target,$scan_type,$ip,$port,$protocol,$state,$service,$version,$hostname,$latency,$additional" >> "$CSV_FILE"
    fi
}

parse_and_save_nmap_output() {
    if [ "$CSV_MODE" = "ON" ]; then
        local output="$1"
        local target="$2"
        local scan_type="$3"
        
        # Parse nmap output and extract information
        echo "$output" | grep -E "^[0-9]+/|Host is up|Nmap scan report" | while read -r line; do
            if [[ "$line" =~ "Nmap scan report for" ]]; then
                # Extract IP and hostname
                ip=$(echo "$line" | grep -oP '\d+\.\d+\.\d+\.\d+' | head -1)
                hostname=$(echo "$line" | sed 's/Nmap scan report for //' | sed 's/ (.*)//')
                if [ -z "$ip" ]; then
                    ip="$hostname"
                    hostname="N/A"
                fi
                current_ip="$ip"
                current_hostname="$hostname"
            elif [[ "$line" =~ "Host is up" ]]; then
                # Extract latency
                latency=$(echo "$line" | grep -oP '\d+\.\d+s' | sed 's/s/000/' | head -1)
                if [ -z "$latency" ]; then
                    latency=$(echo "$line" | grep -oP '\(.*?\)' | tr -d '()' | head -1)
                fi
                save_to_csv "$target" "$scan_type" "${current_ip:-N/A}" "N/A" "N/A" "up" "N/A" "N/A" "${current_hostname:-N/A}" "${latency:-N/A}" "Host_Discovery"
            elif [[ "$line" =~ ^[0-9]+/ ]]; then
                # Parse port line
                port=$(echo "$line" | awk '{print $1}' | cut -d'/' -f1)
                protocol=$(echo "$line" | awk '{print $1}' | cut -d'/' -f2)
                state=$(echo "$line" | awk '{print $2}')
                service=$(echo "$line" | awk '{print $3}')
                version=$(echo "$line" | cut -d' ' -f4-)
                
                save_to_csv "$target" "$scan_type" "${current_ip:-$target}" "$port" "$protocol" "$state" "$service" "$version" "${current_hostname:-N/A}" "N/A" "Port_Scan"
            fi
        done
    fi
}

view_csv_files() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ CSV Export Files ═══${NC}\n"
    
    if [ ! -d "$OUTPUT_DIR" ] || [ -z "$(ls -A $OUTPUT_DIR/*.csv 2>/dev/null)" ]; then
        echo -e "${YELLOW}No CSV files found.${NC}"
        echo -e "${WHITE}Directory: $OUTPUT_DIR${NC}\n"
        echo -e "${CYAN}Enable CSV export and run scans to generate files.${NC}"
    else
        echo -e "${WHITE}Output directory: ${CYAN}$OUTPUT_DIR${NC}\n"
        echo -e "${BOLD}Available CSV files:${NC}\n"
        
        ls -lh "$OUTPUT_DIR"/*.csv 2>/dev/null | awk '{print $9, "(" $5 ")"}'  | nl -w2 -s'. '
        
        echo ""
        echo -e "${GREEN}[1]${NC} Open directory in file manager"
        echo -e "${GREEN}[2]${NC} View latest file"
        echo -e "${GREEN}[3]${NC} Delete all CSV files"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        
        read -p "Select option: " csv_option
        
        case $csv_option in
            1)
                if command -v xdg-open &> /dev/null; then
                    xdg-open "$OUTPUT_DIR" 2>/dev/null &
                elif command -v nautilus &> /dev/null; then
                    nautilus "$OUTPUT_DIR" 2>/dev/null &
                else
                    echo -e "${YELLOW}Opening: $OUTPUT_DIR${NC}"
                fi
                ;;
            2)
                latest=$(ls -t "$OUTPUT_DIR"/*.csv 2>/dev/null | head -1)
                if [ -f "$latest" ]; then
                    echo -e "\n${CYAN}Showing: $(basename $latest)${NC}\n"
                    head -20 "$latest"
                    echo -e "\n${WHITE}(Showing first 20 lines)${NC}"
                fi
                read -p "Press Enter to continue..."
                ;;
            3)
                read -p "Delete all CSV files? (y/n): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    rm -f "$OUTPUT_DIR"/*.csv
                    echo -e "${GREEN}All CSV files deleted.${NC}"
                    sleep 1
                fi
                ;;
        esac
    fi
}

################################################################################
# System Check Functions
################################################################################

check_requirements() {
    # Check if nmap is installed
    if ! command -v nmap &> /dev/null; then
        echo -e "${RED}Error: Nmap is not installed!${NC}"
        echo -e "${YELLOW}Install it with: sudo apt install nmap${NC}"
        exit 1
    fi
    
    # Check if running as root for certain features
    if [ "$EUID" -ne 0 ]; then
        echo -e "${YELLOW}Warning: Not running as root. Some scan types may not work.${NC}"
        echo -e "${YELLOW}Run with sudo for full functionality.${NC}\n"
        sleep 2
    fi
}

################################################################################
# Host Discovery Functions
################################################################################

show_host_discovery() {
    while true; do
        show_banner
        echo -e "${YELLOW}${BOLD}═══ Host Discovery Scans ═══${NC}\n"
        echo -e "${CYAN}Current Target: ${WHITE}$TARGET_IP${NC}\n"
        
        echo -e "${BOLD}${WHITE}Select a host discovery scan:${NC}\n"
        
        echo -e "${GREEN}[1]${NC} Ping Scan (ICMP Only)"
        echo -e "    ${CYAN}Command:${NC} nmap -sn -PE --send-ip <target>"
        echo -e "    ${WHITE}Description:${NC} ICMP echo only (no ARP), shows responding hosts"
        echo ""
        
        echo -e "${GREEN}[2]${NC} Default Discovery (Auto)"
        echo -e "    ${CYAN}Command:${NC} nmap -sn <target>"
        echo -e "    ${WHITE}Description:${NC} Smart discovery (ARP on local, ICMP remote)"
        echo -e "    ${YELLOW}Note: May show many hosts if on local network${NC}"
        echo ""
        
        echo -e "${GREEN}[3]${NC} ARP Scan (Local Network Only)"
        echo -e "    ${CYAN}Command:${NC} nmap -PR -sn <target>"
        echo -e "    ${WHITE}Description:${NC} Fast ARP discovery - finds ALL local devices"
        echo -e "    ${YELLOW}Note: Works only on same subnet, very reliable${NC}"
        echo ""
        
        echo -e "${GREEN}[4]${NC} TCP SYN Discovery"
        echo -e "    ${CYAN}Command:${NC} nmap -PS80,443,22 -sn <target>"
        echo -e "    ${WHITE}Description:${NC} TCP SYN ping to common ports (good for remote)"
        echo ""
        
        echo -e "${GREEN}[5]${NC} TCP ACK Discovery"
        echo -e "    ${CYAN}Command:${NC} nmap -PA80,443,3389 -sn <target>"
        echo -e "    ${WHITE}Description:${NC} TCP ACK ping to web/RDP ports (bypasses some firewalls)"
        echo ""
        
        echo -e "${GREEN}[6]${NC} UDP Discovery"
        echo -e "    ${CYAN}Command:${NC} nmap -PU53,161 -sn <target>"
        echo -e "    ${WHITE}Description:${NC} UDP ping to DNS/SNMP (when TCP is filtered)"
        echo ""
        
        echo -e "${GREEN}[7]${NC} Aggressive Discovery"
        echo -e "    ${CYAN}Command:${NC} nmap -sn -PE -PS80,443 -PA3389 -PU40125 <target>"
        echo -e "    ${WHITE}Description:${NC} Multiple discovery techniques combined"
        echo ""
        
        echo -e "${GREEN}[8]${NC} List Scan (No Ping)"
        echo -e "    ${CYAN}Command:${NC} nmap -sL <target>"
        echo -e "    ${WHITE}Description:${NC} List targets without scanning"
        echo ""
        
        echo -e "${GREEN}[9]${NC} No Ping + Port Scan"
        echo -e "    ${CYAN}Command:${NC} nmap -Pn -F <target>"
        echo -e "    ${WHITE}Description:${NC} ${RED}⚠️  Assumes ALL hosts online, scans ports${NC}"
        echo -e "    ${YELLOW}Note: Use only when hosts block ping but are online${NC}"
        echo ""
        
        echo -e "${GREEN}[10]${NC} Fast Network Sweep"
        echo -e "    ${CYAN}Command:${NC} nmap -sn -T4 <target>"
        echo -e "    ${WHITE}Description:${NC} Quick discovery with aggressive timing"
        echo ""
        
        echo -e "${MAGENTA}[11]${NC} Alternative Tools (arp-scan, netdiscover, fping)"
        echo -e "    ${WHITE}Description:${NC} Use other discovery tools if nmap is blocked"
        echo ""
        
        echo -e "${CYAN}[12]${NC} Change Target (For subnet/range)"
        echo -e "${RED}[0]${NC} Back to Main Menu"
        echo ""
        
        echo -e "${YELLOW}💡 TIP: If seeing all hosts as 'up', your router may be:"
        echo -e "   • Blocking ICMP (ping) requests"
        echo -e "   • Try option [11] for alternative tools"
        echo -e "   • Or use [3] ARP Scan for reliable local discovery${NC}"
        echo ""
        
        read -p "Select scan [0-12]: " scan_choice
        
        case $scan_choice in
            1) 
                echo -e "${YELLOW}Note: If all hosts show as 'up', your router may block ICMP.${NC}"
                echo -e "${YELLOW}Try option [11] for alternative tools or [3] for ARP scan.${NC}"
                sleep 2
                execute_discovery_scan "nmap -sn -PE --send-ip" 
                ;;
            2) execute_discovery_scan "nmap -sn" ;;
            3) execute_discovery_scan "nmap -PR -sn" ;;
            4) execute_discovery_scan "nmap -PS80,443,22 -sn" ;;
            5) execute_discovery_scan "nmap -PA80,443,3389 -sn" ;;
            6) execute_discovery_scan "nmap -PU53,161 -sn" ;;
            7) execute_discovery_scan "nmap -sn -PE -PS80,443 -PA3389 -PU40125" ;;
            8) execute_discovery_scan "nmap -sL" ;;
            9) 
                echo -e "${RED}⚠️  WARNING: This will assume ALL IPs in range are online!${NC}"
                echo -e "${YELLOW}This is NOT a discovery scan - it skips ping checks.${NC}"
                read -p "Continue anyway? (y/n): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    execute_discovery_scan "nmap -Pn -F"
                fi
                ;;
            10) execute_discovery_scan "nmap -sn -T4" ;;
            11) show_alternative_tools ;;
            12) get_target_input ;;
            0) return ;;
            *) 
                echo -e "${RED}Invalid option!${NC}"
                sleep 1
                ;;
        esac
    done
}

show_alternative_tools() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Alternative Discovery Tools ═══${NC}\n"
    echo -e "${CYAN}Current Target: ${WHITE}$TARGET_IP${NC}\n"
    
    echo -e "${WHITE}These tools can find hosts when nmap is blocked or gives false results:${NC}\n"
    
    echo -e "${GREEN}[1]${NC} arp-scan (Local Network)"
    echo -e "    ${CYAN}Command:${NC} sudo arp-scan -l"
    echo -e "    ${WHITE}Best for:${NC} Fast, reliable local network discovery"
    echo -e "    ${WHITE}Finds:${NC} ALL devices on local subnet (bypasses firewall)"
    echo ""
    
    echo -e "${GREEN}[2]${NC} netdiscover (Interactive)"
    echo -e "    ${CYAN}Command:${NC} sudo netdiscover -r <target>"
    echo -e "    ${WHITE}Best for:${NC} Real-time discovery with live updates"
    echo -e "    ${WHITE}Finds:${NC} Devices on local network with MAC addresses"
    echo ""
    
    echo -e "${GREEN}[3]${NC} fping (Fast Ping with Details)"
    echo -e "    ${CYAN}Command:${NC} fping -a -g <target> + enhanced output"
    echo -e "    ${WHITE}Best for:${NC} Quick ICMP sweep with latency & hostnames"
    echo -e "    ${WHITE}Shows:${NC} IP, latency, hostname for each live host"
    echo ""
    
    echo -e "${GREEN}[4]${NC} masscan (Ultra Fast)"
    echo -e "    ${CYAN}Command:${NC} sudo masscan <target> -p80,443,22 --rate 1000"
    echo -e "    ${WHITE}Best for:${NC} Extremely fast port-based discovery"
    echo -e "    ${WHITE}Finds:${NC} Hosts with specific ports open"
    echo ""
    
    echo -e "${GREEN}[5]${NC} ping (Manual Check)"
    echo -e "    ${CYAN}Command:${NC} ping -c 4 <single-ip>"
    echo -e "    ${WHITE}Best for:${NC} Testing single host connectivity"
    echo -e "    ${WHITE}Finds:${NC} If specific IP responds to ICMP"
    echo ""
    
    echo -e "${RED}[0]${NC} Back to Discovery Menu"
    echo ""
    
    read -p "Select tool [0-5]: " tool_choice
    
    case $tool_choice in
        1)
            if command -v arp-scan &> /dev/null; then
                echo -e "\n${YELLOW}Running arp-scan...${NC}\n"
                sudo arp-scan -l
                echo -e "\n${GREEN}Scan completed!${NC}"
            else
                echo -e "\n${RED}arp-scan not installed!${NC}"
                echo -e "${YELLOW}Install with: sudo apt install arp-scan${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        2)
            if command -v netdiscover &> /dev/null; then
                echo -e "\n${YELLOW}Starting netdiscover (Press Ctrl+C to stop)...${NC}\n"
                echo -e "${CYAN}Command: sudo netdiscover -r $TARGET_IP${NC}\n"
                sleep 2
                sudo netdiscover -r "$TARGET_IP"
            else
                echo -e "\n${RED}netdiscover not installed!${NC}"
                echo -e "${YELLOW}Install with: sudo apt install netdiscover${NC}"
                read -p "Press Enter to continue..."
            fi
            ;;
        3)
            if command -v fping &> /dev/null; then
                echo -e "\n${YELLOW}${BOLD}═══ Enhanced fping Discovery ═══${NC}\n"
                
                # Run fping and save results
                echo -e "${CYAN}Step 1: Finding live hosts...${NC}\n"
                echo -e "${WHITE}Command: fping -a -g $TARGET_IP 2>/dev/null${NC}\n"
                
                LIVE_HOSTS=$(fping -a -g "$TARGET_IP" 2>/dev/null)
                
                if [ -z "$LIVE_HOSTS" ]; then
                    echo -e "${RED}No hosts responded to ping!${NC}"
                    echo -e "${YELLOW}This might mean:${NC}"
                    echo "  • Hosts are down"
                    echo "  • Firewall blocks ICMP"
                    echo "  • Try option [1] arp-scan instead"
                else
                    HOST_COUNT=$(echo "$LIVE_HOSTS" | wc -l)
                    echo -e "${GREEN}✓ Found $HOST_COUNT live host(s)!${NC}\n"
                    
                    # Display results with details
                    echo -e "${YELLOW}${BOLD}═══ Detailed Results ═══${NC}\n"
                    echo -e "${WHITE}${BOLD}IP Address       Latency    Hostname${NC}"
                    echo -e "${WHITE}──────────────────────────────────────────────${NC}"
                    
                    # Process each host
                    echo "$LIVE_HOSTS" | while read -r ip; do
                        # Get latency with fping
                        latency=$(fping -c 1 -q "$ip" 2>&1 | grep -oP '\d+\.\d+/\d+\.\d+/\d+\.\d+' | cut -d'/' -f2)
                        
                        # Try to resolve hostname
                        if command -v host &> /dev/null; then
                            hostname=$(host "$ip" 2>/dev/null | grep "domain name pointer" | awk '{print $NF}' | sed 's/\.$//')
                            if [ -z "$hostname" ]; then
                                hostname="${CYAN}(no hostname)${NC}"
                            else
                                hostname="${GREEN}$hostname${NC}"
                            fi
                        else
                            hostname="${CYAN}(host tool not available)${NC}"
                        fi
                        
                        # Display formatted
                        if [ ! -z "$latency" ]; then
                            printf "${WHITE}%-16s ${YELLOW}%-10s ${NC}%b\n" "$ip" "${latency}ms" "$hostname"
                        else
                            printf "${WHITE}%-16s ${YELLOW}%-10s ${NC}%b\n" "$ip" "N/A" "$hostname"
                        fi
                    done
                    
                    echo ""
                    echo -e "${GREEN}${BOLD}═══ Summary ═══${NC}"
                    echo -e "${WHITE}Total hosts discovered: ${GREEN}$HOST_COUNT${NC}"
                    echo -e "${WHITE}Target range: ${CYAN}$TARGET_IP${NC}"
                    
                    # Additional info
                    echo ""
                    echo -e "${YELLOW}💡 TIP: You can now scan these IPs individually:${NC}"
                    echo -e "${WHITE}   • Return to main menu [0]${NC}"
                    echo -e "${WHITE}   • Select [1] Standard Scans${NC}"
                    echo -e "${WHITE}   • Use [7] Change Target to scan specific IP${NC}"
                fi
                
                echo -e "\n${GREEN}Scan completed!${NC}"
            else
                echo -e "\n${RED}fping not installed!${NC}"
                echo -e "${YELLOW}Install with: sudo apt install fping${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        4)
            if command -v masscan &> /dev/null; then
                echo -e "\n${YELLOW}Running masscan (requires root)...${NC}\n"
                echo -e "${CYAN}Command: sudo masscan $TARGET_IP -p80,443,22 --rate 1000${NC}\n"
                sleep 1
                sudo masscan "$TARGET_IP" -p80,443,22 --rate 1000
                echo -e "\n${GREEN}Scan completed!${NC}"
            else
                echo -e "\n${RED}masscan not installed!${NC}"
                echo -e "${YELLOW}Install with: sudo apt install masscan${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        5)
            echo -e "\n${CYAN}Enter single IP to ping:${NC}"
            read -p "> " ping_target
            if [ ! -z "$ping_target" ]; then
                echo -e "\n${YELLOW}Pinging $ping_target...${NC}\n"
                ping -c 4 "$ping_target"
                echo -e "\n${GREEN}Ping completed!${NC}"
            else
                echo -e "${RED}No IP provided!${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        0) return ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            sleep 1
            show_alternative_tools
            ;;
    esac
    
    show_alternative_tools  # Loop back to menu
}

execute_discovery_scan() {
    local base_cmd="$1"
    local full_cmd="$base_cmd $TARGET_IP"
    
    echo ""
    echo -e "${YELLOW}Executing:${NC} ${WHITE}$full_cmd${NC}\n"
    if [ "$CSV_MODE" = "ON" ]; then
        echo -e "${GREEN} CSV Export enabled - results will be saved${NC}\n"
    fi
    sleep 1
    
    # Capture output
    scan_output=$(eval "$full_cmd" 2>&1 | tee /dev/tty)
    
    # Save to CSV if enabled
    if [ "$CSV_MODE" = "ON" ]; then
        parse_and_save_nmap_output "$scan_output" "$TARGET_IP" "Discovery_Scan"
        echo -e "\n${GREEN}✓ Results saved to CSV: $CSV_FILE${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}Scan completed!${NC}"
    read -p "Press Enter to continue..."
}

################################################################################
# NSE Scripts Guide
################################################################################

show_nse_scripts_guide() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Nmap Scripting Engine (NSE) Guide ═══${NC}\n"
    echo -e "${CYAN}NSE allows you to write and run custom scripts for advanced scanning.${NC}\n"
    
    echo -e "${WHITE}[1]${NC} What are NSE Scripts?"
    echo -e "${WHITE}[2]${NC} How to Find NSE Scripts"
    echo -e "${WHITE}[3]${NC} How to Use NSE Scripts"
    echo -e "${WHITE}[4]${NC} Built-in Script Examples"
    echo -e "${WHITE}[5]${NC} How to Write Your Own Scripts"
    echo -e "${WHITE}[6]${NC} Useful Script Resources"
    echo -e "${RED}[0]${NC} Back to Main Menu"
    echo ""
    
    read -p "Select option: " nse_choice
    
    case $nse_choice in
        1) show_nse_what ;;
        2) show_nse_find ;;
        3) show_nse_use ;;
        4) show_nse_examples ;;
        5) show_nse_write ;;
        6) show_nse_resources ;;
        0) return ;;
        *) 
            echo -e "${RED}Invalid option!${NC}"
            sleep 1
            show_nse_scripts_guide
            ;;
    esac
    
    show_nse_scripts_guide  # Loop back to menu
}

show_nse_what() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ What are NSE Scripts? ═══${NC}\n"
    
    (
    echo -e "${CYAN}${BOLD}Nmap Scripting Engine (NSE)${NC}"
    echo "NSE is one of Nmap's most powerful features. It allows users to write"
    echo "and share scripts that automate various networking tasks."
    echo ""
    
    echo -e "${GREEN}${BOLD}What can NSE scripts do?${NC}"
    echo "  • Advanced version detection"
    echo "  • Vulnerability detection and exploitation"
    echo "  • Backdoor detection"
    echo "  • Brute force authentication"
    echo "  • Network discovery"
    echo "  • Malware detection"
    echo "  • And much more!"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Script Categories:${NC}"
    echo "  ${WHITE}auth${NC}       - Authentication testing"
    echo "  ${WHITE}broadcast${NC}   - Network broadcast discovery"
    echo "  ${WHITE}brute${NC}       - Brute force attacks"
    echo "  ${WHITE}default${NC}     - Safe, informative scripts"
    echo "  ${WHITE}discovery${NC}   - Host and service discovery"
    echo "  ${WHITE}dos${NC}         - Denial of Service testing"
    echo "  ${WHITE}exploit${NC}     - Exploitation attempts"
    echo "  ${WHITE}external${NC}    - Use external resources"
    echo "  ${WHITE}fuzzer${NC}      - Fuzzing tests"
    echo "  ${WHITE}intrusive${NC}   - Intrusive tests (may crash services)"
    echo "  ${WHITE}malware${NC}     - Malware detection"
    echo "  ${WHITE}safe${NC}        - Won't crash services"
    echo "  ${WHITE}version${NC}     - Advanced version detection"
    echo "  ${WHITE}vuln${NC}        - Vulnerability checks"
    echo ""
    
    echo -e "${BLUE}${BOLD}NSE is written in Lua${NC}"
    echo "Scripts are written in Lua programming language, making them easy to"
    echo "create, modify, and share. You don't need to be a programming expert!"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

show_nse_find() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ How to Find NSE Scripts ═══${NC}\n"
    
    (
    echo -e "${GREEN}${BOLD}1. Local Script Directory${NC}"
    echo "All NSE scripts are stored in:"
    echo -e "${CYAN}/usr/share/nmap/scripts/${NC}"
    echo ""
    echo "List all scripts:"
    echo -e "${WHITE}ls /usr/share/nmap/scripts/${NC}"
    echo ""
    echo "Search for specific scripts:"
    echo -e "${WHITE}ls /usr/share/nmap/scripts/ | grep http${NC}"
    echo -e "${WHITE}ls /usr/share/nmap/scripts/ | grep vuln${NC}"
    echo ""
    
    echo -e "${GREEN}${BOLD}2. Using nmap --script-help${NC}"
    echo "Get information about scripts:"
    echo -e "${WHITE}nmap --script-help http*${NC}          # All HTTP scripts"
    echo -e "${WHITE}nmap --script-help vuln*${NC}          # All vulnerability scripts"
    echo -e "${WHITE}nmap --script-help discovery*${NC}     # All discovery scripts"
    echo ""
    
    echo -e "${GREEN}${BOLD}3. Online Resources${NC}"
    echo "• Official Nmap NSE Documentation:"
    echo -e "  ${CYAN}https://nmap.org/nsedoc/${NC}"
    echo ""
    echo "• NSE Script Database:"
    echo -e "  ${CYAN}https://nmap.org/book/nse-usage.html${NC}"
    echo ""
    echo "• GitHub Repositories:"
    echo -e "  ${CYAN}https://github.com/nmap/nmap/tree/master/scripts${NC}"
    echo ""
    
    echo -e "${GREEN}${BOLD}4. Update Script Database${NC}"
    echo "After adding new scripts, update the database:"
    echo -e "${WHITE}sudo nmap --script-updatedb${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Popular Script Searches:${NC}"
    echo -e "${WHITE}nmap --script-help all | grep -i ssh${NC}"
    echo -e "${WHITE}nmap --script-help all | grep -i ftp${NC}"
    echo -e "${WHITE}nmap --script-help all | grep -i mysql${NC}"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

show_nse_use() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ How to Use NSE Scripts ═══${NC}\n"
    
    (
    echo -e "${GREEN}${BOLD}Basic Usage:${NC}"
    echo -e "${WHITE}nmap --script <script-name> <target>${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Examples:${NC}"
    echo ""
    echo -e "${CYAN}1. Run a single script:${NC}"
    echo -e "${WHITE}nmap --script http-title 192.168.1.1${NC}"
    echo "   Gets the HTTP page title"
    echo ""
    
    echo -e "${CYAN}2. Run multiple scripts:${NC}"
    echo -e "${WHITE}nmap --script http-title,http-headers 192.168.1.1${NC}"
    echo "   Runs both HTTP scripts"
    echo ""
    
    echo -e "${CYAN}3. Run all scripts in a category:${NC}"
    echo -e "${WHITE}nmap --script vuln 192.168.1.1${NC}"
    echo "   Runs all vulnerability detection scripts"
    echo ""
    
    echo -e "${CYAN}4. Run default safe scripts:${NC}"
    echo -e "${WHITE}nmap -sC 192.168.1.1${NC}"
    echo "   Same as --script=default"
    echo ""
    
    echo -e "${CYAN}5. Run scripts with wildcards:${NC}"
    echo -e "${WHITE}nmap --script \"http-*\" 192.168.1.1${NC}"
    echo "   Runs all HTTP-related scripts"
    echo ""
    
    echo -e "${CYAN}6. Exclude certain scripts:${NC}"
    echo -e "${WHITE}nmap --script \"http-* and not http-brute\" 192.168.1.1${NC}"
    echo "   Runs HTTP scripts except brute force"
    echo ""
    
    echo -e "${GREEN}${BOLD}Script Arguments:${NC}"
    echo "Many scripts accept arguments with --script-args:"
    echo ""
    echo -e "${WHITE}nmap --script http-form-brute --script-args \\\\${NC}"
    echo -e "${WHITE}  ${CYAN}userdb=users.txt,passdb=pass.txt${WHITE} 192.168.1.1${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Get Script Help:${NC}"
    echo -e "${WHITE}nmap --script-help http-sql-injection${NC}"
    echo "Shows detailed information about the script and its arguments"
    echo ""
    
    echo -e "${RED}${BOLD}Important Tips:${NC}"
    echo "• Always test scripts in a safe environment first"
    echo "• Some scripts are intrusive and may crash services"
    echo "• Exploit scripts should only be used with authorization"
    echo "• Use -v or -vv for verbose output to see what scripts are doing"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

show_nse_examples() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Built-in Script Examples ═══${NC}\n"
    
    (
    echo -e "${RED}${BOLD}VULNERABILITY DETECTION:${NC}"
    echo -e "${CYAN}HTTP Vulnerabilities:${NC}"
    echo -e "${WHITE}nmap -p 80,443 --script http-vuln-* <target>${NC}"
    echo "   Checks for common HTTP vulnerabilities"
    echo ""
    
    echo -e "${CYAN}SMB Vulnerabilities (EternalBlue, etc.):${NC}"
    echo -e "${WHITE}nmap -p 445 --script smb-vuln-* <target>${NC}"
    echo "   Checks for SMB vulnerabilities including MS17-010"
    echo ""
    
    echo -e "${CYAN}SSL/TLS Vulnerabilities:${NC}"
    echo -e "${WHITE}nmap -p 443 --script ssl-heartbleed,ssl-poodle <target>${NC}"
    echo "   Checks for Heartbleed and POODLE vulnerabilities"
    echo ""
    
    echo -e "${YELLOW}${BOLD}INFORMATION GATHERING:${NC}"
    echo -e "${CYAN}HTTP Information:${NC}"
    echo -e "${WHITE}nmap -p 80 --script http-title,http-headers,http-enum <target>${NC}"
    echo "   Gets page title, headers, and enumerates directories"
    echo ""
    
    echo -e "${CYAN}DNS Information:${NC}"
    echo -e "${WHITE}nmap -p 53 --script dns-brute <target>${NC}"
    echo "   Attempts DNS subdomain brute forcing"
    echo ""
    
    echo -e "${CYAN}SMB Share Enumeration:${NC}"
    echo -e "${WHITE}nmap -p 445 --script smb-enum-shares,smb-enum-users <target>${NC}"
    echo "   Lists SMB shares and users"
    echo ""
    
    echo -e "${GREEN}${BOLD}AUTHENTICATION TESTING:${NC}"
    echo -e "${CYAN}Default Credentials:${NC}"
    echo -e "${WHITE}nmap -p 22 --script ssh-auth-methods <target>${NC}"
    echo "   Checks SSH authentication methods"
    echo ""
    
    echo -e "${CYAN}FTP Anonymous Login:${NC}"
    echo -e "${WHITE}nmap -p 21 --script ftp-anon <target>${NC}"
    echo "   Checks if anonymous FTP login is allowed"
    echo ""
    
    echo -e "${BLUE}${BOLD}WEB APPLICATION TESTING:${NC}"
    echo -e "${CYAN}SQL Injection:${NC}"
    echo -e "${WHITE}nmap -p 80 --script http-sql-injection <target>${NC}"
    echo "   Tests for SQL injection vulnerabilities"
    echo ""
    
    echo -e "${CYAN}WordPress Scanning:${NC}"
    echo -e "${WHITE}nmap -p 80 --script http-wordpress-* <target>${NC}"
    echo "   Comprehensive WordPress security scan"
    echo ""
    
    echo -e "${WHITE}${BOLD}NETWORK DISCOVERY:${NC}"
    echo -e "${CYAN}Broadcast Scripts (discover local network):${NC}"
    echo -e "${WHITE}nmap --script broadcast-dhcp-discover${NC}"
    echo "   Discovers DHCP servers on local network"
    echo ""
    
    echo -e "${WHITE}nmap --script broadcast-dns-service-discovery${NC}"
    echo "   Discovers DNS-SD services"
    echo ""
    
    echo -e "${MAGENTA}${BOLD}MALWARE DETECTION:${NC}"
    echo -e "${CYAN}Backdoor Detection:${NC}"
    echo -e "${WHITE}nmap -p 0-65535 --script backdoor <target>${NC}"
    echo "   Checks for known backdoors"
    echo ""
    
    echo -e "${RED}${BOLD}EXPLOITATION (Use with caution!):${NC}"
    echo -e "${CYAN}SMB MS08-067:${NC}"
    echo -e "${WHITE}nmap -p 445 --script smb-vuln-ms08-067 <target>${NC}"
    echo "   Checks for MS08-067 vulnerability"
    echo ""
    
    echo -e "${YELLOW}${BOLD}COMBINED EXAMPLES:${NC}"
    echo -e "${CYAN}Complete Web Server Scan:${NC}"
    echo -e "${WHITE}nmap -p 80,443 -sV --script \"http-* and not http-brute\" <target>${NC}"
    echo ""
    
    echo -e "${CYAN}Complete SMB Security Audit:${NC}"
    echo -e "${WHITE}nmap -p 445 -sV --script \"smb-* and not smb-brute\" <target>${NC}"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

show_nse_write() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ How to Write Your Own NSE Scripts ═══${NC}\n"
    
    (
    echo -e "${GREEN}${BOLD}NSE Script Structure:${NC}"
    echo "NSE scripts are written in Lua and have a specific structure:"
    echo ""
    
    echo -e "${CYAN}${BOLD}Basic Template:${NC}"
    echo -e "${WHITE}-----------------------------------------------------------${NC}"
    cat << 'TEMPLATE'
-- Script metadata
description = [[
  Description of what your script does
]]

author = "Your Name"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery", "safe"}

-- Required libraries
local shortport = require "shortport"
local http = require "http"
local stdnse = require "stdnse"

-- Port rule (when to run the script)
portrule = shortport.http

-- Main action function
action = function(host, port)
  local path = "/"
  local response = http.get(host, port, path)
  
  if response.status == 200 then
    return "Server is reachable"
  end
  
  return "No response"
end
TEMPLATE
    echo -e "${WHITE}-----------------------------------------------------------${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}Key Components:${NC}"
    echo ""
    echo -e "${GREEN}1. Metadata Section:${NC}"
    echo "   - description: What the script does"
    echo "   - author: Your name"
    echo "   - license: Usually same as Nmap"
    echo "   - categories: Script categories (safe, intrusive, vuln, etc.)"
    echo ""
    
    echo -e "${GREEN}2. Libraries:${NC}"
    echo "   Common NSE libraries:"
    echo "   - ${WHITE}shortport${NC}: Port matching rules"
    echo "   - ${WHITE}http${NC}: HTTP requests"
    echo "   - ${WHITE}stdnse${NC}: Standard NSE functions"
    echo "   - ${WHITE}nmap${NC}: Nmap library functions"
    echo "   - ${WHITE}string${NC}: String manipulation"
    echo ""
    
    echo -e "${GREEN}3. Rules:${NC}"
    echo "   Determine when the script runs:"
    echo "   - ${WHITE}portrule${NC}: Run on specific ports"
    echo "   - ${WHITE}hostrule${NC}: Run once per host"
    echo "   - ${WHITE}prerule${NC}: Run before scan"
    echo "   - ${WHITE}postrule${NC}: Run after scan"
    echo ""
    
    echo -e "${GREEN}4. Action Function:${NC}"
    echo "   The main script logic that gets executed"
    echo ""
    
    echo -e "${CYAN}${BOLD}Example: Simple HTTP Title Grabber${NC}"
    echo -e "${WHITE}-----------------------------------------------------------${NC}"
    cat << 'EXAMPLE'
description = [[
  Retrieves the title from HTTP responses
]]

author = "Dhype7"
categories = {"discovery", "safe"}

local shortport = require "shortport"
local http = require "http"

portrule = shortport.http

action = function(host, port)
  local response = http.get(host, port, "/")
  
  if response and response.body then
    local title = response.body:match("<title>(.-)</title>")
    if title then
      return string.format("Title: %s", title)
    end
  end
  
  return "Could not retrieve title"
end
EXAMPLE
    echo -e "${WHITE}-----------------------------------------------------------${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}How to Use Your Script:${NC}"
    echo ""
    echo -e "${CYAN}1. Save the script:${NC}"
    echo -e "${WHITE}Save as: /usr/share/nmap/scripts/your-script-name.nse${NC}"
    echo ""
    
    echo -e "${CYAN}2. Update script database:${NC}"
    echo -e "${WHITE}sudo nmap --script-updatedb${NC}"
    echo ""
    
    echo -e "${CYAN}3. Test your script:${NC}"
    echo -e "${WHITE}nmap --script your-script-name <target>${NC}"
    echo ""
    
    echo -e "${GREEN}${BOLD}Learning Resources:${NC}"
    echo "• NSE Script Development:"
    echo -e "  ${CYAN}https://nmap.org/book/nse-tutorial.html${NC}"
    echo ""
    echo "• Lua Programming:"
    echo -e "  ${CYAN}https://www.lua.org/manual/5.3/${NC}"
    echo ""
    echo "• Example Scripts:"
    echo -e "  ${CYAN}/usr/share/nmap/scripts/${NC}"
    echo "  Study existing scripts to learn best practices"
    echo ""
    
    echo -e "${BLUE}${BOLD}Tips for Script Development:${NC}"
    echo "• Start by modifying existing scripts"
    echo "• Test on safe, controlled targets"
    echo "• Add verbose output with stdnse.debug()"
    echo "• Handle errors gracefully"
    echo "• Follow Nmap's coding style"
    echo "• Document your script well"
    echo "• Share useful scripts with the community!"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

show_nse_resources() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Useful NSE Script Resources ═══${NC}\n"
    
    (
    echo -e "${RED}${BOLD}OFFICIAL DOCUMENTATION:${NC}"
    echo ""
    echo -e "${CYAN}Nmap NSE Documentation:${NC}"
    echo -e "  ${WHITE}https://nmap.org/book/nse.html${NC}"
    echo "  Comprehensive NSE guide"
    echo ""
    
    echo -e "${CYAN}NSE Script Documentation:${NC}"
    echo -e "  ${WHITE}https://nmap.org/nsedoc/${NC}"
    echo "  All scripts with detailed descriptions"
    echo ""
    
    echo -e "${CYAN}NSE Library Documentation:${NC}"
    echo -e "  ${WHITE}https://nmap.org/nsedoc/lib/${NC}"
    echo "  NSE library reference"
    echo ""
    
    echo -e "${YELLOW}${BOLD}GITHUB REPOSITORIES:${NC}"
    echo ""
    echo -e "${CYAN}Official Nmap Scripts:${NC}"
    echo -e "  ${WHITE}https://github.com/nmap/nmap/tree/master/scripts${NC}"
    echo "  600+ official NSE scripts"
    echo ""
    
    echo -e "${CYAN}NSE Extra Scripts:${NC}"
    echo -e "  ${WHITE}https://github.com/vulnersCom/nmap-vulners${NC}"
    echo "  Additional vulnerability detection scripts"
    echo ""
    
    echo -e "${CYAN}Vulscan:${NC}"
    echo -e "  ${WHITE}https://github.com/scipag/vulscan${NC}"
    echo "  Advanced vulnerability scanning"
    echo ""
    
    echo -e "${GREEN}${BOLD}TUTORIALS & GUIDES:${NC}"
    echo ""
    echo -e "${CYAN}NSE Tutorial:${NC}"
    echo -e "  ${WHITE}https://nmap.org/book/nse-tutorial.html${NC}"
    echo "  Step-by-step script writing tutorial"
    echo ""
    
    echo -e "${CYAN}Lua Quick Reference:${NC}"
    echo -e "  ${WHITE}https://www.lua.org/manual/5.3/manual.html${NC}"
    echo "  Lua programming language reference"
    echo ""
    
    echo -e "${BLUE}${BOLD}USEFUL TOOLS:${NC}"
    echo ""
    echo -e "${CYAN}NSE Script Generator:${NC}"
    echo -e "  ${WHITE}https://www.nmap-online.com/nse-script-generator/${NC}"
    echo "  Online tool to generate script templates"
    echo ""
    
    echo -e "${CYAN}NSE Script Tester:${NC}"
    echo -e "  Use Nmap's built-in testing:"
    echo -e "  ${WHITE}nmap --script-trace --script <script> <target>${NC}"
    echo ""
    
    echo -e "${WHITE}${BOLD}COMMUNITY RESOURCES:${NC}"
    echo ""
    echo -e "${CYAN}Nmap Development Mailing List:${NC}"
    echo -e "  ${WHITE}https://seclists.org/nmap-dev/${NC}"
    echo "  Discuss script development"
    echo ""
    
    echo -e "${CYAN}Reddit r/nmap:${NC}"
    echo -e "  ${WHITE}https://www.reddit.com/r/nmap/${NC}"
    echo "  Community discussions"
    echo ""
    
    echo -e "${MAGENTA}${BOLD}🎓 VIDEO TUTORIALS:${NC}"
    echo ""
    echo -e "${CYAN}Search YouTube for:${NC}"
    echo "  • 'Nmap NSE scripting tutorial'"
    echo "  • 'Custom Nmap scripts'"
    echo "  • 'Lua programming for NSE'"
    echo ""
    
    echo -e "${RED}${BOLD}⚡ QUICK REFERENCE:${NC}"
    echo ""
    echo -e "${CYAN}Local Scripts Location:${NC}"
    echo -e "  ${WHITE}/usr/share/nmap/scripts/${NC}"
    echo ""
    
    echo -e "${CYAN}Script Database:${NC}"
    echo -e "  ${WHITE}/usr/share/nmap/scripts/script.db${NC}"
    echo ""
    
    echo -e "${CYAN}Update Database:${NC}"
    echo -e "  ${WHITE}sudo nmap --script-updatedb${NC}"
    echo ""
    
    echo -e "${CYAN}Get Script Help:${NC}"
    echo -e "  ${WHITE}nmap --script-help <script-name>${NC}"
    echo ""
    
    echo -e "${YELLOW}${BOLD}PRO TIPS:${NC}"
    echo "• Join the Nmap development community"
    echo "• Contribute your scripts to the official repository"
    echo "• Always test scripts in a safe lab environment"
    echo "• Keep your script database updated"
    echo "• Read existing scripts to learn techniques"
    echo "• Document your scripts thoroughly"
    echo ""
    echo -e "${YELLOW}TIP: Press ${WHITE}q${YELLOW} to exit this view${NC}"
    ) | less -R
    
    echo ""
    read -p "Press Enter to return to NSE menu..."
}

################################################################################
# Main Program Flow
################################################################################

main() {
    check_requirements
    
    # Get target configuration first
    get_target_input
    
    # Main menu loop
    while true; do
        show_banner
        echo -e "${CYAN}Target: ${WHITE}$TARGET_IP${NC}"
        if [ ! -z "$TARGET_PORT" ]; then
            echo -e "${CYAN}Port(s): ${WHITE}$TARGET_PORT${NC}"
        fi
        echo ""
        show_menu
        
        read -p "Enter your choice: " choice
        
        case $choice in
            1) show_standard_scans ;;
            2) show_host_discovery ;;
            3) show_custom_scan_builder ;;
            4) show_all_flag_descriptions ;;
            5) show_about ;;
            6) show_nse_scripts_guide ;;
            7) get_target_input ;;
            8) toggle_csv_mode ;;
            9) view_csv_files ;;
            0) 
                echo -e "\n${GREEN}Thank you for using Hymapper!${NC}"
                echo -e "${CYAN}Created by Dhype7${NC}\n"
                if [ "$CSV_MODE" = "ON" ] && [ -f "$CSV_FILE" ]; then
                    echo -e "${GREEN}CSV file saved: $CSV_FILE${NC}\n"
                fi
                echo -e "${YELLOW}Remember: Always scan responsibly and legally!${NC}\n"
                exit 0
                ;;
            *) 
                echo -e "${RED}Invalid option! Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Run the main program
main
