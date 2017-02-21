#!/bin/bash

#清空所有规则
iptables -F
iptables -X
iptables -Z

#添加默认规则
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#添加本机访问规则
iptables -A INPUT -i lo -j ACCEPT

#添加ssh、http、https、ping允许规则
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT

#
iptables -A INPUT -s 172.24.17.136 -j ACCEPT
iptables -A INPUT -s 172.24.17.137 -j ACCEPT
iptables -A INPUT -s 172.24.17.139 -j ACCEPT
iptables -A INPUT -s 172.24.17.140 -j ACCEPT
iptables -A INPUT -s 172.16.23.234 -j ACCEPT
#保存
#iptables-save
