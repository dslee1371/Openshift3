## Issue 
root@fulab1-01-bastion:/var/lib# docker-storage-setup
INFO: Wipe Signatures is set to true. Any signatures on /dev/sdb will be wiped.
/dev/sdb: 2 bytes were erased at offset 0x000001fe (dos): 55 aa
/dev/sdb: calling ioclt to re-read partition table: 성공
INFO: Writing zeros to first 4MB of device /dev/sdb
4+0 records in
4+0 records out
4194304 bytes (4.2 MB) copied, 0.0023916 s, 1.8 GB/s
INFO: Device node /dev/sdb1 exists.
  Physical volume "/dev/sdb1" successfully created.
  Volume group "docker-vg" successfully created
INFO: Found an already configured thin pool /dev/mapper/docker--vg-docker--pool in /etc/sysconfig/docker-storage
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 60 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 55 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 50 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 45 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 40 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 35 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 30 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 25 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 20 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 15 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 10 seconds
INFO: Waiting for device /dev/mapper/docker--vg-docker--pool to be available. Wait time remaining is 5 seconds
INFO: Timed out waiting for device /dev/mapper/docker--vg-docker--pool
ERROR: Already configured thin pool /dev/mapper/docker--vg-docker--pool is not available. If thin pool exists and is taking longer to activate, set DEVICE_WAIT_TIMEOUT to a higher value and retry. If thin pool does not exist any more, remove /etc/sysconfig/docker-storage and retry
root@
