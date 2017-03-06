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
#指定IP访问ssh权限，其他IP一律禁止访问
iptables -A INPUT -p tcp --dport 22 -s 63.19.189.76 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 24.3.19.58 -j ACCEPT
#所有IP均可访问http、https、ping规则
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT

#指定IP不做任何限制，可访问所有端口
iptables -A INPUT -s 10.0.2.0/24 -j ACCEPT

#保存
#iptables-save
