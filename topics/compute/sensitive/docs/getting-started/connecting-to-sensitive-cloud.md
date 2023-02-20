# Connecting to the Sensitive Cloud

The primary management portal to manage sensitive computing resources is Rancher located at [https://rancher.cloud.trusted.e-infra.cz/](https://rancher.cloud.trusted.e-infra.cz). Before you will be able to log in, you will need go through few additional steps, that will ensure secure communication with SensitiveCloud environment.

The use of the environment's resources is available only to authorized persons, and only through a dedicated virtual private network (VPN). The authorization and authentication infrastructure is implemented by the Perun service with enforced more advanced security features (two-factor authentication, etc.). 

These are prerequisites to communicate with SensitiveCloud:

1.	You have an activated project or you are member of existing project
    - [Tutorial how to create project in SensitiveCloud (for Princial investigators)](../../get-project)
    - [How to get membership of the project (for Princial investigators)](../../manage-project)
2.	Activated and obtained VPN. [Tutorial for using VPN](/managed-services/network/secure-vpn)
    - The VPN must be activated for the period of working with the Rancher management portal and all communication with deployed applications
3.	Activated and Tested Multifactor authentication on e-INFRA CZ SSO. [Tutorial to set up the MFA](/account/mfa/setup/)