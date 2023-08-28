# Known issues

!!! Information
    This section is meant to list specific problems that we know about including recommended work-arounds.

??? "Problems with S3 Object Storage Clients"

	Some problems were encountered on Brno site while using S3 command-line clients to manage data on Swift Object Storage. Due to misconfiguration, commonly used data operations didn't work (e.g., it wasn't possible to save new data to Swift).

	Swift works best with clients propagated by [OpenStack](https://docs.openstack.org/swift/latest/associated_projects.html#application-bindings), the best one being [python-swiftclient](https://pypi.org/project/python-swiftclient/).

	If You encounter problems, try the following:

	* Enforce https instead of http (worked for davix).
	* Check default values (s3cmd requires overwriting parameter `--host-bucket=object-store.cloud.muni.cz`).
	* Look into the logs (many tools come with a `--debug` option).
