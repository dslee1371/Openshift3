# OCP 311 installation 

## Acchitecture 구성

```
dns.fulab1.futuregen.lab, repository, docker registry, image volume
master01, master02, master03: console, etcd
infra01, infra02: router
univ1, univ2, univ3: compute

server	cpu 	memory	os-disk	docker-storage 	docker-volume
-------------------------------------------------------------
fulab1-01-bastion.fulab1.futuregen.lab 	4	16G	   300G	 300G	300G
fulab1-02-nf1.fulab1.futuregen.lab 	2	8G		300G	300G	300G
fulab1-21-master1.fulab1.futuregen.lab 	4 	16G	300G	300G
fulab1-22-master2.fulab2.futuregen.lab 	4	16G	300G	300G
fulab1-23-masger3.fulab3.futuregen.lab 	4	16G	300G	300G
fulab1-41-infra1.fulab1.futuregen.lab 	4	16G	300G	300G
fulab1-42-infra2.fulab2.futuregen.lab 	4	16G	300G	300G
fulab1-61-univ1.fulab1.futuregen.lab 	2	8G	300G	300G
fulab1-62-univ2.fulab1.futuregen.lab 	2	8G	300G	300G
fulab1-63-univ3.fulab1.futuregen.lab 	2	8G 	300G	300G
```

DNS
```
options {
        listen-on port 53 { any; };
        listen-on-v6 port 53 { any; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        allow-query     { any; };

        recursion yes;
        forward first;
        forwarders{
        168.126.63.1;
            8.8.8.8;
        };

        dnssec-enable yes;
        dnssec-validation yes;
        dnssec-lookaside auto;

        /* Path to ISC DLV key */
        bindkeys-file "/etc/named.iscdlv.key";

        managed-keys-directory "/var/named/dynamic";

        pid-file "/run/named/named.pid";
        session-keyfile "/run/named/session.key";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

include "/etc/rndc.key";

controls {
        inet 127.0.0.1 port 953
        allow { 127.0.0.1; } keys { "rndc-key"; };
};

include "/etc/named.rfc1912.zones";
include "futuregen-ocp.lab.key";


zone "futuregen.lab" IN {
        type master;
        file "dynamic/futuregen-ocp.db";
        allow-update { none; };
};

```

## check conf 파일
```
 # named-checkconf -z /etc/named.conf

 zone localhost.localdomain/IN: loaded serial 0
 zone localhost/IN: loaded serial 0
 zone  1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa/IN:  loaded serial 0
 zone 1.0.0.127.in-addr.arpa/IN: loaded serial 0
 zone 0.in-addr.arpa/IN: loaded serial 0
 zone futuregen.lab/IN: loaded serial 170331


출처: https://jehna.tistory.com/12 [Jehna :)]
```

## check zone file
```
 # named-checkzone ns.futuregen.lab.zone /var/named/nari.com.zone
 zone ns.futuregen.lab.zone/IN: loaded serial 170331 
 OK


 # named-checkzone www.futuregen.lab.zone /var/named/nari.com.zone 
 zone www.futuregen.lab.zone/IN: loaded serial 170331
 OK


출처: https://jehna.tistory.com/12 [Jehna :)]
```

## firewall
```
firewall-cmd --permanent --add-port=53/udp
firewall-cmd --reload
```

## Zone
```
$ORIGIN .
$TTL 86400 ; 1 seconds (for fulab1ing only)
futuregen.lab IN SOA dns.futuregen.lab. hostmaster.futuregen.lab. (
                   20191223 ; serial
                   3H ; refresh
                   15 ; retry
                   1W ; expire
                   3H ; minimum (10 seconds)
                   )
                   NS dns.futuregen.lab.
                   A 192.168.30.10
$ORIGIN futuregen.lab
dns             IN      A       192.168.30.10

$ORIGIN apps.fulab1.futuregen.lab.
$TTL 180        ; 3 minutes
* A 192.168.30.11

$ORIGIN fulab1.futuregen.lab.
$TTL 180        ; 3 minutes
#_etcd-server-ssl._tcp SRV 0 10 2380 etcd-0
#_etcd-server-ssl._tcp SRV 0 10 2380 etcd-1
#_etcd-server-ssl._tcp SRV 0 10 2380 etcd-2
#
#etcd-0 A 192.168.30.101
#etcd-1 A 192.168.30.102
#etcd-2 A 192.168.30.103
#
#control-plane-0 A 192.168.30.101
#control-plane-1 A 192.168.30.102
#control-plane-2 A 192.168.30.103
#
#api A 192.168.0.11
#api-int A 192.168.0.11
#
#compute-0 A 192.168.0.24
#compute-1 A 192.168.0.25
#compute-2 A 192.168.0.26
#registry A 192.168.0.10

fulab1-01-bastion A 192.168.30.10
fulab1-02-nfs1A 192.168.30.11
fulab1-21-master1 A 192.168.30.101
fulab1-22-master2 A 192.168.30.102
fulab1-23-master3 A 192.168.30.103
fulab1-41-infra1 A 192.168.30.121
fulab1-42-infra2 A 192.168.30.122
fulab1-61-univ1 A 192.168.30.201
fulab1-62-univ2 A 192.168.30.202
fulab1-63-univ3 A 192.168.30.203
```

## Check name resolv 
```
dig fulab1-01-bastion.fulab1.futuregen.lab +short
dig fulab1-02-nfs1.fulab1.futuregen.lab +short
dig fulab1-21-master1.fulab1.futuregen.lab +short
dig fulab1-22-master2.fulab1.futuregen.lab +short
dig fulab1-23-master3.fulab1.futuregen.lab +short
dig fulab1-41-infra1.fulab1.futuregen.lab +short
dig fulab1-42-infra2.fulab1.futuregen.lab +short
dig fulab1-61-univ1.fulab1.futuregen.lab +short
dig fulab1-62-univ2.fulab1.futuregen.lab +short
dig fulab1-63-univ3.fulab1.futuregen.lab +short
```

## Check hosts
```
ssh fulab1-01-bastion.fulab1.futuregen.lab
ssh fulab1-02-nfs1.fulab1.futuregen.lab
ssh fulab1-21-master1.fulab1.futuregen.lab
ssh fulab1-22-master2.fulab1.futuregen.lab
ssh fulab1-23-master3.fulab1.futuregen.lab
ssh fulab1-41-infra1.fulab1.futuregen.lab
ssh fulab1-42-infra2.fulab1.futuregen.lab
ssh fulab1-61-univ1.fulab1.futuregen.lab
ssh fulab1-62-univ2.fulab1.futuregen.lab
ssh fulab1-63-univ3.fulab1.futuregen.lab
```

## Copy ssh key
```
ssh-copy-id fulab1-01-bastion.fulab1.futuregen.lab
ssh-copy-id fulab1-02-nfs1.fulab1.futuregen.lab
ssh-copy-id fulab1-21-master1.fulab1.futuregen.lab
ssh-copy-id fulab1-22-master2.fulab1.futuregen.lab
ssh-copy-id fulab1-23-master3.fulab1.futuregen.lab
ssh-copy-id fulab1-41-infra1.fulab1.futuregen.lab
ssh-copy-id fulab1-42-infra2.fulab1.futuregen.lab
ssh-copy-id fulab1-61-univ1.fulab1.futuregen.lab
ssh-copy-id fulab1-62-univ2.fulab1.futuregen.lab
ssh-copy-id fulab1-63-univ3.fulab1.futuregen.lab
```

## edit inventory file
```
[masters]
fulab1-21-master1.fulab1.futuregen.lab openshift_ip=192.168.30.101 openshift_public_ip=192.168.30.101 openshift_public_hostname=fulab1-21-master1.fulab1.futuregen.lab
fulab1-22-master2.fulab1.futuregen.lab openshift_ip=192.168.30.102 openshift_public_ip=192.168.30.102 openshift_public_hostname=fulab1-22-master2.fulab1.futuregen.lab
fulab1-23-master3.fulab1.futuregen.lab openshift_ip=192.168.30.103 openshift_public_ip=192.168.30.103 openshift_public_hostname=fulab1-23-master3.fulab1.futuregen.lab

[etcd]
fulab1-21-master1.fulab1.futuregen.lab openshift_ip=192.168.30.101 openshift_public_ip=192.168.30.101 openshift_public_hostname=fulab1-21-master1.fulab1.futuregen.lab
fulab1-22-master2.fulab1.futuregen.lab openshift_ip=192.168.30.102 openshift_public_ip=192.168.30.102 openshift_public_hostname=fulab1-22-master2.fulab1.futuregen.lab
fulab1-23-master3.fulab1.futuregen.lab openshift_ip=192.168.30.103 openshift_public_ip=192.168.30.103 openshift_public_hostname=fulab1-23-master3.fulab1.futuregen.lab

[nodes]
## Master
fulab1-21-master1.fulab1.futuregen.lab openshift_ip=192.168.30.101 openshift_public_ip=192.168.30.101 openshift_public_hostname=fulab1-21-master1.fulab1.futuregen.lab openshift_node_group_name='node-config-master'
fulab1-22-master2.fulab1.futuregen.lab openshift_ip=192.168.30.102 openshift_public_ip=192.168.30.102 openshift_public_hostname=fulab1-22-master2.fulab1.futuregen.lab openshift_node_group_name='node-config-master'
fulab1-23-master3.fulab1.futuregen.lab openshift_ip=192.168.30.103 openshift_public_ip=192.168.30.103 openshift_public_hostname=fulab1-23-master3.fulab1.futuregen.lab openshift_node_group_name='node-config-master'

## Infra
fulab1-41-infra1.fulab1.futuregen.lab openshift_ip=192.168.30.121 openshift_public_ip=192.168.30.121  openshift_public_hostname=fulab1-41-infra1.fulab1.futuregen.lab openshift_node_group_name='node-config-infra'
fulab1-42-infra2.fulab1.futuregen.lab openshift_ip=192.168.30.122 openshift_public_ip=192.168.30.122  openshift_public_hostname=fulab1-42-infra2.fulab1.futuregen.lab openshift_node_group_name='node-config-infra'


## Node
fulab1-61-univ1.fulab1.futuregen.lab openshift_ip=192.168.30.201 openshift_public_ip=192.168.30.201 openshift_public_hostname=fulab1-61-univ1.fulab1.futuregen.lab openshift_node_group_name='node-config-compute'
fulab1-62-univ2.fulab1.futuregen.lab openshift_ip=192.168.30.202 openshift_public_ip=192.168.30.202 openshift_public_hostname=fulab1-62-univ2.fulab1.futuregen.lab openshift_node_group_name='node-config-compute'
fulab1-63-univ3.fulab1.futuregen.lab openshift_ip=192.168.30.203 openshift_public_ip=192.168.30.203 openshift_public_hostname=fulab1-63-univ3.fulab1.futuregen.lab openshift_node_group_name='node-config-compute'
```

## docker pull that OpenShift Container Platform infrastructure component images
```
docker pull registry.redhat.io/openshift3/apb-base:v3.11.170
docker pull registry.redhat.io/openshift3/apb-tools:v3.11.170
docker pull registry.redhat.io/openshift3/automation-broker-apb:v3.11.170
docker pull registry.redhat.io/openshift3/csi-attacher:v3.11.170
docker pull registry.redhat.io/openshift3/csi-driver-registrar:v3.11.170
docker pull registry.redhat.io/openshift3/csi-livenessprobe:v3.11.170
docker pull registry.redhat.io/openshift3/csi-provisioner:v3.11.170
docker pull registry.redhat.io/openshift3/grafana:v3.11.170
docker pull registry.redhat.io/openshift3/local-storage-provisioner:v3.11.170
docker pull registry.redhat.io/openshift3/manila-provisioner:v3.11.170
docker pull registry.redhat.io/openshift3/mariadb-apb:v3.11.170
docker pull registry.redhat.io/openshift3/mediawiki:v3.11.170
docker pull registry.redhat.io/openshift3/mediawiki-apb:v3.11.170
docker pull registry.redhat.io/openshift3/mysql-apb:v3.11.170
docker pull registry.redhat.io/openshift3/ose-ansible-service-broker:v3.11.170
docker pull registry.redhat.io/openshift3/ose-cli:v3.11.170
docker pull registry.redhat.io/openshift3/ose-cluster-autoscaler:v3.11.170
docker pull registry.redhat.io/openshift3/ose-cluster-capacity:v3.11.170
docker pull registry.redhat.io/openshift3/ose-cluster-monitoring-operator:v3.11.170
docker pull registry.redhat.io/openshift3/ose-console:v3.11.170
docker pull registry.redhat.io/openshift3/ose-configmap-reloader:v3.11.170
docker pull registry.redhat.io/openshift3/ose-control-plane:v3.11.170
docker pull registry.redhat.io/openshift3/ose-deployer:v3.11.170
docker pull registry.redhat.io/openshift3/ose-descheduler:v3.11.170
docker pull registry.redhat.io/openshift3/ose-docker-builder:v3.11.170
docker pull registry.redhat.io/openshift3/ose-docker-registry:v3.11.170
docker pull registry.redhat.io/openshift3/ose-efs-provisioner:v3.11.170
docker pull registry.redhat.io/openshift3/ose-egress-dns-proxy:v3.11.170
docker pull registry.redhat.io/openshift3/ose-egress-http-proxy:v3.11.170
docker pull registry.redhat.io/openshift3/ose-egress-router:v3.11.170
docker pull registry.redhat.io/openshift3/ose-haproxy-router:v3.11.170
docker pull registry.redhat.io/openshift3/ose-hyperkube:v3.11.170
docker pull registry.redhat.io/openshift3/ose-hypershift:v3.11.170
docker pull registry.redhat.io/openshift3/ose-keepalived-ipfailover:v3.11.170
docker pull registry.redhat.io/openshift3/ose-kube-rbac-proxy:v3.11.170
docker pull registry.redhat.io/openshift3/ose-kube-state-metrics:v3.11.170
docker pull registry.redhat.io/openshift3/ose-metrics-server:v3.11.170
docker pull registry.redhat.io/openshift3/ose-node:v3.11.170
docker pull registry.redhat.io/openshift3/ose-node-problem-detector:v3.11.170
docker pull registry.redhat.io/openshift3/ose-operator-lifecycle-manager:v3.11.170
docker pull registry.redhat.io/openshift3/ose-ovn-kubernetes:v3.11.170
docker pull registry.redhat.io/openshift3/ose-pod:v3.11.170
docker pull registry.redhat.io/openshift3/ose-prometheus-config-reloader:v3.11.170
docker pull registry.redhat.io/openshift3/ose-prometheus-operator:v3.11.170
docker pull registry.redhat.io/openshift3/ose-recycler:v3.11.170
docker pull registry.redhat.io/openshift3/ose-service-catalog:v3.11.170
docker pull registry.redhat.io/openshift3/ose-template-service-broker:v3.11.170
docker pull registry.redhat.io/openshift3/ose-tests:v3.11.170
docker pull registry.redhat.io/openshift3/ose-web-console:v3.11.170
docker pull registry.redhat.io/openshift3/postgresql-apb:v3.11.170
docker pull registry.redhat.io/openshift3/registry-console:v3.11.170
docker pull registry.redhat.io/openshift3/snapshot-controller:v3.11.170
docker pull registry.redhat.io/rhel7/etcd:3.2.22
```

## For on-premise installations on x86_64 server.
```
docker pull registry.redhat.io/openshift3/ose-efs-provisioner:v3.11.170
```

## Component images
```
docker pull registry.redhat.io/openshift3/metrics-cassandra:v3.11.170
docker pull registry.redhat.io/openshift3/metrics-hawkular-metrics:v3.11.170
docker pull registry.redhat.io/openshift3/metrics-hawkular-openshift-agent:v3.11.170
docker pull registry.redhat.io/openshift3/metrics-heapster:v3.11.170
docker pull registry.redhat.io/openshift3/metrics-schema-installer:v3.11.170
docker pull registry.redhat.io/openshift3/oauth-proxy:v3.11.170
docker pull registry.redhat.io/openshift3/ose-logging-curator5:v3.11.170
docker pull registry.redhat.io/openshift3/ose-logging-elasticsearch5:v3.11.170
docker pull registry.redhat.io/openshift3/ose-logging-eventrouter:v3.11.170
docker pull registry.redhat.io/openshift3/ose-logging-fluentd:v3.11.170
docker pull registry.redhat.io/openshift3/ose-logging-kibana5:v3.11.170
docker pull registry.redhat.io/openshift3/prometheus:v3.11.170
docker pull registry.redhat.io/openshift3/prometheus-alertmanager:v3.11.170
docker pull registry.redhat.io/openshift3/prometheus-node-exporter:v3.11.170
docker pull registry.redhat.io/cloudforms46/cfme-openshift-postgresql
docker pull registry.redhat.io/cloudforms46/cfme-openshift-memcached
docker pull registry.redhat.io/cloudforms46/cfme-openshift-app-ui
docker pull registry.redhat.io/cloudforms46/cfme-openshift-app
docker pull registry.redhat.io/cloudforms46/cfme-openshift-embedded-ansible
docker pull registry.redhat.io/cloudforms46/cfme-openshift-httpd
docker pull registry.redhat.io/cloudforms46/cfme-httpd-configmap-generator
docker pull registry.redhat.io/rhgs3/rhgs-server-rhel7
docker pull registry.redhat.io/rhgs3/rhgs-volmanager-rhel7
docker pull registry.redhat.io/rhgs3/rhgs-gluster-block-prov-rhel7
docker pull registry.redhat.io/rhgs3/rhgs-s3-server-rhel7
```

## S2I builder images
```
docker pull registry.redhat.io/jboss-amq-6/amq63-openshift:v3.11.170
docker pull registry.redhat.io/jboss-datagrid-7/datagrid71-openshift:v3.11.170
docker pull registry.redhat.io/jboss-datagrid-7/datagrid71-client-openshift:v3.11.170
docker pull registry.redhat.io/jboss-datavirt-6/datavirt63-openshift:v3.11.170
docker pull registry.redhat.io/jboss-datavirt-6/datavirt63-driver-openshift:v3.11.170
docker pull registry.redhat.io/jboss-decisionserver-6/decisionserver64-openshift:v3.11.170
docker pull registry.redhat.io/jboss-processserver-6/processserver64-openshift:v3.11.170
docker pull registry.redhat.io/jboss-eap-6/eap64-openshift:v3.11.170
docker pull registry.redhat.io/jboss-eap-7/eap71-openshift:v3.11.170
docker pull registry.redhat.io/jboss-webserver-3/webserver31-tomcat7-openshift:v3.11.170
docker pull registry.redhat.io/jboss-webserver-3/webserver31-tomcat8-openshift:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-2-rhel7:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-agent-maven-35-rhel7:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-agent-nodejs-8-rhel7:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-slave-base-rhel7:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-slave-maven-rhel7:v3.11.170
docker pull registry.redhat.io/openshift3/jenkins-slave-nodejs-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/mongodb-32-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/mysql-57-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/perl-524-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/php-56-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/postgresql-95-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/python-35-rhel7:v3.11.170
docker pull registry.redhat.io/redhat-sso-7/sso70-openshift:v3.11.170
docker pull registry.redhat.io/rhscl/ruby-24-rhel7:v3.11.170
docker pull registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:v3.11.170
docker pull registry.redhat.io/redhat-sso-7/sso71-openshift:v3.11.170
docker pull registry.redhat.io/rhscl/nodejs-6-rhel7:v3.11.170
docker pull registry.redhat.io/rhscl/mariadb-101-rhel7:v3.11.170
```

## Create repo
```
for repo in \
rhel-7-server-rpms \
rhel-7-server-extras-rpms \
rhel-7-server-ansible-2.8-rpms \
rhel-7-server-ose-3.11-rpms
do
  reposync --gpgcheck -lm --repoid=${repo} --download_path=/root/repos 
  createrepo -v /root/repos/${repo} -o /root/repos${repo} 
done
```
