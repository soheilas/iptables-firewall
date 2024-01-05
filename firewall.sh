#!/bin/bash

# اطمینان از اجرا به عنوان روت
if [ "$(id -u)" != "0" ]; then
   echo "Ba User root bayad run koni script ro " 1>&2
   exit 1
fi

# پاک کردن قوانین iptables فعلی
iptables -F

# اجازه دادن به SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# اجازه دادن به Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# حفظ اتصالات موجود
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 8880 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 8880 -j ACCEPT
iptables -A INPUT -p tcp --dport 2052 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2052 -j ACCEPT
iptables -A INPUT -p tcp --dport 2054 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2054 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 2074 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2074 -j ACCEPT
iptables -A INPUT -p tcp --dport 2060 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2060 -j ACCEPT
iptables -A INPUT -p tcp --dport 2059 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2059 -j ACCEPT
iptables -A INPUT -p tcp --dport 4242 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 4242 -j ACCEPT
iptables -A INPUT -p tcp --dport 2083 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2083 -j ACCEPT
iptables -A INPUT -p tcp --dport 2053 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2053 -j ACCEPT

# مسدود کردن یک آدرس IP خاص
iptables -A INPUT -s 192.0.2.0/24 -j DROP
iptables -A OUTPUT -d 192.0.2.0/24 -j DROP

# مسدود کردن ترافیک UDP
iptables -A INPUT -p udp -j DROP
iptables -A OUTPUT -p udp -j DROP

# مسدود کردن اسکن‌های مخرب
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP

# تنظیم سیاست‌های پیش‌فرض
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

echo "Iptables Firewall rules set!"
