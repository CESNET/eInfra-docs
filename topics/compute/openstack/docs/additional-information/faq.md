---

title: "Frequently Asked Questions"
search:
  exclude: false
hide:
  - toc
---

# Frequently Asked Questions

Also you can access site specific FAQ:

 - [Brno G1 site FAQ](../technical-reference/brno-g1-site/faq.md)
 - [Ostrava G2 site FAQ](../technical-reference/ostrava-g2-site/faq.md)
 - [Brno G2 site FAQ](../technical-reference/brno-g2-site/faq.md)

??? "What to expect from the cloud and cloud computing"

	[Migration of Legacy Systems to Cloud Computing](https://www.researchgate.net/publication/280154501_Migration_of_Legacy_Systems_to_Cloud_Computing) article gives an overview of what to expect when joining a cloud with a personal legacy application.

	##  What are the cloud computing benefits?

	The most visible [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing) benefits are:

	* cost savings
	* online access to the cloud resources for everyone authorized
	* cloud project scalability (elasticity)
	* online cloud resource management and improved sustainability
	* security and privacy improvements
	* encouraged cloud project agility

??? "How do I register?"
	Follow instructions for [registering](../additional-information/register.md).

??? "How many floating IPs does my group project need?"
	One floating IP per project should generally suffice. All OpenStack instances are deployed on top of internal OpenStack networks. These internal networks are not by default accessible from outside of OpenStack, but instances on top of the same internal network can communicate with each other.

	To access the internet from an instance, or access an instance from the internet, you could allocate floating public IP per instance. Since there are not many public IP addresses available and assigning public IP to every instance is not a security best practice, both in public and private clouds these two concepts are used:

	* **internet access is provided by virtual router** - all new OpenStack projects are created with a *group-project-network* internal network connected to a virtual router with a public IP as a gateway. Every instance created with *group-project-network* can access the internet through NAT provided by its router by default.
	* **accessing the instances:**
		+ **I need to access instances by myself** - best practice for accessing your instances is creating one server with floating IP called [jump host](https://en.wikipedia.org/wiki/Jump_server) and then access all other instances through this host. Simple setup:
			1. Create an instance with any Linux.
			2. Associate floating IP with this instance.
			3. Install [sshuttle](https://github.com/sshuttle/sshuttle) on your client.
			4. `sshuttle -r root@jump_host_fip 192.168.0.1/24`. All your traffic to the internal OpenStack network *192.168.0.1/24* is now tunneled through the jump host.
		+ **I need to serve content (e.g. web service) to other users** - public and private clouds provide LBaaS (Load-Balancer-as-a-Service) service, which proxies users traffic to instances. MetaCentrum Cloud provides this service in experimental mode.

	In case, that these options are not suitable for your use case, you can still request multiple floating IPs.

??? "Backups"
	All the data is protected against disk failures. We are not responsible for any data loss that may occur. For now, we do not provide any means for offsite backups.

	What can I do?

	- Use OpenStack Snapshots for local backup.
	- Use backup software like Borg or Restic to create an offsite incremental backup.
	- Use backup/data storage services provided by your local it support or CESNET (e. g. on MU [https://it.muni.cz/sluzby/zalohovani-bacula](https://it.muni.cz/sluzby/zalohovani-bacula)).

??? "What is the default user for my VM?"
	Default users are usually the same as the name of the operating system you are running.

	| OS     | Login for SSH command |
	|--------|-----------------------|
	| Debian | debian                |
	| Ubuntu | ubuntu                |
	| Centos | centos                |

	In more general the default user is the value of the `default_user` property of the image.
