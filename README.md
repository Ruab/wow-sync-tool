# wow-sync-tool
A PowerShell script designed to back up World of Warcraft game files, settings, and AddOns. This tool helps players preserve their custom configurations, keybinds, interface layouts, and other critical game data across re-installs or system migrations.

# Overview
This PowerShell script automates the process of backing up critical World of Warcraft (WoW) files and related configurations to your OneDrive. It is designed for players who want to safeguard their UI, AddOns, logs, screenshots, and WoW-related app data—making it easy to restore or migrate setups.

# Features
Timestamped backup folders for easy version tracking

Automatically backs up WoW interface settings, AddOns, screenshots, logs, and UI cache

Also includes backup of key WoW-related Windows application data (WeakAuras Companion, WowUp)

Stores all backups in your OneDrive under organized folders

# Backup Locations
World of Warcraft directories backed up:
C:\Program Files (x86)\World of Warcraft\_retail_\Cache

C:\Program Files (x86)\World of Warcraft\_retail_\Errors

C:\Program Files (x86)\World of Warcraft\_retail_\Fonts

C:\Program Files (x86)\World of Warcraft\_retail_\GPUCache

C:\Program Files (x86)\World of Warcraft\_retail_\Interface

C:\Program Files (x86)\World of Warcraft\_retail_\Logs

C:\Program Files (x86)\World of Warcraft\_retail_\Screenshots

C:\Program Files (x86)\World of Warcraft\_retail_\Utils

C:\Program Files (x86)\World of Warcraft\_retail_\WTF

AppData directories backed up:
%APPDATA%\weakauras-companion

%APPDATA%\WowUpCf

# Requirements
PowerShell 5.1 or higher

Windows OS with OneDrive enabled and signed in

Sufficient OneDrive storage space for backup files

Usage
Save the script as wow-backup.ps1

Right-click and run it as Administrator

It will automatically:

Create a timestamped folder in your OneDrive

Copy WoW and AppData folders into appropriate backup directories

