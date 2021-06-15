# Certificates FAQ

FAQ about certificates in general.

## Q: What Are Certificates?

IT4Innovations employs X.509 certificates for secure communication (e.g. credentials exchange) and for grid services related to PRACE, as they present a single method of authentication for all PRACE services, where only one password is required.

There are different kinds of certificates, each with a different scope of use. We mention here:

* User (Private) certificates
* Certificate Authority (CA) certificates
* Host certificates
* Service certificates

However, users only need to manage User and CA certificates. Note that your user certificate is protected by an associated private key, and this **private key must never be disclosed**.

## Q: Which X.509 Certificates Are Recognized by IT4Innovations?

See the [Certificates for Digital Signatures][1] section.

## Q: How Do I Get a User Certificate That Can Be Used With IT4Innovations?

To get a certificate, you must make a request to your local, IGTF approved Certificate Authority (CA). Then, you must usually visit, in person, your nearest Registration Authority (RA) to verify your affiliation and identity (photo identification is required). Usually, you will then be emailed details on how to retrieve your certificate, although procedures can vary between CAs. If you are in Europe, you can locate [your trusted CA][a].

In some countries, certificates can also be retrieved using the TERENA Certificate Service, see the FAQ below for the link.

## Q: Does IT4Innovations Support Short Lived Certificates (SLCS)?

Yes, if the CA which provides this service is also a member of IGTF.

## Q: Does IT4Innovations Support the TERENA Certificate Service?

 Yes, IT4Innovations supports TERENA eScience personal certificates. For more information, visit [TCS - Trusted Certificate Service][b], where you can also find if your organization/country can use this service.

## Q: What Format Should My Certificate Take?

User Certificates come in many formats, the three most common being the ’PKCS12’, ’PEM’, and JKS formats.

The PKCS12 (often abbreviated to ’p12’) format stores your user certificate, along with your associated private key, in a single file. This form of your certificate is typically employed by web browsers, mail clients, and grid services like UNICORE, DART, gsissh-term, and Globus toolkit (GSI-SSH, GridFTP, and GRAM5).

The PEM format (`*`.pem) stores your user certificate and your associated private key in two separate files. This form of your certificate can be used by PRACE’s gsissh-term and with the grid related services like Globus toolkit (GSI-SSH, GridFTP, and GRAM5).

To convert your Certificate from PEM to p12 formats and _vice versa_, IT4Innovations recommends using the OpenSSL tool (see the [separate FAQ entry][2]).

JKS is the Java KeyStore and may contain both your personal certificate with your private key and a list of your trusted CA certificates. This form of your certificate can be used by grid services like DART and UNICORE6.

To convert your certificate from p12 to JKS, IT4Innovations recommends using the keytool utility (see the [separate FAQ entry][3]).

## Q: What Are CA Certificates?

Certification Authority (CA) certificates are used to verify the link between your user certificate and the issuing authority. They are also used to verify the link between the host certificate of an IT4Innovations server and the CA that issued the certificate. In essence, they establish a chain of trust between you and the target server. Thus, for some grid services, users must have a copy of all the CA certificates.

To assist users, SURFsara (a member of PRACE) provides a complete and up-to-date bundle of all the CA certificates that any PRACE user (or IT4Innovations grid services user) will require. Bundle of certificates, in either p12, PEM, or JKS formats, are [available here][c].

It is worth noting that gsissh-term and DART automatically update their CA certificates from this SURFsara website. In other cases, if you receive a warning that a server’s certificate cannot be validated (not trusted), update your CA certificates via the SURFsara website. If this fails, contact the IT4Innovations helpdesk.

Lastly, if you need the CA certificates for a personal Globus 5 installation, you can install the CA certificates from a MyProxy server with the following command:

```console
    myproxy-get-trustroots -s myproxy-prace.lrz.de
```

If you run this command as `root`, it will install the certificates into /etc/grid-security/certificates. Otherwise, the certificates will be installed into $HOME/.globus/certificates. For Globus, you can download the globuscerts.tar.gz packet [available here][c].

## Q: What Is a DN and How Do I Find Mine?

DN stands for Distinguished Name and is a part of your user certificate. IT4Innovations needs to know your DN to enable your account to use the grid services. You may use OpenSSL (see [below][2]) to determine your DN or, if your browser contains your user certificate, you can extract your DN from your browser.

For Internet Explorer users, the DN is referred to as the "subject" of your certificate. ToolsInternet OptionsContentCertificatesViewDetailsSubject.

For users running Firefox under Windows, the DN is referred to as the "subject" of your certificate. ToolsOptionsAdvancedEncryptionView Certificates. Highlight your name and then click ViewDetailsSubject.

## Q: How Do I Use the Openssl Tool?

The following examples are for Unix/Linux operating systems only.

To convert from PEM to p12, enter the following command:

```console
    openssl pkcs12 -export -in usercert.pem -inkey userkey.pem -out
    username.p12
```

To convert from p12 to PEM, type the following _four_ commands:

```console
    openssl pkcs12 -in username.p12 -out usercert.pem -clcerts -nokeys
    openssl pkcs12 -in username.p12 -out userkey.pem -nocerts
    chmod 444 usercert.pem
    chmod 400 userkey.pem
```

To check your Distinguished Name (DN), enter the following command:

```console
    openssl x509 -in usercert.pem -noout -subject -nameopt
    RFC2253
```

To check your certificate (e.g. DN, validity, issuer, public key algorithm, etc.), enter the following command:

```console
    openssl x509 -in usercert.pem -text -noout
```

To download OpenSSL if not pre-installed, see [here][d]. On Macintosh Mac OS X computers, OpenSSL is already pre-installed and can be used immediately.

## Q: How Do I Create and Then Manage a Keystore?

IT4innovations recommends the Java-based keytool utility to create and manage keystores, which themselves are stores of keys and certificates. For example if you want to convert your pkcs12 formatted key pair into a Java keystore you can use the following command:

```console
    keytool -importkeystore -srckeystore $my_p12_cert -destkeystore
    $my_keystore -srcstoretype pkcs12 -deststoretype jks -alias
    $my_nickname -destalias $my_nickname
```

where `$my_p12_cert` is the name of your p12 (pkcs12) certificate, `$my_keystore` is the name that you give to your new java keystore and `$my_nickname` is the alias name that the p12 certificate was given and is also used for the new keystore.

You can also import CA certificates into your Java keystore with the tool, for exmaple:

```console
    keytool -import -trustcacerts -alias $mydomain -file $mydomain.crt -keystore $my_keystore
```

where `$mydomain.crt` is the certificate of a trusted signing authority (CA) and `$mydomain` is the alias name that you give to the entry.

More information on the tool can be found [here][e].

## Q: How Do I Use My Certificate to Access Different Grid Services?

Most grid services require the use of your certificate; however, the format of your certificate depends on the grid Service you wish to employ.

If employing the PRACE version of GSISSH-term (also a Java Web Start Application), you may use either the PEM or p12 formats. Note that this service automatically installs up-to-date PRACE CA certificates.

If the grid service is UNICORE, then you bind your certificate, in either the p12 format or JKS, to UNICORE during the installation of the client on your local machine.

If the grid service is a part of Globus (e.g. GSI-SSH, GriFTP, or GRAM5), the certificates can be in either p12 or PEM format and must reside in the "$HOME/.globus" directory for Linux and Mac users or %HOMEPATH%.globus for Windows users. (Windows users will have to use the DOS command `cmd` to create a directory which starts with a ’.’). Further, user certificates should be named either "usercred.p12" or "usercert.pem" and "userkey.pem", and the CA certificates must be kept in a pre-specified directory as follows. For Linux and Mac users, this directory is either $HOME/.globus/certificates or /etc/grid-security/certificates. For Windows users, this directory is %HOMEPATH%.globuscertificates. (If you are using GSISSH-Term from prace-ri.eu, you do not have to create the .globus directory nor install CA certificates to use this tool alone).

## Q: How Do I Manually Import My Certificate Into My Browser?

In Firefox, you can import your certificate by first choosing the "Preferences" window. For Windows, this is ToolsOptions. For Linux, this is EditPreferences. For Mac, this is FirefoxPreferences. Then choose the "Advanced" button, followed by the "Encryption" tab. Then choose the "Certificates" panel, select the "Select one automatically" option if you have only one certificate, or "Ask me every time" if you have more than one. Then, click on the "View Certificates" button to open the "Certificate Manager" window. You can then select the "Your Certificates" tab and click on the "Import" button. Then locate the PKCS12 (.p12) certificate you wish to import and employ its associated password.

If you are a Safari user, then simply open the "Keychain Access" application and follow "FileImport items".

If you are an Internet Explorer user, click Start > Settings > Control Panel and then double-click on Internet. On the Content tab, click Personal and then click Import. Type your password in the Password field. You may be prompted multiple times for your password. In the "Certificate File To Import" box, type the filename of the certificate you wish to import, and then click OK. Click Close, and then click OK.

## Q: What Is a Proxy Certificate?

A proxy certificate is a short-lived certificate, which may be employed by UNICORE and the Globus services. The proxy certificate consists of a new user certificate and a newly generated proxy private key. This proxy typically has a rather short lifetime (normally 12 hours) and often allows only a limited delegation of rights. Its default location for Unix/Linux, is /tmp/x509_u_uid_ but can be set via the `$X509_USER_PROXY` environment variable.

## Q: What Is the MyProxy Service?

[MyProxy Service][g] can be employed by gsissh-term and Globus tools and is an online repository that allows users to store long-lived proxy certificates remotely, which can then be retrieved for later use. Each proxy is protected by a password provided by the user at the time of storage. This is beneficial to Globus users, as they do not have to carry their private keys and certificates when travelling; nor do users have to install private keys and certificates on possibly insecure computers.

## Q: Someone May Have Copied or Had Access to the Private Key of My Certificate Either in a Separate File or in the Browser. What Should I Do?

Please ask the Certificate Authority that issued your certificate to revoke this certificate and to supply you with a new one. In addition, report this to IT4Innovations by contacting [the support team][h].

## Q: My Certificate Expired. What Should I Do?

In order to still be able to communicate with us, make a request for a new certificate to your CA. There is no need to explicitly send us any information about your new certificate if a new one has the same Distinguished Name (DN) as the old one.

[1]: obtaining-login-credentials.md#certificates-for-digital-signatures
[2]: #q-how-do-i-use-the-openssl-tool
[3]: #q-how-do-i-create-and-then-manage-a-keystore

[a]: https://www.eugridpma.org/members/worldmap/
[b]: https://tcs-escience-portal.terena.org/
[c]: https://winnetou.surfsara.nl/prace/certs/
[d]: https://www.openssl.org/source/
[e]: http://docs.oracle.com/javase/7/docs/technotes/tools/solaris/keytool.html
[g]: http://grid.ncsa.illinois.edu/myproxy/
[h]: https://support.it4i.cz/rt
