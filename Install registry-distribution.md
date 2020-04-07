## Prereuisites - Mount docker-distribution volume
```
system off
add volume (vmware)
> configure mount
fdisk -l #check disk info.
Disk /dev/sdd: 322.1 GB, 322122547200 bytes, 629145600 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


root@fulab1-01-bastion:~# fdisk /dev/sdd
	Welcome to fdisk (util-linux 2.23.2).

	Changes will remain in memory only, until you decide to write them.
	Be careful before using the write command.

	Device does not contain a recognized partition table
	Building a new DOS disklabel with disk identifier 0xb9090073.

	Command (m for help): n
	Partition type:
	   p   primary (0 primary, 0 extended, 4 free)
	   e   extended
	Select (default p): p
	Partition number (1-4, default 1):
	First sector (2048-629145599, default 2048):
	Using default value 2048
	Last sector, +sectors or +size{K,M,G} (2048-629145599, default 629145599):
	Using default value 629145599
	Partition 1 of type Linux and of size 300 GiB is set

	Command (m for help): t
	Selected partition 1
	Hex code (type L to list all codes): 8e
	Changed type of partition 'Linux' to 'Linux LVM'

	Command (m for help): p

	Disk /dev/sdd: 322.1 GB, 322122547200 bytes, 629145600 sectors
	Units = sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk label type: dos
	Disk identifier: 0xb9090073

	   Device Boot      Start         End      Blocks   Id  System
	/dev/sdd1            2048   629145599   314571776   8e  Linux LVM

	Command (m for help): w
	The partition table has been altered!

	Calling ioctl() to re-read partition table.
	Syncing disks.

pvcreate /dev/sdd1
vgcreate reg-dist-vg /dev/sdd1
lvcreate -n reg-dist-lv -l 100%FREE reg-dist-vg
mkfs.xfs /dev/mapper/reg--dist--vg-reg--dist--lv #verify `fdisk -l` refer
fsck -y /dev/mapper/reg--dist--vg-reg--dist--lv   

mkdir /data-reg-dist
mount /dev/mapper/reg--dist--vg-reg--dist--lv  /data-reg-dist

> edit file as /etc/fstab
/dev/mapper/reg--dist--vg-reg--dist--lv /data-reg-dist xfs defaults     0 0
```

## Create registry certificate
```
> name defind
registry-dist.fulab1.futuregen.lab 
admin / admin

> Action history
command 
mkdir -p /opt/certs-registry-distribution

history
configure dns record for 'registry-dist'

command
openssl genrsa -des3 -out /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key 2048

history
Enter pass phrase for /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab > test123

command
openssl req -new -key /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key -out /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.csr

history
Common Name (eg, your name or your server's hostname) []:registry-dist.fulab1.futuregen.lab

command
cp /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key.origin

openssl rsa -in /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key.origin -out /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key

openssl x509 -req -days 3650 -in registry-dist.fulab1.futuregen.lab.csr -signkey registry-dist.fulab1.futuregen.lab.key -out registry-dist.fulab1.futuregen.lab.crt
```
## Configure docker-distribution
```
yum -y install docker-distribution

-- Edit file as cat /etc/docker-distribution/registry/config.yaml
version: 0.1
log:
  fields:
    service: registry
storage:
    cache:
        layerinfo: inmemory
    filesystem:
        rootdirectory: /data-reg-dist
http:
  addr: registry-dist.fulab1.futuregen.lab:5000
  headers:
    X-Content-Type-Options: [nosniff]
  tls:
    certificate: /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.crt
    key: /opt/certs-registry-distribution/registry-dist.fulab1.futuregen.lab.key
health:
  storagedriver:
    enabled: true
    interval: 60s
    threshold: 3
```
## Configure setting firewall
`firewall-cmd --add-port=5000/tcp`

## Copy Certificate
```
/etc/docker/certs.d/ # in `fqdn:port/__.crt`
```

## Action
```
update-ca-trust enable
systemctl daemon-reload
systemctl restart docker
systemctl restart docker-distribution
systemctl enalbe docker-distribution
```

## verify check
```
registry.redhat.io/openshift3/csi-attacher:v3.11.170
docker tag registry.redhat.io/openshift3/csi-attacher:v3.11.170 registry-dist.fulab1.futuregen.lab:5000/openshift3/csi-attacher:v3.11.170
docker push registry-dist.fulab1.futuregen.lab:5000/openshift3/csi-attacher:v3.11.170
```
## Remark - harbor docker certifacate with certificate without id authentication
```
docker pull nginx
docker tag docker.io/nginx:latest registry.fulab1.futuregen.lab:8443/ocp311170/nginx:latest
docker push registry.fulab1.futuregen.lab:8443/ocp311170/nginx:latest
```
## refer
```
id/pw configure - https://www.centlinux.com/2019/04/configure-secure-registry-docker-distribution-centos-7.html
```
## check nginx on node from bastion
```
docker pull nginx
docker tag docker.io/nginx:latest registry-dist.fulab1.futuregen.lab:5000/nginx:latest
docker pull registry-dist.fulab1.futuregen.lab:5000/nginx:latest
```

## CA
```
Install the ca-certificates package:
	`um install ca-certificates`
Enable the dynamic CA configuration feature:
	`update-ca-trust force-enable`
Add it as a new file to /etc/pki/ca-trust/source/anchors/:
	`cp foo.crt /etc/pki/ca-trust/source/anchors/`
Use command:
	`update-ca-trust extract`
```

## LL
```
sublime text tool study
system mgmgt tools (pstree, lsof, strace) study
-- yum install -y net-tools psmisc lsof strace
ssh session mgmt
```
