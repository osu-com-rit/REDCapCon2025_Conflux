# REDCap Projects Auto-Sync

A lightweight file synchronization script that automatically monitors a REDCap projects directory and syncs changes to a destination folder in real-time.

## What it does

This script provides automated, real-time synchronization between your REDCap projects directory and backup location. It uses file system monitoring to detect changes and efficiently syncs only what's changed.

## Features

- **Real-time monitoring**: Detects file changes as they happen
- **Efficient syncing**: Only transfers changed files using rsync
- **Background operation**: Runs continuously without blocking your terminal
- **Persistent**: Continues running even after logout (using nohup)
- **Configurable**: Easy to modify paths and sync options

## Requirements

- **macOS** or **Linux** system
- **fswatch** - File system monitoring utility
- **rsync** - File synchronization tool (usually pre-installed)

### Installing fswatch

**macOS (using Homebrew)**:
```bash
brew install fswatch
```

**Ubuntu/Debian**:
```bash
sudo apt-get install fswatch
```

**CentOS/RHEL**:
```bash
sudo yum install fswatch
```

## Usage

1. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/redcap-auto-sync.git
   cd redcap-auto-sync
   ```

2. **Edit the script** to match your paths:
   ```bash
   nano sync_redcap.sh
   ```
   
   Update these paths in the script:
   - Source: `/PATH/REDCap_Projects` (your REDCap projects folder)
   - Destination: `/Path/www/edocs/conflux_loader/` (your sync destination)

3. **Make the script executable**:
   ```bash
   chmod +x sync_redcap.sh
   ```

4. **Run the script**:
   ```bash
   ./sync_redcap.sh
   ```

## Configuration Options

### Basic Sync (No Deletion)
The default script preserves files in the destination even if they're deleted from the source:
```bash
rsync -av /source/ /destination/
```

### Mirror Sync (With Deletion)
To make the destination an exact mirror (deletes files not in source):
```bash
rsync -av --delete /source/ /destination/
```

### Additional rsync Options
- `--dry-run` - Test the sync without actually copying files
- `--exclude='*.tmp'` - Exclude certain file types
- `--compress` - Compress data during transfer (good for remote syncing)

## How It Works

1. **fswatch** monitors the source directory for any file system events
2. When changes are detected, **xargs** processes the event
3. **rsync** efficiently synchronizes the changed files to the destination
4. **nohup** ensures the process continues running in the background
5. The `&` symbol runs the entire pipeline as a background process

## Stopping the Script

To stop the sync process:

1. **Find the process**:
   ```bash
   ps aux | grep fswatch
   ```

2. **Kill the process**:
   ```bash
   kill [process_id]
   ```

Or use:
```bash
pkill fswatch
```

## Troubleshooting

### Script not starting
- Verify fswatch is installed: `which fswatch`
- Check that source and destination paths exist
- Ensure you have read/write permissions for both directories

### Files not syncing
- Check if the script is still running: `ps aux | grep fswatch`
- Verify the source path is correct
- Test rsync manually: `rsync -av /source/ /destination/`

### Permission errors
- Ensure the destination directory is writable
- For remote syncing, verify SSH key authentication is set up

## Use Cases

- **Development**: Auto-deploy changes to a web server
- **Backup**: Real-time backup of important project files
- **Collaboration**: Keep shared directories synchronized
- **Testing**: Automatically update test environments

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:
1. Check the troubleshooting section above
2. Open an issue on GitHub
3. Review the rsync and fswatch documentation

## Acknowledgments

- Built using [fswatch](https://github.com/emcrisostomo/fswatch) for file monitoring
- Uses [rsync](https://rsync.samba.org/) for efficient file synchronization