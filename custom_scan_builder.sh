# Custom Scan Builder Module
# This file contains all the custom scan builder functions
# Source this file in the main script

show_custom_scan_builder() {
    SCAN_COMMAND="nmap"
    
    while true; do
        show_banner
        echo -e "${YELLOW}${BOLD}═══ Build Your Own Scan ═══${NC}\n"
        echo -e "${CYAN}Target: ${WHITE}$TARGET_IP${NC}"
        if [ ! -z "$TARGET_PORT" ]; then
            echo -e "${CYAN}Port(s): ${WHITE}$TARGET_PORT${NC}"
        fi
        echo -e "${MAGENTA}Current Command: ${WHITE}$SCAN_COMMAND $TARGET_IP${NC}\n"
        
        echo -e "${BOLD}${WHITE}Select flag category:${NC}\n"
        echo -e "${GREEN}[1]${NC}  Scan Techniques"
        echo -e "${GREEN}[2]${NC}  Port Specification"
        echo -e "${GREEN}[3]${NC}  Service/Version Detection"
        echo -e "${GREEN}[4]${NC}  Script Scanning (NSE)"
        echo -e "${GREEN}[5]${NC}  OS Detection"
        echo -e "${GREEN}[6]${NC}  Timing and Performance"
        echo -e "${GREEN}[7]${NC}  Firewall/IDS Evasion"
        echo -e "${GREEN}[8]${NC}  Output Options"
        echo -e "${GREEN}[9]${NC}  Misc Options"
        echo ""
        echo -e "${CYAN}[E]${NC}  Execute Current Scan"
        echo -e "${YELLOW}[R]${NC}  Reset Scan Command"
        echo -e "${MAGENTA}[D]${NC}  Show All Descriptions"
        echo -e "${RED}[0]${NC}  Back to Main Menu"
        echo ""
        
        read -p "Select category: " category_choice
        
        case $category_choice in
            1) show_scan_techniques ;;
            2) show_port_specification ;;
            3) show_service_detection ;;
            4) show_script_scanning ;;
            5) show_os_detection ;;
            6) show_timing_performance ;;
            7) show_firewall_evasion ;;
            8) show_output_options ;;
            9) show_misc_options ;;
            [Ee]) execute_custom_scan ;;
            [Rr]) 
                SCAN_COMMAND="nmap"
                echo -e "${GREEN}Scan command reset!${NC}"
                sleep 1
                ;;
            [Dd]) show_all_flag_descriptions ;;
            0) return ;;
            *) 
                echo -e "${RED}Invalid option!${NC}"
                sleep 1
                ;;
        esac
    done
}

add_flag() {
    local flag="$1"
    
    # Check if flag already exists
    if [[ $SCAN_COMMAND =~ $flag ]]; then
        echo -e "${YELLOW}Flag already added!${NC}"
        sleep 1
        return
    fi
    
    # Add flag to command
    SCAN_COMMAND="$SCAN_COMMAND $flag"
    echo -e "${GREEN}✓ Flag added: $flag${NC}"
    sleep 1
}

execute_custom_scan() {
    show_banner
    echo -e "${YELLOW}${BOLD}═══ Execute Custom Scan ═══${NC}\n"
    
    local full_command="$SCAN_COMMAND $TARGET_IP"
    
    echo -e "${CYAN}Final Command: ${WHITE}$full_command${NC}\n"
    echo -e "${YELLOW}Ready to execute this scan?${NC}"
    read -p "Continue? (y/n): " confirm
    
    if [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "\n${GREEN}Starting scan...${NC}\n"
        echo "═══════════════════════════════════════════════════════════════════"
        
        # Execute the scan
        eval $full_command
        
        echo ""
        echo "═══════════════════════════════════════════════════════════════════"
        echo -e "\n${GREEN}Scan completed!${NC}\n"
    else
        echo -e "${YELLOW}Scan cancelled.${NC}"
    fi
    
    read -p "Press Enter to continue..."
}
