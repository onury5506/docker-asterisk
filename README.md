## Docker for asterisk + WebRTC

Use `docker build -t dialog/asterisk .` to create the image,

Run the container with following:
```
docker run -it \
    -e EXTERN_IP=$EXTERN_IP \
    -p 5060:5060/udp \
    -p 5061:5061/tcp \
    -p 10000-10010:10000-10010/udp \
    -p 8088:8088/tcp \
    dialog/asterisk
```
where `$EXTERN_IP` is the external ip of the machine.

To create your own certificates
```
mkdir /etc/asterisk/keys
cd asterisk-14.6.1/contrib/scripts/
./ast_tls_cert -C sip.dialog.im -O "Dialog SIP" -d /etc/asterisk/keys
```
