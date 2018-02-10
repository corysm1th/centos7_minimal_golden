#!/bin/sh
cat <<EOF > /etc/local/runonce.d/sanitize.sh
#!/bin/sh
unset HISTFILE
systemctl stop rsyslog
package-cleanup -y --oldkernels --count=1
yum clean all
/sbin/logrotate -f /etc/logrotate.conf
rm -f \
    /var/log/*-201* \
    /var/log/*.gz \
    /var/log/dmesg.old \
    /var/log/anaconda/* \
    /root/.bash_history \
    /var/spool/mail/root

truncate -s 0M \
    /var/log/audit/audit.log \
    /var/log/wtmp \
    /var/log/lastlog \
    /var/log/grubby

rm -f /etc/udev/rules.d/70*
sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-*

EOF

chmod +x /etc/local/runonce.d/sanitize.sh

shutdown -r now
