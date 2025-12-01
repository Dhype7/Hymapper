# Flag Categories Module  
# Contains all flag category menus and descriptions

show_scan_techniques() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Scan Techniques (15 Options) ═══${NC}\n"
    echo -e "${CYAN}Choose a scan type:${NC}\n"
    
    echo -e "${RED}${BOLD}TCP Scan Types:${NC}"
    echo -e "${GREEN}[1]${NC}   -sS  ${WHITE}TCP SYN scan (stealth)${NC}"
    echo -e "${GREEN}[2]${NC}   -sT  ${WHITE}TCP Connect scan${NC}"
    echo -e "${GREEN}[3]${NC}   -sA  ${WHITE}TCP ACK scan (firewall detection)${NC}"
    echo -e "${GREEN}[4]${NC}   -sW  ${WHITE}TCP Window scan${NC}"
    echo -e "${GREEN}[5]${NC}   -sM  ${WHITE}TCP Maimon scan${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Stealth Scan Types:${NC}"
    echo -e "${GREEN}[6]${NC}   -sN  ${WHITE}TCP NULL scan${NC}"
    echo -e "${GREEN}[7]${NC}   -sF  ${WHITE}FIN scan${NC}"
    echo -e "${GREEN}[8]${NC}   -sX  ${WHITE}Xmas scan${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Other Protocol Scans:${NC}"
    echo -e "${GREEN}[9]${NC}   -sU  ${WHITE}UDP scan${NC}"
    echo -e "${GREEN}[10]${NC}  -sY  ${WHITE}SCTP INIT scan${NC}"
    echo -e "${GREEN}[11]${NC}  -sZ  ${WHITE}SCTP COOKIE ECHO scan${NC}"
    echo -e "${GREEN}[12]${NC}  -sO  ${WHITE}IP protocol scan${NC}"
    echo ""
    echo -e "${WHITE}${BOLD}Discovery Only:${NC}"
    echo -e "${GREEN}[13]${NC}  -sn  ${WHITE}Ping scan (no port scan)${NC}"
    echo -e "${GREEN}[14]${NC}  -Pn  ${WHITE}Skip host discovery (treat all as online)${NC}"
    echo -e "${GREEN}[15]${NC}  -sL  ${WHITE}List scan (DNS resolution only)${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}   Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}   Back"
    echo ""
    
    read -p "Select option: " tech_choice
    
    case $tech_choice in
        1) add_flag "-sS" ;;
        2) add_flag "-sT" ;;
        3) add_flag "-sA" ;;
        4) add_flag "-sW" ;;
        5) add_flag "-sM" ;;
        6) add_flag "-sN" ;;
        7) add_flag "-sF" ;;
        8) add_flag "-sX" ;;
        9) add_flag "-sU" ;;
        10) add_flag "-sY" ;;
        11) add_flag "-sZ" ;;
        12) add_flag "-sO" ;;
        13) add_flag "-sn" ;;
        14) add_flag "-Pn" ;;
        15) add_flag "-sL" ;;
        [Dd]) show_scan_techniques_descriptions ;;
        0) return ;;
    esac
}

show_scan_techniques_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Scan Techniques - Detailed Descriptions ═══${NC}\n"
    
    (
    echo -e "${RED}${BOLD}TCP SCAN TYPES:${NC}"
    echo -e "${GREEN}-sS (TCP SYN Scan)${NC}"
    echo "  Default and most popular. Sends SYN packets, waits for SYN/ACK response."
    echo "  Half-open scan - doesn't complete TCP handshake. Stealthy. Requires root."
    echo ""
    
    echo -e "${GREEN}-sT (TCP Connect Scan)${NC}"
    echo "  Completes full TCP 3-way handshake. Used when SYN scan unavailable."
    echo "  More detectable, logged by services. Doesn't require root privileges."
    echo ""
    
    echo -e "${GREEN}-sA (TCP ACK Scan)${NC}"
    echo "  Sends TCP packets with only ACK flag set. Maps firewall rulesets."
    echo "  Determines if ports are filtered or unfiltered, not open/closed."
    echo ""
    
    echo -e "${GREEN}-sW (TCP Window Scan)${NC}"
    echo "  Like ACK scan but examines TCP Window field of responses."
    echo "  Can differentiate open from closed ports on some systems."
    echo ""
    
    echo -e "${GREEN}-sM (TCP Maimon Scan)${NC}"
    echo "  Sends FIN/ACK packets. Named after discoverer Uriel Maimon."
    echo "  Exactly like NULL, FIN, and Xmas scans except uses FIN/ACK probe."
    echo ""
    
    echo -e "${YELLOW}${BOLD}STEALTH SCAN TYPES:${NC}"
    echo -e "${GREEN}-sN (TCP NULL Scan)${NC}"
    echo "  Sends packets with NO flags set. Exploits TCP RFC loophole."
    echo "  Can evade stateless firewalls and packet filters. Stealthy."
    echo ""
    
    echo -e "${GREEN}-sF (FIN Scan)${NC}"
    echo "  Sends packets with only FIN flag. Stealthy, less logged."
    echo "  Works against RFC-compliant systems. Can bypass some firewalls."
    echo ""
    
    echo -e "${GREEN}-sX (Xmas Scan)${NC}"
    echo "  Sends packets with FIN, PSH, URG flags (packet 'lit up like Xmas tree')."
    echo "  Stealthy technique, works on RFC-compliant systems."
    echo ""
    
    echo -e "${BLUE}${BOLD}OTHER PROTOCOL SCANS:${NC}"
    echo -e "${GREEN}-sU (UDP Scan)${NC}"
    echo "  Scans UDP ports. Slower than TCP (no handshake confirmation)."
    echo "  Critical for DNS (53), SNMP (161), DHCP (67/68) services."
    echo ""
    
    echo -e "${GREEN}-sY (SCTP INIT Scan)${NC}"
    echo "  SCTP equivalent of TCP SYN scan. Scans SCTP associations."
    echo "  Used for SS7/SIGTRAN, newer VoIP, and Diameter applications."
    echo ""
    
    echo -e "${GREEN}-sZ (SCTP COOKIE ECHO Scan)${NC}"
    echo "  More stealthy than SCTP INIT. Sends COOKIE ECHO chunks."
    echo "  Can bypass some SCTP-aware firewalls."
    echo ""
    
    echo -e "${GREEN}-sO (IP Protocol Scan)${NC}"
    echo "  Determines which IP protocols (TCP, ICMP, IGMP, etc.) are supported."
    echo "  Iterates through IP protocol numbers to find supported protocols."
    echo ""
    
    echo -e "${WHITE}${BOLD}DISCOVERY ONLY:${NC}"
    echo -e "${GREEN}-sn (Ping Scan)${NC}"
    echo "  Only host discovery, no port scanning. Fast for large networks."
    echo "  Uses ICMP echo, TCP SYN to 443, TCP ACK to 80, ICMP timestamp."
    echo ""
    
    echo -e "${GREEN}-Pn (No Ping)${NC}"
    echo "  Skips host discovery, treats all targets as online."
    echo "  Useful when hosts block ping but are actually up."
    echo ""
    
    echo -e "${GREEN}-sL (List Scan)${NC}"
    echo "  Simply lists targets, performs DNS resolution. No scanning."
    echo "  Useful for reconnaissance without touching targets."
    echo ""
    ) | less -R
    
    if [ $? -ne 0 ]; then
        read -p "Press Enter to continue..."
    fi
}

show_port_specification() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Port Specification (12 Options) ═══${NC}\n"
    echo -e "${CYAN}Choose port options:${NC}\n"
    
    echo -e "${RED}${BOLD}Full Range Options:${NC}"
    echo -e "${GREEN}[1]${NC}   -p-  ${WHITE}Scan all 65535 ports${NC}"
    echo -e "${GREEN}[2]${NC}   -p [ports]  ${WHITE}Scan specific ports (use your port input)${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Top Ports (Most Common):${NC}"
    echo -e "${GREEN}[3]${NC}   --top-ports 10  ${WHITE}Top 10 most common${NC}"
    echo -e "${GREEN}[4]${NC}   --top-ports 100  ${WHITE}Top 100 ports${NC}"
    echo -e "${GREEN}[5]${NC}   --top-ports 1000  ${WHITE}Top 1000 ports${NC}"
    echo -e "${GREEN}[6]${NC}   -F  ${WHITE}Fast mode (top 100 common ports)${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Port Ranges:${NC}"
    echo -e "${GREEN}[7]${NC}   -p 1-1000  ${WHITE}Scan ports 1-1000${NC}"
    echo -e "${GREEN}[8]${NC}   -p 1-1024  ${WHITE}Well-known ports only${NC}"
    echo -e "${GREEN}[9]${NC}   -p 1024-49151  ${WHITE}Registered ports${NC}"
    echo ""
    echo -e "${WHITE}${BOLD}Special Options:${NC}"
    echo -e "${GREEN}[10]${NC}  --port-ratio 0.1  ${WHITE}Ports more common than 10%${NC}"
    echo -e "${GREEN}[11]${NC}  -r  ${WHITE}Randomize port scan order${NC}"
    echo -e "${GREEN}[12]${NC}  Custom range  ${WHITE}Enter your own port range${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}   Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}   Back"
    echo ""
    
    read -p "Select option: " port_choice
    
    case $port_choice in
        1) add_flag "-p-" ;;
        2) 
            if [ ! -z "$TARGET_PORT" ]; then
                add_flag "-p $TARGET_PORT"
            else
                echo -e "${RED}No port specified in target configuration!${NC}"
                sleep 2
            fi
            ;;
        3) add_flag "--top-ports 10" ;;
        4) add_flag "--top-ports 100" ;;
        5) add_flag "--top-ports 1000" ;;
        6) add_flag "-F" ;;
        7) add_flag "-p 1-1000" ;;
        8) add_flag "-p 1-1024" ;;
        9) add_flag "-p 1024-49151" ;;
        10) add_flag "--port-ratio 0.1" ;;
        11) add_flag "-r" ;;
        12) 
            echo -e "${YELLOW}Enter custom port range (e.g., 80,443 or 1-500,8000-9000):${NC}"
            read -p "> " custom_ports
            if [ ! -z "$custom_ports" ]; then
                add_flag "-p $custom_ports"
            fi
            ;;
        [Dd]) show_port_specification_descriptions ;;
        0) return ;;
    esac
}

show_port_specification_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Port Specification - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-p- (All Ports)${NC}"
    echo "  Scans all 65535 TCP ports. Very thorough but time-consuming."
    echo ""
    
    echo -e "${GREEN}-p [ports] (Specific Ports)${NC}"
    echo "  Scan only specified ports. Examples: -p 80, -p 22-443, -p 22,80,443"
    echo ""
    
    echo -e "${GREEN}--top-ports 100${NC}"
    echo "  Scans the 100 most common ports based on nmap's frequency data."
    echo ""
    
    echo -e "${GREEN}--top-ports 1000${NC}"
    echo "  Scans the 1000 most common ports. Good balance of coverage and speed."
    echo ""
    
    echo -e "${GREEN}-F (Fast Mode)${NC}"
    echo "  Scans 100 most common ports. Faster than default scan."
    echo ""
    
    echo -e "${GREEN}-p 1-1000${NC}"
    echo "  Scans ports 1 through 1000. Covers most common services."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_service_detection() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Service/Version Detection (9 Options) ═══${NC}\n"
    echo -e "${CYAN}Choose service detection options:${NC}\n"
    
    echo -e "${RED}${BOLD}Basic Service Detection:${NC}"
    echo -e "${GREEN}[1]${NC}  -sV  ${WHITE}Standard service version detection${NC}"
    echo -e "${GREEN}[2]${NC}  -sV --version-light  ${WHITE}Light detection (intensity 2)${NC}"
    echo -e "${GREEN}[3]${NC}  -sV --version-all  ${WHITE}Try all probes (most thorough)${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Custom Intensity (0-9):${NC}"
    echo -e "${GREEN}[4]${NC}  -sV --version-intensity 0  ${WHITE}Lightest (fast)${NC}"
    echo -e "${GREEN}[5]${NC}  -sV --version-intensity 5  ${WHITE}Moderate intensity${NC}"
    echo -e "${GREEN}[6]${NC}  -sV --version-intensity 9  ${WHITE}Most intense (slow)${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Advanced Options:${NC}"
    echo -e "${GREEN}[7]${NC}  -sV --version-trace  ${WHITE}Show detailed version scan activity${NC}"
    echo -e "${GREEN}[8]${NC}  -sR  ${WHITE}RPC scan (port mapper enumeration)${NC}"
    echo -e "${GREEN}[9]${NC}  -sV -sC  ${WHITE}Version detection + default scripts${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}  Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}  Back"
    echo ""
    
    read -p "Select option: " svc_choice
    
    case $svc_choice in
        1) add_flag "-sV" ;;
        2) add_flag "-sV --version-light" ;;
        3) add_flag "-sV --version-all" ;;
        4) add_flag "-sV --version-intensity 0" ;;
        5) add_flag "-sV --version-intensity 5" ;;
        6) add_flag "-sV --version-intensity 9" ;;
        7) add_flag "-sV --version-trace" ;;
        8) add_flag "-sR" ;;
        9) add_flag "-sV -sC" ;;
        [Dd]) show_service_detection_descriptions ;;
        0) return ;;
    esac
}

show_service_detection_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Service/Version Detection - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-sV (Service Version Detection)${NC}"
    echo "  Probes open ports to determine service and version information."
    echo "  Essential for vulnerability assessment."
    echo ""
    
    echo -e "${GREEN}-sV --version-intensity 0 (Light)${NC}"
    echo "  Uses only the most likely probes. Faster but less accurate."
    echo ""
    
    echo -e "${GREEN}-sV --version-intensity 9 (Intense)${NC}"
    echo "  Tries all probes. Most accurate but slower."
    echo ""
    
    echo -e "${GREEN}-sV --version-all${NC}"
    echo "  Tries every single probe. Very slow but comprehensive."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_script_scanning() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Script Scanning (NSE) - 14 Options ═══${NC}\n"
    echo -e "${CYAN}Choose NSE script options:${NC}\n"
    
    echo -e "${RED}${BOLD}Basic Script Categories:${NC}"
    echo -e "${GREEN}[1]${NC}   -sC  ${WHITE}Default safe scripts${NC}"
    echo -e "${GREEN}[2]${NC}   --script safe  ${WHITE}All safe scripts${NC}"
    echo -e "${GREEN}[3]${NC}   --script default  ${WHITE}Default script collection${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Security-Focused Scripts:${NC}"
    echo -e "${GREEN}[4]${NC}   --script vuln  ${WHITE}Vulnerability detection${NC}"
    echo -e "${GREEN}[5]${NC}   --script exploit  ${WHITE}Exploitation attempts (use with caution!)${NC}"
    echo -e "${GREEN}[6]${NC}   --script malware  ${WHITE}Malware detection${NC}"
    echo -e "${GREEN}[7]${NC}   --script backdoor  ${WHITE}Backdoor detection${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Information Gathering:${NC}"
    echo -e "${GREEN}[8]${NC}   --script discovery  ${WHITE}Advanced discovery${NC}"
    echo -e "${GREEN}[9]${NC}   --script auth  ${WHITE}Authentication testing${NC}"
    echo -e "${GREEN}[10]${NC}  --script brute  ${WHITE}Brute force attempts${NC}"
    echo -e "${GREEN}[11]${NC}  --script broadcast  ${WHITE}Network broadcast discovery${NC}"
    echo ""
    echo -e "${WHITE}${BOLD}Advanced Options:${NC}"
    echo -e "${GREEN}[12]${NC}  --script dos  ${WHITE}DoS vulnerability checks${NC}"
    echo -e "${GREEN}[13]${NC}  --script fuzzer  ${WHITE}Fuzzing scripts${NC}"
    echo -e "${GREEN}[14]${NC}  Custom script  ${WHITE}Enter specific script name${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}   Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}   Back"
    echo ""
    
    read -p "Select option: " script_choice
    
    case $script_choice in
        1) add_flag "-sC" ;;
        2) add_flag "--script safe" ;;
        3) add_flag "--script default" ;;
        4) add_flag "--script vuln" ;;
        5) add_flag "--script exploit" ;;
        6) add_flag "--script malware" ;;
        7) add_flag "--script backdoor" ;;
        8) add_flag "--script discovery" ;;
        9) add_flag "--script auth" ;;
        10) add_flag "--script brute" ;;
        11) add_flag "--script broadcast" ;;
        12) add_flag "--script dos" ;;
        13) add_flag "--script fuzzer" ;;
        14) 
            echo -e "${YELLOW}Enter script name (e.g., http-sql-injection):${NC}"
            read -p "> " custom_script
            if [ ! -z "$custom_script" ]; then
                add_flag "--script $custom_script"
            fi
            ;;
        [Dd]) show_script_scanning_descriptions ;;
        0) return ;;
    esac
}

show_script_scanning_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Script Scanning (NSE) - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-sC (Default Scripts)${NC}"
    echo "  Runs a collection of safe, useful, and informative scripts."
    echo "  Good starting point for most scans."
    echo ""
    
    echo -e "${GREEN}--script vuln (Vulnerability Scripts)${NC}"
    echo "  Runs scripts that check for known vulnerabilities."
    echo "  Essential for security assessments."
    echo ""
    
    echo -e "${GREEN}--script auth (Authentication Scripts)${NC}"
    echo "  Tests authentication mechanisms and checks for default credentials."
    echo ""
    
    echo -e "${GREEN}--script discovery (Discovery Scripts)${NC}"
    echo "  Performs advanced host and service discovery."
    echo ""
    
    echo -e "${GREEN}--script exploit (Exploitation Scripts)${NC}"
    echo "  Attempts to exploit vulnerabilities. Use with caution!"
    echo ""
    
    echo -e "${GREEN}--script safe (Safe Scripts)${NC}"
    echo "  Only runs scripts that won't crash services or cause problems."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_os_detection() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ OS Detection ═══${NC}\n"
    echo -e "${CYAN}Choose OS detection options:${NC}\n"
    
    echo -e "${GREEN}[1]${NC}  -O  ${WHITE}Enable OS detection${NC}"
    echo -e "${GREEN}[2]${NC}  -O --osscan-guess  ${WHITE}Aggressive OS guess${NC}"
    echo -e "${GREEN}[3]${NC}  --traceroute  ${WHITE}Trace hop path to host${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}  Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}  Back"
    echo ""
    
    read -p "Select option: " os_choice
    
    case $os_choice in
        1) add_flag "-O" ;;
        2) add_flag "-O --osscan-guess" ;;
        3) add_flag "--traceroute" ;;
        [Dd]) show_os_detection_descriptions ;;
        0) return ;;
    esac
}

show_os_detection_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ OS Detection - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-O (OS Detection)${NC}"
    echo "  Attempts to identify the target's operating system."
    echo "  Uses TCP/IP stack fingerprinting. Requires root privileges."
    echo ""
    
    echo -e "${GREEN}-O --osscan-guess (Aggressive Guess)${NC}"
    echo "  Makes an aggressive guess at the OS when standard detection isn't perfect."
    echo ""
    
    echo -e "${GREEN}--traceroute${NC}"
    echo "  Traces the network path to the target host."
    echo "  Shows all hops between you and the target."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_timing_performance() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Timing and Performance ═══${NC}\n"
    echo -e "${CYAN}Choose timing options:${NC}\n"
    
    echo -e "${GREEN}[1]${NC}  -T0  ${WHITE}Paranoid (slowest)${NC}"
    echo -e "${GREEN}[2]${NC}  -T1  ${WHITE}Sneaky${NC}"
    echo -e "${GREEN}[3]${NC}  -T2  ${WHITE}Polite${NC}"
    echo -e "${GREEN}[4]${NC}  -T3  ${WHITE}Normal (default)${NC}"
    echo -e "${GREEN}[5]${NC}  -T4  ${WHITE}Aggressive (fast)${NC}"
    echo -e "${GREEN}[6]${NC}  -T5  ${WHITE}Insane (fastest)${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}  Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}  Back"
    echo ""
    
    read -p "Select option: " timing_choice
    
    case $timing_choice in
        1) add_flag "-T0" ;;
        2) add_flag "-T1" ;;
        3) add_flag "-T2" ;;
        4) add_flag "-T3" ;;
        5) add_flag "-T4" ;;
        6) add_flag "-T5" ;;
        [Dd]) show_timing_performance_descriptions ;;
        0) return ;;
    esac
}

show_timing_performance_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Timing and Performance - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-T0 (Paranoid)${NC}"
    echo "  Extremely slow. One port at a time. For IDS evasion."
    echo ""
    
    echo -e "${GREEN}-T1 (Sneaky)${NC}"
    echo "  Very slow. Still stealthy. Waits 15 seconds between probes."
    echo ""
    
    echo -e "${GREEN}-T2 (Polite)${NC}"
    echo "  Slows down scan to use less bandwidth and target resources."
    echo ""
    
    echo -e "${GREEN}-T3 (Normal)${NC}"
    echo "  Default timing. Balances speed and accuracy."
    echo ""
    
    echo -e "${GREEN}-T4 (Aggressive)${NC}"
    echo "  Faster scan. Assumes fast and reliable network. Recommended."
    echo ""
    
    echo -e "${GREEN}-T5 (Insane)${NC}"
    echo "  Extremely fast. May sacrifice accuracy. Only on very fast networks."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_firewall_evasion() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Firewall/IDS Evasion (12 Options) ═══${NC}\n"
    echo -e "${CYAN}Choose evasion techniques:${NC}\n"
    
    echo -e "${RED}${BOLD}Packet Manipulation:${NC}"
    echo -e "${GREEN}[1]${NC}   -f  ${WHITE}Fragment packets (8 bytes)${NC}"
    echo -e "${GREEN}[2]${NC}   -ff  ${WHITE}Fragment packets (16 bytes)${NC}"
    echo -e "${GREEN}[3]${NC}   --mtu 24  ${WHITE}Custom MTU size${NC}"
    echo -e "${GREEN}[4]${NC}   --data-length 200  ${WHITE}Append random data to packets${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Source Obfuscation:${NC}"
    echo -e "${GREEN}[5]${NC}   -D RND:5  ${WHITE}5 random decoy IPs${NC}"
    echo -e "${GREEN}[6]${NC}   -D RND:10  ${WHITE}10 random decoy IPs${NC}"
    echo -e "${GREEN}[7]${NC}   -S [IP]  ${WHITE}Spoof source IP address${NC}"
    echo -e "${GREEN}[8]${NC}   -e [iface]  ${WHITE}Use specific network interface${NC}"
    echo -e "${GREEN}[9]${NC}   -g [port]  ${WHITE}Use specific source port${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Advanced Evasion:${NC}"
    echo -e "${GREEN}[10]${NC}  --badsum  ${WHITE}Send bad checksums${NC}"
    echo -e "${GREEN}[11]${NC}  --scan-delay 1s  ${WHITE}Delay between probes${NC}"
    echo -e "${GREEN}[12]${NC}  --randomize-hosts  ${WHITE}Randomize target order${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}   Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}   Back"
    echo ""
    
    read -p "Select option: " evasion_choice
    
    case $evasion_choice in
        1) add_flag "-f" ;;
        2) add_flag "-ff" ;;
        3) 
            echo -e "${YELLOW}Enter MTU size (8-byte multiples, e.g., 24, 32):${NC}"
            read -p "> " mtu_size
            if [ ! -z "$mtu_size" ]; then
                add_flag "--mtu $mtu_size"
            fi
            ;;
        4) add_flag "--data-length 200" ;;
        5) add_flag "-D RND:5" ;;
        6) add_flag "-D RND:10" ;;
        7) 
            echo -e "${YELLOW}Enter spoofed IP address:${NC}"
            read -p "> " spoof_ip
            if [ ! -z "$spoof_ip" ]; then
                add_flag "-S $spoof_ip"
            fi
            ;;
        8) 
            echo -e "${YELLOW}Enter network interface (e.g., eth0):${NC}"
            read -p "> " iface
            if [ ! -z "$iface" ]; then
                add_flag "-e $iface"
            fi
            ;;
        9) 
            echo -e "${YELLOW}Enter source port number:${NC}"
            read -p "> " src_port
            if [ ! -z "$src_port" ]; then
                add_flag "-g $src_port"
            fi
            ;;
        10) add_flag "--badsum" ;;
        11) add_flag "--scan-delay 1s" ;;
        12) add_flag "--randomize-hosts" ;;
        [Dd]) show_firewall_evasion_descriptions ;;
        0) return ;;
    esac
}

show_firewall_evasion_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Firewall/IDS Evasion - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-f (Fragment Packets)${NC}"
    echo "  Splits packets into smaller fragments. Can evade some packet filters."
    echo ""
    
    echo -e "${GREEN}-D RND:10 (Decoy Scan)${NC}"
    echo "  Makes it appear that 10 random IPs are scanning the target."
    echo "  Hides your real IP among decoys."
    echo ""
    
    echo -e "${GREEN}-S [IP] (Spoof Source)${NC}"
    echo "  Makes packets appear to come from specified IP address."
    echo "  Requires careful network setup to receive responses."
    echo ""
    
    echo -e "${GREEN}--data-length 200${NC}"
    echo "  Appends random data to packets to change their size."
    echo "  Can evade signature-based detection."
    echo ""
    
    echo -e "${GREEN}--badsum${NC}"
    echo "  Sends packets with incorrect checksums."
    echo "  Tests if firewall is actually inspecting packets."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_output_options() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Output Options ═══${NC}\n"
    echo -e "${CYAN}Choose output format:${NC}\n"
    
    echo -e "${GREEN}[1]${NC}  -oN scan.txt  ${WHITE}Normal output to file${NC}"
    echo -e "${GREEN}[2]${NC}  -oX scan.xml  ${WHITE}XML output to file${NC}"
    echo -e "${GREEN}[3]${NC}  -oG scan.gnmap  ${WHITE}Grepable output${NC}"
    echo -e "${GREEN}[4]${NC}  -oA scan  ${WHITE}All formats${NC}"
    echo -e "${GREEN}[5]${NC}  -v  ${WHITE}Verbose output${NC}"
    echo -e "${GREEN}[6]${NC}  -vv  ${WHITE}Very verbose output${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}  Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}  Back"
    echo ""
    
    read -p "Select option: " output_choice
    
    case $output_choice in
        1) add_flag "-oN scan.txt" ;;
        2) add_flag "-oX scan.xml" ;;
        3) add_flag "-oG scan.gnmap" ;;
        4) add_flag "-oA scan" ;;
        5) add_flag "-v" ;;
        6) add_flag "-vv" ;;
        [Dd]) show_output_options_descriptions ;;
        0) return ;;
    esac
}

show_output_options_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Output Options - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-oN scan.txt (Normal Output)${NC}"
    echo "  Saves scan results in normal human-readable format."
    echo ""
    
    echo -e "${GREEN}-oX scan.xml (XML Output)${NC}"
    echo "  Saves results in XML format. Can be imported into other tools."
    echo ""
    
    echo -e "${GREEN}-oG scan.gnmap (Grepable Output)${NC}"
    echo "  One line per host. Easy to grep, awk, cut, etc."
    echo ""
    
    echo -e "${GREEN}-oA scan (All Formats)${NC}"
    echo "  Saves results in all three major formats (Normal, XML, Grepable)."
    echo ""
    
    echo -e "${GREEN}-v (Verbose)${NC}"
    echo "  Shows more details during the scan. Useful for monitoring progress."
    echo ""
    
    echo -e "${GREEN}-vv (Very Verbose)${NC}"
    echo "  Maximum verbosity. Shows even more scan details."
    echo ""
    
    read -p "Press Enter to continue..."
}

show_misc_options() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Miscellaneous Options (11 Options) ═══${NC}\n"
    echo -e "${CYAN}Choose additional options:${NC}\n"
    
    echo -e "${RED}${BOLD}Comprehensive Scans:${NC}"
    echo -e "${GREEN}[1]${NC}   -A  ${WHITE}Aggressive (OS, version, scripts, traceroute)${NC}"
    echo -e "${GREEN}[2]${NC}   --reason  ${WHITE}Display why port is in specific state${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}Network & Protocol:${NC}"
    echo -e "${GREEN}[3]${NC}   -6  ${WHITE}Enable IPv6 scanning${NC}"
    echo -e "${GREEN}[4]${NC}   -n  ${WHITE}No DNS resolution (faster)${NC}"
    echo -e "${GREEN}[5]${NC}   -R  ${WHITE}Always resolve DNS${NC}"
    echo -e "${GREEN}[6]${NC}   --dns-servers [IP]  ${WHITE}Custom DNS servers${NC}"
    echo ""
    echo -e "${BLUE}${BOLD}Output Filtering:${NC}"
    echo -e "${GREEN}[7]${NC}   --open  ${WHITE}Only show open/possibly open ports${NC}"
    echo -e "${GREEN}[8]${NC}   --packet-trace  ${WHITE}Show all packets sent/received${NC}"
    echo -e "${GREEN}[9]${NC}   --iflist  ${WHITE}List network interfaces and routes${NC}"
    echo ""
    echo -e "${WHITE}${BOLD}Performance:${NC}"
    echo -e "${GREEN}[10]${NC}  --min-rate 100  ${WHITE}Send at least 100 packets/sec${NC}"
    echo -e "${GREEN}[11]${NC}  --max-retries 2  ${WHITE}Limit probe retransmissions${NC}"
    echo ""
    echo -e "${MAGENTA}[D]${NC}   Show detailed descriptions"
    echo -e "${CYAN}[0]${NC}   Back"
    echo ""
    
    read -p "Select option: " misc_choice
    
    case $misc_choice in
        1) add_flag "-A" ;;
        2) add_flag "--reason" ;;
        3) add_flag "-6" ;;
        4) add_flag "-n" ;;
        5) add_flag "-R" ;;
        6) 
            echo -e "${YELLOW}Enter DNS server IP:${NC}"
            read -p "> " dns_server
            if [ ! -z "$dns_server" ]; then
                add_flag "--dns-servers $dns_server"
            fi
            ;;
        7) add_flag "--open" ;;
        8) add_flag "--packet-trace" ;;
        9) add_flag "--iflist" ;;
        10) add_flag "--min-rate 100" ;;
        11) add_flag "--max-retries 2" ;;
        [Dd]) show_misc_options_descriptions ;;
        0) return ;;
    esac
}

show_misc_options_descriptions() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Miscellaneous Options - Detailed Descriptions ═══${NC}\n"
    
    echo -e "${GREEN}-A (Aggressive Scan)${NC}"
    echo "  Enables OS detection, version detection, script scanning, and traceroute."
    echo "  Comprehensive but noisy. Good for thorough reconnaissance."
    echo ""
    
    echo -e "${GREEN}-6 (IPv6)${NC}"
    echo "  Enables IPv6 scanning. Required for scanning IPv6 addresses."
    echo ""
    
    echo -e "${GREEN}--reason${NC}"
    echo "  Shows why Nmap determined a port is in a particular state."
    echo "  Useful for understanding scan results."
    echo ""
    
    echo -e "${GREEN}--open${NC}"
    echo "  Only displays open (or possibly open) ports."
    echo "  Filters out closed and filtered ports from output."
    echo ""
    
    echo -e "${GREEN}--packet-trace${NC}"
    echo "  Shows every packet sent and received."
    echo "  Very verbose. Useful for debugging."
    echo ""
    
    read -p "Press Enter to continue..."
}
