#Overview

The certificate playground - root certificate catalog, is intended for evaluation during development of secure application that uses certificates for authentication and signing using the SimpleLink™ WiFi family. 
It can be used to evaluate secure sockets and secure storage features.  

#Bundle content

The bundle contains the following:

- root certificate - dummy-root-ca-cert 
- intermidiate ca trusted - dummy-trusted-ca-cert
- intermidiate ca revoked - dummy-revoked-ca-cert
- trusted certificate - dummy-trusted-cert
- revoked certificate - dummy-revoked-cert
- trusted chain - trusted-chain.pem (contains the dummy-trusted-ca-cert and the dummy-trusted-cert together)
- revoked chain - revoked-chain.pem (contains the dummy-revoked-ca-cert and the dummy-revoked-cert together)
- cetifictae catalog and its signature: 
certcatalogPlayGroungXXXXXXXX.lst certcatalogPlayGroungXXXXXXXX.lst.signed.bin

#Bundle description

The bundle forms two chains, both of them are signed by the root ca which is in the trust list of the certificate catalog.

The first chain is the trusted chain, contains an intermediate ca (dummy-trusted-ca-cert) and a certificate (dummy-trusted-cert).
This chain can be used for development - using the SSL, signing development files and MCU images.

The second chain is the revoked chain, contains an intermediate ca (dummy-revoked-ca-cert) and a certificate (dummy-revoked-cert).
The dummy-revoked-ca-cert is in the revocation list of the certificate catalog and cause the whole chain to be revoked.
This chain is used ONLY for assessment of the revocation feature.