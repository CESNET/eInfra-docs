---
languages:
  - en
  - cs
---
# Přístup k vašemu účtu a službám

Účet **e-INFRA CZ v zásadě a ve výchozím nastavení nemá vlastní
přihlašovací údaje**. **Předpokládá se, že se přihlásíte pomocí účtu své domovské organizace**,
který byste měli používat a znát ze svého každodenního pracovního/studijního života.

Musíte použít stejný účet ze stejné organizace, **který byl použit. 
při vytváření účtu e-INFRA CZ**.

S podobným principem jste se mohli setkat i u služeb poskytovaných jinými 
výzkumných infrastrukturách nebo v komerčním světě, kde se používají webové služby jako např. 
e-shopy, nabízejí vytvoření účtu a přístup k němu vlastně pomocí vašeho účtu. 
Google nebo Facebook účtu.

!!!Poznámka "Přístup pomocí dalších účtů"
    Můžete přidružit další účty od různých organizací, které jste 
    jste přidruženi, a použít kterýkoli z nich pro přístup ke svému účtu e-INFRA CZ. 
    Můžete přidat i soukromé účty od poskytovatelů sociálních služeb, jako je *Google*, 
    *Microsoft*, *ORCID* nebo české *MojeID*.

## Proces přihlášení

Následující část popisuje obecný proces přihlášení, který je stejný 
pro všechny služby s webovým rozhraním spravované společností e-INFRA CZ AAI. Takové 
služby obvykle poskytují jeden nebo oba následující způsoby přihlášení.

- Přihlášení pomocí účtu domovské organizace
- Přihlaste se pomocí svého hesla e-INFRA CZ

### Přihlášení pomocí účtu domovské organizace

První způsob přihlášení, při kterém si vybíráte z různých možností, je více 
častěji používaný, protože může obsahovat i druhý způsob přihlášení pod názvem 
*e-INFRA CZ heslo*. Celý proces přihlášení se pak skládá z následujících kroků:

1. Pokusíte se vstoupit do služby
2. Jste vyzváni k přihlášení
3. Nabídne se vám výběr organizací/možností, z nichž si můžete vybrat
4. Vyberete si svou domovskou organizaci/možnost
5. Jste přesměrováni na domovskou organizaci IdP (přihlašovací formulář).
6. Přihlásíte se pomocí pověření z účtu domovské organizace.
7. V případě úspěchu jste přesměrováni zpět na službu

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

### Non-Web Services

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
