# Hymapper - Network Scanning Made Easy

```
██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ██████╗ ███████╗██████╗ 
██║  ██║╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████║ ╚████╔╝ ██╔████╔██║███████║██████╔╝██████╔╝█████╗  ██████╔╝
██╔══██║  ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗
██║  ██║   ██║   ██║ ╚═╝ ██║██║  ██║██║     ██║     ███████╗██║  ██║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝
```

**Version 1.3** | **2,840+ Lines of Code** | **Created by Dhype7 (Abdullah Ibrahem)**

A powerful, beginner-friendly command-line interface for Nmap that simplifies network scanning and reconnaissance. Designed for cybersecurity professionals, penetration testers, and students learning network security.

---

## Table of Contents

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Key Components](#key-components)
- [Host Discovery](#host-discovery)
- [CSV Export](#csv-export)
- [Requirements](#requirements)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)

---

## About

Hymapper is an interactive wrapper for Nmap that eliminates the complexity of remembering command-line flags and syntax. It provides a color-coded menu system with detailed descriptions, pre-configured scans, and advanced features like CSV export and alternative discovery tools.

Perfect for:
- Cybersecurity students learning network reconnaissance
- Penetration testers who want quick access to common scans
- Security professionals conducting network assessments
- Anyone who wants to understand Nmap without memorizing syntax

---

## Features

### 1. Standard Scans (40 Pre-configured Options)

Four categories organized by speed and depth:

**PRO SCANS (8 scans)**
- Aggressive scan with OS detection
- Full TCP port scan with service detection
- Comprehensive vulnerability scan
- Stealth SYN scan with script scanning
- Full UDP and TCP combined scan
- Intense scan with all probes
- Comprehensive exploit detection
- Full port range with max scripts

**GOOD SCANS (8 scans)**
- Service version detection
- OS detection with traceroute
- Top 1000 ports fast scan
- Default script scan
- TCP SYN scan with OS detection
- Version intense with scripts
- Stealth scan with service detection
- Network discovery and analysis

**MID SCANS (8 scans)**
- Basic port scan
- TCP connect scan
- Service and version detection
- Top 100 ports quick scan
- UDP top ports scan
- ACK scan for firewall detection
- FIN scan (stealthy alternative)
- NULL scan for firewall bypass

**FAST SCANS (8 scans)**
- Ping scan (host discovery)
- Quick scan top 20 ports
- Fast SYN scan
- Single port quick check
- Fast TCP connect
- Rapid host discovery
- Top 10 ports lightning fast
- Quick web ports scan

**BASIC SCANS (8 scans)**
- Simple scan (default)
- Check if host is up
- List open ports
- Scan common ports
- Basic service detection
- Polite scan (slow and careful)
- Top 50 ports basic
- Simple web server check

### 2. Advanced Host Discovery (12 Methods)

Specialized techniques for finding live hosts:
- Ping scan (ICMP only)
- Default discovery (auto mode)
- ARP scan (local network)
- TCP SYN discovery
- TCP ACK discovery
- UDP discovery
- Aggressive discovery
- List scan (no ping)
- No ping + port scan
- Fast network sweep

Includes router protection warnings and alternative tools menu for bypassing common network restrictions.

### 3. Alternative Discovery Tools

Integration with multiple discovery tools:
- arp-scan (local network discovery)
- netdiscover (passive/active ARP reconnaissance)
- fping (enhanced ICMP ping with latency)
- masscan (ultra-fast port scanner)
- ping (traditional ICMP echo)

Each tool includes detailed usage instructions and automatic availability checking.

### 4. Custom Scan Builder

Build custom scans by selecting from organized flag categories:
- Scan Techniques (15+ options)
- Port Specification (10+ options)
- Service/Version Detection (8+ options)
- Script Scanning (12+ NSE categories)
- OS Detection (6+ options)
- Timing Templates (6 levels)
- Output Formats (5+ options)
- Firewall/IDS Evasion (8+ techniques)
- Advanced Options (10+ features)

Total: 80+ flags with detailed descriptions

### 5. CSV Export Functionality

Automatically save scan results to CSV files:
- Timestamped file creation
- Automatic parsing of nmap output
- 12-column structured format
- File management interface
- Export directory: ~/hymapper_scans/

CSV includes: Timestamp, Target, Scan Type, IP Address, Port, Protocol, State, Service, Version, Hostname, Latency, Additional Info

### 6. NSE Scripts Guide

Categorized Nmap Scripting Engine (NSE) scripts:
- Authentication scripts
- Broadcast scripts
- Brute force scripts
- Default scripts
- Discovery scripts
- DOS scripts
- Exploit scripts
- Fuzzer scripts
- Intrusive scripts
- Malware detection scripts
- Safe scripts
- Version detection scripts
- Vulnerability scripts

### 7. Educational Resources

- Complete flag descriptions with examples
- Command preview before execution
- Detailed explanations for each scan type
- Tips and warnings for router protection
- Best practices for legal scanning

---

## Installation

### Quick Install (Recommended)

```bash
git clone https://github.com/Dhype7/Hymapper.git
cd Hymapper
sudo bash install.sh
```

The installer will:
1. Check for required dependencies (nmap)
2. Detect optional tools (arp-scan, netdiscover, fping, masscan)
3. Offer to install missing tools
4. Create a system-wide shortcut
5. Make all scripts executable

### Manual Installation

```bash
git clone https://github.com/Dhype7/Hymapper.git
cd Hymapper
chmod +x hymapper.sh install.sh
sudo bash hymapper.sh
```

---

## Usage

### After Installation

Run from anywhere:
```bash
sudo hymapper
```

### Manual Execution

Run from the script directory:
```bash
sudo bash hymapper.sh
```

### Important Notes

- Root/sudo privileges are required for most scan types
- Always ensure you have permission before scanning any target
- Unauthorized scanning may be illegal in your jurisdiction

---

## Key Components

### Main Script
- **hymapper.sh** (1,590 lines) - Main interface and core functionality

### Modules
- **custom_scan_builder.sh** (410 lines) - Interactive scan builder
- **flag_categories.sh** (418 lines) - Flag categorization and descriptions
- **descriptions.sh** (201 lines) - About, help, and detailed descriptions
- **install.sh** (221 lines) - Automated installation script

**Total: 2,840+ lines of bash code**

---

## Host Discovery

Hymapper includes extensive host discovery capabilities to handle various network scenarios:

### Router Protection Handling
Many modern routers block ICMP requests, causing false positives. Hymapper addresses this with:
- Clear warnings when all hosts appear online
- Alternative discovery methods (ARP, TCP SYN, TCP ACK, UDP)
- Integration with specialized tools (arp-scan, netdiscover, fping)

### Enhanced Fping
Special fping integration shows:
- IP addresses
- Response latency in milliseconds
- Resolved hostnames
- Formatted table output

---

## CSV Export

Export scan results for documentation and analysis:

### Features
- Toggle CSV export on/off from main menu
- Automatic file creation with timestamps
- Intelligent parsing of nmap output
- 12-column structured format
- File management interface (view, delete, open directory)

### CSV Format
```
Timestamp, Target, Scan_Type, IP_Address, Port, Protocol, State, Service, Version, Hostname, Latency_ms, Additional_Info
```

### Output Location
```
~/hymapper_scans/hymapper_scan_YYYYMMDD_HHMMSS.csv
```

---

## Requirements

### Required
- **Bash** 4.0 or higher
- **Nmap** (any recent version)
- **Root/sudo privileges** for most scan types
- **Linux** (tested on Kali Linux, should work on most distributions)

### Optional (for alternative discovery)
- arp-scan
- netdiscover
- fping
- masscan

The installer can automatically detect and install these tools.

---

## Contributing

Contributions are welcome! Please feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

**Creator:** Dhype7 (Abdullah Ibrahem)

---

## Disclaimer

**IMPORTANT LEGAL NOTICE:**

This tool is provided for educational and authorized testing purposes only. Users must:
- Obtain explicit permission before scanning any network or system
- Comply with all applicable local, state, and federal laws
- Use this tool responsibly and ethically

Unauthorized network scanning may be illegal in your jurisdiction. The creator assumes no liability for misuse or damage caused by this tool.

**Always scan responsibly and legally!**

---

## Version History

**v1.3** - Current Release
- Added 12 host discovery methods
- Integrated alternative discovery tools
- Enhanced fping with latency and hostname resolution
- Implemented CSV export functionality
- Added router protection warnings
- Expanded to 40 standard scans
- Improved installation script with dependency checking

**v1.0** - Initial Release
- 25 pre-configured scans
- Custom scan builder
- Flag descriptions
- NSE scripts guide

---

**Star this repository if you find it useful!**
- ⏱️ Timing and Performance (15+ options: T0-T5, custom timings, parallelism, etc.)
- 🛡️ Firewall/IDS Evasion (12+ techniques: Fragmentation, decoys, spoofing, random data, etc.)
- 📄 Output Options (10+ formats: Normal, XML, Grepable, Script Kiddie, append, etc.)
- ⚙️ Miscellaneous Options (10+ flags: IPv6, reason, DNS options, interface, etc.)













## 🔒 Legal & Ethical Notice

⚠️ **IMPORTANT DISCLAIMER**

- Only scan systems you **own** or have **explicit written permission** to test
- Unauthorized port scanning may be **illegal** in your jurisdiction
- This tool is for **educational** and **authorized security testing** only
- Always follow **responsible disclosure** practices
- Respect the **privacy and security** of others

**The creator (Dhype7) is not responsible for any misuse of this tool.**

## 🛠️ Project Structure

```
Hymapper/
├── hymapper.sh              # Main script
├── custom_scan_builder.sh   # Custom scan builder module
├── flag_categories.sh       # Flag category menus and descriptions
├── descriptions.sh          # Comprehensive flag guide
├── install.sh               # Installation script
└── README.md               # This file
```

## 🤝 Contributing

Contributions are welcome! If you have ideas for improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

detailed explanations

## 🐛 Known Issues

- None currently. Please report any bugs you find!

## 📧 Contact & Support

- **Creator**: Dhype7
- **GitHub**: https://github.com/Dhype7/Hymapper
- **Issues**: Report bugs and suggest features via GitHub Issues

## 📜 License

This project is released for educational purposes. Use responsibly and ethically.

## 🙏 Acknowledgments

- **Nmap Project** - For creating the amazing network scanning tool
- **Kali Linux** - For the comprehensive penetration testing platform
- **Cybersecurity Community** - For continuous learning and sharing

---

<div align="center">

**Made with ❤️ by Dhype7**

*Happy Ethical Hacking! 🔐*

</div>
