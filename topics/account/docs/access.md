# Accessing Your Account and Services

In principle and by default, **e-INFRA CZ Account doesn't have own
credentials**. **You are supposed to log in with your home organization account**,
which is something you should use and know from your daily work/study life.

You need to use the same account from the same organization, **which was used 
during e-INFRA CZ Account creation**.

You might have encountered a similar principle in services provided by other 
research infrastructures or in the commercial world, where web services like 
e-shops offers you to create and access an account by actually using your 
Google or Facebook accounts.

!!!note "Access using additional accounts"
    You can associate additional accounts from a different organizations you 
    are affiliated with and use any of them to access your e-INFRA CZ Account. 
    You can even add private accounts from social providers like *Google*, 
    *Microsoft*, *ORCID* or Czech *MojeID*.

## Login Process

The following section describes the generic login process, which is the same 
for all services with web-based interfaces managed by e-INFRA CZ AAI. Such 
services usually provide one or both of the following ways to log in.

- Log in with your home organization account
- Log in with your e-INFRA CZ password

### Log in With Your Home Organization Account

The first way to log in, where you choose from a different options, is more 
commonly used as it can also contain the second way to log in under the name 
*e-INFRA CZ password*. Whole login process then consist of following steps:

1. You try to access the service
2. You are asked to log in
3. You are offered with the selection of organizations/options to choose from
4. You choose your home organization/option
5. You are redirected to your home organization IdP (login form)
6. You log in with the credentials from your home organization account
7. If successful you are redirected back to the service

!!!note "Limitation of available options"
    **Each service can independently decide, which organizations / options are 
    available** to choose from.<br/><br/>For example, you might not be able to 
    log in with one of the *social provider* accounts or by *e-INFRA CZ password* 
    even if they are associated with your e-INFRA CZ Account. Such options 
    are either completely missing from the list or are greyed out.
    <br/><br/>**All possible options are available when accessing e-INFRA CZ 
    User Profile** and other administrative interfaces related to your e-INFRA 
    CZ Account to make sure you will always get access to your account.

!!!note "Multi-Factor Authentication"
    You can **enhance security of your e-INFRA CZ Account by enabling MFA** 
    (Multi-Factor Authentication). In such a case login process contains one
    additional step, in which you verify one of your registered MFA tokens.
    <br/><br/>You can read more about it in [MFA overview](/account/mfa)
    section.

### Log in With Your e-INFRA CZ Password

In this case service usually displays simple login form where you fill in your 
credentials (your e-INFRA CZ login and password) and submit the form.

Alternatively if the service is actually using the first way to log in, this 
option is called *e-INFRA CZ password*.  

### Non-web Services

Non-web services are by their nature using different means to authenticate 
the user and exact description of how to access them should be a part of 
service specific documentation.

They often use either login / password combination or SSH keys. In such a 
case it usually means *e-INFRA CZ login/password* and SSH keys associated 
with your e-INFRA CZ Account (managed on User Profile application).

## e-INFRA CZ Login/Password

As stated above, by default e-INFRA CZ Account doesn't have or require you
to create any new credentials. However, **some e-INFRA CZ services might**, by
their nature, **require you to have login and password** associated with your
account.

You are not required nor advised to create them in advance. You will choose
your login and password when you register for first service which requires
them. These credentials are shared for all such services. They are referred
to as **e-INFRA CZ login** or **e-INFRA CZ password** and can be used
for both web and non-web based services.

Once set, you can manage your e-INFRA CZ credentials (e.g. change / reset
password) through [e-INFRA CZ User Profile](https://profile.e-infra.cz).

!!!note "Compliance with Access Policy"
    When you log in with your *e-INFRA CZ password*, we are not provided with
    the fresh information about your affiliation with your home organization
    and your compliance with *Access Policy* can't be determined. So this option
    can't be used to renew your e-INFRA CZ Account.
