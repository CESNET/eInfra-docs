---

title: Deploying Loadbalancers
search:
  exclude: false
---

# Deploying Load Balancers

Load balancers serve as a proxy between virtualized infrastructure and clients in the outside network. This is essential in OpenStack since it can be used in a scenario where the infrastructure dynamically starts new VMs and adds them into the load balancing pool in order to mitigate inaccessibility of services.

## Create Load Balancers

To create a load balancer, first prepare a pool of VMs with operational service you wish to balance to. Next create the load balancer in the same network and assign the pool as well as listeners on specific ports.

=== "CLI"
    __1.__ Create the load balancer

    ```
    openstack loadbalancer create --name my_loadbalancer --vip-subnet-id my_subnet_id --wait
    ```

    __2.__ Create listeners (eg. ports 80)
    
    ```
    openstack loadbalancer listener create --name my_listener --protocol TCP --protocol-port 80 --wait my_loadbalancer
    ```

    __3.__ Create LB pools
    
    ```
    openstack loadbalancer pool create --name my_pool --lb-algorithm ROUND_ROBIN --listener my_listener --protocol TCP --wait
    ```

    __4.__ Create Health Monitors
    
    ```
    openstack loadbalancer healthmonitor create --delay 5 --max-retries 3 --timeout 3 --type HTTP --url-path / --wait my_pool
    ```

    __5.__ Assign endpoint VMs
    
    ```
    openstack loadbalancer member create --address vm_ip_address --protocol-port 80 --wait my_pool
    ```

## Delete Load Balancers

When deleting a load balancer, first unassign the floating IP address used by the load balancer.

=== "CLI"

    To delete the load balancer and all resources, run:

    ```
    openstack loadbalancer delete --cascade --wait my_loadbalancer
    ```
