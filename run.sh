docker run -it \
    -p 5060:5060/udp \
    -p 5061:5061/tcp \
    -p 10000-10010:10000-10010/udp \
    -p 8088:8088/tcp \
    dialog/asterisk
