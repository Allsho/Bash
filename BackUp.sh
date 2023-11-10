#!/bin/bash

# Source folder (your development files on the Desktop)
source_folder="$HOME/Desktop/Dev"

# Destination folder (company's network share folder)
destination_folder="/path/to/company/network/share"

# Check for the existence of the last full backup
if [ -e "$destination_folder/full_backup.tar.gz" ]; then
    # Create an incremental backup since the last full backup
    backup_filename="incremental_backup_$(date +%Y%m%d%H%M%S).tar.gz"
    tar -czf "$destination_folder/$backup_filename" --listed-incremental="$destination_folder/incremental_snapshot.snar" -C "$source_folder" .
else
    # Create a full backup
    backup_filename="full_backup_$(date +%Y%m%d%H%M%S).tar.gz"
    tar -czf "$destination_folder/$backup_filename" -C "$source_folder" .

    # Create an incremental snapshot
    touch "$destination_folder/incremental_snapshot.snar"
fi

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed."
fi
