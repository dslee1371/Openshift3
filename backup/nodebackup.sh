ansible -i hosts-v2.0-logging-v0.2 all -m shell -a'sudo mkdir -p /backup/$(date +%Y%m%d)/etc/sysconfig'
ansible -i hosts-v2.0-logging-v0.2 all -m shell -a'sudo cp -aR /etc/origin /backup/$(date +%Y%m%d)/etc'
ansible -i hosts-v2.0-logging-v0.2 all -m shell -a'sudo cp -aR /etc/sysconfig/ /backup/$(date +%Y%m%d)/etc/sysconfig'
