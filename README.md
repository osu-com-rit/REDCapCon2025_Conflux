# REDCapCon 2025 Conflux Demo

Repository for REDCap Con 2025 Conflux demonstrations featuring dynamic form layouts and development tools.

## Repository Structure

```
REDCapCon2025_Conflux/
├── Creating Zip Files/
│   ├── zip_creator.sh           # Automated zip creation script
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
1. Navigate to `Example/rc_conflux_demo/`
2. Configure `loader_config.json` for your REDCap setup
3. Deploy files to your REDCap Conflux directory
4. See the demo-specific README for detailed instructions

## Development Tools

### File Synchronization (`sync_redcap.sh`)
Real-time file synchronization between your development directory and REDCap server.

**Features:**
- Real-time monitoring with fswatch
- Efficient rsync-based transfers
- Background operation
- Configurable paths and options

**Usage:**
```bash
cd "File Synchronization"
./sync_redcap.sh
```

### Zip Creation (`zip_creator.sh`)
Automated packaging tool for creating distribution-ready zip files of your Conflux demos.

**Features:**
- Package individual or all demo folders
- Automatic file filtering (includes HTML, CSS, JS, JSON)
- Excludes development files (.git, .tmp, etc.)
- Configurable compression levels

**Usage:**
```bash
cd "Creating Zip Files"

# Create zip for all demos
./zip_creator.sh -a

# Create zip for specific demo
./zip_creator.sh rc_conflux_demo

# List available demos
./zip_creator.sh -l
```

## System Requirements

### For Layout Switcher Demo
- REDCap with Conflux support
- Modern web browsers (Chrome 60+, Firefox 60+, Safari 12+)
- JavaScript enabled

### For Development Tools
- macOS or Linux system
- fswatch (for sync tool)
- zip utility (for packaging)
- rsync (usually pre-installed)

## Installation

### Demo Deployment
1. **REDCap Integration:**
   ```bash
   # Copy demo files to your REDCap Conflux directory
   cp -r Example/rc_conflux_demo/ /path/to/redcap/conflux/
   ```

2. **Configure paths in `loader_config.json`**

3. **Test the demo in your REDCap environment**

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
   # Edit paths in sync_redcap.sh
   nano "File Synchronization/sync_redcap.sh"
   ```

3. **Make scripts executable:**
   ```bash
   chmod +x "File Synchronization/sync_redcap.sh"
   chmod +x "Creating Zip Files/zip_creator.sh"
   ```

## Configuration

### Layout Switcher
- Modify `rc_demo.css` for styling customization
- Update `rc_demo.js` for behavior changes  
- Configure `loader_config.json` for REDCap integration

### Development Tools
- **Sync Script**: Edit `SOURCE_DIR` and `DEST_DIR` variables
- **Zip Creator**: Adjust `BASE_DIR` and `OUTPUT_DIR` paths
- **File Filtering**: Modify `INCLUDE_FILES` and `EXCLUDE_PATTERNS` arrays

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
4. **Zip creation fails**: Verify zip utility installation and path configuration

### Debug Mode
Enable logging in scripts:
```bash
# For sync script
tail -f ~/redcap_sync.log

# For zip script  
./create_zip.sh -l  # List available demos first
```

## Contributing

### Development Workflow
1. Use the sync script for real-time development
2. Test changes in your REDCap environment
3. Create zip packages for distribution
4. Update documentation as needed

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

## Support

For questions about:
- **Demo implementation**: See individual README files in each demo folder
- **Development tools**: Check script comments and troubleshooting sections
- **REDCap integration**: Consult REDCap Conflux documentation