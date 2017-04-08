#!/usr/bin/bash

CONFIG_FILE=~/.config/backup/backup.cfg

if [ ! -r $CONFIG_FILE ]; then
	echo "Config file not readable"
	exit 1
fi

source $CONFIG_FILE

FAILED=0

if [ -z "$BACKUP_SET" ]; then echo "Backup set not set"; FAILED=1; fi
if [ -z "$DEST_DIR" ]; then echo "Destination directory not set"; FAILED=1; fi
if [ -z "$TEMP_ARCHIVE" ]; then echo "Temporary archive file not set"; FAILED=1; fi
if [ -z "$TEMP_ARCHIVE_ENC" ]; then echo "Temporary encrypted archive file not set"; FAILED=1; fi
if [ -z "$PASSWD_FILE" ]; then echo "Password file not set"; FAILED=1; fi

for file in $BACKUP_SET; do
	if [ ! -r $file ]; then
		echo "'$file' from the backup set is not readable or does not exist"
		FAILED=1
	fi
done

if [ ! -r $PASSWD_FILE ]; then
	echo "Password file not readable or does not exist"
	FAILED=1
fi

exit $FAILED
