# Certificate Helper
## License
MIT License
## What it is
A tool that tells you why your certificates might not work.
It is designed to be easily extensible and currently implements the following Certificate Problems (to add a problem, subclass CertificateProblem and implement +load,-infoObjects and -htmlDescription)
- NoCertificateProblem: No problems found, your certificates should work
- MissingCertificatesProblem: No Certificates were found that have a name like "3rd Party…"
- MissingPrivateKeyProblem: No Private key found for your certificates. You need the private keys in order to sign with the certificates

Feel free to fork/extend Certificate Helper