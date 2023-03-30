---

title: Volume Transfer Between Projects
search:
  exclude: false
---

# Volume Transfer Between Projects

__1.__ Shut off the instance and make a copy of the volume which you want to transfer using **Create volume backup**.
You can follow [this guide](../manage-volumes/#creating-volume-backup) and as a next step create a new volume from the backup.
You will end with a volume copy.

__2.__ In the menu of the volume which you want to transfer, select **Create Transfer**

  ![](/compute/openstack/images/volume-transfer/transfer1.png)

__3.__ Fill in **Transfer Name**

  ![](/compute/openstack/images/volume-transfer/transfer2.png)

__4.__ New volume transfer is created. You will need **Transfer ID** and **Authorization Key**.
You can download them to your computer using **Download transfer credentials**.

  ![](/compute/openstack/images/volume-transfer/transfer3.png)

__5.__ You can see in the original project that the transfer is created and waiting
for action in destination project.

  ![](/compute/openstack/images/volume-transfer/transfer4.png)

__6.__ In horizon, switch to the destination project and go to the Volumes menu.
Press the **Accept Transfer** button.

  ![](/compute/openstack/images/volume-transfer/transfer5.png)

__7.__ Accept the volume transfer in the destination project.
You will need **Transfer ID** and **Authorization Key** from the previous step.

  ![](/compute/openstack/images/volume-transfer/transfer6.png)

__8.__ Now you can see the transferred volume in the destination project.

  ![](/compute/openstack/images/volume-transfer/transfer7.png)
