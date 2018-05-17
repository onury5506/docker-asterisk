## Docker for asterisk + WebRTC

Use `docker build -t dialog/asterisk .` to create the image,

Run the container with `./run`

To create your own certificates
```
mkdir /etc/asterisk/keys
cd asterisk-15.4.0/contrib/scripts/
./ast_tls_cert -C sip.dialog.im -O "Dialog SIP" -d /etc/asterisk/keys
```
