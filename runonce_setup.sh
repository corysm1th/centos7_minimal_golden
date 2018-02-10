#!/bin/sh
(crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/runonce") | crontab -
mkdir -p /etc/local/runonce.d/ran

cat <<'EOF' > /usr/local/bin/runonce
#!/bin/sh
for file in /etc/local/runonce.d/*
do
    if [ ! -f "$file" ]
    then
        continue
    fi
    "$file"
    mv "$file" "/etc/local/runonce.d/ran/$(basename $file).$(date +%Y%m%dT%H%M%S)"
    logger -t runonce -p local3.info "$file"
    if [ "$file" == "/etc/local/runonce.d/sanitize.sh" ]; then
        /sbin/shutdown -h now
    fi
done

EOF

chmod +x /usr/local/bin/runonce
