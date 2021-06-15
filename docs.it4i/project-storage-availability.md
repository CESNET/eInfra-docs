# PROJECT Storage Availability

The PROJECT storage is available from 15.3.2021

The PROJECT data storage is a central storage for project's data on IT4Innovations clusters and accessible from Barbora, Salomon clusters.

For more information, see the [PROJECT Data Storage][a] section.

## Data Copy From Salomon to PROJECT Storage

The initial data copy from Salomon's `/scratch/work/project` directory ran from 12.3. to 14.3.2021.

Later this year, both HOME and SCRATCH storages on Salomon will become **permanently inaccessible**, so it is important that you check and synchronize any remaining data on Salomon's `/scratch/work/project` that were created or modified **after 14.3.2021**. No additional backup or data transfer is scheduled for Salomon's storages by IT4Innovations.

!!!Rights and permissions
    The data migration has kept intact all users and groups ownerships, permissions, ACLs, etc. on all files.

### Data Cleanup on PROJECT Storage After Data Copy From Salomon

The initial data copy from Salomon ignored default PROJECT's quotas,
but we strongly recommend that you delete old data from your PROJECT directory,
because if your PROJECT directory exceeds the default quota,
you won't be able to create new data until you free up some space or request addition space allocation.

### PROJECT Storage Quotas

Default quotas for capacity and amount of inodes per project are:

| PROJECT default quota |        |
| --------------------- | ------ |
| Space quota           | 20TB   |
| Inodes quota          | 5 mil. |

If you require additional storage space for migration of your data, contact [IT4Innovations support][b].

[a]: storage/project-storage.md
[b]: mailto:support@it4i.cz
