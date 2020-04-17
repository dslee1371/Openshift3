syschecklo="/home/ebaycloud/.futuregen/$(date +"%Y%m%d")"
# echo $syschecklo
mkdir $syschecklo

oc get po --all-namespaces | grep -v Running | grep -v Completed | grep -v STATUS > $syschecklo/result-01-01-pod-Error-list.txt

oc get po -o wide --all-namespaces > $syschecklo/result-01-02-pod-All-list.txt

oc get project > $syschecklo/result-01-03-project-All-list.txt

oc get pv > $syschecklo/result-01-04-pv-All-list.txt

oc get pvc --all-namespaces > $syschecklo/result-01-05-pvc-All-list.txt

oc get pod -l openshift.io/component=api -n kube-system > $syschecklo/result-02-01-master-status.txt

oc get po -n kube-system -o wide > $syschecklo/result-02-02-apihealth.txt

ansible -i hosts nodes -m shell -a"docker version" > $syschecklo/result-03-docker-version.txt

oc status --all-namespaces > $syschecklo/result-04-oc-status.txt

oc adm top nodes > $syschecklo/result-05-oc-top-nodes.txt

oc get cm -n openshift-node > $syschecklo/result-06-openshift-node-cm.txt

sudo ETCDCTL_API=3 etcdctl --cert="/etc/etcd/peer.crt" --key=/etc/etcd/peer.key --cacert=/etc/etcd/ca.crt --endpoints="https://fusione3m01gm.gmarket.nh:2379" endpoint health > $syschecklo/result-07-etcd-health.txt
sudo ETCDCTL_API=3 etcdctl --cert="/etc/etcd/peer.crt" --key=/etc/etcd/peer.key --cacert=/etc/etcd/ca.crt --endpoints="https://fusione3m02gm.gmarket.nh:2379" endpoint health >> $syschecklo/result-07-etcd-health.txt
sudo ETCDCTL_API=3 etcdctl --cert="/etc/etcd/peer.crt" --key=/etc/etcd/peer.key --cacert=/etc/etcd/ca.crt --endpoints="https://fusione3m03gm.gmarket.nh:2379" endpoint health >> $syschecklo/result-07-etcd-health.txt

oc get user > $syschecklo/result-08-01-users.txt

oc get identity > $syschecklo/result-08-02-identity.txt

kubectl version --short > $syschecklo/result-09-01-kube-info.txt

kubectl config view > $syschecklo/result-09-02-config-view.txt

kubectl config get-contexts > $syschecklo/result-09-03-context.txt

kubectl get cs > $syschecklo/result-10-01-cs-health.txt

kubectl cluster-info > $syschecklo/result-10-02-cs-info.txt

kubectl get event --all-namespaces > $syschecklo/result-11-event.txt

ansible all -m shell -a"ifconfig br0 | grep mtu" > $syschecklo/result-12-mtu.txt

ansible all -m shell -a"sudo grep -rn --include=*.yaml 'mtu' /etc/origin/node/node-config.yaml | awk '{print$3}'" >> $syschecklo/result-12-mtu.txt

ansible all -m shell -a"df -h | grep 'Filesystem\|/dev/*' | grep -v 'dm' | grep -v 'docker'" > $syschecklo/result-13-diskuage.txt

ansible all -m shell -a "rpm -qa | sort" > $syschecklo/result-14-rmplist.txt

ansible all -m shell -a"nmcli device show | grep DNS" > $syschecklo/result-15-dns.txt

ansible all -m shell -a'cat /etc/sysconfig/selinux | grep SELINUX=' > $syschecklo/result-16-selinux.txt

ansible all -m shell -a'sysctl vm.overcommit_memory' > $syschecklo/result-17-overc-memory.txt

ansible all -m shell -a'sysctl vm.panic_on_oom'  > $syschecklo/result-18-vm-panic-on.txt

ansible all -m shell -a'free | grep Swap | awk "{print$2}"' > $syschecklo/result-19-swap.txt
