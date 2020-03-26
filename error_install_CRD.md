## Installation Error - Waite for the ServiceMonitor CRD to be created
```
TASK [openshift_cluster_monitoring_operator : Wait for the ServiceMonitor CRD to be created] ***********************************************************************************************************************************************
Thursday 26 March 2020  14:24:26 +0900 (0:00:00.789)       0:17:23.429 ********
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (30 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (29 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (28 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (27 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (26 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (25 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (24 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (23 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (22 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (21 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (20 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (19 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (18 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (17 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (16 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (15 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (14 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (13 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (12 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (11 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (10 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (9 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (8 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (7 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (6 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (5 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (4 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (3 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (2 retries left).
FAILED - RETRYING: Wait for the ServiceMonitor CRD to be created (1 retries left).
fatal: [fulab1-21-master1.fulab1.futuregen.lab]: FAILED! => {"attempts": 30, "changed": true, "cmd": ["oc", "get", "crd", "servicemonitors.monitoring.coreos.com", "-n", "openshift-monitoring", "--config=/tmp/openshift-cluster-monitoring-ansible-9mqvyq/admin.kubeconfig"], "delta": "0:00:00.205312", "end": "2020-03-26 14:39:38.235289", "msg": "non-zero return code", "rc": 1, "start": "2020-03-26 14:39:38.029977", "stderr": "No resources found.\nError from server (NotFound): customresourcedefinitions.apiextensions.k8s.io \"servicemonitors.monitoring.coreos.com\" not found", "stderr_lines": ["No resources found.", "Error from server (NotFound): customresourcedefinitions.apiextensions.k8s.io \"servicemonitors.monitoring.coreos.com\" not found"], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************************************************************************************************************************************************************************
fulab1-21-master1.fulab1.futuregen.lab : ok=456  changed=134  unreachable=0    failed=1    skipped=813  rescued=0    ignored=0
fulab1-22-master2.fulab1.futuregen.lab : ok=251  changed=56   unreachable=0    failed=0    skipped=437  rescued=0    ignored=0
fulab1-23-master3.fulab1.futuregen.lab : ok=251  changed=56   unreachable=0    failed=0    skipped=437  rescued=0    ignored=0
fulab1-41-infra1.fulab1.futuregen.lab : ok=109  changed=20   unreachable=0    failed=0    skipped=147  rescued=0    ignored=0
fulab1-42-infra2.fulab1.futuregen.lab : ok=109  changed=20   unreachable=0    failed=0    skipped=147  rescued=0    ignored=0
fulab1-61-univ1.fulab1.futuregen.lab : ok=109  changed=20   unreachable=0    failed=0    skipped=147  rescued=0    ignored=0
fulab1-62-univ2.fulab1.futuregen.lab : ok=109  changed=20   unreachable=0    failed=0    skipped=147  rescued=0    ignored=0
fulab1-63-univ3.fulab1.futuregen.lab : ok=109  changed=20   unreachable=0    failed=0    skipped=147  rescued=0    ignored=0
localhost                  : ok=11   changed=0    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0


INSTALLER STATUS ***************************************************************************************************************************************************************************************************************************
Initialization               : Complete (0:00:21)
Health Check                 : Complete (0:00:01)
Node Bootstrap Preparation   : Complete (0:02:54)
etcd Install                 : Complete (0:00:30)
Master Install               : Complete (0:10:48)
Master Additional Install    : Complete (0:01:04)
Node Join                    : Complete (0:00:49)
Hosted Install               : Complete (0:00:36)
Cluster Monitoring Operator  : In Progress (0:15:19)
        This phase can be restarted by running: playbooks/openshift-monitoring/config.yml
Thursday 26 March 2020  14:39:38 +0900 (0:15:11.429)       0:32:34.858 ********
===============================================================================
openshift_cluster_monitoring_operator : Wait for the ServiceMonitor CRD to be created --------------------------------------------------------------------------------------------------------------------------------------------- 911.43s
openshift_control_plane : Wait for all control plane pods to come up and become ready --------------------------------------------------------------------------------------------------------------------------------------------- 511.81s
openshift_node : Check status of node image pre-pull ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 60.97s
cockpit : Install cockpit-ws ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 29.15s
openshift_manage_node : Wait for sync DS to set annotations on all nodes ----------------------------------------------------------------------------------------------------------------------------------------------------------- 11.92s
openshift_node_group : Wait for the sync daemonset to become ready and available --------------------------------------------------------------------------------------------------------------------------------------------------- 10.86s
Approve node certificates when bootstrapping ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 7.80s
openshift_hosted : Create OpenShift router ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 7.62s
openshift_manageiq : Configure role/user permissions -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 5.30s
openshift_excluder : Install docker excluder - yum ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 4.86s
openshift_excluder : Install openshift excluder - yum ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 4.72s
openshift_node : Install node, clients, and conntrack packages ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 4.62s
openshift_control_plane : Wait for APIs to become available ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 4.32s
openshift_examples : Import xPaas templates ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 3.24s
openshift_node : Update journald setup ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 2.96s
openshift_hosted : Create default projects ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 2.88s
openshift_node : install needed rpm(s) ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 2.67s
tuned : Ensure files are populated from templates ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 2.45s
openshift_node : Install Ceph storage plugin dependencies --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 2.34s
openshift_node : Install GlusterFS storage plugin dependencies ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 2.33s


Failure summary:


  1. Hosts:    fulab1-21-master1.fulab1.futuregen.lab
     Play:     Configure Cluster Monitoring Operator
     Task:     Wait for the ServiceMonitor CRD to be created
     Message:  non-zero return code
```
