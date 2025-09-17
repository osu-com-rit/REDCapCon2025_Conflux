#!/bin/bash

# REDCap Projects Auto-Sync Script
# 
# This script monitors a REDCap projects directory for changes and automatically
# syncs those changes to a destination directory using fswatch and rsync.
#
# Author: [Your Name]
# Version: 1.0
# Date: $(date +%Y-%m-%d)

# =============================================================================
# CONFIGURATION - Edit these paths to match your setup
# =============================================================================

# Source directory to monitor (your REDCap projects folder)
SOURCE_DIR="/Users/PATH/REDCap_Projects"

# Destination directory to sync to (web server, backup location, etc.)
DEST_DIR="/Path/www/edocs/conflux_loader/"

# Rsync options:
# -a : archive mode (preserves permissions, timestamps, etc.)
# -v : verbose output
# --delete : uncomment this line if you want to delete files in destination 
#            that don't exist in source (makes destination an exact mirror)
RSYNC_OPTIONS="-av"
# RSYNC_OPTIONS="-av --delete"  # Uncomment for mirror sync

# Log file location (optional)
LOG_FILE="$HOME/redcap_sync.log"

# =============================================================================
# FUNCTIONS
# =============================================================================

# Function to log messages with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to check if required commands exist
check_dependencies() {
    local missing_deps=()
    
    if ! command -v fswatch &> /dev/null; then
        missing_deps+=("fswatch")
    fi
    
    if ! command -v rsync &> /dev/null; then
        missing_deps+=("rsync")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Error: Missing required dependencies: ${missing_deps[*]}"
        echo "Please install the missing tools and try again."
        echo "On macOS: brew install fswatch"
        echo "On Ubuntu: sudo apt-get install fswatch"
        exit 1
    fi
}

# Function to validate directories
validate_directories() {
    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Error: Source directory does not exist: $SOURCE_DIR"
        echo "Please update the SOURCE_DIR variable in this script."
        exit 1
    fi
    
    if [ ! -d "$DEST_DIR" ]; then
        echo "Warning: Destination directory does not exist: $DEST_DIR"
        echo "Creating destination directory..."
        mkdir -p "$DEST_DIR" || {
            echo "Error: Could not create destination directory"
            exit 1
        }
    fi
    
    # Test write permissions
    if [ ! -w "$DEST_DIR" ]; then
        echo "Error: No write permission for destination directory: $DEST_DIR"
        exit 1
    fi
}

# Function to perform initial sync
initial_sync() {
    log_message "Performing initial sync from $SOURCE_DIR to $DEST_DIR"
    rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$DEST_DIR/" || {
        log_message "Error: Initial sync failed"
        exit 1
    }
    log_message "Initial sync completed successfully"
}

# Function to start monitoring
start_monitoring() {
    log_message "Starting file system monitoring..."
    log_message "Monitoring: $SOURCE_DIR"
    log_message "Syncing to: $DEST_DIR"
    log_message "Rsync options: $RSYNC_OPTIONS"
    log_message "Press Ctrl+C to stop, or use 'pkill fswatch' from another terminal"
    
    # Start fswatch with rsync
    fswatch -o "$SOURCE_DIR" | while read; do
        log_message "Change detected, syncing files..."
        rsync $RSYNC_OPTIONS "$SOURCE_DIR/" "$DEST_DIR/" && {
            log_message "Sync completed successfully"
        } || {
            log_message "Error: Sync failed"
        }
    done
}

# Function to handle script termination
cleanup() {
    log_message "Sync monitoring stopped"
    exit 0
}

# =============================================================================
# MAIN SCRIPT
# =============================================================================

# Set up signal handlers
trap cleanup INT TERM

# Display script information
echo "REDCap Projects Auto-Sync Script"
echo "================================="
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo "Log file: $LOG_FILE"
echo ""

# Check dependencies and validate setup
check_dependencies
validate_directories

# Ask user if they want to perform initial sync
read -p "Perform initial sync? This will copy all files from source to destination. (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    initial_sync
fi

# Start monitoring
start_monitoring