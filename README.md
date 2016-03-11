central-sonatype-publisher
======================

	> gpg --armor --export-secret-keys [YOUR_EMAIL_USED_IN_KEY] > KEY.asc && docker run -e GPG_PASSPHRASE=[PASSPHRASE] -e SONATYPE_USERNAME=[OSS_USERNAME] -e SONATYPE_PASSWORD=[OSS_PASSWORD] -e POM_NAME=pom.xml  -v `pwd`:/data -v ~/.m2:/root/.m2  -it totocastaldi/central-sonatype-publisher

### Prerequisites

##### Sonatype

Register yourself following http://central.sonatype.org/pages/producers.html

##### Signing

###### Generate key

	> gpg --gen-key

###### To identify your key use :

	> gpg --list-secret-keys

###### The public key must be published :

	> gpg --keyserver hkp://pgp.mit.edu --send-keys [KEY_ID]

#### greetings :

> Written with [StackEdit](https://stackedit.io/).
