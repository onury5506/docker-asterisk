#!/bin/bash
sed -i "s/EXTERN_IP/$EXTERN_IP/g" /etc/asterisk/sip.conf
asterisk -vvvvvvvvvvvvvvvvvc
