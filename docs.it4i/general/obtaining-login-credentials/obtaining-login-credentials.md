# IT4I Account

!!! important
    If you are affiliated with an academic institution from the Czech Republic ([eduID.cz][u]), create an [e-INFRA CZ account][8], instead.

Once [authorized by a PI][10], every person (PI or collaborator) wishing to access the clusters should contact the [IT4I support][a] (email: [support\[at\]it4i.cz][b]) providing the following information:

1. Project ID
1. Full name and affiliation
1. Statement that you have read and accepted the [Acceptable use policy document][c] (AUP).
1. Attach the AUP file.
1. Your preferred username (3 to 12 characters). The preferred username must associate with your first and last name or be otherwise derived from it. Only alphanumeric sequences and dash signs are allowed.
1. In case you choose an [Alternative way to personal certificate][3], a **scan of photo ID** (personal ID or passport or driver license) is required.

!!! warning
    Should the above information be provided by email, the email **must be** digitally signed. Read more on [digital signatures][4] below.

!!! hint
    VSB associates will be given a VSB login username.

Example (except the subject line, which must be in English, you may use Czech or Slovak language for communication with us):

```console
Subject: Access to IT4Innovations

Dear support,

Please open the user account for me and attach the account to OPEN-0-0
Name and affiliation: John Smith, john.smith@myemail.com, Department of Chemistry, MIT, US
I have read and accept the Acceptable use policy document (attached)

Preferred username: johnsm

Thank you,
John Smith
(Digitally signed)
```

You will receive your personal login credentials by protected email. The login credentials include:

1. username
1. SSH private key and private key passphrase
1. system password

The clusters are accessed by the [private key][5] and username. Username and password are used for login to the [information systems][d].

## Certificates for Digital Signatures

We accept personal certificates issued by any widely respected certification authority (CA). This includes certificates by CAs organized in [International Grid Trust Federation][f], its European branch [EUGridPMA][g] and its member organizations, e.g. the [CESNET certification authority][h]. The Czech _"Qualified certificate" (Kvalifikovaný certifikát)_ provided by [PostSignum][i] or [I.CA][j], which is used in electronic contact with Czech authorities, is accepted as well.

Certificate generation process for academic purposes, utilizing the CESNET certification authority, is well described here:

* [How to generate a personal TCS certificate in Mozilla Firefox ESR web browser.][k] (in Czech)

!!! note
    The certificate file can be installed into your email client. Web-based email interfaces cannot be used for secure communication, external application, such as Thunderbird or Outlook must be used. This way, your new credentials will be visible only in applications that have access to your certificate.

If you are not able to obtain the certificate from any of the respected certification authorities, follow the Alternative Way below.

A FAQ about certificates can be found here: [Certificates FAQ][7].

## Alternative Way to Personal Certificate

!!! important
    Follow these steps **only** if you cannot obtain your certificate in a standard way.
    If you choose this procedure, **you must attach a scan of your photo ID** (personal ID, passport, or driver's license) when applying for login credentials.

* Go to the [Actalis Free Email Certificate][l] request form.
* Follow the instructions: fill out the form, accept the terms and conditions, and submit the request.
* You will receive an email with the certificate.
* Import the certificate to one of the supported email clients. (See Actalis' [Email applications currently supported][s] section.)
* For instructions on how to import the certificate, see Actalis' [Guides to installing and using your certificate][t] section.

!!! note
    Web-based email interfaces cannot be used for secure communication; external application, such as Thunderbird or Outlook must be used. This way, your new credentials will be visible only in applications that have access to your certificate.

[1]: https://docs.it4i.cz/general/obtaining-login-credentials/obtaining-login-credentials/#certificates-for-digital-signatures
[2]: #authorization-by-web
[3]: #alternative-way-to-personal-certificate
[4]: #certificates-for-digital-signatures
[5]: ../accessing-the-clusters/shell-access-and-data-transfer/ssh-keys.md
[6]: ../accessing-the-clusters/shell-access-and-data-transfer/putty.md#putty-key-generator
[7]: ../obtaining-login-credentials/certificates-faq.md
[8]: ../access/einfracz-account.md
[10]: ../access/project-access.md

[a]: https://support.it4i.cz/rt/
[b]: mailto:support@it4i.cz
[c]: https://www.it4i.cz/cs/file/f4afe72710863f0e8d119a31389e7bfb/5422/acceptable-use-policy.pdf
[d]: http://support.it4i.cz/
[e]: https://scs.it4i.cz
[f]: http://www.igtf.net/
[g]: https://www.eugridpma.org
[h]: https://tcs.cesnet.cz
[i]: http://www.postsignum.cz/
[j]: http://www.ica.cz/Kvalifikovany-certifikat.aspx
[k]: http://idoc.vsb.cz/xwiki/wiki/infra/view/uzivatel/moz-cert-gen
[l]: https://extrassl.actalis.it/portal/uapub/freemail?lang=en
[r]: https://www.it4i.cz/computing-resources-allocation/?lang=en
[s]: https://www.actalis.it/en/certificates-for-secure-electronic-mail.aspx
[t]: https://www.actalis.it/en/certificates-for-secure-electronic-mail.aspx
[u]: https://www.eduid.cz/
