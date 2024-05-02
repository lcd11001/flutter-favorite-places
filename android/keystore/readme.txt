Generate Keystores:
keytool -genkey -v -keystore places.keystore -storepass 123456 -alias places -keypass 123456 -keyalg RSA -keysize 2048 -validity 10000

keytool -genkey -v -keystore places.jks -storepass b@byjumb0 -alias places -keypass b@byjumb0 -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 

Warning: The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using 
"keytool -importkeystore -srckeystore places.keystore -destkeystore places_pkcs12.keystore -deststoretype pkcs12".

keytool -importkeystore -srckeystore places.jks -destkeystore places_pkcs12.jks -deststoretype pkcs12



Get Key Fingerprints:
keytool -list -v -keystore places.keystore -storepass 123456 -alias places -keypass 123456
keytool -list -v -keystore places_pkcs12.keystore -storepass 123456 -alias places -keypass 123456

keytool -list -v -keystore places_pkcs12.jks -storepass b@byjumb0 -alias places -keypass b@byjumb0

for Facebook hash
keytool -exportcert -alias places -storepass 123456 -keystore places.keystore | openssl sha1 -binary | openssl base64