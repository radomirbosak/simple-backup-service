install:
	ansible-playbook -c local -i 'localhost,' install.yaml

reinstall-run:
	ansible-playbook -c local -i 'localhost,' install.yaml
	systemctl --user daemon-reload
	systemctl --user start backup.service

enable:
	systemctl --user enable backup.timer
	systemctl --user start backup.timer
