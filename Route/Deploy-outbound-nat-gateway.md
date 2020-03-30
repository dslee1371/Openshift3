# Deploy Outbound NAT Gateway 

## Enable IP Forwading
The next step is to enable IPv4 packet forwading from the command line.

```
sysctl -w net.ipv4.ip_forward=1
```

To preserve packet forwading on reboot, the aboce configuration value and key must also be added to the `/etc/sysctl.d/ip_forward.conf` file.

```
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/ip_forward.conf
```

## Enable NAT

IP masquerading must now be enabled using iptables.

```
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o ens192 -j MASQUERADE -s 192.168.30.0/24
firewall-cmd --reload
```

The internal node should now be able to access the public internet through the gateway server. This can tested by ping an external server form ...node.

## Reference Documentation

- https://devops.ionos.com/tutorials/deploy-outbound-nat-gateway-on-centos-7/



## fix Error
```
firewall-cmd --list-all-zones
firewall-cmd --permanent --zone=external --remove-masquerade
firewall-cmd --reload
firewall-cmd --list-all-zones

#check external if as value = no and retry
```

## cant see MASQUERADE in command as firewall-cmd --list-all-zones
```
iptables -nL -v -t nat
```


## docker insecure configuration
```
registry.fulab1.futuregen.lab:8443 (insecure), registry.access.redhat.com (secure), docker.io (secure), registry.fedoraproject.org (secure), quay.io (secure), registry.centos.org (secure), docker.io (secure)


```

## edit docker insecure configuration
```
ADD_REGISTRY='--add-registry registry.fulab1.futuregen.lab:8443 --add-registry registry.access.redhat.com '
INSECURE_REGISTRY='--insecure-registry registry.fulab1.futuregen.lab:8443'

```

## Traffic monitoring
```
tcpdump -i ens224 | grep 30.101
```

## no route issue
```
## IPv4 traffic configuration
/sbin/sysctl -w net.ipv4.ip_forward=1 # 1 value check

## edit file as /etc/sysctl.conf
net.ipv4.ip_forward=1

## masquerade check
firewall-cmd --permanent --zone=public --add-masquerade
firewall-cmd --reload
```
