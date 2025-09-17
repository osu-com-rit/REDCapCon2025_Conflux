# REDCap Conflux Demo Zip Creator

A simple script to package REDCap Conflux demo files into distributable zip archives.

## Overview

This script creates zip packages from REDCap Conflux demo files in your current directory. It automatically includes common web development files (HTML, CSS, JavaScript, JSON) and documentation while excluding system files and temporary files.

## Features

- ✅ Automatically detects and includes relevant files
- ✅ Excludes unwanted system files (.DS_Store, .git*, etc.)
- ✅ Configurable output names
- ✅ File listing and preview functionality
- ✅ Colored terminal output for better visibility
- ✅ Error handling and validation

## Prerequisites

- **Unix-like system** (macOS, Linux, or Windows with Git Bash/WSL)
- **zip command** (usually pre-installed on macOS and most Linux distributions)

## Installation

1. Clone or download the REDCap Conflux demo repository:
   ```bash
   git clone https://github.com/osu-com-rit/REDCapCon2025_Conflux.git
   cd REDCapCon2025_Conflux
   ```

2. Copy the zip creator script to the demo directory:
   ```bash
   cp simple_zip_creator.sh rc_conflux_demo/
   ```

3. Change to the demo directory (this is important):
   ```bash
   cd rc_conflux_demo
   ```

4. Make the script executable:
   ```bash
   chmod +x simple_zip_creator.sh
   ```

**Important:** The script must be run from within the `rc_conflux_demo` directory where your demo files are located. The script looks for files in the current working directory.

## Usage

### Basic Usage

**Important:** Always run the script from within the `rc_conflux_demo` directory.

Create a zip with the default name (`rc_conflux_demo.zip`):
```bash
cd rc_conflux_demo
./simple_zip_creator.sh
```

Create a zip with a custom name:
```bash
cd rc_conflux_demo
./simple_zip_creator.sh my_custom_demo
```

### Options

**Show help:**
```bash
cd rc_conflux_demo
./simple_zip_creator.sh --help
./simple_zip_creator.sh -h
```

**List files that would be included (dry run):**
```bash
cd rc_conflux_demo
./simple_zip_creator.sh --list
./simple_zip_creator.sh -l
```

## File Inclusion Rules

### Included Files
The script automatically includes files matching these patterns:
- `*.html` - HTML files
- `*.css` - Stylesheet files  
- `*.js` - JavaScript files
- `*.json` - JSON configuration files
- `README.md` - Documentation
- `*.md` - Other Markdown files

### Excluded Files
The script automatically excludes:
- `.DS_Store` - macOS system files
- `*.tmp` - Temporary files
- `*.log` - Log files
- `.git*` - Git repository files
- `node_modules` - Node.js dependencies

## Output

### Directory Structure
After cloning the repository and setting up the script:
```
REDCapCon2025_Conflux/
├── simple_zip_creator.sh        # Copy this to rc_conflux_demo/
├── rc_conflux_demo/              # Work from this directory
│   ├── simple_zip_creator.sh     # Script location
│   ├── rc_demo.html
│   ├── rc_demo.css
│   ├── rc_demo.js
│   ├── loader_config.json
│   ├── README.md
│   └── zip_packages/             # Created automatically
│       └── rc_conflux_demo.zip
└── other_files...

### Script Output
The script provides clear feedback:
```
==================================================
REDCap Conflux Demo Zip Creator
==================================================
Current directory: /path/to/your/demo
Output directory: zip_packages

Checking for files to include...
  Found 1 file(s) matching: *.html
  Found 1 file(s) matching: *.css
  Found 1 file(s) matching: *.js
  Found 1 file(s) matching: *.json
  Found 1 file(s) matching: README.md

Creating zip file: rc_conflux_demo.zip
Success! Created zip file with 5 files (15K)
Location: zip_packages/rc_conflux_demo.zip

Zip contents:
  rc_demo.html
  rc_demo.css
  rc_demo.js
  loader_config.json
  README.md

Zip creation completed successfully!
```

## Configuration

You can modify the script's behavior by editing these variables at the top:

```bash
# Default output name
DEFAULT_OUTPUT_NAME="rc_conflux_demo"

# Output directory
OUTPUT_DIR="zip_packages"

# Compression level (0-9)
COMPRESSION_LEVEL=6

# File patterns to include
INCLUDE_PATTERNS=("*.html" "*.css" "*.js" "*.json" "README.md" "*.md")

# Files to exclude
EXCLUDE_PATTERNS=(".DS_Store" "*.tmp" "*.log" ".git*" "node_modules")
```

## Examples

### Example 1: Basic Demo Package
```bash
# Your directory contains:
# - rc_demo.html
# - rc_demo.css  
# - rc_demo.js
# - loader_config.json
# - README.md

./simple_zip_creator.sh

# Creates: zip_packages/rc_conflux_demo.zip
```

### Example 2: Custom Named Package
```bash
./simple_zip_creator.sh patient_dashboard_demo

# Creates: zip_packages/patient_dashboard_demo.zip
```

### Example 3: Preview Before Creating
```bash
./simple_zip_creator.sh -l

# Shows what files would be included without creating zip
```

## Troubleshooting

### "No matching files found"
- **Check your working directory:** Ensure you're in the `rc_conflux_demo` directory, not the parent directory
- **Verify the repository structure:** Make sure you've cloned from https://github.com/osu-com-rit/REDCapCon2025_Conflux
- Use `pwd` to confirm you're in the right location: `/path/to/REDCapCon2025_Conflux/rc_conflux_demo`
- Use `./simple_zip_creator.sh -l` to see what the script detects

### "zip command not found"
- **macOS:** zip should be pre-installed
- **Ubuntu/Debian:** `sudo apt-get install zip`
- **CentOS/RHEL:** `sudo yum install zip`
- **Windows:** Use Git Bash or install via Chocolatey: `choco install zip`

### Permission errors
- Make sure the script is executable: `chmod +x simple_zip_creator.sh`
- Ensure you have write permissions in the current directory

### Script won't run
- Check the shebang line points to bash: `#!/bin/bash`
- Try running with: `bash simple_zip_creator.sh`

## Integration with REDCap Conflux

This zip creator is designed to work with the REDCap Conflux development workflow:

1. **Development Phase:** Work on your demo files using Conflux Loader
2. **Testing Phase:** Test your demo in your local REDCap environment
3. **Packaging Phase:** Use this script to create distributable packages
4. **Distribution Phase:** Share the zip files with colleagues or deploy to production

## Contributing

To modify or extend this script:

1. The main logic is in the `create_zip()` function
2. File patterns are configured in the arrays at the top
3. Add new functionality as separate functions
4. Maintain the colored output for user experience

## License

This script is provided as-is for REDCap Conflux development workflows. Feel free to modify and distribute according to your organization's policies.

---

**Created for REDCap Conflux Demo Packaging**  
*Simplifying the path from prototype to production*