---

title: "Frequently Asked Questions"
search:
  exclude: false
hide:
  - toc
---

# Frequently Asked Questions

??? "Where do I report a problem?"
	First, try searching the documentation for an answer to your problem. If that does not yield results, open a
	ticket with [cloud@metacentrum.cz](mailto:cloud@metacentrum.cz). When contacting user support, always
	include your *username* (upper right corner of the web interface) and the *domain* with
	an active *project* (upper left corner of the web interface) as well as a description of
	your problem and/or an error message if available.

??? "What networks can I use to access my instances?"
	Personal projects can allocate floating IPs from `public-cesnet-78-128-250-PERSONAL*` Routing is preset for this address pool.
	Group projects can currently allocate floating IPs from networks ending with `GROUP` suffix as well as `private-muni-10-16-116`.
	Furthermore, IP addresses allocated from `public-muni-147-251-124-GROUP` and `public-muni-147-251-255-GROUP` are released daily, so we encourage using only `public-cesnet-78-128-251-GROUP` and `private-muni-10-16-116` for group projects.

??? "Issues with network MTU (Docker, kubernetes, custom network overlays)"
	OpenStack compute server instances should use 1442 bytes MTU (maximum transmission unit) instead of the standard 1500 bytes MTU. The instance itself can set up the correct MTU with its counterpart via Path MTU Discovery. Docker needs MTU set up explicitly. Refer to the documentation for setting up 1442 MTU in [Docker](https://docs.docker.com/v17.09/engine/userguide/networking/default_network/custom-docker0/) or [Kubernetes](https://docs.projectcalico.org/v3.5/usage/configuration/mtu) or change the configuration with the steps below.

	## Changes in Docker daemon
	```sh
	# edit docker configuration
	sudo vi /etc/docker/daemon.json

	# MTU 1442 or lower
	{
	"mtu": 1442
	}

	# then restart docker
	sudo systemctl restart docker
	```

	## Changes for Docker Compose
	Docker Compose does not inherit the network changes in Docker daemon. To set the MTU also for Docker Compose, you need to add the following lines to the `docker-compose.yaml` file in your project.

	```sh
	networks:
	  default:
	    driver: bridge
	    driver_opts:
	      com.docker.network.driver.mtu: 1442
	```

	## MTU detection
	You can use following bash function to detect end-to-end maximum packet size without packet fragmentation.

	```sh
	# detect_mtu <host>
	#   measure end-to-end MTU
	function detect_mtu() {
	local endpoint_host="$1"

	for i_mtu in `seq 1200 20 1500` `seq 1500 50 9000`; do
		if ping -M do -s $(( $i_mtu - 28 )) -c 5 "${endpoint_host}" >/dev/null; then
		echo "Packets of size ${i_mtu} work as expected"
		else
		echo "Packets of size ${i_mtu} are blocked by MTU limit on the path to destination host ${endpoint_host}!"
		break
		fi
	done
	}
	# execute
	detect_mtu www.nic.cz
	```    

??? "Issues with proxy in private networks"
	OpenStack instances can either use public or private networks. If you are using a private network and you need to access the internet for updates, etc., you can use the muni proxy server `proxy.ics.muni.cz`. This server only supports HTTP protocol, not HTTPS. To configure it you must also consider what applications
	will be using it because they can have their configuration files, where this information must be set. If so, you must find the particular setting and set up there
	the mentioned proxy server with port 3128. Most applications use the following settings, which can be done by editing the `/etc/environment` file where you need to add the line
	`http_proxy="http://proxy.ics.muni.cz:3128/"`. And then you must either restart your machine or use the command `source /etc/environment`.

??? "I can't log into OpenStack, how is that possible?"
	The most common reason why you can't log into your OpenStack account is that your membership in Metacentrum has expired. To extend your membership in Metacentrum,
	you can visit [https://metavo.metacentrum.cz/en/myaccount/prodlouzeni](https://metavo.metacentrum.cz/en/myaccount/prodlouzeni).

??? "I can't access my cloud VMs. MetaCentrum OpenStack network security protection"
	Access to the MetaCentrum cloud is protected by [CSIRT-MU](https://csirt.muni.cz/?lang=en) and [CSIRT-CESNET](https://csirt.cesnet.cz/en/index) security teams.

	Some interactions with allocated cloud resources may cause cloud access blockage. This is caused by the fact, that legal SSH access to a new virtual machine (VM) which is being allocated is very similar to a (SSH) brute-force attack.

	A newly created VM will respond to SSH connection attempts in different ways as it moves through the setup stages:

	* A) VM is booting and network is being established. At this stage, there is no functional connection point, and connection attempts will time out.
	* B) SSH connection is being set. At the start of its lifetime, a VM runs the cloud-init process, which enables SSH authentication with the user's SSH key. A connection is refused, because it can't verify the user.
  	* C) Connection is finally successful. All setup processes are finished.

	When a (SSH) brute-force attack is attempted, the scenario is similar. Repeated unsuccessful (unauthorized) connections to the VM are made (resulting in connection reset or timeout). Once the attacker passes the right credentials, gets connected and logged.Therefore, when security systems discover such suspicious series of unsuccessful connections followed by successful one, they likely block Your IP address to the allocated cloud VMs.

	## Best practices for accessing cloud resources without getting blocked

	The key practices helping to avoid source IP address blockage are:

	* connect to cloud infrastructure via single public facing jump/bastion node (using [sshuttle](https://github.com/sshuttle/sshuttle#readme) or [ssh ProxyJump](https://www.jeffgeerling.com/blog/2022/using-ansible-playbook-ssh-bastion-jump-host) or eventually [ssh ProxyCommand](https://blog.ruanbekker.com/blog/2020/10/26/use-a-ssh-jump-host-with-ansible/))
	* use OpenStack API to watch whether VM is ACTIVE
    * relax public IP try-connect loop timing
	* configure SSH client to [reuse connection for instance with `-o ControlMaster=auto -o ControlPersist=60s`](https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Multiplexing)

    !!! example

    	As an example, consider a group of virtual machines, where at least one has access to the internet using an IPv4 or IPv6 public address, and they are connected by an internal network (e.  g. 10.0.0.0/24).

      To access the first VM with a public address `<public-ip-jump>`:

    	* Wait for the machine to enter ACTIVE state via Openstack API: `openstack server show <openstack-server-id> -f json | jq -r .status`.
    	* After VM is in ACTIVE state try to open connection to SSH port with timeout of approx. 5 seconds and period of at least 30 seconds.

    	To access other VMs on the same cloud internal network (once SSH connection to 1st is established):

    	* The recommended method is to create an SSH VPN using sshuttle with `sshuttle -r user@<public-ip-jump> 10.0.0.0/24`
    	* Address all internal virtual servers with their internal address (CIDR 10.0.0.0/24) and use the 1st (jump/bastion) machine with the public address as an SSH proxy.
    	* Follow the same steps to connect – first wait for ACTIVE state and then try a port connection.

  	## How to check, whether you are blocked

  	Run the following bash script from the machine, where you believe you got blocked (A), and also from another one located in another IP network segment (B, for instance VM in other cloud):

  	```sh
  	# Test Cloud Accessibility for a linux or Windows WSDL 2 environments
  	# BASH function requires following tools to be installed:
  	#   ip, host tracepath traceroute ping, curl, ncat, timeout, bash
  	# Execution example: test_cloud_access 178.128.250.99 22

  	function test_cloud_access() {
  	local basion_vm_public_ip="$1"
  	local basion_vm_public_port="${2:-22}"
  	local cloud_identity_host=${3:-identity.cloud.muni.cz}
  	local timeout=60
  	set -x
  	cmds=("ip a" "ip -4 r l" "ip -6 r l")
  	for i_cmd in "${cmds[@]}"; do
  		${i_cmd}; echo "ecode:$?";
    done
  	for i_cmd in host tracepath traceroute ping ; do
  		timeout --signal=2 ${timeout} ${i_cmd} "${cloud_identity_host}"
  		echo "ecode:$?"
  	done
  	timeout --signal=2 ${timeout} curl -v "https://${cloud_identity_host}"
  	echo "ecode:$?"
  	timeout --signal=2 ${timeout} ncat -z "${basion_vm_public_ip}" "${basion_vm_public_port}"
  	echo "ecode:$?"
  	set +x
  	}
  	```

  	## How to report network issue and get unblocked

  	If you are suspecting, that Your virtual machines are blocked, You should contact support by sending an email to the address cloud@metacentrum.cz. To make things easier and resolve the   issue faster, it is important to add the outputs of the bash function `test_cloud_access()` above, ran from both VMs (A and B).
