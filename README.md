# Backup timer

A simple service which uses systemd timers for backup

It runs *daily* backups. Modify `backup.cfg` (installed as `~/.config/backup/backup.cfg`) to change the backup set and the backup destination. Modify the value of the `OnCalendar` variable in `~/.config/systemd/user/backup.timer` file to change the backup frequency.

## Installation

```console
# install the backup script and systemd service
$ make install-locally

# edit the configuration file: configure your backup set and destination server
$ vim ~/.config/backup/backup.cfg

# enable the daily backups
$ make enable
```

## Usage

Nothing special needed. Backups are automatic.

You can force the backup to start by running
```console
$ systemctl --user start backup.service
```

## Todo

* [ ] service test
* [x] status check
* [x] do not overwrite config file if it exists
* [x] .service file
* [x] .timer file
* [x] ansible deployment script
* [x] backup script

## Sources

* Some [slides](https://jamesbvaughan.github.io/systemd-timers-presentation/#/2)
* The same in a [.pdf presentation](https://jamesbvaughan.com/assets/systemd-timers.pdf)
* [ArchWiki page](https://wiki.archlinux.org/index.php/Systemd/Timers)
* Some [blog post](https://jason.the-graham.com/2013/03/06/how-to-use-systemd-timers/)
* [man systemd.timer](https://www.freedesktop.org/software/systemd/man/systemd.timer.html)
