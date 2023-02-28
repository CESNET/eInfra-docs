---

title: Volume transfer between projects
search:
  exclude: false
---

# Volume transfer between projects

__1.__ Shut off instance and make copy of volume which you want to transfer using
**Create volume backup** you can follow
[this guide](../manage-volumes/#creating-volume-backup) and as a next step
create new volume from backup. You will end with a volume copy.


__2.__ In menu of volume which you want to transfer select **Create Transfer**

  ![](/compute/openstack/images/volume-transfer/transfer1.png)

__3.__ Fill in **Transfer Name**

  ![](/compute/openstack/images/volume-transfer/transfer2.png)

__4.__ New volume transfer is created, you will need **Transfer ID** and
**Authorization Key**. You can download them to your computer using
**Download transfer credentials**.

  ![](/compute/openstack/images/volume-transfer/transfer3.png)

__5.__ You can see in original project that transfer is created and waiting
for action in destination project.

  ![](/compute/openstack/images/volume-transfer/transfer4.png)

__6.__ In horizon switch to destination project and go to Volumes menu. Select
**Accept Transfer** button.

  ![](/compute/openstack/images/volume-transfer/transfer5.png)

__7.__ Accept volume transfer in destination project. You will need
**Transfer ID** and **Authorization Key** from previous step.

  ![](/compute/openstack/images/volume-transfer/transfer6.png)

__8.__ Now you can see transferred volume in destination project.

  ![](/compute/openstack/images/volume-transfer/transfer7.png)
