#!/usr/bin/bash


# run sanity-check
SANITY_CHECK_SCRIPT=~/.local/bin/backup-sanity-check.sh
if [ -f $SANITY_CHECK_SCRIPT ]; then
    echo 1
    if ! $SANITY_CHECK_SCRIPT; then
        echo 2
        echo "Backup sanity check failed, check 'journalctl --user-unit backup.service' for logs"
        notify-send backup "Backup sanity check failed, see logs"
        exit 1
    fi
fi

# load variables
source ~/.config/backup/backup.cfg


function cleanup {
    if [ -f $TEMP_ARCHIVE ]; then rm $TEMP_ARCHIVE; fi
    if [ -f $TEMP_ARCHIVE_ENC ]; then rm $TEMP_ARCHIVE_ENC; fi
}

function catch_error {
    if [ "$?" != "0" ]; then
        echo "$1"
        /usr/bin/notify-send backup "$1"
        cleanup
        exit 1
    fi
}

# inform
/usr/bin/notify-send backup "backup started"

# commpress to tar
/usr/bin/tar cvzf $TEMP_ARCHIVE \
    $BACKUP_SET
catch_error "Creation of the backup tarball failed"

# encrypt
/usr/bin/gpg2 -c --batch --yes \
    -o $TEMP_ARCHIVE_ENC \
    --passphrase-file $PASSWD_FILE \
    $TEMP_ARCHIVE
catch_error "Encryption of the compressed archive failed"

# copy
/usr/bin/scp -oBatchMode=yes $TEMP_ARCHIVE_ENC $DEST_DIR
catch_error "Copying of the backup archive failed"

# remove temp files
cleanup

# inform
/usr/bin/notify-send backup "backup complete"
