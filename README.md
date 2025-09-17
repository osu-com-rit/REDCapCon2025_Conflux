# REDCapCon 2025 Conflux Demo

Repository for REDCap Con 2025 Conflux demonstrations featuring dynamic form layouts and development tools.

## Repository Structure

```
REDCapCon2025_Conflux/
├── Creating Zip Files/
│   ├── zip_creator.sh           # Original automated zip creation script
│   └── README.md                # Zip tool documentation
├── Example/
│   └── rc_conflux_demo/         # Main layout switcher demo
│       ├── rc_demo.html         # HTML structure
│       ├── rc_demo.js           # JavaScript transformation logic  
│       ├── rc_demo.css          # Bootstrap-integrated styling
│       ├── loader_config.json   # REDCap Conflux configuration
│       └── README.md            # Demo-specific documentation
├── File Synchronization/
│   ├── sync_redcap.sh          # Auto-sync script for development
│   └── README.md               # Sync tool documentation
├── simple_zip_creator.sh       # Simplified zip creation script (new)
└── README.md                   # This file
```

## Featured Demo: Layout Switcher

The main demo showcases a dynamic form layout system that transforms standard REDCap form fields into responsive Card and Grid layouts.

### Key Features
- **Dual Layout Modes**: Switch between Card and Grid views
- **Bootstrap Integration**: Modern, responsive design
- **Accessibility Compliant**: Meets web accessibility standards
- **Mobile Responsive**: Optimized for all screen sizes
- **REDCap Compatible**: Integrates with Shazam form system

### Quick Start
1. Clone this repository:
   ```bash
   git clone https://github.com/osu-com-rit/REDCapCon2025_Conflux.git
   cd REDCapCon2025_Conflux
   ```

2. Navigate to the demo directory:
   ```bash
   cd Example/rc_conflux_demo/
   ```

3. Configure `loader_config.json` for your REDCap setup
4. Deploy files to your REDCap Conflux directory
5. See the demo-specific README for detailed instructions

## Development Tools

### File Synchronization (File\ Synchronization/sync_redcap.sh)
Real-time file synchronization between your development directory and REDCap server.

**Features:**
- Real-time monitoring with fswatch
- Efficient rsync-based transfers
- Background operation
- Configurable paths and options

**Usage:**
```bash
cd "File Synchronization"/
./sync_redcap.sh
```

### Zip Creation Tools

#### Original Zip Creator (Creating\ Zip\ Files/zip_creator.sh)
Advanced packaging tool for creating distribution-ready zip files from multiple demo folders.

**Features:**
- Package individual or all demo folders
- Automatic file filtering (includes HTML, CSS, JS, JSON)
- Excludes development files (.git, .tmp, etc.)
- Configurable compression levels

**Usage:**
```bash
cd "Creating Zip Files"/

# Create zip for all demos
./zip_creator.sh -a

# Create zip for specific demo
./zip_creator.sh rc_conflux_demo

# List available demos
./zip_creator.sh -l
```

#### Simplified Zip Creator (`simple_zip_creator.sh`)
Easy-to-use packaging tool for single demo directory.

**Features:**
- Package demo files from current directory
- Automatic file filtering (includes HTML, CSS, JS, JSON, Markdown)
- Excludes development files (.DS_Store, .git, .tmp, etc.)
- Configurable compression and naming
- Preview mode to see what files will be included

**Usage:**
```bash
# Copy script to demo directory
cp simple_zip_creator.sh Example/rc_conflux_demo/
cd Example/rc_conflux_demo/

# Create zip with default name (rc_conflux_demo.zip)
./simple_zip_creator.sh

# Create zip with custom name
./simple_zip_creator.sh my_custom_demo

# Preview files that would be included
./simple_zip_creator.sh -l

# Show help
./simple_zip_creator.sh -h
```

## System Requirements

### For Layout Switcher Demo
- REDCap with Conflux support
- Modern web browsers (Chrome 60+, Firefox 60+, Safari 12+)
- JavaScript enabled

### For Development Tools
- macOS or Linux system
- fswatch (for sync tool)
- zip utility (for packaging - usually pre-installed)
- rsync (usually pre-installed)

## Installation

### Demo Deployment
1. **Clone the repository:**
   ```bash
   git clone https://github.com/osu-com-rit/REDCapCon2025_Conflux.git
   cd REDCapCon2025_Conflux
   ```

2. **REDCap Integration:**
   ```bash
   # Copy demo files to your REDCap Conflux directory
   cp -r Example/rc_conflux_demo/ /path/to/redcap/conflux/
   ```

3. **Configure paths in `loader_config.json`**

4. **Test the demo in your REDCap environment**

### Development Setup
1. **Install dependencies:**
   ```bash
   # macOS
   brew install fswatch
   
   # Ubuntu/Debian  
   sudo apt-get install fswatch
   ```

2. **Configure sync script:**
   ```bash
   # Edit paths in File Synchronization/sync_redcap.sh
   nano "File Synchronization"/sync_redcap.sh
   ```

3. **Make scripts executable:**
   ```bash
   chmod +x "File Synchronization"/sync_redcap.sh
   chmod +x "Creating Zip Files"/zip_creator.sh
   chmod +x simple_zip_creator.sh
   ```

4. **Set up simplified zip creator:**
   ```bash
   # Copy simplified zip creator to demo directory
   cp simple_zip_creator.sh Example/rc_conflux_demo/
   cd Example/rc_conflux_demo
   chmod +x simple_zip_creator.sh
   ```

## Configuration

### Layout Switcher
- Modify `rc_demo.css` for styling customization
- Update `rc_demo.js` for behavior changes  
- Configure `loader_config.json` for REDCap integration

### Development Tools
- **Sync Script**: Edit `SOURCE_DIR` and `DEST_DIR` variables in `sync_redcap.sh`
- **Zip Creator**: Runs from the demo directory, automatically finds files to include
- **File Filtering**: Modify `INCLUDE_PATTERNS` and `EXCLUDE_PATTERNS` in the script if needed

## Browser Support
- Chrome 60+
- Firefox 60+ 
- Safari 12+
- Edge 79+
- Mobile: iOS 12+, Android 7+

## REDCap Integration Notes

### Conflux Requirements
- REDCap version with Conflux support
- Proper directory permissions for file uploads
- Shazam form system integration

### Field Configuration
- Use standard REDCap field types (radio, checkbox, text, notes)
- Include `edc-label` and `edc-[type]` CSS classes
- Follow alternating label/value HTML structure

## Troubleshooting

### Common Issues
1. **Layout not switching**: Verify demo_switcher radio buttons exist
2. **Styling conflicts**: Check CSS specificity and !important declarations  
3. **Sync not working**: Confirm fswatch installation and directory permissions
4. **Zip creation fails**: 
   - Ensure you're running the script from the `rc_conflux_demo` directory
   - Verify zip utility installation
   - Check file permissions

### Debug Mode
Enable logging and debugging:
```bash
# For sync script
tail -f ~/redcap_sync.log

# For zip script - preview files first
cd rc_conflux_demo
./simple_zip_creator.sh -l

# Check current directory
pwd  # Should show: /path/to/REDCapCon2025_Conflux/rc_conflux_demo
```

### Zip Creator Troubleshooting
If you get "No matching files found" with the simplified zip creator:
```bash
# Verify you're in the correct directory
pwd  # Should show: /path/to/REDCapCon2025_Conflux/Example/rc_conflux_demo

# Check for demo files in the correct directory
cd Example/rc_conflux_demo/
ls -la *.html *.css *.js *.json

# Make sure you're in the demo directory and run preview
./simple_zip_creator.sh -l
```

## Contributing

### Development Workflow
1. Clone the repository
2. Use the sync script for real-time development
3. Test changes in your REDCap environment
4. Create zip packages for distribution using the simple zip creator
5. Update documentation as needed

### Code Standards
- Maintain Bootstrap compatibility
- Follow REDCap integration patterns
- Include comprehensive comments
- Test across target browsers

## Conference Information

This repository was created for REDCap Con 2025 to demonstrate:
- Advanced form layout techniques
- Development workflow optimization  
- REDCap Conflux best practices
- Rapid prototyping workflows

## Repository Links

- **GitHub**: https://github.com/osu-com-rit/REDCapCon2025_Conflux
- **Issues**: Report bugs or request features via GitHub Issues
- **Conflux Documentation**: See REDCap Conflux official documentation

## Support

For questions about:
- **Demo implementation**: See `rc_conflux_demo/README.md`
- **Development tools**: Check script comments and troubleshooting sections above
- **REDCap integration**: Consult REDCap Conflux documentation
- **Repository issues**: Create an issue on GitHub