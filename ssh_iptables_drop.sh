#!/bin/bash
#解决ssh_exchange_identification: Connection closed by remote host
#分析ssh登陆日志，iptables中添加非法登陆ip

SECURE="/var/log/secure"
SECURE_TEMPFILE="/tmp/secure_tempfile"
ALLOW_IP="36.7.145.24"

tail -300 $SECURE | grep "Failed password for" > $SECURE_TEMPFILE

LIST=`cat $SECURE_TEMPFILE | awk '{print $11}' | sort | uniq | sed "s/$ALLOW_IP//g"`

for IP in $LIST
do
	NUM=`grep $IP $SECURE_TEMPFILE | wc -l`
	if [[ $NUM -gt 2 ]];then
		#/sbin/iptables -L | grep $IP
		cat /etc/hosts.deny | grep $IP
		if [[ $? -ne 0 ]];then
			#/sbin/iptables -A INPUT -s $IP -j DROP
			echo "sshd:$IP:deny" >> /etc/hosts.deny
			
		fi
	fi
done

rm $SECURE_TEMPFILE

