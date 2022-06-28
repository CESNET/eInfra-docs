# Connecting to the Sensitive Cloud

The primary management portal to manage sensitive computing resources is Rancher located at [https://rancher.cloud.trusted.e-infra.cz/](https://rancher.cloud.trusted.e-infra.cz). Before you will be able to log in, you will need go through few additional steps, that will ensure secure communication with SensitiveCloud environment.

The use of the environment's resources is available only to authorized persons, and only through a dedicated virtual private network (VPN). The authorization and authentication infrastructure is implemented by the Perun service with enforced more advanced security features (two-factor authentication, etc.). 

These are prerequisites have to communicate with SensitiveCloud:

1.	You have an activated project [Tutorial how to create project in SensitiveCloud](./new-project.md)
2.	Defined access entity in Masaryk University Identity and Access Management (Perun) [Tutorial to create authorized group of users](https://it.muni.cz/sluzby/sprava-skupin-a-pristupu/navody/jak-vytvorit-skupiny)
3.	Activated and obtained VPN. [Tutorial for using VPN](/managed-services/network/secure-vpn)
4.	Activated and Tested Multifactor authentication on MUNI SSO. [Tutorial to set up the MFA](https://it.muni.cz/en/services/jednotne-prihlaseni-na-muni/navody/how-to-set-up-multi-factor-authentication)