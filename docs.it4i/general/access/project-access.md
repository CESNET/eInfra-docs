# Get Project / Membership

The computational resources of IT4I are [allocated][r] by the Allocation Committee to a Project investigated by a Primary Investigator. By [allocating the computational resources][r], the Allocation Committee is authorizing the PI to access and use the clusters. The PI may decide to authorize a number of their collaborators to access and use the clusters to consume the resources allocated to their Project. These collaborators will be associated to the Project. The Figure below is depicting the authorization chain:

![](../../img/Authorization_chain.png)

!!! note
    You need to either [become a PI][1] or [be named as a collaborator][2] by a PI in order to access and use the clusters.

## Authorization of PI by Allocation Committee

The PI is authorized to use the clusters by the allocation decision issued by the Allocation Committee. The PI will be informed by IT4I about the Allocation Committee decision.

## Process Flow Chart

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

* I am a Primary Investigator and I want to allow my collaborators to access my project

<div class="mermaid">
graph TB
id110(I am a Primary Investigator and I want to allow my collaborators to access my project)
id120[Obtain a certificate for digital signature]
id110-->id120
id130[EduID organizations from CESNET*]
click id130 "#certificates-for-digital-signatures"
id140[Personal certificate from PostSignum or I.CA]
id150[Free certificate from Sectigo / Comodo*]
click id150 "#alternative-way-to-personal-certificate"
id155[Other trusted certificate]
subgraph ""
id120-->id130
id120-->id140
id120-->id150
id120-->id155
end
id160[Export and save the certificate to a file]
id130-->id160
id140-->id160
id150-->id160
id155-->id160
id170[Import the certificate into your email client*]
click id170 "#installation-of-the-certificate-into-your-mail-client"
id160-->id170
id180[Send an email with request for authorization to IT4I Support*]
click id180 "#authorization-by-e-mail-an-alternative-approach"
id170-->id180
</div>

* I am an existing user/Primary Investigator and I want to manage my projects/users

<div class="mermaid">
graph TB
id210(I am an existing user/Primary Investigator and I want to manage my projects/users)
id220[Log into scs.it4i.cz]
id230[Go to the Authorization Requests section]
id210-->id220
id220-->id230
id240[Submit a request to become a project member]
id245[Wait for an approval from the Primary Investigator]
id230-->|User|id240
id240-->id245
id250[Wait for a user to submit the request to become a project member]
id255[Approve or deny user requests for becoming project members]
id230-->|Primary Investigator|id250
id250-->id255
id240-.->id255
</div>

## Authorization by Web

!!! warning
    **Only** for those who already have their IT4I HPC account. This is a preferred way of granting access to project resources. Please, use this method when possible.

This is a preferred way of granting access to project resources. Please, use this method whenever it's possible.

Log in to the [IT4I SCS portal][e] using IT4I credentials and go to the **Authorization Requests** section.

* **Users:** Please, submit your requests for becoming a project member.
* **Primary Investigators:** Please, approve or deny users' requests in the same section.

## Authorization by Email (An Alternative Approach)

In order to authorize a Collaborator to utilize the allocated resources, the PI should contact the [IT4I support][a] (email: [support\[at\]it4i.cz][b]) and provide the following information:

1. Identify their project by project ID.
1. Provide a list of people, including themself, who are authorized to use the resources allocated to the project. The list must include the full name, email and affiliation. If collaborators' login access already exists in the IT4I systems, provide their usernames as well.
1. Include "Authorization to IT4Innovations" into the subject line.

!!! warning
    Should the above information be provided by email, the email **must be** digitally signed. Read more on [digital signatures][4] below.

Example (except the subject line which must be in English, you may use Czech or Slovak language for communication with us):

```console
Subject: Authorization to IT4Innovations

Dear support,

Please include my collaborators to project OPEN-0-0.

John Smith, john.smith@myemail.com, Department of Chemistry, MIT, US
Jonas Johansson, jjohansson@otheremail.se, Department of Physics, RIT, Sweden
Luisa Fibonacci, lf@emailitalia.it, Department of Mathematics, National Research Council, Italy

Thank you,
PI
(Digitally signed)
```

!!! note
    Web-based email interfaces cannot be used for secure communication; external application, such as Thunderbird or Outlook must be used. This way, your new credentials will be visible only in applications that have access to your certificate.

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
