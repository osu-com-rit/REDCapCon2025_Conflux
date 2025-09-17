#!/bin/bash

# REDCap Conflux Zip Creator Script
# 
# This script creates zip files from REDCap Conflux demo folders, packaging
# all necessary files (HTML, CSS, JS, JSON) for distribution or deployment.
#
# Author: [Your Name]
# Version: 1.0
# Date: $(date +%Y-%m-%d)

# =============================================================================
# CONFIGURATION - Edit these paths to match your setup
# =============================================================================

# Base directory containing your conflux demo folders
BASE_DIR="/Users/PATH/REDCapCon2025_Conflux"

# Output directory for zip files
OUTPUT_DIR="$BASE_DIR/zip_packages"

# Files to include in zip (space-separated patterns)
INCLUDE_FILES=("*.html" "*.css" "*.js" "*.json" "README.md")

# Files/directories to exclude (space-separated patterns)
EXCLUDE_PATTERNS=(".git*" "*.tmp" "*.log" ".DS_Store" "node_modules")

# Zip compression level (0-9, where 9 is highest compression)
COMPRESSION_LEVEL=6

# =============================================================================
# FUNCTIONS
# =============================================================================

# Function to display script header
display_header() {
    echo "======================================================"
    echo "REDCap Conflux Zip Creator Script"
    echo "======================================================"
    echo "Base directory: $BASE_DIR"
    echo "Output directory: $OUTPUT_DIR"
    echo "Compression level: $COMPRESSION_LEVEL"
    echo ""
}

# Function to check if zip command exists
check_dependencies() {
    if ! command -v zip &> /dev/null; then
        echo "Error: zip command not found"
        echo "Please install zip utility:"
        echo "  macOS: Already installed"
        echo "  Ubuntu: sudo apt-get install zip"
        echo "  Windows: Use Git Bash or install via Chocolatey"
        exit 1
    fi
}

# Function to create output directory
setup_output_dir() {
    if [ ! -d "$OUTPUT_DIR" ]; then
        echo "Creating output directory: $OUTPUT_DIR"
        mkdir -p "$OUTPUT_DIR" || {
            echo "Error: Could not create output directory"
            exit 1
        }
    fi
}

# Function to build exclude parameters for zip command
build_exclude_params() {
    local exclude_params=""
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        exclude_params="$exclude_params -x \"$pattern\""
    done
    echo "$exclude_params"
}

# Function to create zip for a single demo folder
create_demo_zip() {
    local demo_dir="$1"
    local demo_name=$(basename "$demo_dir")
    local zip_file="$OUTPUT_DIR/${demo_name}.zip"
    
    echo "Processing: $demo_name"
    
    # Check if demo directory exists
    if [ ! -d "$demo_dir" ]; then
        echo "  Warning: Directory not found, skipping"
        return 1
    fi
    
    # Change to demo directory
    cd "$demo_dir" || {
        echo "  Error: Could not access directory"
        return 1
    }
    
    # Build zip command with includes and excludes
    local zip_cmd="zip -r$COMPRESSION_LEVEL \"$zip_file\""
    
    # Add include patterns
    for pattern in "${INCLUDE_FILES[@]}"; do
        if ls $pattern 1> /dev/null 2>&1; then
            zip_cmd="$zip_cmd $pattern"
        fi
    done
    
    # Add exclude patterns
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        zip_cmd="$zip_cmd -x \"$pattern\""
    done
    
    # Execute zip command
    eval $zip_cmd > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        local size=$(du -h "$zip_file" | cut -f1)
        echo "  ✓ Created: ${demo_name}.zip ($size)"
        return 0
    else
        echo "  ✗ Failed to create zip file"
        return 1
    fi
}

# Function to list available demo folders
list_demo_folders() {
    echo "Available demo folders:"
    local count=0
    for dir in "$BASE_DIR"/*; do
        if [ -d "$dir" ] && [ "$(basename "$dir")" != "zip_packages" ]; then
            count=$((count + 1))
            echo "  $count. $(basename "$dir")"
        fi
    done
    
    if [ $count -eq 0 ]; then
        echo "  No demo folders found in $BASE_DIR"
        return 1
    fi
    
    return 0
}

# Function to create zip for all demo folders
create_all_zips() {
    echo "Creating zip files for all demo folders..."
    echo ""
    
    local success_count=0
    local total_count=0
    
    for dir in "$BASE_DIR"/*; do
        if [ -d "$dir" ] && [ "$(basename "$dir")" != "zip_packages" ]; then
            total_count=$((total_count + 1))
            if create_demo_zip "$dir"; then
                success_count=$((success_count + 1))
            fi
        fi
    done
    
    echo ""
    echo "Summary: $success_count/$total_count zip files created successfully"
    
    if [ $success_count -gt 0 ]; then
        echo "Zip files saved to: $OUTPUT_DIR"
        ls -la "$OUTPUT_DIR"/*.zip 2>/dev/null
    fi
}

# Function to create zip for specific demo folder
create_specific_zip() {
    local demo_name="$1"
    local demo_dir="$BASE_DIR/$demo_name"
    
    echo "Creating zip file for: $demo_name"
    echo ""
    
    if create_demo_zip "$demo_dir"; then
        echo ""
        echo "Zip file created successfully!"
        echo "Location: $OUTPUT_DIR/${demo_name}.zip"
        ls -la "$OUTPUT_DIR/${demo_name}.zip"
    else
        echo ""
        echo "Failed to create zip file for $demo_name"
        exit 1
    fi
}

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS] [DEMO_NAME]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -l, --list     List available demo folders"
    echo "  -a, --all      Create zip files for all demo folders"
    echo ""
    echo "Examples:"
    echo "  $0 -a                    # Create zips for all demos"
    echo "  $0 -l                    # List available demos"
    echo "  $0 rc_conflux_demo       # Create zip for specific demo"
    echo ""
    echo "Files included: ${INCLUDE_FILES[*]}"
    echo "Files excluded: ${EXCLUDE_PATTERNS[*]}"
}

# Function to handle cleanup on exit
cleanup() {
    cd "$BASE_DIR" 2>/dev/null
}

# =============================================================================
# MAIN SCRIPT
# =============================================================================

# Set up signal handlers
trap cleanup EXIT

# Display header
display_header

# Check dependencies
check_dependencies

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_usage
        exit 0
        ;;
    -l|--list)
        list_demo_folders
        exit $?
        ;;
    -a|--all)
        setup_output_dir
        create_all_zips
        exit 0
        ;;
    "")
        echo "No arguments provided. Use -h for help, -l to list demos, or specify a demo name."
        echo ""
        list_demo_folders
        exit 1
        ;;
    *)
        setup_output_dir
        create_specific_zip "$1"
        exit 0
        ;;
esac