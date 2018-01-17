#Overview

The ota example certificate is intended for evaluation during development of OTA.


#Content

The bundle contains the following:  

- dummy\_ota\_vendor\_cert.der  
- dummy\_ota\_vendor\_cert.pem  
- dummy\_ota\_vendor\_key.der  
- dummy\_ota\_vendor\_key.pem  


#Description
The contained files are used for authentication as part of the secured OTA update.  
In order to authenticate the TAR file sender, the TAR file that Uniflash generates contains a file name "ota.sign" which holds the signature of the "ota.cmd" file.
The format of the signature is prime256v1 ECDSA with SHA256.  
The dummy\_ota\_vendor\_key is an example for the private key that is used to generate the signature.  
The dummy\_ota\_vendor\_cert is an example for the certificate that is used to verify the signature.

