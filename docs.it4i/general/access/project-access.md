# Get Project Membership

!!! note
    You need to be named as a collaborator by a PI in order to access and use the clusters.

## Authorization by Web

This is a preferred method if you have an IT4I or e-INFRA CZ account.

Log in to the [IT4I SCS portal][e] using IT4I credentials and go to the **Authorization Requests** section. Here you can submit your requests for becoming a project member.

### Process Flow Chart

This chart describes the process of obtaining login credentials on the clusters. You may skip the tasks that you have already done. Some of the tasks, marked with asterisk (\*), are clickable and will take you to a more detailed description.

* I am a collaborator on a project and want to obtain login credentials

<div class="mermaid">
graph TB
id10(I am a collaborator on a project and want to obtain login credentials)
id20[Obtain a certificate for digital signature]
id10-->id20
id30[EduID organizations from CESNET*]
click id30 "#certificates-for-digital-signatures"
id40[Personal certificate from PostSignum or I.CA]
id50[Free certificate from Sectigo / Comodo*]
click id50 "#alternative-way-to-personal-certificate"
id55[Other trusted certificate]
subgraph ""
id20-->id30
id20-->id40
id20-->id50
id20-->id55
end
id60[Export and save the certificate to a file]
id30-->id60
id40-->id60
id50-->id60
id55-->id60
id70[Import the certificate into your email client*]
click id70 "#installation-of-the-certificate-into-your-mail-client"
id60-->id70
id80[Send an email with request for access to IT4I Support*]
click id80 "#login-credentials"
id70-->id80
</div>

[1]: https://docs.it4i.cz/general/obtaining-login-credentials/obtaining-login-credentials/#certificates-for-digital-signatures
[2]: #authorization-by-web
[3]: #alternative-way-to-personal-certificate
[4]: #certificates-for-digital-signatures
[5]: ../accessing-the-clusters/shell-access-and-data-transfer/ssh-keys.md
[6]: ../accessing-the-clusters/shell-access-and-data-transfer/putty.md#putty-key-generator
[7]: ../obtaining-login-credentials/certificates-faq.md

[a]: https://support.it4i.cz/rt/
[b]: mailto:support@it4i.cz
[c]: https://www.it4i.cz/cs/file/f4afe72710863f0e8d119a31389e7bfb/5422/acceptable-use-policy.pdf
[d]: http://support.it4i.cz/
[e]: https://scs.it4i.cz/
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
