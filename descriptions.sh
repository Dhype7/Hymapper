# Comprehensive Flag Descriptions
# Complete guide to all Nmap flags

show_all_flag_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ All Flag Descriptions ═══${NC}\n"
    echo -e "${CYAN}This will display detailed descriptions for all available flags.${NC}\n"
    
    echo -e "${RED}${BOLD}Opening comprehensive flag guide...${NC}\n"
    
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════════════╗
║                        NMAP FLAGS COMPREHENSIVE GUIDE                      ║
╚═══════════════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────────────┐
│ SCAN TECHNIQUES                                                          │
└─────────────────────────────────────────────────────────────────────────┘
-sS : TCP SYN scan - The default and most popular. Stealthy and fast.
-sT : TCP Connect scan - Completes connections. No root needed.
-sU : UDP scan - Scans UDP ports. Slower but necessary for UDP services.
-sA : TCP ACK scan - Maps firewall rulesets.
-sW : TCP Window scan - Differentiates ports using TCP Window field.
-sN : TCP NULL scan - No flags set. Can evade some firewalls.
-sF : FIN scan - Only FIN flag set. Stealthy alternative.
-sX : Xmas scan - FIN, PSH, URG flags set. Named after lit-up Christmas tree.
-sn : Ping scan - Host discovery only. No port scanning.

┌─────────────────────────────────────────────────────────────────────────┐
│ PORT SPECIFICATION                                                       │
└─────────────────────────────────────────────────────────────────────────┘
-p- : Scan all 65535 ports
-p [ports] : Scan specific ports (e.g., -p 22,80,443 or -p 1-1000)
--top-ports [n] : Scan n most common ports
-F : Fast mode - Scan fewer ports than default
-r : Scan ports consecutively (don't randomize)

┌─────────────────────────────────────────────────────────────────────────┐
│ SERVICE/VERSION DETECTION                                                │
└─────────────────────────────────────────────────────────────────────────┘
-sV : Probe ports to determine service/version info
--version-intensity [0-9] : Set version detection intensity (0=light, 9=all)
--version-light : Limit to most likely probes (intensity 2)
--version-all : Try every single probe (intensity 9)

┌─────────────────────────────────────────────────────────────────────────┐
│ SCRIPT SCANNING (NSE - Nmap Scripting Engine)                           │
└─────────────────────────────────────────────────────────────────────────┘
-sC : Run default NSE scripts
--script=[script] : Run specific script(s)
--script=vuln : Check for vulnerabilities
--script=auth : Test authentication
--script=discovery : Advanced discovery
--script=exploit : Attempt exploitation (careful!)
--script=safe : Only safe scripts

┌─────────────────────────────────────────────────────────────────────────┐
│ OS DETECTION                                                             │
└─────────────────────────────────────────────────────────────────────────┘
-O : Enable OS detection
--osscan-guess : Guess OS more aggressively
--osscan-limit : Limit OS detection to promising targets
--traceroute : Trace hop path to each host

┌─────────────────────────────────────────────────────────────────────────┐
│ TIMING AND PERFORMANCE                                                   │
└─────────────────────────────────────────────────────────────────────────┘
-T0 : Paranoid - Very slow, IDS evasion
-T1 : Sneaky - Slow, IDS evasion
-T2 : Polite - Slower, less bandwidth
-T3 : Normal - Default timing
-T4 : Aggressive - Fast, assumes good network
-T5 : Insane - Very fast, may sacrifice accuracy

--min-rate [n] : Send packets no slower than [n] per second
--max-rate [n] : Send packets no faster than [n] per second

┌─────────────────────────────────────────────────────────────────────────┐
│ FIREWALL/IDS EVASION                                                     │
└─────────────────────────────────────────────────────────────────────────┘
-f : Fragment packets
--mtu [n] : Use specified MTU
-D [decoy1,decoy2] : Cloak scan with decoys
-S [IP] : Spoof source address
--source-port [port] : Use given port number
--data-length [n] : Append random data to packets
--randomize-hosts : Randomize target host order
--badsum : Send packets with bad checksums

┌─────────────────────────────────────────────────────────────────────────┐
│ OUTPUT OPTIONS                                                           │
└─────────────────────────────────────────────────────────────────────────┘
-oN [file] : Normal output to file
-oX [file] : XML output to file
-oG [file] : Grepable output to file
-oA [basename] : Output in all formats
-v : Increase verbosity level
-vv : Very verbose
--reason : Display reason port is in particular state
--open : Only show open (or possibly open) ports
--packet-trace : Show all packets sent and received

┌─────────────────────────────────────────────────────────────────────────┐
│ MISCELLANEOUS                                                            │
└─────────────────────────────────────────────────────────────────────────┘
-A : Aggressive scan (OS, version, scripts, traceroute)
-6 : Enable IPv6 scanning
-n : No DNS resolution
-R : Always resolve DNS
--dns-servers [servers] : Use specified DNS servers
--system-dns : Use OS's DNS resolver
--exclude [hosts] : Exclude hosts from scan
--excludefile [file] : Exclude list from file

╔═══════════════════════════════════════════════════════════════════════════╗
║ COMMON SCAN COMBINATIONS                                                  ║
╚═══════════════════════════════════════════════════════════════════════════╝

Quick Scan:        nmap -T4 -F [target]
Standard Scan:     nmap [target]
Intense Scan:      nmap -A -T4 [target]
Stealth Scan:      nmap -sS -sV -O [target]
Vulnerability:     nmap -sV --script vuln [target]
All Ports:         nmap -p- [target]

╔═══════════════════════════════════════════════════════════════════════════╗
║ LEARNING TIPS FOR BEGINNERS                                               ║
╚═══════════════════════════════════════════════════════════════════════════╝

1. Always start with basic scans before moving to advanced options
2. Use -T4 for faster scans on reliable networks
3. Combine -sV with scans to identify service versions
4. Use -sC for safe, informative script scanning
5. Remember: Some scans require root/sudo privileges
6. Save important scan results with -oA option
7. Use --open to filter out closed ports from results
8. Be patient with full port scans (-p-), they take time
9. Always ensure you have permission before scanning
10. Learn one flag category at a time

╔═══════════════════════════════════════════════════════════════════════════╗
║ LEGAL & ETHICAL REMINDER                                                  ║
╚═══════════════════════════════════════════════════════════════════════════╝

⚠️  IMPORTANT: Only scan systems you own or have explicit permission to test
⚠️  Unauthorized scanning may be illegal in your jurisdiction
⚠️  This tool is for educational and authorized testing purposes only
⚠️  Always follow responsible disclosure practices
⚠️  Respect privacy and security of others

EOF
    
    read -p "Press Enter to continue..."
}

show_about() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ About Hymapper ═══${NC}\n"
    
    echo -e "${CYAN}${BOLD}Hymapper v1.3${NC}"
    echo -e "${WHITE}Creator: ${GREEN}Dhype7${NC}\n"
    
    echo -e "${WHITE}Description:${NC}"
    echo "Hymapper is a beginner-friendly command-line tool designed to make"
    echo "Nmap scanning accessible and easy to understand for cybersecurity"
    echo "beginners and professionals. It provides an interactive interface"
    echo "with color-coded options, detailed descriptions, and pre-configured"
    echo "scan templates with advanced host discovery capabilities."
    echo ""
    
    echo -e "${WHITE}Features:${NC}"
    echo "✓ 40 pre-configured standard scans categorized by effectiveness"
    echo "✓ 12 advanced host discovery methods with detailed explanations"
    echo "✓ Alternative discovery tools (arp-scan, netdiscover, fping, masscan, ping)"
    echo "✓ Enhanced fping with latency measurement and hostname resolution"
    echo "✓ CSV export functionality for saving and managing scan results"
    echo "✓ Custom scan builder with categorized flags"
    echo "✓ NSE scripts guide with categorized script examples"
    echo "✓ Detailed descriptions for every flag and scan type"
    echo "✓ Router protection warnings and bypass techniques"
    echo "✓ Target and port configuration with subnet support"
    echo "✓ Perfect for learning Nmap fundamentals and advanced techniques"
    echo ""
    
    echo -e "${WHITE}Requirements:${NC}"
    echo "• Nmap (required) - apt install nmap"
    echo "• Root/sudo privileges for most scan types"
    echo "• Optional tools: arp-scan, netdiscover, fping, masscan"
    echo "• Kali Linux or any Linux distribution with bash 4.0+"
    echo ""
    
    echo -e "${WHITE}Usage:${NC}"
    echo "  sudo hymapper           - Run from anywhere (after install)"
    echo "  sudo bash hymapper.sh   - Run from script directory"
    echo ""
    
    echo -e "${WHITE}Installation:${NC}"
    echo "  bash install.sh         - Automated installation with shortcut"
    echo ""
    
    echo -e "${WHITE}Support & Updates:${NC}"
    echo "  GitHub: github.com/Dhype7/Hymapper"
    echo "  Issues: Report bugs and suggest features"
    echo "  Version: 1.3 (Enhanced Discovery & CSV Export Edition)"
    echo ""
    
    echo -e "${YELLOW}Always ensure you have permission before scanning any target!${NC}"
    echo -e "${RED}Unauthorized scanning may be illegal in your jurisdiction.${NC}"
    echo ""
    
    read -p "Press Enter to continue..."
}
