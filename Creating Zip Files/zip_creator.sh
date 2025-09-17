#!/bin/bash

# Simple REDCap Conflux Demo Zip Creator
# Creates a zip package from the current directory's demo files
#
# Usage: ./simple_zip_creator.sh [output_name]
#
# Author: Generated for REDCap Conflux Demo
# Version: 1.0

set -e  # Exit on any error

# Configuration
DEFAULT_OUTPUT_NAME="rc_conflux_demo"
OUTPUT_DIR="zip_packages"
COMPRESSION_LEVEL=6

# File patterns to include
INCLUDE_PATTERNS=("*.html" "*.css" "*.js" "*.json" "README.md" "*.md")

# Files to exclude
EXCLUDE_PATTERNS=(".DS_Store" "*.tmp" "*.log" ".git*" "node_modules")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo "=================================================="
    echo "REDCap Conflux Demo Zip Creator"
    echo "=================================================="
    echo "Current directory: $(pwd)"
    echo "Output directory: $OUTPUT_DIR"
    echo ""
}

check_files() {
    local found_files=false
    
    print_status $YELLOW "Checking for files to include..."
    
    for pattern in "${INCLUDE_PATTERNS[@]}"; do
        if compgen -G "$pattern" > /dev/null 2>&1; then
            local count=$(ls -1 $pattern 2>/dev/null | wc -l)
            echo "  Found $count file(s) matching: $pattern"
            found_files=true
        fi
    done
    
    if [ "$found_files" = false ]; then
        print_status $RED "Error: No matching files found to zip"
        echo "Looking for files matching: ${INCLUDE_PATTERNS[*]}"
        exit 1
    fi
    
    echo ""
}

create_output_dir() {
    if [ ! -d "$OUTPUT_DIR" ]; then
        print_status $YELLOW "Creating output directory: $OUTPUT_DIR"
        mkdir -p "$OUTPUT_DIR"
    fi
}

create_zip() {
    local output_name="${1:-$DEFAULT_OUTPUT_NAME}"
    local zip_file="$OUTPUT_DIR/${output_name}.zip"
    
    print_status $YELLOW "Creating zip file: ${output_name}.zip"
    
    # Remove existing zip if it exists
    if [ -f "$zip_file" ]; then
        rm "$zip_file"
        echo "  Removed existing zip file"
    fi
    
    # Build the zip command
    local zip_cmd="zip -$COMPRESSION_LEVEL \"$zip_file\""
    
    # Add files that exist
    for pattern in "${INCLUDE_PATTERNS[@]}"; do
        if compgen -G "$pattern" > /dev/null 2>&1; then
            zip_cmd="$zip_cmd $pattern"
        fi
    done
    
    # Add exclude patterns
    for exclude in "${EXCLUDE_PATTERNS[@]}"; do
        zip_cmd="$zip_cmd -x \"$exclude\""
    done
    
    # Execute the zip command
    if eval $zip_cmd > /dev/null 2>&1; then
        local file_size=$(du -h "$zip_file" | cut -f1)
        local file_count=$(unzip -l "$zip_file" 2>/dev/null | tail -1 | awk '{print $2}')
        
        print_status $GREEN "Success! Created zip file with $file_count files ($file_size)"
        echo "Location: $zip_file"
        
        # List contents
        echo ""
        echo "Zip contents:"
        unzip -l "$zip_file" | grep -v "Archive:" | grep -v "Length" | grep -v "^-" | grep -v "files$" | awk '{print "  " $4}' | grep -v "^  $"
        
    else
        print_status $RED "Error: Failed to create zip file"
        exit 1
    fi
}

show_usage() {
    echo "Usage: $0 [OPTIONS] [OUTPUT_NAME]"
    echo ""
    echo "Creates a zip file from REDCap Conflux demo files in the current directory"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo "  -l, --list    List files that would be included"
    echo ""
    echo "Arguments:"
    echo "  OUTPUT_NAME   Name for the zip file (default: $DEFAULT_OUTPUT_NAME)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Create $DEFAULT_OUTPUT_NAME.zip"
    echo "  $0 my_demo            # Create my_demo.zip"
    echo "  $0 -l                 # List files that would be included"
    echo ""
    echo "Includes: ${INCLUDE_PATTERNS[*]}"
    echo "Excludes: ${EXCLUDE_PATTERNS[*]}"
}

list_files() {
    print_header
    print_status $YELLOW "Files that would be included in zip:"
    echo ""
    
    local total_files=0
    for pattern in "${INCLUDE_PATTERNS[@]}"; do
        if compgen -G "$pattern" > /dev/null 2>&1; then
            echo "Files matching $pattern:"
            for file in $pattern; do
                if [ -f "$file" ]; then
                    local size=$(du -h "$file" | cut -f1)
                    echo "  $file ($size)"
                    total_files=$((total_files + 1))
                fi
            done
            echo ""
        fi
    done
    
    if [ $total_files -eq 0 ]; then
        print_status $RED "No files found matching include patterns"
    else
        print_status $GREEN "Total files: $total_files"
    fi
}

# Main script logic
case "${1:-}" in
    -h|--help)
        show_usage
        exit 0
        ;;
    -l|--list)
        list_files
        exit 0
        ;;
    *)
        print_header
        check_files
        create_output_dir
        create_zip "$1"
        echo ""
        print_status $GREEN "Zip creation completed successfully!"
        ;;
esac