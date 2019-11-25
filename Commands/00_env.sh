### Default Setting
DATETIME=`date +%Y%m%d%H%M%S`
INSTALL_USER=root
BASE_IP=192.168.137.230
BASE_DIR=/root/install/OCP
OCP_HOSTNAME=${BASE_DIR}/config/ocp_hostname
OCP_HOSTNAME_ALL=${BASE_DIR}/config/ocp_hostname_all
OCP_IP=${BASE_DIR}/config/ocp_ip
OCP_IP_ALL=${BASE_DIR}/config/ocp_ip_all

### REPOSITORY
#REPO_PATH="\/root\/repos\/rhel-7-server-rpms"
#REPO_PATH="\/root\/\.pentalink\/repos\/rhel-7-server-rpms"
REPO_PATH="\/var\/www\/html\/repos\/rhel-7-server-rpms"
REPO_IP=192.168.137.230

### DNS
DNS_IP=192.168.137.110
DNS_DOMAIN=ocp.cloud

### NetWork
#NW_NAME="System\ eth0"
NW_PREFIX=24
NW_GATEWAY=192.168.137.1
NW_DNS1=${DNS_IP}
NW_DNS_SEARCH=${DNS_DOMAIN}
#NW_MTU=1496

### CHRONY
CHRONY_SERVER=192.168.137.230

### DOCKER
DOCKER_DEVS=/dev/sdb

### DOCKER-DISTRIBUTION
DD_IP=192.168.137.230
DD_ADDR=repo.ocp.cloud
DD_PORT=5000
ROOTDIRECTORY="\/volumes"
CERT_PATH="\/volumes\/cert"

### User Check
UNAME=`whoami`
if [ "e${UNAME}" != "e${INSTALL_USER}" ] && [ "e${1}" != "enoCheck" ];
then
  echo "\"${UNAME}\" is not the same as the install account. (${INSTALL_USER})"
  exit;
fi
