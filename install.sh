#!/bin/bash

################################################################################
# Hymapper Installation Script v1.3
# Creator: Dhype7
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║         Hymapper Installation Script          ║${NC}"
echo -e "${CYAN}║              Creator: Dhype7                   ║${NC}"
echo -e "${CYAN}║                 Version 1.3                    ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════╝${NC}"
echo ""

if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (use sudo)${NC}"
    echo -e "${YELLOW}Example: sudo bash install.sh${NC}"
    exit 1
fi

echo -e "${YELLOW}Checking and installing requirements...${NC}\n"

APT_UPDATED=false

update_apt_if_needed() {
    if [ "$APT_UPDATED" = false ]; then
        echo -e "${YELLOW}Updating package lists...${NC}"
        apt update -qq
        APT_UPDATED=true
        echo ""
    fi
}

echo -e "${WHITE}Required Tool:${NC}"

# Check nmap (required)
if ! command -v nmap &> /dev/null; then
    echo -e "${RED}✗ Nmap not found${NC} - Installing..."
    update_apt_if_needed
    apt install -y nmap
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Nmap installed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to install Nmap${NC}"
        exit 1
    fi
else
    nmap_version=$(nmap --version | head -n1 | awk '{print $3}')
    echo -e "${GREEN}✓ Nmap is already installed${NC} (version $nmap_version)"
fi

echo ""
echo -e "${WHITE}Optional Tools (for alternative discovery):${NC}"

OPTIONAL_TOOLS=("arp-scan" "netdiscover" "fping" "masscan")
MISSING_TOOLS=()

for tool in "${OPTIONAL_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        echo -e "${YELLOW}✗ $tool not found${NC}"
        MISSING_TOOLS+=("$tool")
    else
        echo -e "${GREEN}✓ $tool is installed${NC}"
    fi
done

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Found ${#MISSING_TOOLS[@]} missing optional tool(s): ${MISSING_TOOLS[*]}${NC}"
    echo -e "${WHITE}These tools provide alternative host discovery methods.${NC}"
    read -p "Install missing optional tools? (y/n): " install_optional
    
    if [[ $install_optional =~ ^[Yy]$ ]]; then
        update_apt_if_needed
        for tool in "${MISSING_TOOLS[@]}"; do
            echo -e "${YELLOW}Installing $tool...${NC}"
            apt install -y "$tool"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ $tool installed successfully${NC}"
            else
                echo -e "${RED}✗ Failed to install $tool (not critical)${NC}"
            fi
        done
    else
        echo -e "${CYAN}Skipping optional tools installation${NC}"
    fi
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo -e "${YELLOW}Setting up Hymapper...${NC}\n"

chmod +x "$SCRIPT_DIR/hymapper.sh"
if [ -f "$SCRIPT_DIR/custom_scan_builder.sh" ]; then
    chmod +x "$SCRIPT_DIR/custom_scan_builder.sh"
fi
if [ -f "$SCRIPT_DIR/flag_categories.sh" ]; then
    chmod +x "$SCRIPT_DIR/flag_categories.sh"
fi
if [ -f "$SCRIPT_DIR/descriptions.sh" ]; then
    chmod +x "$SCRIPT_DIR/descriptions.sh"
fi

echo -e "${GREEN}✓ Made scripts executable${NC}"

echo -e "${YELLOW}Creating system-wide shortcut...${NC}"

if [ -L /usr/local/bin/hymapper ]; then
    rm /usr/local/bin/hymapper
fi

ln -s "$SCRIPT_DIR/hymapper.sh" /usr/local/bin/hymapper

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Shortcut created: /usr/local/bin/hymapper -> $SCRIPT_DIR/hymapper.sh${NC}"
else
    echo -e "${RED}✗ Failed to create shortcut${NC}"
    exit 1
fi

# Verify installation
if command -v hymapper &> /dev/null; then
    echo -e "${GREEN}✓ Hymapper command is now available system-wide${NC}"
else
    echo -e "${RED}✗ Installation verification failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Installation completed successfully!      ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${WHITE}Installed Tools Summary:${NC}"
echo -e "  ${GREEN}✓ Nmap${NC} - Required (installed)"
if command -v arp-scan &> /dev/null; then
    echo -e "  ${GREEN}✓ arp-scan${NC} - Optional (installed)"
else
    echo -e "  ${YELLOW}✗ arp-scan${NC} - Optional (not installed)"
fi
if command -v netdiscover &> /dev/null; then
    echo -e "  ${GREEN}✓ netdiscover${NC} - Optional (installed)"
else
    echo -e "  ${YELLOW}✗ netdiscover${NC} - Optional (not installed)"
fi
if command -v fping &> /dev/null; then
    echo -e "  ${GREEN}✓ fping${NC} - Optional (installed)"
else
    echo -e "  ${YELLOW}✗ fping${NC} - Optional (not installed)"
fi
if command -v masscan &> /dev/null; then
    echo -e "  ${GREEN}✓ masscan${NC} - Optional (installed)"
else
    echo -e "  ${YELLOW}✗ masscan${NC} - Optional (not installed)"
fi
echo ""
echo -e "${CYAN}You can now run Hymapper from anywhere:${NC}"
echo -e "  ${WHITE}sudo hymapper${NC}  - Run with full privileges (recommended)"
echo ""
echo -e "${YELLOW}Note: Root/sudo privileges are required for most scan types${NC}"
echo -e "${WHITE}Installation directory: ${CYAN}$SCRIPT_DIR${NC}"
echo ""
