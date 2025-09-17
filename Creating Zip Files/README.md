# Zip Creator Script

A shell script that automatically creates zip files from REDCap Conflux demo folders for easy distribution and deployment.

## What it does

This script scans your project directory for demo folders and creates compressed zip files containing all the necessary files (HTML, CSS, JavaScript, JSON) while excluding development artifacts like .git folders and temporary files.

## Features

- **Selective packaging**: Only includes relevant files (HTML, CSS, JS, JSON, README)
- **Automatic exclusions**: Skips development files (.git, .tmp, .DS_Store, etc.)
- **Batch processing**: Create zips for all demos or target specific ones
- **Size reporting**: Shows compressed file sizes after creation
- **Configurable compression**: Adjustable compression levels (0-9)
- **Error handling**: Validates directories and provides clear feedback

## Requirements

- **macOS** or **Linux** system
- **zip** command-line utility (usually pre-installed)
- Proper read permissions for source directories
- Write permissions for output directory

### Checking zip installation
```bash
zip --version
```

If not installed:
- **Ubuntu/Debian**: `sudo apt-get install zip`
- **CentOS/RHEL**: `sudo yum install zip` 
- **Windows**: Use Git Bash or install via Chocolatey

## Usage

### Make the script executable
```bash
chmod +x zip_creator.sh
```

### Basic commands

**Create zips for all demo folders:**
```bash
./zip_creator.sh -a
```

**List available demo folders:**
```bash
./zip_creator.sh -l
```

**Create zip for specific demo:**
```bash
./zip_creator.sh rc_conflux_demo
```

**Show help:**
```bash
./zip_creator.sh -h
```

## Configuration

Edit the script variables to match your setup:

```bash
# Base directory containing demo folders
BASE_DIR="/Users/PATH/REDCapCon2025_Conflux"

# Output directory for zip files  
OUTPUT_DIR="$BASE_DIR/zip_packages"

# Files to include (patterns)
INCLUDE_FILES=("*.html" "*.css" "*.js" "*.json" "README.md")

# Files to exclude (patterns)
EXCLUDE_PATTERNS=(".git*" "*.tmp" "*.log" ".DS_Store" "node_modules")

# Compression level (0-9, where 9 is highest)
COMPRESSION_LEVEL=6
```

## File Filtering

### Included by default:
- `*.html` - HTML template files
- `*.css` - Stylesheet files  
- `*.js` - JavaScript files
- `*.json` - Configuration files
- `README.md` - Documentation

### Excluded by default:
- `.git*` - Git repository files
- `*.tmp` - Temporary files
- `*.log` - Log files
- `.DS_Store` - macOS system files
- `node_modules` - Node.js dependencies

## Output Structure

The script creates a `zip_packages` folder containing:
```
zip_packages/
├── rc_conflux_demo.zip
├── another_demo.zip
└── third_demo.zip
```

Each zip contains the demo's essential files:
```
demo.zip
├── loader_config.json
├── demo.html
├── demo.css  
├── demo.js
└── README.md
```

## Examples

### Create all zips with verbose output:
```bash
./zip_creator.sh -a
```
Output:
```
======================================================
REDCap Conflux Zip Creator Script  
======================================================
Base directory: /Users/PATH/REDCapCon2025_Conflux
Output directory: /Users/PATH/REDCapCon2025_Conflux/zip_packages

Creating zip files for all demo folders...

Processing: rc_conflux_demo
  ✓ Created: rc_conflux_demo.zip (15K)
Processing: another_demo  
  ✓ Created: another_demo.zip (12K)

Summary: 2/2 zip files created successfully
```

### Target specific demo:
```bash
./zip_creator.sh Example/rc_conflux_demo
```

### List available demos:
```bash
./zip_creator.sh -l
```
Output:
```
Available demo folders:
  1. Example/rc_conflux_demo
  2. File Synchronization
```

## Troubleshooting

### Script won't run
- Check file permissions: `ls -la zip_creator.sh`
- Make executable: `chmod +x zip_creator.sh`
- Verify zip installation: `zip --version`

### No zip files created
- Confirm BASE_DIR path exists and contains demo folders
- Check that demo folders contain the expected file types
- Verify write permissions for OUTPUT_DIR

### Permission errors
- Ensure read access to source directories
- Check write permissions for output directory
- Run with appropriate user privileges

### Empty zip files
- Verify INCLUDE_FILES patterns match your actual files
- Check that files aren't being caught by EXCLUDE_PATTERNS
- Test manually: `ls *.html *.css *.js *.json` in demo folder

## Customization

### Add new file types:
```bash
INCLUDE_FILES=("*.html" "*.css" "*.js" "*.json" "*.md" "*.txt")
```

### Exclude additional patterns:
```bash
EXCLUDE_PATTERNS=(".git*" "*.tmp" "*.log" ".DS_Store" "backup*")
```

### Change compression level:
```bash
COMPRESSION_LEVEL=9  # Maximum compression (slower)
COMPRESSION_LEVEL=1  # Minimal compression (faster)
```

### Different output location:
```bash
OUTPUT_DIR="/Users/your-name/Desktop/conflux-packages"
```

## Integration with Development Workflow

1. **Develop** your Conflux demos in individual folders
2. **Test** using the sync script for live updates  
3. **Package** with this zip creator when ready for distribution
4. **Deploy** zip files to REDCap environments

## Script Limitations

- Only processes folders (not individual files)
- Requires specific directory structure
- Depends on file extensions for filtering
- No built-in compression format options (only zip)

## Contributing

To modify this script:
1. Test changes with `-l` option first
2. Use small test directories to verify filtering
3. Check cross-platform compatibility if needed
4. Update documentation for any new features